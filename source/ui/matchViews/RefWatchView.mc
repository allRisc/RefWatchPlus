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
using Toybox.Math;

using HelperFunctions as func;

import Toybox.Lang;

class RefWatchView extends Ui.View {

  var idle as Boolean;

  ///////////////////////////////////////////////////////////////////////////////////////
  // Override functions
  ///////////////////////////////////////////////////////////////////////////////////////
  function initialize() {
    View.initialize();

    idle = true;
  }

  // Resources are loaded here
  function onLayout(dc) {
    setLayout(Rez.Layouts.layoutRefWatchView(dc));
  }

  // onShow() is called when this View is brought to the foreground
  function onShow() {
  }

  // onUpdate() is called periodically to update the View
  function onUpdate(dc) {

    if (idle) {
      onUpdateIdle(dc);
    } else {
      onUpdateMatch(dc);
    }

    View.onUpdate(dc);
  }

  // onHide() is called when this View is removed from the screen
  function onHide() {
  }

  ///////////////////////////////////////////////////////////////////////////////////////
  // Custom Functions
  ///////////////////////////////////////////////////////////////////////////////////////
  function onUpdateIdle(dc) {
    var centerText = View.findDrawableById("centerText");
    var upperLeftText = View.findDrawableById("upperLeftText");
    var upperRightText = View.findDrawableById("upperRightText");
    var timeRing = View.findDrawableById("timeRing");

    if (centerText instanceof Ui.Text) {
      centerText.setText(func.clockFace());
    } else {
      throw new Lang.UnexpectedTypeException("centerText not the expected type", null, null);
    }

    if (upperLeftText instanceof Ui.Text) {
      upperLeftText.setText(func.sec2timer(func.min2sec(AppSettings.getPeriodLength())));
    } else {
      throw new Lang.UnexpectedTypeException("upperLeftText not the expected type", null, null);
    }

    if (upperRightText instanceof Ui.Text) {
      upperRightText.setText(func.sec2timer(0));
    } else {
      throw new Lang.UnexpectedTypeException("upperRightText not the expected type", null, null);
    }

    if (timeRing instanceof RefWatchTimeRing) {
      timeRing.degs = Math.ceil(360.0 * (Sys.getClockTime().sec) / 60);
    } else {
      throw new Lang.UnexpectedTypeException("timeRing not the expected type", null, null);
    }
  }

  function onUpdateMatch(dc) {

  }
}