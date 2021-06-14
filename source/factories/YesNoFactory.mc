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

using Toybox.Graphics;
using Toybox.WatchUi;
using Toybox.Test as Test;

class YesNoFactory extends WatchUi.PickerFactory {
    const YES_VAL = true;
    const NO_VAL = false;

    hidden const YES_IDX = 1;
    hidden const NO_IDX = 0;
    hidden const FACTORY_SIZE = 2;

	var fontOpts;

    function initialize(options) {
        PickerFactory.initialize();

        if(options != null) {
            fontOpts = options.get(:font);
        }

        if(fontOpts == null) {
            fontOpts = Graphics.FONT_NUMBER_HOT;
        }

    }

    function getDrawable(index, selected) {
    	var text;
    	if (getValue(index) == YES_VAL) {
    		text = "YES";
		} else {
			text = "NO";
		}
        return new WatchUi.Text( { :text=>text, :color=>Graphics.COLOR_WHITE, :font=> fontOpts, :locX =>WatchUi.LAYOUT_HALIGN_CENTER, :locY=>WatchUi.LAYOUT_VALIGN_CENTER } );
    }

    function getValue(index) {
        if (index == YES_IDX) {
        	return YES_VAL;
        } else {
        	return NO_VAL;
        }
    }

    function getSize() {
        return FACTORY_SIZE;
    }

	function getIndex(value) {
    	if (Toybox has :Test) {
            Test.assertMessage(value instanceof Boolean, "YesNoFactory Value Not Boolean");
        }
        
		if (value == YES_VAL) {
			return YES_IDX;
		} else {
			return NO_IDX;
		}
    }
}
