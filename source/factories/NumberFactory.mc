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

using Toybox.Graphics as Gfx;
using Toybox.WatchUi;

using ViewDrawables as draw; 

class NumberFactory extends WatchUi.PickerFactory {
    hidden var startNum;
    hidden var stopNum;
    hidden var incVal;
    hidden var mFormatString;
    hidden var fontOpts;

    function getIndex(value) {
        var index = (value / incVal) - startNum;
        
        return index;
    }

    function initialize(start, stop, increment, options) {
        PickerFactory.initialize();

        startNum = start;
        stopNum = stop;
        incVal = increment;

        if(options != null) {
            fontOpts = options.get(:font);
        }

        if(fontOpts == null) {
            fontOpts = Graphics.FONT_NUMBER_HOT;
        }

    }

    function getDrawable(index, selected) {
        return new WatchUi.Text( { :text=>getValue(index).format("%d"), :color=>Gfx.COLOR_WHITE, :font=> fontOpts, :locX =>WatchUi.LAYOUT_HALIGN_CENTER, :locY=>WatchUi.LAYOUT_VALIGN_CENTER } );
    }

    function getValue(index) {
        return startNum + (index * incVal);
    }

    function getSize() {
        return (stopNum - startNum) / incVal + 1;
    }

}
