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
 
using Toybox.System as Sys;
using Toybox.WatchUi as Ui;

import Toybox.Lang;

class ExitConfirmationDelegate extends Ui.ConfirmationDelegate{
  function initialize() {
    ConfirmationDelegate.initialize();
  }

  function onResponse(response) as Boolean {
    if (response == WatchUi.CONFIRM_NO) {
      Ui.popView(Ui.SLIDE_IMMEDIATE);
      return false;
    } else {
      Sys.exit();
    }
    return true;
  }
}