using Toybox.Application as app;
using Toybox.WatchUi;
using Toybox.Position as Pos;
using Toybox.Sensor as Sensor;

class RefWatchApp extends app.AppBase {

    function initialize() {
        AppBase.initialize();

        var prop = getProperty(Rez.Strings.PeriodLength_PropID.toString());
        if (prop == NULL) {
            setProperty(Rez.Strings.PeriodLength_PropID.toString(), 45);
        }

        prop = getProperty(Rez.Strings.NumPeriods_PropID.toString());
        if (prop == NULL) {
            setProperty(Rez.Strings.NumPeriods_PropID.toString(), 45);
        }

        prop = getProperty(Rez.Strings.BreakLength_PropID.toString());
        if (prop == NULL) {
            setProperty(Rez.Strings.BreakLength_PropID.toString(), 45);
        }

        prop = getProperty(Rez.Strings.BreakAlert_PropID.toString());
        if (prop == NULL) {
            setProperty(Rez.Strings.BreakAlert_PropID.toString(), 45);
        }

        prop = getProperty(Rez.Strings.OTPeriodLength_PropID.toString());
        if (prop == NULL) {
            setProperty(Rez.Strings.OTPeriodLength_PropID.toString(), 45);
        }

        prop = getProperty(Rez.Strings.NumOTPeriods_PropID.toString());
        if (prop == NULL) {
            setProperty(Rez.Strings.NumOTPeriods_PropID.toString(), 45);
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
