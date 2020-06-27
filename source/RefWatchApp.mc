using Toybox.Application as app;
using Toybox.WatchUi;
using Toybox.Position as Pos;
using Toybox.Sensor as Sensor;

using VibrationController as Vib;

class RefWatchApp extends app.AppBase {

    function initialize() {
        AppBase.initialize();

        AppData.initAppData();
        Vib.initialize();

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
