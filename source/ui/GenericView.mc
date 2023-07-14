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
using Toybox.Graphics as Gfx;

import Toybox.Lang;

class GenericView extends Ui.View {

  static const darkModeForegroundColor as Gfx.ColorValue = Gfx.COLOR_WHITE;
  static const lightModeForegroundColor as Gfx.ColorValue = Gfx.COLOR_BLACK;

  ///////////////////////////////////////////////////////////////////////////////////////
  // Override functions
  ///////////////////////////////////////////////////////////////////////////////////////
  function initialize() {
    View.initialize();
  }

  ///////////////////////////////////////////////////////////////////////////////////////
  // Custom Functions
  ///////////////////////////////////////////////////////////////////////////////////////
  static function getForegroundColor() as Gfx.ColorValue {
    if (AppSettings.getDarkMode()) {
      return darkModeForegroundColor;
    } else {
      return lightModeForegroundColor;
    }
  }
}