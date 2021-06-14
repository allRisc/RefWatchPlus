/***************************************************************************
 * This file is part of RefWatchPlus                                       *
 *                                                                         *
 * RefWatchPlus is free software: you can redistribute it and/or modify    *
 * it under the terms of the GNU General Public License as published by    *
 * the Free Software Foundation, either version 3 of the License, or       *
 * (at your option) any later version.                                     *
 *                                                                         *
 * RefWatchPlus is distributed in the hope that it will be useful,         *
 * but WITHOUT ANY WARRANTY; without even the implied warranty of          *
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the           *
 * GNU General Public License for more details.                            *
 *                                                                         *
 * You should have received a copy of the GNU General Public License       *
 * along with RefWatchPlus.  If not, see <https://www.gnu.org/licenses/>.  *
 ***************************************************************************/

using Toybox.Application as app;
using Toybox.WatchUi;
using Toybox.Position as Pos;
using Toybox.Sensor as Sensor;
using Toybox.System as Sys;

using VibrationController as Vib;
using RefreshTimer;
using ActivityTracking as Tracker;

class RefWatchApp extends app.AppBase {

    function initialize() {
        AppBase.initialize();

        AppData.initAppData();
        Vib.initialize();
        var bsMode = AppData.getBatterySaver();
        RefreshTimer.initTimer(bsMode);
        Tracker.initTracker();

        // Enable GPS
        Pos.enableLocationEvents( Pos.LOCATION_CONTINUOUS, method(:onPosition));

        // Enable HeartRate Sensor
        var sensorsenabled = Sensor.setEnabledSensors([Sensor.SENSOR_HEARTRATE]);

        // Initialize MatchSession
        MatchData.initMatchData();
    }

    // onStart() is called on application start up
    function onStart(state) {}

    // onStop() is called when your application is exiting
    function onStop(state) {
        MatchData.stopMatch();
    }

    // Return the initial view of your application here
    function getInitialView() {
        return [ new RefWatchView(), new RefWatchInputDelegate() ];
    }

    function onPosition(info) {}

}
