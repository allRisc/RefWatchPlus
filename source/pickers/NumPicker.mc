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
using Toybox.Test;

import Toybox.Lang;

class NumPicker extends Ui.Picker {

  function initialize(titleName as String, prop as String) {

    if (Toybox has :Test) {
      Test.assertMessage(titleName instanceof String, "NumPicker: \'titleName\' not a string");
      Test.assertMessage(prop      instanceof String, "NumPicker: \'prop\' not a string");
      Test.assertMessage(AppSettings.get(prop) != null, "NumPicker: Invalid Property");
    }

    var title = new Ui.Text({:text=>titleName, :font=>Gfx.FONT_MEDIUM, :locX=>Ui.LAYOUT_HALIGN_CENTER, :locY=>Ui.LAYOUT_VALIGN_BOTTOM, :color=>Gfx.COLOR_WHITE});

    var factories = new Array<NumberFactory>[1];

    factories[0] = new NumberFactory(0, 99, 1, {:font=>Graphics.FONT_MEDIUM});

    var defaults = new [1];

    var idx = AppSettings.get(prop);

    if (idx instanceof Number) {
      defaults[0] = factories[0].getIndex(idx);
    } else {
      throw new UnexpectedTypeException("NumPicker index must be Number!", null, null);
    }

    Picker.initialize({:title=>title, :pattern=>factories, :defaults=>defaults});
  }
}

