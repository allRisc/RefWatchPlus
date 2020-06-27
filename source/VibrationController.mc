using Toybox.Attention as Att;
using Toybox.System as Sys;

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
}