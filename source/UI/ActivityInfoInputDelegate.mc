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

class ActivityInfoInputDelegate extends Ui.InputDelegate {
    var escPressTime;

    function initialize() {
        InputDelegate.initialize();

        escPressTime = 0;
    }
    
	// Handle a Key Press
    function onKey(evt) {

        if (evt.getKey() == Ui.KEY_ENTER) {
            if (!MatchData.isStarted()) {
                Vib.startStrongVib();
                MatchData.startMatch();
                MatchData.getCurPeriod().start();
                Ui.requestUpdate();
                return true;
            } else if (MatchData.isPlayingPeriod()) {
                if ( MatchData.getCurPeriod().isStarted() ) {
                    MatchData.getCurPeriod().stoppage();
                } else {
                	Vib.startStrongVib();
                    MatchData.getCurPeriod().start();
                }
                return true;
            }

        }

        if (evt.getKey() == Ui.KEY_ESC) {
            if (!MatchData.isStarted())
            {
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
        
        if (evt.getKey() == Ui.KEY_DOWN) {
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
  
  
  	function dispBack() {
        Ui.popView(Ui.SLIDE_DOWN);
        Ui.requestUpdate();
  	
  		return true;
  	}
}