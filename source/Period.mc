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

using HelperFunctions as func;

class Period {

    hidden var startTime;
    hidden var periodDuration;

    // Initialized the period class with a given durations
    // @param [Number] dur The duration in minutes of the period
    function initialize(dur) {
        startTime      = 0;
        periodDuration = dur;
    }

    // Start the period timer
    function start() {
        startTime = Sys.getTimer();
    }

    // Stop the period timer
    function end() {
        startTime = 0;
    }


    /**********************************************************/
    /******************** Getter Functions ********************/
    /**********************************************************/

    // Get the number of milliseconds since the match started
    // @return [Number] The number of milliseconds since the match started
    function getMSecElapsed() {
        if (isStarted()) {
            return Sys.getTimer() - startTime;
        } else {
            return 0;
        }
    }

    // Get the number of seconds since the match started
    // @return [Number] The number of seconds since the match started
    function getSecElapsed() {
        return func.msec2sec(getMSecElapsed());
    }
    
    // Get the number of seconds since the match started in NCAA mode (without stoppages)
    // @return [Number] the number of seconds since the start of the match (discounting stoppage)
    function getSecElapsedNCAA() {
    	return func.msec2sec(getMSecElapsed());
    }

    // Get the number of milliseconds until the end of the current period
    // @return [Number] The number of milliseconds until the end of the current period
    function getMSecRemaining() {
        return func.min2msec(periodDuration) - getMSecElapsed();
    }

    // Get the number of seconds until the end of the current period
    // @return [Number] The number of seconds until the end of the current period
    function getSecRemaining() {
        return func.msec2sec_ceil(getMSecRemaining());
    }

    // Determine if the match is currently in progress
    // @return [Boolean] True if the match is currently in progress
    function isStarted() {
        return startTime != 0;
    }

    // Return the expected number of minutes for the period
    function getPeriodLength() {
        return periodDuration;
    }
}