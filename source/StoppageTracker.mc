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

class StoppageTracker {

  hidden var startTime as Number;
  hidden var stoppage as Number;

  // Initialized the period class with a given durations
  // @param [Number] dur The duration in minutes of the period
  function initialize()  {
    startTime = 0;
    stoppage  = 0;
  }

  // Start the period timer
  function start() as Void {
    startTime = Sys.getTimer();
  }

  // Stop the period timer
  function stop() as Void {
    stoppage += (Sys.getTimer() - startTime);
    startTime = 0;
  }


  /**********************************************************/
  /******************** Getter Functions ********************/
  /**********************************************************/

  // Get the number of milliseconds of stoppage currently recorded
  // @return [Number] The number of milliseconds of stoppage currently recorded
  function getMSec() as Number {
    if (isTracking()) {
      return stoppage + (Sys.getTimer() - startTime);
    } else {
      return stoppage;
    }
  }

  // Get the number of seconds of stoppage currently recorded
  // @return [Number] The number of seconds of stoppage currently recorded
  function getSec() as Number {
    return func.msec2sec(getMSec());
  }

  // Determine if stoppage is currently being tracked
  // @return [Boolean] True if stoppage is currently being tracked
  function isTracking() as Boolean {
    return startTime != 0;
  }

}