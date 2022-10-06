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

class RefWatchView extends GenericView {

  function initialize() {
    GenericView.initialize();
  }

  // Load your resources here
  function onLayout(dc as Gfx.Dc) as Void {}

  // Called when this View is brought to the foreground. Restore
  // the state of this View and prepare it to be shown. This includes
  // loading resources into memory.
  function onShow() {}

  // Update the view
  function onUpdate(dc as Gfx.Dc) as Void {
      drawScreen(dc);
  }

  // Called when this View is removed from the screen. Save the
  // state of this View here. This includes freeing resources from
  // memory.
  function onHide() {}

  // Control function for main display panel
  function drawScreen(dc as Gfx.Dc) as Void {
    clearScreen(dc);

    // Get current timing Information
    if (!MatchData.isStarted()) {
      drawIdleScreen(dc);
    } else if (MatchData.isPlayingPeriod()) {
      drawPlayingScreen(dc);
    } else {
      drawBreakScreen(dc);
    }
  }

    function drawIdleScreen(dc as Gfx.Dc) as Void {

        var timeRemaining = func.min2sec( AppSettings.getPeriodLength() );
        var curStoppage   = 0;

        // Set the timing information color based on current state of the timer
        var timeRemainingColor = getForegroundColor();
        var timeElapsedColor   = getForegroundColor();
        var curStoppageColor   = getForegroundColor();
        var secRingColor       = getGPSQualityColor(Pos.getInfo());

        topLeft(timeRemainingColor, func.sec2timer(timeRemaining), dc);
        center(timeElapsedColor, func.clockFace(), dc);
        topRight(curStoppageColor, func.sec2timer(curStoppage), dc);
        timeRemainingRing(secRingColor, (60-Sys.getClockTime().sec), 60, dc);
    }

    function drawBreakScreen(dc as Gfx.Dc) as Void {
        var timeRemaining = MatchData.getCurPeriod().getSecRemaining();
        var curPeriod     = MatchData.getCurPeriodNum();

        // Set the timing information color based on current state of the timer
        var timeRemainingColor = getForegroundColor();
        var curPeriodColor     = getForegroundColor();

        if (MatchData.getCurPeriod().isNearComplete()) {
            timeRemainingColor = Gfx.COLOR_RED;
        }

        center(timeRemainingColor, func.sec2timer(timeRemaining), dc);
        drawPeriod(curPeriodColor, curPeriod, dc);
    }

  function drawPlayingScreen(dc as Gfx.Dc) as Void {
    var timeRemaining = MatchData.getCurPeriod().getSecRemaining();
    var timeElapsed   = MatchData.getSecPlayingTime();
    var curStoppage   = MatchData.getCurPeriod().getSecStoppage();
    var curPeriod     = MatchData.getCurPeriodNum();
    var periodTime;

    // Set the timing information color based on current state of the timer
    var timeRemainingColor = getForegroundColor();
    var timeElapsedColor   = getForegroundColor();
    var curStoppageColor   = getForegroundColor();
    var curPeriodColor     = getForegroundColor();
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

    topLeft(timeRemainingColor, func.sec2timer(timeRemaining), dc);
    drawCenterText(timeElapsedColor, func.sec2timer(timeElapsed), dc);
    topRight(curStoppageColor, func.sec2timer(curStoppage), dc);

    drawPeriod(curPeriodColor, curPeriod, dc);

    timeRemainingRing(ringColor, timeRemaining, periodTime, dc);
  }
}
