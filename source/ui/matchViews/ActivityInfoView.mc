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
using Toybox.UserProfile as Usr;
using Toybox.System as Sys;

using ActivityTracking as Tracker;

class ActivityInfoView extends GenericView {

  function initialize() {
    GenericView.initialize();
  }

  // Load your resources here
  function onLayout(dc) {}

  // Called when this View is brought to the foreground. Restore
  // the state of this View and prepare it to be shown. This includes
  // loading resources into memory.
  function onShow() {}

  // Update the view
  function onUpdate(dc) {
    drawScreen(dc);
  }

  // Called when this View is removed from the screen. Save the
  // state of this View here. This includes freeing resources from
  // memory.
  function onHide() {}

  // Control function for main display panel
  function drawScreen(dc as Gfx.Dc) as Void {
    clearScreen(dc);

    drawDividers(dc);
    drawHR(dc);
    drawDist(dc);
    drawGpsRing(dc);
  }

  ///////////////////////////////////////////////////////////////////////////////
  // Functions for drawing                                                     //
  ///////////////////////////////////////////////////////////////////////////////
  function drawDividers(dc as Gfx.Dc) as Void {
    var color  = getForegroundColor();
    var x      = getMidWidth(dc);
    var y      = getMidHeight(dc);
    var length = dc.getWidth();

    drawHDivider(color, x, y, length, dc);
  }

  function drawHR(dc as Gfx.Dc) as Void {
    var hr = Tracker.getCurHeartRate();
    var hrColor = getForegroundColor();
    var zoneInfo = Usr.getHeartRateZones(Usr.HR_ZONE_SPORT_RUNNING);
    
    if (hr <= zoneInfo[0]) {
      hrColor = getForegroundColor();
    } else if (hr <= zoneInfo [1]) {
      hrColor = Gfx.COLOR_LT_GRAY;
    } else if (hr <= zoneInfo[2]) {
      hrColor = Gfx.COLOR_BLUE;
    } else if (hr <= zoneInfo[3]) {
      hrColor = Gfx.COLOR_GREEN;
    } else if (hr <= zoneInfo[4]) {
      hrColor = Gfx.COLOR_ORANGE;
    } else {
      hrColor = Gfx.COLOR_RED;
    }
  
    drawCenterTopLabel(getForegroundColor(), "HR (bpm):", dc);
    drawCenterTopText(hrColor, hr.toString(), dc);
  }

  function drawDist(dc as Gfx.Dc) as Void {
    var devSettings = Sys.getDeviceSettings();
    var label;
    var dist;

    if (devSettings.distanceUnits == Sys.UNIT_STATUTE) {
      label = "Distance (mi)";
      dist = Tracker.getCurDistMi();
    } else {
      label = "Distance (km)";
      dist = Tracker.getCurDistKM();
    }

    drawCenterBottomLabel(getForegroundColor(), label, dc);
    drawCenterBottomText(getForegroundColor(), dist.format("%02.2f"), dc);
  }
}