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

import Toybox.Lang;

class Period {

  hidden var startTime as Number;
  hidden var periodDuration as Number;

  // Initialized the period class with a given durations
  // @param [Number] dur The duration in minutes of the period
  function initialize(dur as Number)  {
    startTime      = 0;
    periodDuration = dur;
  }

  // Start the period timer
  function start() as Void {
    startTime = Sys.getTimer();
  }

  // Stop the period timer
  function end() as Void {
    startTime = 0;
  }


  /**********************************************************/
  /******************** Getter Functions ********************/
  /**********************************************************/

  // Get the number of milliseconds since the match started
  // @return [Number] The number of milliseconds since the match started
  function getMSecElapsed() as Number {
    if (isStarted()) {
      return Sys.getTimer() - startTime;
    } else {
      return 0;
    }
  }

  // Get the number of seconds since the match started
  // @return [Number] The number of seconds since the match started
  function getSecElapsed() as Number {
    return func.msec2sec(getMSecElapsed());
  }

  // Get the number of milliseconds until the end of the current period
  // @return [Number] The number of milliseconds until the end of the current period
  function getMSecRemaining() as Number {
    return func.min2msec(periodDuration) - getMSecElapsed();
  }

  // Get the number of seconds until the end of the current period
  // @return [Number] The number of seconds until the end of the current period
  function getSecRemaining() as Number {
    return func.msec2sec_ceil(getMSecRemaining());
  }

  // Determine if the match is currently in progress
  // @return [Boolean] True if the match is currently in progress
  function isStarted() as Boolean {
    return startTime != 0;
  }

  // Return the expected number of minutes for the period
  function getPeriodLength() as Number {
    return periodDuration;
  }
}