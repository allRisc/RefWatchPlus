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

using Toybox.System as Sys;
using Toybox.WatchUi as Ui;
using Toybox.Graphics as Gfx;
using Toybox.UserProfile as Usr;

using ActivityTracking as Tracker;

import Toybox.Lang;

class ActivityInfoView extends GenericView {
  ///////////////////////////////////////////////////////////////////////////////////////
  // Override functions
  ///////////////////////////////////////////////////////////////////////////////////////
  function initialize() {
    GenericView.initialize();
  }

  // Resources are loaded here
  function onLayout(dc) {
    setLayout(Rez.Layouts.layoutInfoView(dc));
  }

  // onShow() is called when this View is brought to the foreground
  function onShow() {
  }

  // onUpdate() is called periodically to update the View
  function onUpdate(dc) {
    View.onUpdate(dc);

    var topLabel    = View.findDrawableById("topLabel");
    var topText     = View.findDrawableById("topText");
    var bottomLabel = View.findDrawableById("bottomLabel");
    var bottomText  = View.findDrawableById("bottomText");
    var ring = View.findDrawableById("ring");

    var devSettings = Sys.getDeviceSettings();
    var distLabel;
    var dist;
    var foregroundColor;

    foregroundColor = GenericView.getForegroundColor();

    if (devSettings.distanceUnits == Sys.UNIT_STATUTE) {
      distLabel = "Distance (mi)";
      dist = Tracker.getCurDistMi();
    } else {
      distLabel = "Distance (km)";
      dist = Tracker.getCurDistKM();
    }

    if (topLabel instanceof Ui.Text) {
      topLabel.setText("HR (bpm):");
      topLabel.setColor(foregroundColor);
    } else {
      throw new Lang.UnexpectedTypeException("topLabel not the expected type", null, null);
    }

    if (topText instanceof Ui.Text) {
      var hr = Tracker.getCurHeartRate();
      var hrColor = foregroundColor;
      var zoneInfo = Usr.getHeartRateZones(Usr.HR_ZONE_SPORT_RUNNING);

      if (hr <= zoneInfo[0]) {
        hrColor = foregroundColor;
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
      topText.setText(hr.toString());
      topText.setColor(hrColor);
    } else {
      throw new Lang.UnexpectedTypeException("topText not the expected type", null, null);
    }

    if (bottomLabel instanceof Ui.Text) {
      bottomLabel.setText(distLabel);
      bottomLabel.setColor(foregroundColor);
    } else {
      throw new Lang.UnexpectedTypeException("bottomLabel not the expected type", null, null);
    }

    if (bottomText instanceof Ui.Text) {
      bottomText.setText(dist.format("%02.2f"));
      bottomText.setColor(foregroundColor);
    } else {
      throw new Lang.UnexpectedTypeException("bottomText not the expected type", null, null);
    }

    if (ring instanceof RefWatchTimeRing) {
      ring.degs = 360;
      // TODO: Handle GPS ring color
    } else {
      throw new Lang.UnexpectedTypeException("ring not the expected type", null, null);
    }
  }

  // onHide() is called when this View is removed from the screen
  function onHide() {
  }

}