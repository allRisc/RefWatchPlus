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
 
using Toybox.Timer;
using Toybox.WatchUi as Ui;
using Toybox.Lang;
using Toybox.Test;
using Toybox.System as Sys;

module RefreshTimer {
    var updateTimer = null;
    var batterySaverMode;
    var modeUpdated;
    var running;

    const PERFORMANCE_TIMER = 100;
    const BATTERY_SAVER_TIMER = 500;

    function initTimer(batterySaver) {
        if (updateTimer == null) {
            updateTimer = new Timer.Timer();
        }
        
        batterySaverMode = batterySaver;
        running = false;
        modeUpdated = false;
    }

    function startTimer() {
        if (Toybox has :Test) {
            Test.assertMessage(updateTimer != null, "updateTimer uninitialized");
        }

        var callBack = new Lang.Method(RefreshTimer, :updateTimerCallback);
        
        if (!running) {
        	if (batterySaverMode) {
        		updateTimer.start(callBack, BATTERY_SAVER_TIMER, true);
        	} else {
        		updateTimer.start(callBack, PERFORMANCE_TIMER, true);	
        	}
    	}
        
        running = true;
    }

    function stopTimer() {
        updateTimer.stop();
        running = false;
    }

	function updateBatterSaver(batterySaver) {
		modeUpdated = true;
		batterySaverMode = batterySaver;
	}

    function updateTimerCallback() {
    	if (modeUpdated) {
    		stopTimer();
    		startTimer();
    		modeUpdated = false;
    	}
        Ui.requestUpdate();
    }
}