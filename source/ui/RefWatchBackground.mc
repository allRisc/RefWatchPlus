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

class RefWatchBackground extends Ui.Drawable {

  static const darkModeBackgroundColor as Gfx.ColorValue = Gfx.COLOR_BLACK;
  static const lightModeBackgroundColor as Gfx.ColorValue = Gfx.COLOR_BLUE;

  function initialize(dictionary) {
    Drawable.initialize(dictionary);
  }

  function draw(dc) {
    // Set the background color then call to clear the screen
    dc.setColor(getBackgroundColor(), getBackgroundColor());
    dc.clear();
  }

  static function getBackgroundColor() as Gfx.ColorValue {
    if (AppSettings.getDarkMode()) {
      return darkModeBackgroundColor;
    } else {
      return lightModeBackgroundColor;
    }
  }
}
