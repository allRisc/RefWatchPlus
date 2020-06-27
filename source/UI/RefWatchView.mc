using Toybox.WatchUi as Ui;
using Toybox.Timer as Timer;
using Toybox.Graphics as Gfx;
using Toybox.Attention as Att;
using Toybox.Lang;
using Toybox.Math;
using Toybox.Position as Pos;
using Toybox.Application as app;
using Toybox.System as Sys;

using HelperFunctions as func;
using ViewDrawables as draw;
using MatchData;
using VibrationController as Vib;

class RefWatchView extends Ui.View {

    const CALLBACK_TIMER = 100;

    var updateTimer;

    function initialize() {
        View.initialize();
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
        var curStoppage   = 0;

        // Set the timing information color based on current state of the timer
        var timeRemainingColor = Gfx.COLOR_WHITE;
        var timeElapsedColor   = Gfx.COLOR_WHITE;
        var curStoppageColor   = Gfx.COLOR_WHITE;
        var secRingColor       = draw.getGPSQualityColor(Pos.getInfo());

        draw.timeRemainingRing(secRingColor, (60-Sys.getClockTime().sec), 60, dc);
        draw.topLeftTime(timeRemainingColor, timeRemaining, dc);
        draw.centerClock(timeElapsedColor, dc);
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
        var timeElapsed   = MatchData.getSecPlayingTime();
        var curStoppage   = MatchData.getCurPeriod().getSecStoppage();
        var curPeriod     = MatchData.getCurPeriodNum();
        var periodTime;

        // Set the timing information color based on current state of the timer
        var timeRemainingColor = Gfx.COLOR_WHITE;
        var timeElapsedColor   = Gfx.COLOR_WHITE;
        var curStoppageColor   = Gfx.COLOR_WHITE;
        var curPeriodColor     = Gfx.COLOR_WHITE;
        var ringColor          = Gfx.COLOR_GREEN;

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

        if (MatchData.isOTPeriod()) {
            periodTime = func.min2sec(AppData.getOTPeriodLength());
        } else {
            periodTime = func.min2sec(AppData.getPeriodLength());
        }

        draw.timeRemainingRing(ringColor, timeRemaining, periodTime, dc);

        draw.topLeftTime(timeRemainingColor, timeRemaining, dc);
        draw.centerTime(timeElapsedColor, timeElapsed, dc);
        draw.topRightTime(curStoppageColor, curStoppage, dc);

        draw.period(curPeriodColor, curPeriod, dc);
    }

    ////////////////////////////////////////////////////////////////////////
    // Functions to manage vibrations                                     //
    ////////////////////////////////////////////////////////////////////////

    function handleVibration() {

        if (MatchData.isStarted()) {
            if (MatchData.isPlayingPeriod()) {
                if (periodComplete()) {
                    Vib.startStrongVib();
                } else if (stoppageComplete()) {
                    Vib.startStrongVib();
                } else if (stoppageTrackingStarted()) {
                    Vib.startWeakVib();
                } else if (stoppageTrackingReminder()) {
                    Vib.startMidVib();
                }
            } else {
                if (periodComplete()) {
                    Vib.startStrongVib();
                } else if (breakAlert()) {
                    Vib.startMidVib();
                }
            }
        }
    }

    hidden var prevElapsedTime = 0;
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

    hidden var prevRemainingTime = 0;
    function stoppageComplete() {

        if ( (prevRemainingTime > 0) &&
             (MatchData.getCurPeriod().getSecRemaining() <= 0) ) {
            prevRemainingTime = MatchData.getCurPeriod().getSecRemaining();
            return true;
        }

        prevRemainingTime = MatchData.getCurPeriod().getSecRemaining();
        return false;
    }

    hidden var prevTrackingStatus = false;
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

    hidden var prevNearComplete = false;
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
