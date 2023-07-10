/***************************************************************************
 * RefWatchPlus is a FOSS app made for reffing soccer and tracking time.
 * Copyright (C) 2021  Benjamin Davis
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


using Toybox.Math;
using Toybox.System as Sys;

import Toybox.Lang;

module HelperFunctions {
  function min2sec(m as Numeric) as Numeric {
    return 60*m;
  }

  function min2msec(m as Numeric) as Numeric {
    return 60*m*1000;
  }

  function sec2msec(s as Numeric) as Numeric {
    return s * 1000;
  }

  function msec2sec(ms as Numeric) as Number {
    return Math.floor(ms / 1000);
  }

  function msec2sec_ceil(ms as Numeric) as Number {
    return Math.ceil(ms / 1000.0).toNumber();
  }

  function sec2timer(s as Number) as String {
    var sign = "";
    var min  = (s/60).abs();
    var sec  = (s % 60).abs();

    if (s < 0) {
      sign = "-";
    }

    var myFormat = "$1$$2$:$3$";
    var myParams = [sign, min.toNumber(), sec.toNumber().format("%02d")];
    var myString = Lang.format(myFormat, myParams);

    return myString;
  }

  function clockFace() as String {
    var curTime = Sys.getClockTime();
    var hour = curTime.hour;

    if (!Sys.getDeviceSettings().is24Hour) {
      hour = hour % 12;
      if (hour == 0) {
        hour = 12;
      }
    }


    return hour.format("%02d").toString() + ":" + curTime.min.format("%02d").toString();
  }
}