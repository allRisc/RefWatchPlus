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

using Toybox.System as Sys;

using ActivityTracking as Tracker;
using HelperFunctions as func;

class PlayingPeriod extends Period {
    var stoppageTime;
    var trackingStoppage;
    var stoppageStartTime;

    function initialize(dur) {
        Period.initialize(dur);

        if (AppData.getSeparateActivities() && ! Tracker.isActiveSession()) {
            Tracker.startTracking();
        }

        stoppageTime      = 0;
        trackingStoppage  = false;
        stoppageStartTime = 0;
    }

    // Function Called at start and stop of stoppage recording
    //  If starting it sets the stoppageStartTime
    //  If stopping it calculates the total time in this
    //      stoppage and adds it to the total fixed stoppage
    function stoppage() {
        trackingStoppage = !trackingStoppage;

        if (trackingStoppage) {
            stoppageStartTime = Sys.getTimer();
        } else {
            stoppageTime = stoppageTime + (Sys.getTimer() - stoppageStartTime);
        }
    }

    // Called to stop the period. Forces the stoppage counter off
    function stop() {
        Period.stop();

        trackingStoppage = false;
    }

    function end() {
        Period.end();
        
        if (AppData.getSeparateActivities() && Tracker.isActiveSession()) {
            Tracker.endTracking();
        }
    }

    /**********************************************************/
    /******************** Getter Functions ********************/
    /**********************************************************/

    // Get the number of milliseconds until the end of the current period
    // @return [Number] The number of milliseconds until the end of the current period
    function getMSecRemaining() {
        return Period.getMSecRemaining() + getMSecStoppage();
    }

    // Get the number of milliseconds of stoppage currently recorded for this period
    // @return [Number] The number of milliseconds of stoppage currently recorded for this period
    function getMSecStoppage() {
        if (trackingStoppage)
        {
            return stoppageTime + (Sys.getTimer() - stoppageStartTime);
        }

        return stoppageTime;
    }

    // Get the number of seconds of stoppage currently recorded for this period
    // @return [Number] The number of seconds of stoppage currently recorded for this period
    function getSecStoppage() {
        return func.msec2sec(getMSecStoppage());
    }

    // Get the number of seconds since the match started in NCAA mode (without stoppages)
    // @return [Number] the number of seconds since the start of the match (discounting stoppage)
    function getSecElapsedNCAA() {
    	return func.msec2sec(getMSecElapsed() - getMSecStoppage());
    }	

    // Determine if the session is currently recording stoppage time
    // @return [Boolean] True if currently recording stoppage time
    function isTrackingStoppage() {
        return trackingStoppage;
    }

    // Determine if the session is currently near stoppage time
    // @return [Boolean] True if currently within 1 minute stoppage time
    function isNearStoppage() {
        return (func.min2msec(periodDuration)-getMSecElapsed()) <= func.min2msec(1);
    }

    // Determine if the session is currently in stoppage time
    // @return [Boolean] True if currently in stoppage time
    function isInStoppage() {
        return (func.min2msec(periodDuration)-getMSecElapsed()) <= 0;
    }
}