/***************************************************************************
 * RefWatchPlus is a FOSS app made for reffing soccer and tracking time.
 * Copyright (C) 2023  Benjamin Davis
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <https://www.gnu.org/licenses/>.
 ***************************************************************************/

using Toybox.WatchUi as Ui;
using Toybox.Application as App;
using Toybox.Graphics as Gfx;

import Toybox.Lang;

class RefWatchTimeRing extends Ui.Drawable {

  var color as Gfx.ColorValue?;
  var degs as Numeric = 0.0;

  function initialize(dictionary) {
    Drawable.initialize(dictionary);

    color = Gfx.COLOR_GREEN;
    degs = 360.0;
  }

  function draw(dc) {
    if (degs == 0) {
      return;
    }

    if (Toybox has :Test) {
      Test.assertMessage(degs >=   0, "Degrees for arc out of range (low)");
      Test.assertMessage(degs <= 360, "Degrees for arc out of range (high)");
    }

    dc.setColor(color, RefWatchBackground.getBackgroundColor());

    var xCenter = dc.getWidth() / 2.0;
    var yCenter = dc.getHeight() / 2.0;

    var degOffset = ((360-degs) + 90);
    var degFinish = degOffset.abs().toNumber() % 360;

    var radius = getRadius(dc);

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

  static function getRadius(dc) as Float {
    return (dc.getWidth() / 2.0) - 1;
  }
}
