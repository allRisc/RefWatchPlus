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
 
class YesNoPickerDelegate extends Ui.PickerDelegate {
    var pickerProperty;

    function initialize(prop) {
        if (Toybox has :Test) {
            Test.assertMessage(prop instanceof String, "NumPickerDelegate \'prop\' not a string");
        }

        PickerDelegate.initialize();
        pickerProperty = prop;
    }

    function onCancel() {
        Ui.popView(Ui.SLIDE_IMMEDIATE);
    }

    function onAccept(values) {
        AppData.set(pickerProperty, values[0]);
        AppData.refreshAppData();

        Ui.popView(Ui.SLIDE_IMMEDIATE);
    }
}