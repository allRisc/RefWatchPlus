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
using Toybox.WatchUi as Ui;

import Toybox.Lang;

class NumberFactory extends Ui.PickerFactory {
  hidden var startNum as Number;
  hidden var stopNum as Number;
  hidden var incVal as Number;
  hidden var fontOpts as Gfx.FontType;

  function getIndex(value as Number) as Number {
    var index = (value / incVal) - startNum;

    return index;
  }

  function initialize(start as Number, stop as Number, increment as Number, options as {:font as Gfx.FontType}) {
    var fnt;

    PickerFactory.initialize();

    startNum = start;
    stopNum = stop;
    incVal = increment;
    fontOpts = Gfx.FONT_NUMBER_HOT;

    if(options != null) {
      fontOpts = options.get(:font);
    }
  }

  function getDrawable(index as Number, selected as Boolean) as Ui.Drawable? {
    return new Ui.Text( { :text=>getNum(index).format("%d"), :color=>Gfx.COLOR_WHITE, :font=> fontOpts, :locX =>Ui.LAYOUT_HALIGN_CENTER, :locY=>Ui.LAYOUT_VALIGN_CENTER } );
  }

  function getNum(index as Number) as Number {
    return startNum + (index * incVal);
  }

  function getValue(index as Number) as Object? {
    return startNum + (index * incVal);
  }

  function getSize()  as Number {
    return (stopNum - startNum) / incVal + 1;
  }

}
