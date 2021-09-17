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

using Menus;

class MainMenuInputDelegate extends Ui.Menu2InputDelegate {

    function initialize() {
        Menu2InputDelegate.initialize();
    }

    function onSelect(item) {
        switch (item.getId()) {
            case :EndMatch_MenuID       :
                Ui.pushView(new Ui.Confirmation("Quit Match?"),
                            new ExitConfirmationDelegate(),
                            Ui.SLIDE_IMMEDIATE);
                break;
        	case :TimingMenu_MenuID     :
        		Ui.pushView( Menus.getTimingMenu(), 
        					 new TimingMenuInputDelegate(), 
        					 Ui.SLIDE_LEFT );
			 	break;
		 	case :NCAAMode_MenuID       :
		 		AppData.setNCAAMode(item.isEnabled());
                break;
 			case :BatterySaver_MenuID   :
                AppData.setBatterySaver(item.isEnabled());
                break;
            case :DarkMode_MenuID       :
            	AppData.setDarkMode(item.isEnabled());
				break;
			case :ThickRing_MenuID    :
				AppData.setThickRing(item.isEnabled());
				break;
			default:
				Sys.println(item.getId());
        }

        Ui.requestUpdate();
    }
}