using Toybox.ActivityRecording as ActRec;
using Toybox.WatchUi as Ui;
using Toybox.Application as app;


module MatchData {
    var actRecSession;

    var curPeriod;
    var curPeriodNum;
    var playingPeriod;

    function initMatchData() {
        curPeriod     = null;
        curPeriodNum  = 0;
        playingPeriod = false;
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


        if (curPeriodNum < 2*app.getApp().getProperty("num_periods")) {
            if (playingPeriod) {
                curPeriod = new PlayingPeriod(app.getApp().getProperty("period_time"));
            } else {
                curPeriod = new BreakPeriod(app.getApp().getProperty("break_period_time"));
                curPeriod.start();
            }
        } else if (app.getApp().getProperty("enable_ot") &&
                    (curPeriodNum < 2*(app.getApp().getProperty("num_ot_periods") + app.getApp().getProperty("num_periods")))) {
            if (playingPeriod) {
                curPeriod = new PlayingPeriod(app.getApp().getProperty("ot_period_time"));
            } else {
                curPeriod = new BreakPeriod(app.getApp().getProperty("break_period_time"));
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