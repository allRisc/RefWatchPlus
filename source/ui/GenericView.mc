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
using Toybox.Position as Pos;
using Toybox.Math;

import Toybox.Lang;

class GenericView extends Ui.View {

  const darkModeBackgroundColor = Gfx.COLOR_BLACK;
  const darkModeForegroundColor = Gfx.COLOR_WHITE;
  const lightModeBackgroundColor = Gfx.COLOR_WHITE;
  const lightModeForegroundColor = Gfx.COLOR_BLACK;

  const dividerWidth    = 3;

  function initialize() {
    View.initialize();
  }

  // Load view resources
  function onLayout(dc as Gfx.Dc) as Void {}

  // Called when this View is brought to the foreground.
  // - Restore the state of the view and prepare for it to be shown
  function onShow() as Void {}

  // Update the view
  function onUpdate(dc as Gfx.Dc) as Void {}

  /*********************************************************/
  /* Static Functions for drawing on screen                */
  /*********************************************************/

  static function getBackgroundColor() as Gfx.ColorValue {
    if (AppSettings.getDarkMode()) {
      return darkModeBackgroundColor;
    } else {
      return lightModeBackgroundColor;
    }
  }

  static function getForegroundColor() as Gfx.ColorValue {
    if (AppSettings.getDarkMode()) {
      return darkModeForegroundColor;
    } else {
      return lightModeForegroundColor;
    }
  }

  // Get the horizontal middle point of the watch face
  static function getMidWidth(dc as Gfx.Dc) as Float {
    return dc.getWidth() / 2.0 + 0.5;
  }

  // Get the vertical middle point of the watch face 
  static function getMidHeight(dc as Gfx.Dc) as Float {
    return dc.getHeight() / 2.0 + 0.5;
  }

  // Get the radius of the watch face
  static function getRadius(dc as Gfx.Dc) as Float {
    return (dc.getWidth() / 2.0) - 1;
  }

  // Clear the screen
  static function clearScreen(dc as Gfx.Dc) as Void {
    dc.setColor(getBackgroundColor(), getBackgroundColor());
    dc.clear();
  }

  // Get a color based on the current GPS Status
  static function getGPSQualityColor(gpsInfo as Pos.Info?) as Gfx.ColorValue {
    if( gpsInfo == null ) {
      gpsInfo = Pos.getInfo();
    }

    if( gpsInfo.accuracy == Pos.QUALITY_GOOD ) {
      return Gfx.COLOR_DK_GREEN;
    } else if( gpsInfo.accuracy == Pos.QUALITY_USABLE ) {
      return Gfx.COLOR_YELLOW;
    }
    return Gfx.COLOR_DK_RED;
  }

  // Draw a GPS Ring on the watch face
  static function drawGpsRing(dc as Gfx.Dc) as Void {
    drawRing(getGPSQualityColor(null), 360.0, getRadius(dc), dc);
  }

  // Draw a ring for a given timeleft vs timetotal set
  function timeRemainingRing(color as Gfx.ColorValue, timeLeft as Number, timeTotal as Number, dc as Gfx.Dc) as Void {
    var degrees;

    if (timeLeft < 0) {
      degrees = 360.0;
    } else {
      degrees = Math.ceil(360.0 * (timeTotal - timeLeft) / timeTotal);
    }

    drawRing(color, degrees, getRadius(dc), dc);
  }

  // Draw a ring with the given color, arg degree, and radius
  static function drawRing(color as Gfx.ColorValue, degs as Numeric, radius as Numeric, dc as Gfx.Dc) as Void {
    if (degs == 0) {
      return;
    }

    if (Toybox has :Test) {
      Test.assertMessage(degs >=   0, "Degrees for arc out of range (low)");
      Test.assertMessage(degs <= 360, "Degrees for arc out of range (high)");
    }

    dc.setColor(color, getBackgroundColor());

    var xCenter = getMidWidth(dc);
    var yCenter = getMidHeight(dc);
    
    var degOffset = ((360-degs) + 90);
    var degFinish = degOffset.abs().toNumber() % 360;
    
    dc.drawArc(xCenter, yCenter, radius + 1, Gfx.ARC_CLOCKWISE, 90, degFinish);
    dc.drawArc(xCenter, yCenter, radius    , Gfx.ARC_CLOCKWISE, 90, degFinish);
    dc.drawArc(xCenter, yCenter, radius - 1, Gfx.ARC_CLOCKWISE, 90, degFinish);
    dc.drawArc(xCenter, yCenter, radius - 2, Gfx.ARC_CLOCKWISE, 90, degFinish);
    if (AppSettings.getThickRing()) {
      dc.drawArc(xCenter, yCenter, radius - 3, Gfx.ARC_CLOCKWISE, 90, degFinish);
      dc.drawArc(xCenter, yCenter, radius - 4, Gfx.ARC_CLOCKWISE, 90, degFinish);
      dc.drawArc(xCenter, yCenter, radius - 5, Gfx.ARC_CLOCKWISE, 90, degFinish);
    }
  }

