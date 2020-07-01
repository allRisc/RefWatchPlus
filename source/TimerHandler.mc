using Toybox.Timer;
using Toybox.WatchUi as Ui;
using Toybox.Lang;

class TimerHandler {
    static var updateTimer;

    static const CALLBACK_TIMER = 100;

    function initialize() {
        if (updateTimer == null) {
            updateTimer = new Timer.Timer();
        }
    }

    static function initTimer() {
        if (updateTimer == null) {
            updateTimer = new Timer.Timer();
        }
    }

    static function startUpdateTimer() {
        var callBack = new Lang.Method(TimerHandler, :updateTimerCallback);
        updateTimer.start( callBack, CALLBACK_TIMER, true);
    }

    static function stopUpdateTimer() {
        updateTimer.stop();
    }

    static function updateTimerCallback() {
        Ui.requestUpdate();
    }
}