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
using VibrationController as Vib;
using Menus;

class GenericDelegate extends Ui.InputDelegate {

    var escPressTime;

    function initialize() {
        InputDelegate.initialize();

        escPressTime = 0;
    }

	// Handle a keyed input
    function onKey(evt) {
        // var keynum = Lang.format("K $1$", [evt.getKey()]);
        // Sys.println(keynum);

		// If the start key is hit
        if (evt.getKey() == Ui.KEY_ENTER) {
            // Start the match
            if (!MatchData.isStarted()) {
                Vib.startStrongVib();
                MatchData.startMatch();
                MatchData.getCurPeriod().start();
                Ui.requestUpdate();
                return true;
            }
            else if (MatchData.isPlayingPeriod()) {
            	// If the playing period is already underway toggle the stoppage counter
            	// Else start it
                if ( MatchData.getCurPeriod().isStarted() ) {
                    MatchData.getCurPeriod().stoppage();
                } else {
                	Vib.startStrongVib();
                    MatchData.getCurPeriod().start();
                }
                return true;
            }
        }

		// Handle the escape key for moving to next period. Only works on double press
        if (evt.getKey() == Ui.KEY_ESC) {
            if (!MatchData.isStarted()) {
                return false;
            }

            var time = Sys.getTimer();

            if (time - escPressTime <= func.sec2msec(1)) {
                MatchData.nextPeriod();
                escPressTime = 0;
            } else {
                escPressTime = time;
            }
            return true;
        }
        
        // Handle the menu key press
		if (evt.getKey() == Ui.KEY_MENU) {
    		return dispMainMenu();
    	}

        return false;
    }
    
    // Display the main menu
    function dispMainMenu() {
    	var MainMenu = Menus.getMainMenu(); //new Rez.Menus.MainMenu(); 
        Ui.pushView( MainMenu, new MainMenuInputDelegate(), Ui.SLIDE_RIGHT );
        Ui.requestUpdate();
        return true;
    }
    
    // Display the activity view
    function dispActivityView() {
   	 	Ui.pushView( new ActivityInfoView(), new ActivityInfoInputDelegate(), Ui.SLIDE_UP );
        Ui.requestUpdate();
    	return true;
    }
    
    // Display the device info view
    function dispDevInfoView() {
   	 	Ui.pushView( new DeviceInfoView(), new DeviceInfoInputDelegate(), Ui.SLIDE_DOWN );
        Ui.requestUpdate();
    	return true;
    }
    
  	// Go back to the last display
  	function dispBack() {
        Ui.popView(Ui.SLIDE_DOWN);
        Ui.requestUpdate();
  	
  		return true;
  	}
}