  // Draws the text in the center of the screen
  static function drawCenterText(color as Gfx.ColorValue, txt as String, dc as Gfx.Dc) as Void {
    dc.setColor(color, Gfx.COLOR_TRANSPARENT);
    dc.drawText(getMidWidth(dc), dc.getHeight()/3, Gfx.FONT_NUMBER_THAI_HOT, txt, Gfx.TEXT_JUSTIFY_CENTER);
  }

  // Draws the current period on the screen
  static function drawPeriodText(color as Gfx.ColorValue, per as Number, dc as Gfx.Dc) as Void {
    var curPeriod = Lang.format("Per: $1$", [per]);
    dc.setColor(color, Gfx.COLOR_TRANSPARENT);
    dc.drawText(getMidWidth(dc), dc.getHeight()*2/3, Gfx.FONT_MEDIUM, curPeriod, Gfx.TEXT_JUSTIFY_CENTER);
  }

  // Display text at the center top of the screen
  static function drawCenterTopText(color as Gfx.ColorValue, txt as String, dc as Gfx.Dc) as Void {
    dc.setColor(color, Gfx.COLOR_TRANSPARENT);
    dc.drawText(getMidWidth(dc), dc.getHeight()/7, Gfx.FONT_NUMBER_HOT, txt, Gfx.TEXT_JUSTIFY_CENTER);
  }

  // Display a label at the center top of the screen
  static function centerTopLabel(color as Gfx.ColorValue, label as String, dc as Gfx.Dc) as Void {
    dc.setColor(color, Gfx.COLOR_TRANSPARENT);
    dc.drawText(getMidWidth(dc), dc.getHeight()/14, Gfx.FONT_MEDIUM, label, Gfx.TEXT_JUSTIFY_CENTER);
  }

  // Display text at the center bottom of the screen
  static function centerBottom(color as Gfx.ColorValue, txt as String, dc as Gfx.Dc) as Void {
    dc.setColor(color, Gfx.COLOR_TRANSPARENT);
    dc.drawText(getMidWidth(dc), dc.getHeight()*4/7, Gfx.FONT_NUMBER_HOT, txt, Gfx.TEXT_JUSTIFY_CENTER);
  }

  static function centerBottomLabel(color as Gfx.ColorValue, label as String, dc as Gfx.Dc) as Void {
    dc.setColor(color, Gfx.COLOR_TRANSPARENT);
    dc.drawText(getMidWidth(dc), dc.getHeight()/2, Gfx.FONT_MEDIUM, label, Gfx.TEXT_JUSTIFY_CENTER);
  }

  // Places a text value into the top-left point    
  static function topLeft(color as Gfx.ColorValue, txt as String, dc as Gfx.Dc) as Void {
    dc.setColor(color, Gfx.COLOR_TRANSPARENT);
    dc.drawText(dc.getWidth()/3, dc.getHeight()/6, Gfx.FONT_LARGE, txt, Gfx.TEXT_JUSTIFY_CENTER);
  }

  // Places a time value into the top-right corner
  static function topRight(color as Gfx.ColorValue, txt as String, dc as Gfx.Dc) as Void {
    dc.setColor(color, Gfx.COLOR_TRANSPARENT);
    dc.drawText(dc.getWidth() * 2/3, dc.getHeight()/6, Gfx.FONT_LARGE, txt, Gfx.TEXT_JUSTIFY_CENTER);
  }


  // Create a horizontal divider on screen
  static function hDivider(color as Gfx.ColorValue, x as Numeric, y as Numeric, len as Numeric, dc as Gfx.Dc) as Void {
    var yLoc = y - Math.floor(dividerWidth/2);
    var xLoc = x - Math.floor(len/2);
    dc.setColor(color, getBackgroundColor());
    dc.fillRectangle(xLoc, yLoc, len, dividerWidth);
  }

  // Create vertical divider on screen
  static function vDivider(color as Gfx.ColorValue, x as Numeric, y as Numeric, len as Numeric, dc as Gfx.Dc) as Void {
        var xLoc = x - Math.floor(dividerWidth/2);
        var yLoc = y - Math.floor(len/2);
        dc.setColor(color, getBackgroundColor());
        dc.fillRectangle(xLoc, yLoc, dividerWidth, len);
    }
}