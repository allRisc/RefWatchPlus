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
using Toybox.Application as app;
using Toybox.Application.Storage as Store;

using HelperFunctions as func;
using ActivityTracking as Tracker;

module MatchData {

    // Match Data
    var curPeriod;
    var breakPeriod;
    var playingPeriod;

    function initMatchData() {
        curPeriod     = null;
        breakPeriod   = 0;
        playingPeriod = 0;

        AppData.refreshAppData();
    }

    // Function which start the match
    function startMatch() {
        // If the match is not in progress
        if (playingPeriod == 0) {
            nextPeriod();

            // If the Separate Activities option is on, then
            // tracking is managed within the PlayingPeriod.
            // Otherwise start tracking here.
            if (! AppData.getSeparateActivities()) {
                Tracker.startTracking();
            }
        }
    }

    // Function which completely ends the match
    function stopMatch() {
        if (Tracker.isActiveSession()) {
            Tracker.endTracking();
        }

        initMatchData();
    }

    // Function which creates the next period
    function nextPeriod() {
        if (curPeriod != null) {
            curPeriod.end();
        }


        if (playingPeriod < AppData.getNumPeriods()) {
            if (playingPeriod <= breakPeriod) {
                curPeriod = new PlayingPeriod( AppData.getPeriodLength() );
                playingPeriod++;
            } else {
                curPeriod = new BreakPeriod( AppData.getBreakLength() );
                curPeriod.start();
                breakPeriod++;
            }
        } else if ( ( AppData.getNumOTPeriods() != 0 ) &&
                    ( playingPeriod < (AppData.getNumPeriods() + AppData.getNumOTPeriods()) ) ) {
            if (playingPeriod <= breakPeriod) {
                curPeriod = new PlayingPeriod( AppData.getOTPeriodLength() );
                playingPeriod++;
            } else {
                curPeriod = new BreakPeriod( AppData.getBreakLength() );
                curPeriod.start();
                breakPeriod++;
            }
        } else {
            stopMatch();
            return;
        }

        // If we are not treating each period as a separate
        // activity, then we'll use laps instead.
        if (! AppData.getSeparateActivities()) {
            Tracker.addLap();
        }
    }

    function isPlayingPeriod() {
        return playingPeriod > breakPeriod;
    }

    function isStarted() {
        return playingPeriod != 0;
    }

    function getCurPeriod() {
        return curPeriod;
    }

    function getCurPeriodNum() {
        return playingPeriod;
    }

    function isOTPeriod() {
        return playingPeriod > AppData.getNumPeriods();
    }

    function getSecPlayingTime() {
        var pTime = 0;
        if (playingPeriod <= AppData.getNumPeriods()) {
            pTime = ((playingPeriod-1) * func.min2sec(AppData.getPeriodLength()));
        } else {
            pTime = AppData.getNumPeriods() * func.min2sec(AppData.getPeriodLength());
            pTime = pTime + ( (playingPeriod - 1 - AppData.getNumPeriods())
                             * func.min2sec(AppData.getOTPeriodLength()) );
        }

		if(!AppData.getNCAAMode()) {
        	pTime = pTime + curPeriod.getSecElapsed();
    	} else {
    		pTime = pTime + curPeriod.getSecElapsedNCAA();
		}
        return pTime;
    }
}
