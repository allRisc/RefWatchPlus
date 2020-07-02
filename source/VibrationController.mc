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
            weakVibProf = [new Att.VibeProfile( 50, 250),
                           new Att.VibeProfile(  0, 250),
                           new Att.VibeProfile( 50, 250)];

            midVibDur  = 1500;
            midVibProf = [new Att.VibeProfile( 75, 250),
                          new Att.VibeProfile(  0, 250),
                          new Att.VibeProfile( 75, 250),
                          new Att.VibeProfile(  0, 250),
                          new Att.VibeProfile( 75, 250)];

            strongVibDur  = 2000;
            strongVibProf = [new Att.VibeProfile(100, 500),
                             new Att.VibeProfile(  0, 125),
                             new Att.VibeProfile( 75, 125),
                             new Att.VibeProfile(  0, 125),
                             new Att.VibeProfile( 75, 125),
                             new Att.VibeProfile(  0, 125),
                             new Att.VibeProfile(100, 625)];

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
                    startWeakVib();
                } else if (stoppageTrackingReminder()) {
                    startMidVib();
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

        if ( (prevElapsedTime < perLen) &&
             (MatchData.getCurPeriod().getSecElapsed() >= perLen) ) {
            prevElapsedTime = MatchData.getCurPeriod().getSecElapsed();
            return true;
        }

        prevElapsedTime = MatchData.getCurPeriod().getSecElapsed();
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