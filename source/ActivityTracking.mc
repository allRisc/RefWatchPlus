using Toybox.ActivityRecording as ActRec;
using Toybox.WatchUi as Ui;
using Toybox.Activity as Act;

module ActivityTracking {
    const METER_PER_MILE = 1609.344;

    var actRecSession;

    function initTracker() {

    }

    function startTracking() {
        actRecSession = ActRec.createSession( { :name=>"Match", :sport=>ActRec.SPORT_SOCCER, :subsport=>ActRec.SUB_SPORT_GENERIC } );
        if( actRecSession != null )
        {
            var started = false;
            do{
                started = actRecSession.start();
            }
            while(!started);
        }
    }

    function endTracking() {
        if( actRecSession != null && actRecSession.isRecording() )
        {
            var stopped = false;
            var saved   = false;
            do{
            stopped = actRecSession.stop();
            }
            while(stopped == false);

            do {
                saved = actRecSession.save();
            }
            while( saved == false );


            actRecSession = null;
            Ui.requestUpdate();
        }

        actRecSession = null;
    }

    function getCurHeartRate() {
        var info = Act.getActivityInfo().currentHeartRate;
        if (info != null) {
            return info;
        }

        return 0;
    }

    function getCurDistM() {
        var info = Act.getActivityInfo().elapsedDistance;
        if (info != null) {
            return info;
        }

        return 0;
    }

    function getCurDistKM() {
        return getCurDistM().toFloat() / 1000.0;
    }

    function getCurDistMi() {
        return getCurDistM().toFloat() / METER_PER_MILE;
    }
}