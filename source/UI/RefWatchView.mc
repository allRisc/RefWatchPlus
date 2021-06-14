/***************************************************************************
 * This file is part of RefWatchPlus                                       *
 *                                                                         *
 * RefWatchPlus is free software: you can redistribute it and/or modify    *
 * it under the terms of the GNU General Public License as published by    *
 * the Free Software Foundation, either version 3 of the License, or       *
 * (at your option) any later version.                                     *
 *                                                                         *
 * RefWatchPlus is distributed in the hope that it will be useful,         *
 * but WITHOUT ANY WARRANTY; without even the implied warranty of          *
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the           *
 * GNU General Public License for more details.                            *
 *                                                                         *
 * You should have received a copy of the GNU General Public License       *
 * along with RefWatchPlus.  If not, see <https://www.gnu.org/licenses/>.  *
 ***************************************************************************/

using Toybox.WatchUi as Ui;
using Toybox.Graphics as Gfx;
using Toybox.Attention as Att;
using Toybox.Lang;
using Toybox.Math;
using Toybox.Position as Pos;
using Toybox.Application as app;
using Toybox.System as Sys;

using HelperFunctions as func;
using ViewDrawables as draw;
using MatchData;
using VibrationController as Vib;
using RefreshTimer;

class RefWatchView extends Ui.View {

    const CALLBACK_TIMER = 100;

    var updateTimer;

    function initialize() {
        View.initialize();
    }

    // Load your resources here
    function onLayout(dc) {
    }

    // Called when this View is brought to the foreground. Restore
    // the state of this View and prepare it to be shown. This includes
    // loading resources into memory.
    function onShow() {
        RefreshTimer.startTimer();
    }

    // Update the view
    function onUpdate(dc) {
        drawScreen(dc);
        Vib.handleVibration();
    }

    // Called when this View is removed from the screen. Save the
    // state of this View here. This includes freeing resources from
    // memory.
    function onHide() {}

    // Control function for main display panel
    function drawScreen(dc) {
        draw.clearScreen(dc);

        // Get current timing Information
        if (!MatchData.isStarted()) {
            drawIdleScreen(dc);
        } else if (MatchData.isPlayingPeriod()) {
            drawPlayingScreen(dc);
        } else {
            drawBreakScreen(dc);
        }

    }

    function drawIdleScreen(dc) {

        var timeRemaining = func.min2sec( AppData.getPeriodLength() );
        var curStoppage   = 0;

        // Set the timing information color based on current state of the timer
        var timeRemainingColor = Gfx.COLOR_WHITE;
        var timeElapsedColor   = Gfx.COLOR_WHITE;
        var curStoppageColor   = Gfx.COLOR_WHITE;
        var secRingColor       = draw.getGPSQualityColor(Pos.getInfo());

        draw.topLeft(timeRemainingColor, func.sec2timer(timeRemaining), dc);
        draw.center(timeElapsedColor, func.clockFace(), dc);
        draw.topRight(curStoppageColor, func.sec2timer(curStoppage), dc);
        draw.timeRemainingRing(secRingColor, (60-Sys.getClockTime().sec), 60, dc);
    }

    function drawBreakScreen(dc) {
        var timeRemaining = MatchData.getCurPeriod().getSecRemaining();
        var curPeriod     = MatchData.getCurPeriodNum();

        // Set the timing information color based on current state of the timer
        var timeRemainingColor = Gfx.COLOR_WHITE;
        var curPeriodColor     = Gfx.COLOR_WHITE;

        if (MatchData.getCurPeriod().isNearComplete()) {
            timeRemainingColor = Gfx.COLOR_RED;
        }

        draw.center(timeRemainingColor, func.sec2timer(timeRemaining), dc);
        draw.period(curPeriodColor, curPeriod, dc);
    }

    function drawPlayingScreen(dc) {
        var timeRemaining = MatchData.getCurPeriod().getSecRemaining();
        var timeElapsed   = MatchData.getSecPlayingTime();
        var curStoppage   = MatchData.getCurPeriod().getSecStoppage();
        var curPeriod     = MatchData.getCurPeriodNum();
        var periodTime;

        // Set the timing information color based on current state of the timer
        var timeRemainingColor = Gfx.COLOR_WHITE;
        var timeElapsedColor   = Gfx.COLOR_WHITE;
        var curStoppageColor   = Gfx.COLOR_WHITE;
        var curPeriodColor     = Gfx.COLOR_WHITE;
        var ringColor          = Gfx.COLOR_GREEN;

        if (MatchData.getCurPeriod().isInStoppage()) {
            timeElapsedColor = Gfx.COLOR_RED;
        } else if (MatchData.getCurPeriod().isNearStoppage()) {
            timeElapsedColor = Gfx.COLOR_YELLOW;
        }

        if (MatchData.getCurPeriod().isTrackingStoppage()) {
            curStoppageColor = Gfx.COLOR_ORANGE;
        }

        if (MatchData.isOTPeriod()) {
            periodTime = func.min2sec(AppData.getOTPeriodLength());
        } else {
            periodTime = func.min2sec(AppData.getPeriodLength());
        }

        draw.topLeft(timeRemainingColor, func.sec2timer(timeRemaining), dc);
        draw.center(timeRemainingColor, func.sec2timer(timeElapsed), dc);
        draw.topRight(curStoppageColor, func.sec2timer(curStoppage), dc);

        draw.period(curPeriodColor, curPeriod, dc);
        
        draw.timeRemainingRing(ringColor, timeRemaining, periodTime, dc);
    }
}
