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
using Toybox.Application;
using Toybox.System as Sys;
using Toybox.Test;

using ViewDrawables as draw;

class NumPicker extends Ui.Picker {

    function initialize(titleName, prop) {
        var title;

        if (Toybox has :Test) {
            Test.assertMessage(titleName instanceof String, "NumPicker: \'titleName\' not a string");
            Test.assertMessage(prop      instanceof String, "NumPicker: \'prop\' not a string");
            Test.assertMessage(AppData.get(prop) != null, "NumPicker: Invalid Property");
        }

        title = new Ui.Text({:text=>titleName, :font=>Gfx.FONT_MEDIUM, :locX=>Ui.LAYOUT_HALIGN_CENTER, :locY=>Ui.LAYOUT_VALIGN_BOTTOM, :color=>Gfx.COLOR_WHITE});

        var factories = new [1];

        factories[0] = new NumberFactory(0, 99, 1, {:font=>Graphics.FONT_MEDIUM});

        var defaults = new [1];
        defaults[0] = factories[0].getIndex(AppData.get(prop));

        Picker.initialize({:title=>title, :pattern=>factories, :defaults=>defaults});
    }
}

