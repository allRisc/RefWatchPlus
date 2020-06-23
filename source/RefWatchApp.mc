using Toybox.Application as app;
using Toybox.WatchUi;
using Toybox.Position as Pos;
using Toybox.Sensor as Sensor;

class RefWatchApp extends app.AppBase {

    function initialize() {
        AppBase.initialize();

        var prop = getProperty("period_time");
        if (prop == null) {
            setProperty("period_time", 45);
        }

        prop = getProperty("num_periods");
        if (prop == null) {
            setProperty("num_periods", 2);
        }

        prop = getProperty("ot_period_time");
        if (prop == null) {
            setProperty("ot_period_time", 15);
        }

        prop = getProperty("num_ot_periods");
        if (prop == null) {
            setProperty("num_ot_periods", 2);
        }

        prop = getProperty("enable_ot");
        if (prop == null) {
            setProperty("enable_ot", true);
        }

        prop = getProperty("break_period_time");
        if (prop == null) {
            setProperty("break_period_time", 15);
        }

        prop = getProperty("break_alert");
        if (prop == null) {
            setProperty("break_alert", 3);
        }

        // Enable GPS
        Pos.enableLocationEvents( Pos.LOCATION_CONTINUOUS, method(:onPosition));

        // Enable HeartRate Sensor
        var sensorsenabled = Sensor.setEnabledSensors([Sensor.SENSOR_HEARTRATE]);

        // Initialize MatchSession
        MatchData.initMatchData();
    }

    // onStart() is called on application start up
    function onStart(state) {
    }

    // onStop() is called when your application is exiting
    function onStop(state) {
        MatchData.stopMatch();
    }

    // Return the initial view of your application here
    function getInitialView() {
        return [ new RefWatchView(), new RefWatchInputDelegate() ];
    }

    function onPosition() {
    }

}
