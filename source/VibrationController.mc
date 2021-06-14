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

using Toybox.Attention as Att;
using Toybox.System as Sys;

using HelperFunctions as func;

module VibrationController {
    var weakVibDur;
    var weakVibProf;
    var midVibDur;
    var midVibProf;
    var strongVibDur;
    var strongVibProf;

    var nextVibTime;

    function initialize() {
        if (Att has :vibrate) {
            weakVibDur  = 1000;
            weakVibProf = [new Att.VibeProfile( 75, 250),
                           new Att.VibeProfile(  0, 250),
                           new Att.VibeProfile( 75, 250)];

            midVibDur  = 1500;
            midVibProf = [new Att.VibeProfile( 75, 250),
                          new Att.VibeProfile(  0, 250),
                          new Att.VibeProfile( 75, 250),
                          new Att.VibeProfile(  0, 250),
                          new Att.VibeProfile( 75, 250)];

            strongVibDur  = 3000;
            strongVibProf = [new Att.VibeProfile(100, 750),
                             new Att.VibeProfile(  0, 125),
                             new Att.VibeProfile( 75, 125),
                             new Att.VibeProfile(  0, 125),
                             new Att.VibeProfile( 75, 125),
                             new Att.VibeProfile(  0, 125),
                             new Att.VibeProfile(100, 1500)];

            strongVibDur  = 2000;
        }

        nextVibTime = 0;
    }

    function vibReady() {
        return nextVibTime < Sys.getTimer();
    }

    function startWeakVib() {
        if (vibReady()) {
            nextVibTime = Sys.getTimer() + weakVibDur;
            Att.vibrate(weakVibProf);
        }
    }

    function startMidVib() {
        if (vibReady()) {
            nextVibTime = Sys.getTimer() + midVibDur;
            Att.vibrate(midVibProf);
        }
    }

    function startStrongVib() {
        if (vibReady()) {
            nextVibTime = Sys.getTimer() + strongVibDur;
            Att.vibrate(strongVibProf);
        }
    }

    ////////////////////////////////////////////////////////////////////////
    // Functions to manage vibrations                                     //
    ////////////////////////////////////////////////////////////////////////

    function handleVibration() {

        if (MatchData.isStarted()) {
            if (MatchData.isPlayingPeriod()) {
                if (periodComplete()) {
                    startStrongVib();
                } else if (stoppageComplete()) {
                    startStrongVib();
                } else if (stoppageTrackingStarted()) {
                    startMidVib();
                } else if (stoppageTrackingReminder()) {
                    startWeakVib();
                }
            } else {
                if (periodComplete()) {
                    startStrongVib();
                } else if (breakAlert()) {
                    startMidVib();
                }
            }
        }
    }

    var prevElapsedTime = 0;
    function periodComplete() {
        var perLen = func.min2sec(MatchData.getCurPeriod().getPeriodLength());
        var elapsedTime = MatchData.getCurPeriod().getSecElapsed();
        
        if (AppData.getNCAAMode()) {
        	elapsedTime = MatchData.getCurPeriod().getSecElapsedNCAA();
        }

        if ( (prevElapsedTime < perLen) &&
             (elapsedTime >= perLen) ) {
            prevElapsedTime = elapsedTime;
            return true;
        }

        prevElapsedTime = elapsedTime;
        return false;
    }

    var prevRemainingTime = 0;
    function stoppageComplete() {

        if ( (prevRemainingTime > 0) &&
             (MatchData.getCurPeriod().getSecRemaining() <= 0) ) {
            prevRemainingTime = MatchData.getCurPeriod().getSecRemaining();
            return true;
        }

        prevRemainingTime = MatchData.getCurPeriod().getSecRemaining();
        return false;
    }

    var prevTrackingStatus = false;
    function stoppageTrackingStarted() {

        if ( prevTrackingStatus != MatchData.getCurPeriod().isTrackingStoppage() &&
             MatchData.getCurPeriod().isTrackingStoppage()) {
            prevTrackingStatus = MatchData.getCurPeriod().isTrackingStoppage();
            return true;
        }

        prevTrackingStatus = MatchData.getCurPeriod().isTrackingStoppage();
        return false;
    }

    function stoppageTrackingReminder() {

        if (MatchData.getCurPeriod().isTrackingStoppage()) {
            if (MatchData.getCurPeriod().getSecStoppage() % 10 == 0) {
                return true;
            }
        }

        return false;
    }

    var prevNearComplete = false;
    function breakAlert() {
        if ( prevNearComplete != MatchData.getCurPeriod().isNearComplete() &&
             MatchData.getCurPeriod().isNearComplete()) {
            prevNearComplete = MatchData.getCurPeriod().isNearComplete();
            return true;
        }

        prevNearComplete = MatchData.getCurPeriod().isNearComplete();
        return false;
    }
}