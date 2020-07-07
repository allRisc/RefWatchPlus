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

module TimerHandler {
    var updateTimer = null;

    const CALLBACK_TIMER = 100;

    function initTimer() {
        if (updateTimer == null) {
            updateTimer = new Timer.Timer();
        }
    }

    function startUpdateTimer() {
        Test.assertMessage(updateTimer != null, "updateTimer uninitialized");

        var callBack = new Lang.Method(TimerHandler, :updateTimerCallback);
        updateTimer.start(callBack, CALLBACK_TIMER, true);

    }

    function stopUpdateTimer() {
        updateTimer.stop();
    }

    function updateTimerCallback() {
        Ui.requestUpdate();
    }
}