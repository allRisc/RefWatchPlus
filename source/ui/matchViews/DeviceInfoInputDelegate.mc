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
 * but WITHOUT ANY WARRANTY; without even the implied warranty of/***************************************************************************
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

using Toybox.WatchUi as Ui;

import Toybox.Lang;

class DeviceInfoInputDelegate extends GenericDelegate {

  function initialize() {
    GenericDelegate.initialize();
  }

  // Handle a keyed input
  function onKey(evt as Ui.KeyEvent) as Boolean {
    if (GenericDelegate.onKeyStatic(evt)) {
      return true;
    } else if (evt.getKey() == Ui.KEY_UP) {
      return dispBack();
    }

    return false;
  }

  // Handle a swipe input
  function onSwipe(evt) {
    if (evt.getDirection() == Ui.SWIPE_DOWN) {
      return dispBack();
    }

    return false;
  }
}