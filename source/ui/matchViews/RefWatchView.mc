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

using Toybox.Graphics as Gfx;
using Toybox.Application as App;
using Toybox.System as Sys;

using HelperFunctions as func;

import Toybox.Lang;
import Toybox.System;

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
    var app = RefWatchApp.getApp();

    var appState = app.getMatchState();

    clearScreen(dc);

    switch (appState) {
      case IDLE :
        drawIdleScreen(dc);
        break;
      case PLAYING_PERIOD :
      case TRACKING_STOPPAGE :
      case WAITING_KICK :
        drawPlayingScreen(dc);
        break;
      case BREAK_PERIOD :
        drawBreakScreen(dc);
        break;
    }
  }

  function drawIdleScreen(dc as Gfx.Dc) as Void {

    var timeRemaining = func.min2sec( AppSettings.getPeriodLength() );
    var curStoppage   = 0;

    // Set the timing information color based on current state of the timer
    var timeRemainingColor = getForegroundColor();
    var timeElapsedColor   = getForegroundColor();
    var curStoppageColor   = getForegroundColor();
    var secRingColor       = getGPSQualityColor(null);

    drawTopLeftText(timeRemainingColor, func.sec2timer(timeRemaining), dc);
    drawCenterText(timeElapsedColor, func.clockFace(), dc);
    drawTopRightText(curStoppageColor, func.sec2timer(curStoppage), dc);
    drawTimeRemainingRing(secRingColor, (60-Sys.getClockTime().sec), 60, dc);
  }

  function drawBreakScreen(dc as Gfx.Dc) as Void {
    var app = RefWatchApp.getApp();

    var timeRemaining = app.getSecRemaining();
    var curPeriod     = app.getPeriodNum();

    // Set the timing information color based on current state of the timer
    var timeRemainingColor = getForegroundColor();
    var curPeriodColor     = getForegroundColor();

    if (app.isNearComplete()) {
      timeRemainingColor = Gfx.COLOR_RED;
    }

    drawCenterText(timeRemainingColor, func.sec2timer(timeRemaining), dc);
    drawPeriodText(curPeriodColor, curPeriod, dc);
  }

  function drawPlayingScreen(dc as Gfx.Dc) as Void {
    var app = RefWatchApp.getApp();
    var timeRemaining = app.getSecRemaining();
    var timeElapsed   = app.getSecElapsed();
    var curStoppage   = app.getSecStoppage();
    var curPeriod     = app.getPeriodNum();
    var periodTime    = app.getPeriodTime();

    // Set the timing information color based on current state of the timer
    var timeRemainingColor = getForegroundColor();
    var timeElapsedColor   = getForegroundColor();
    var curStoppageColor   = getForegroundColor();
    var curPeriodColor     = getForegroundColor();
    var ringColor          = Gfx.COLOR_GREEN;

    if (app.isInStoppage()) {
      timeElapsedColor = Gfx.COLOR_RED;
    } else if (app.isNearComplete()) {
      timeElapsedColor = Gfx.COLOR_YELLOW;
    }

    if (app.isTrackingStoppage()) {
      curStoppageColor = Gfx.COLOR_ORANGE;
    }

    drawTopLeftText(timeRemainingColor, func.sec2timer(timeRemaining), dc);
    drawCenterText(timeElapsedColor, func.sec2timer(timeElapsed), dc);
    drawTopRightText(curStoppageColor, func.sec2timer(curStoppage), dc);

    drawPeriodText(curPeriodColor, curPeriod, dc);

    drawTimeRemainingRing(ringColor, timeRemaining, periodTime, dc);
  }
}
