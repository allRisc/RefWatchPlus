using Toybox.ActivityRecording as ActRec;
using Toybox.WatchUi as Ui;
using Toybox.Application as app;
using Toybox.Application.Storage as Store;


module MatchData {
    var actRecSession;

    // Match Data
    var curPeriod;
    var curPeriodNum;
    var playingPeriod;

    function initMatchData() {
        curPeriod     = null;
        curPeriodNum  = 0;
        playingPeriod = false;

        AppData.refreshAppData();
    }

    // Function which start the match
    function startMatch() {
        // If the match is in progress
        if (curPeriodNum == 0) {
            nextPeriod();

            actRecSession = ActRec.createSession( { :name=>"Match", :sport=>ActRec.SPORT_RUNNING, :subsport=>ActRec.SUB_SPORT_GENERIC } );
            if( actRecSession != null )
            {
                var started = false;
                do{
                    started = actRecSession.start();
                }
                while(!started);
            }
        }
    }

    // Function which completely ends the match
    function stopMatch() {
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

        initMatchData();
    }

    // Function which creates the next period
    function nextPeriod() {
        curPeriodNum++;
        playingPeriod = !playingPeriod;

        if (curPeriod != null) {
            curPeriod.end();
        }


        if (curPeriodNum < 2*numPeriods) {
            if (playingPeriod) {
                curPeriod = new PlayingPeriod( AppData.getPeriodLength() );
            } else {
                curPeriod = new BreakPeriod( AppData.getBreakLength() );
                curPeriod.start();
            }
        } else if ( ( AppData.getNumOTPeriods() != 0 ) &&
                    ( curPeriodNum < 2 * (AppData.getNumPeriods() + AppData.getNumOTPeriods()) ) ) {
            if (playingPeriod) {
                curPeriod = new PlayingPeriod( AppData.getOTPeriodLength() );
            } else {
                curPeriod = new BreakPeriod( AppData.getBreakLength() );
                curPeriod.start();
            }
        } else {
            stopMatch();
            return;
        }
    }

    function isPlayingPeriod() {
        return playingPeriod;
    }

    function isStarted() {
        return curPeriodNum != 0;
    }

    function getCurPeriod() {
        return curPeriod;
    }

    function getCurPeriodNum() {
        return curPeriodNum;
    }
}