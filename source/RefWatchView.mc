using Toybox.WatchUi as Ui;
using Toybox.Timer as Timer;
using Toybox.Graphics as Gfx;
using Toybox.Attention as Att;
using Toybox.Lang;
using Toybox.Math;
using Toybox.Position as Pos;
using Toybox.Application as app;

using HelperFunctions as func;
using ViewDrawables as draw;

class RefWatchView extends Ui.View {

    const CALLBACK_TIMER = 100;

    var updateTimer;

    var vibProf;
    var vibStarted;

    function initialize() {
        View.initialize();

        if (Att has :vibrate) {
            vibProf = new Att.VibeProfile(75, 1000);
        }

        vibStarted = false;
    }

    // Load your resources here
    function onLayout(dc) {
        updateTimer = new Timer.Timer();
        updateTimer.start( method(:timerCallback), CALLBACK_TIMER, true);
    }

    function timerCallback() {
        Ui.requestUpdate();
    }

    // Called when this View is brought to the foreground. Restore
    // the state of this View and prepare it to be shown. This includes
    // loading resources into memory.
    function onShow() {
    }

    // Update the view
    function onUpdate(dc) {
        drawScreen(dc);
        handleVibration();
    }

    function handleVibration() {
//
//        if ((MatchSession.getSecStoppage() % 10 == 0) && (MatchSession.getSecStoppage() > 0))
//        {
//            if ((vibProf != null) && (MatchSession.isTrackingStoppage()) && !vibStarted)
//            {
//                Att.vibrate([vibProf]);
//            }
//        }
//        else
//        {
//            vibStarted = false;
//        }
    }

    // Called when this View is removed from the screen. Save the
    // state of this View here. This includes freeing resources from
    // memory.
    function onHide() {
    }

    // Control function for main display panel
    function drawScreen(dc) {
        draw.clearScreen(dc);

        // Get current timing Information
        if (!MatchData.isStarted())
        {
            drawIdleScreen(dc);
        }
        else if (MatchData.isPlayingPeriod())
        {
            drawPlayingScreen(dc);
        }
        else
        {
            drawBreakScreen(dc);
        }

    }

    function drawIdleScreen(dc) {

        var timeRemaining = func.min2sec( AppData.getPeriodLength() );
        var timeElapsed   = 0;
        var curStoppage   = 0;

        // Set the timing information color based on current state of the timer
        var timeRemainingColor = Gfx.COLOR_WHITE;
        var timeElapsedColor   = Gfx.COLOR_WHITE;
        var curStoppageColor   = Gfx.COLOR_WHITE;

        draw.gpsRing(dc);
        draw.topLeftTime(timeRemainingColor, timeRemaining, dc);
        draw.centerTime(timeElapsedColor, timeElapsed, dc);
        draw.topRightTime(curStoppageColor, curStoppage, dc);
    }

    function drawBreakScreen(dc) {
        var timeRemaining = MatchData.getCurPeriod().getSecRemaining();
        var curPeriod     = MatchData.getCurPeriodNum();

        // Set the timing information color based on current state of the timer
        var timeRemainingColor = Gfx.COLOR_WHITE;
        var curPeriodColor     = Gfx.COLOR_WHITE;

        if (MatchData.getCurPeriod().isNearComplete())
        {
            timeRemainingColor = Gfx.COLOR_RED;
        }

        draw.centerTime(timeRemainingColor, timeRemaining, dc);
        draw.period(curPeriodColor, curPeriod, dc);
    }

    function drawPlayingScreen(dc) {
        var timeRemaining = MatchData.getCurPeriod().getSecRemaining();
        var timeElapsed   = MatchData.getCurPeriod().getSecElapsed();
        var curStoppage   = MatchData.getCurPeriod().getSecStoppage();
        var curPeriod     = MatchData.getCurPeriodNum();

        // Set the timing information color based on current state of the timer
        var timeRemainingColor = Gfx.COLOR_WHITE;
        var timeElapsedColor   = Gfx.COLOR_WHITE;
        var curStoppageColor   = Gfx.COLOR_WHITE;
        var curPeriodColor     = Gfx.COLOR_WHITE;

        if (MatchData.getCurPeriod().isInStoppage())
        {
            timeElapsedColor = Gfx.COLOR_RED;
        }
        else if (MatchData.getCurPeriod().isNearStoppage())
        {
            timeElapsedColor = Gfx.COLOR_YELLOW;
        }

        if (MatchData.getCurPeriod().isTrackingStoppage())
        {
            curStoppageColor = Gfx.COLOR_ORANGE;
        }

        draw.topLeftTime(timeRemainingColor, timeRemaining, dc);
        draw.centerTime(timeElapsedColor, timeElapsed, dc);
        draw.topRightTime(curStoppageColor, curStoppage, dc);

        draw.period(curPeriodColor, curPeriod, dc);
    }
}
