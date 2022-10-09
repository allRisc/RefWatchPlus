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
using Toybox.Timer;
using Toybox.Graphics as Gfx;
using Toybox.System as Sys;

using HelperFunctions as func;

class DeviceInfoView extends GenericView {
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

    drawTime(dc);
    drawBattery(dc);
    drawDividers(dc);
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

  function drawTime(dc as Gfx.Dc) as Void {
    drawCenterTopText(getForegroundColor(), func.clockFace(), dc);
  }

  function drawBattery(dc as Gfx.Dc) as Void {
    var batColor = getForegroundColor();
    var bat = Sys.getSystemStats().battery;
    var batTxt = Lang.format("$1$%", [bat.format("%02.0f")]);

    if (bat <= 10.0) {
      batColor = Gfx.COLOR_RED;
    } else if (bat <= 25.0) {
      batColor = Gfx.COLOR_YELLOW;
    }

    drawCenterBottomLabel(getForegroundColor(), "Battery", dc);
    drawCenterBottomText(batColor, batTxt, dc);
  }
}