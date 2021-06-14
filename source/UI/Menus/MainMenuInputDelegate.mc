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

class MainMenuInputDelegate extends Ui.MenuInputDelegate {

    function initialize() {
        MenuInputDelegate.initialize();
    }

    function onMenuItem(item) {
        switch (item) {
            case :EndMatch_MenuID       :
                Ui.pushView(new Ui.Confirmation("Quit Match?"),
                            new ExitConfirmationDelegate(),
                            Ui.SLIDE_IMMEDIATE);
                break;
        	case :TimingMenu_MenuID     :
        		Ui.pushView( new Rez.Menus.TimingMenu(), 
        					 new TimingMenuInputDelegate(), 
        					 Ui.SLIDE_LEFT );
			 	break;
		 	case :NCAAMode_MenuID       :
                Ui.pushView(new YesNoPicker(Ui.loadResource(Rez.Strings.NCAAMode_MenuLabel), Ui.loadResource(Rez.Strings.NCAAMode_StorageID)),
                            new YesNoPickerDelegate(Ui.loadResource(Rez.Strings.NCAAMode_StorageID)),
                            Ui.SLIDE_LEFT);
                break;
 			case :BatterySaver_MenuID       :
                Ui.pushView(new YesNoPicker(Ui.loadResource(Rez.Strings.BatterySaver_MenuLabel), Ui.loadResource(Rez.Strings.BatterySaver_StorageID)),
                            new YesNoPickerDelegate(Ui.loadResource(Rez.Strings.BatterySaver_StorageID)),
                            Ui.SLIDE_LEFT);
                break;
        }

        Ui.requestUpdate();
    }
}