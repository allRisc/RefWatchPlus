/***************************************************************************
 * RefWatchPlus is a FOSS app made for reffing soccer and tracking time.
 * Copyright (C) 2023  Benjamin Davis
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <https://www.gnu.org/licenses/>.
 ***************************************************************************/

using Toybox.Attention as Att;
using Toybox.System as Sys;

using HelperFunctions as func;

import Toybox.Lang;

module Vibration {
  const weakVibDur = 1000;
  var weakVibProf as Array<Att.VibeProfile> = new Array<Att.VibeProfile>[3];

  const midVibDur = 1500;
  var midVibProf as Array<Att.VibeProfile> = new Array<Att.VibeProfile>[5];

  const strongVibDur = 3000;
  var strongVibProf as Array<Att.VibeProfile> = new Array<Att.VibeProfile>[7];

  var nextVibTime as Number = 0;

  function initialize () as Void {
    weakVibProf[0] = new Att.VibeProfile( 75, 250);
    weakVibProf[1] = new Att.VibeProfile(  0, 250);
    weakVibProf[2] = new Att.VibeProfile( 75, 250);

    midVibProf[0] =  new Att.VibeProfile( 75, 250);
    midVibProf[1] =  new Att.VibeProfile(  0, 250);
    midVibProf[2] =  new Att.VibeProfile( 75, 250);
    midVibProf[3] =  new Att.VibeProfile(  0, 250);
    midVibProf[4] =  new Att.VibeProfile( 75, 250);

    strongVibProf[0] = new Att.VibeProfile(100, 750);
    strongVibProf[1] = new Att.VibeProfile(  0, 125);
    strongVibProf[2] = new Att.VibeProfile( 75, 125);
    strongVibProf[3] = new Att.VibeProfile(  0, 125);
    strongVibProf[4] = new Att.VibeProfile( 75, 125);
    strongVibProf[5] = new Att.VibeProfile(  0, 125);
    strongVibProf[6] = new Att.VibeProfile(100, 1500);
  }

  function vibReady() as Boolean {
    return nextVibTime < Sys.getTimer();
  }

  function startWeakVib() as Void {
    if (vibReady()) {
      nextVibTime = Sys.getTimer() + weakVibDur;
      Att.vibrate(weakVibProf);
    }
  }

  function startMidVib() as Void {
    if (vibReady()) {
      nextVibTime = Sys.getTimer() + midVibDur;
      Att.vibrate(midVibProf);
    }
  }

  function startStrongVib() as Void {
    if (vibReady()) {
      nextVibTime = Sys.getTimer() + strongVibDur;
      Att.vibrate(strongVibProf);
    }
  }

  // TODO: Move the below functions
  ////////////////////////////////////////////////////////////////////////
  // Functions to manage vibrations                                     //
  ////////////////////////////////////////////////////////////////////////

  // function handleVibration() {

  //     if (MatchData.isStarted()) {
  //         if (MatchData.isPlayingPeriod()) {
  //             if (periodComplete()) {
  //                 startStrongVib();
  //             } else if (stoppageComplete()) {
  //                 startStrongVib();
  //             } else if (stoppageTrackingStarted()) {
  //                 startMidVib();
  //             } else if (stoppageTrackingReminder()) {
  //                 startWeakVib();
  //             }
  //         } else {
  //             if (periodComplete()) {
  //                 startStrongVib();
  //             } else if (breakAlert()) {
  //                 startMidVib();
  //             }
  //         }
  //     }
  // }

  // var prevElapsedTime = 0;
  // function periodComplete() {
  //     var perLen = func.min2sec(MatchData.getCurPeriod().getPeriodLength());
  //     var elapsedTime = MatchData.getCurPeriod().getSecElapsed();

  //     if (AppData.getNCAAMode()) {
  //       elapsedTime = MatchData.getCurPeriod().getSecElapsedNCAA();
  //     }

  //     if ( (prevElapsedTime < perLen) &&
  //           (elapsedTime >= perLen) ) {
  //         prevElapsedTime = elapsedTime;
  //         return true;
  //     }

  //     prevElapsedTime = elapsedTime;
  //     return false;
  // }

  // var prevRemainingTime = 0;
  // function stoppageComplete() {

  //     if ( (prevRemainingTime > 0) &&
  //           (MatchData.getCurPeriod().getSecRemaining() <= 0) ) {
  //         prevRemainingTime = MatchData.getCurPeriod().getSecRemaining();
  //         return true;
  //     }

  //     prevRemainingTime = MatchData.getCurPeriod().getSecRemaining();
  //     return false;
  // }

  // var prevTrackingStatus = false;
  // function stoppageTrackingStarted() {

  //     if ( prevTrackingStatus != MatchData.getCurPeriod().isTrackingStoppage() &&
  //           MatchData.getCurPeriod().isTrackingStoppage()) {
  //         prevTrackingStatus = MatchData.getCurPeriod().isTrackingStoppage();
  //         return true;
  //     }

  //     prevTrackingStatus = MatchData.getCurPeriod().isTrackingStoppage();
  //     return false;
  // }

  // function stoppageTrackingReminder() {

  //     if (MatchData.getCurPeriod().isTrackingStoppage()) {
  //         if (MatchData.getCurPeriod().getSecStoppage() % AppData.getReminderInterval() == 0) {
  //             return true;
  //         }
  //     }

  //     return false;
  // }

  // var prevNearComplete = false;
  // function breakAlert() {
  //     if ( prevNearComplete != MatchData.getCurPeriod().isNearComplete() &&
  //           MatchData.getCurPeriod().isNearComplete()) {
  //         prevNearComplete = MatchData.getCurPeriod().isNearComplete();
  //         return true;
  //     }

  //     prevNearComplete = MatchData.getCurPeriod().isNearComplete();
  //     return false;
  // }
}