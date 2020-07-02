using Toybox.Timer;
using Toybox.WatchUi as Ui;
using Toybox.Lang;
using Toybox.Test;

module TimerHandler {
    var updateTimer;

    const CALLBACK_TIMER = 100;

    function initTimer() {
        if (updateTimer == null) {
            updateTimer = new Timer.Timer();
        }
    }

    function startUpdateTimer() {
        Test.assertMessage(updateTimer != null, "updateTimer uninitialized");

        var callBack = new Lang.Method(TimerHandler, :updateTimerCallback);
        updateTimer.start(callBack, CALLBACK_TIMER, true);

    }

    function stopUpdateTimer() {
        updateTimer.stop();
    }

    function updateTimerCallback() {
        Ui.requestUpdate();
    }
}