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
using Toybox.System as Sys;

using HelperFunctions as func;

class ActivityInfoInputDelegate extends GenericDelegate {

    function initialize() {
        GenericDelegate.initialize();
    }
    
  // Handle a Key Press
    function onKey(evt) {
        if (GenericDelegate.onKey(evt)) {
        return true;
        } else if (evt.getKey() == Ui.KEY_DOWN) {
          return dispBack();
      }

        return false;
    }

    function onSwipe(evt) {
        if (evt.getDirection() == Ui.SWIPE_UP) {
            return dispBack();
        }

        return false;
    }
  
  

}