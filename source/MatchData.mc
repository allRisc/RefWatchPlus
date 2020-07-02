using Toybox.WatchUi as Ui;
using Toybox.Application as app;
using Toybox.Application.Storage as Store;

using HelperFunctions as func;
using ActivityTracking as Tracker;

module MatchData {

    // Match Data
    var curPeriod;
    var breakPeriod;
    var playingPeriod;

    function initMatchData() {
        curPeriod     = null;
        breakPeriod   = 0;
        playingPeriod = 0;

        AppData.refreshAppData();
    }

    // Function which start the match
    function startMatch() {
        // If the match is not in progress
        if (playingPeriod == 0) {
            nextPeriod();

            Tracker.startTracking();
        }
    }

    // Function which completely ends the match
    function stopMatch() {
        Tracker.endTracking();

        initMatchData();
    }

    // Function which creates the next period
    function nextPeriod() {
        if (curPeriod != null) {
            curPeriod.end();
        }


        if (playingPeriod < AppData.getNumPeriods()) {
            if (playingPeriod <= breakPeriod) {
                curPeriod = new PlayingPeriod( AppData.getPeriodLength() );
                playingPeriod++;
            } else {
                curPeriod = new BreakPeriod( AppData.getBreakLength() );
                curPeriod.start();
                breakPeriod++;
            }
        } else if ( ( AppData.getNumOTPeriods() != 0 ) &&
                    ( playingPeriod < (AppData.getNumPeriods() + AppData.getNumOTPeriods()) ) ) {
            if (playingPeriod <= breakPeriod) {
                curPeriod = new PlayingPeriod( AppData.getOTPeriodLength() );
                playingPeriod++;
            } else {
                curPeriod = new BreakPeriod( AppData.getBreakLength() );
                curPeriod.start();
                breakPeriod++;
            }
        } else {
            stopMatch();
            return;
        }
    }

    function isPlayingPeriod() {
        return playingPeriod > breakPeriod;
    }

    function isStarted() {
        return playingPeriod != 0;
    }

    function getCurPeriod() {
        return curPeriod;
    }

    function getCurPeriodNum() {
        return playingPeriod;
    }

    function isOTPeriod() {
        return playingPeriod >= AppData.getNumPeriods();
    }

    function getSecPlayingTime() {
        var pTime = 0;
        if (playingPeriod <= AppData.getNumPeriods()) {
            pTime = ((playingPeriod-1) * func.min2sec(AppData.getPeriodLength()));
        } else {
            pTime = AppData.getNumPeriods() * func.min2sec(AppData.getPeriodLength());
            pTime = pTime + ( (playingPeriod - 1 - AppData.getNumPeriods())
                             * func.min2sec(AppData.getOTPeriodLength()) );
        }

        pTime = pTime + curPeriod.getSecElapsed();
        return pTime;
    }
}