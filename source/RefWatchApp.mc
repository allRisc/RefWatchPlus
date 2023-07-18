/***************************************************************************
 * RefWatchPlus is a FOSS app made for reffing soccer and tracking time.
 * Copyright (C) 2023  Benjamin Davis
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <https://www.gnu.org/licenses/>.
 ***************************************************************************/

using Toybox.Application as App;
using Toybox.Position as Pos;
using Toybox.Sensor as Sensor;
using Toybox.WatchUi as Ui;
using Toybox.Timer;
using Toybox.System as Sys;

using ActivityTracking as Act;

import Toybox.Lang;

class RefWatchApp extends App.AppBase {

  const VERSION = "v1.0.0";
  const TIMER_PERIOD_MS = 100;

  enum MatchState {
    IDLE = 0,
    PLAYING_PERIOD = 1,
    TRACKING_STOPPAGE = 2,
    BREAK_PERIOD = 3,
    WAITING_KICK = 4
  }

  hidden var currentState as MatchState;
  hidden var curPeriod as Number;

  hidden var period as Period;
  hidden var stoppage as StoppageTracker;

  hidden var updateTimer as Timer.Timer;

  function initialize() {
    AppBase.initialize();

    // Initialize the game state
    currentState = IDLE;
    curPeriod = 0;
    period = new Period(0);
    stoppage = new StoppageTracker();

    // Initialize the settings of the APP
    AppSettings.initAppSettings();

    // TODO add function to convert from previous save values if necessary

    // Initialize Vibration engine as necessary
    //  N/A

    // Enable HeartRate Sensor
    if (Sensor has :enableSensorType) {
      Sensor.enableSensorType(Sensor.SENSOR_HEARTRATE);
    } else {
      Sensor.setEnabledSensors([Sensor.SENSOR_HEARTRATE]);
    }

    // Initialize Refresh Timer as necessary
    updateTimer = new Timer.Timer();
    updateTimer.start(method(:onTimer), TIMER_PERIOD_MS, true);
  }

  // onStart() is called on application start up
  function onStart(state) as Void {}

  // onStop() is called when your application is exiting
  function onStop(state) as Void {
    Act.endTracking();

    // TODO: Ensure match is stopped on exit
  }

  // Return the initial view of your application here
  function getInitialView() {
    var ret = new Array<Ui.Views or Ui.InputDelegates>[2];
    ret[0] = new RefWatchView();
    ret[1] = new RefWatchInputDelegate();
    return ret;
  }

  // typedef CallBack as (Method(loc as Pos.Info) as Void);
  function onPosition(info as Pos.Info) as Void {}

  // Timer Callback method
  function onTimer() as Void {
    // TODO: Add vibration checking for stoppage time, end of period
    Ui.requestUpdate();
  }

  static function getApp() as RefWatchApp {
    var app = App.getApp();

    if (app instanceof RefWatchApp) {
      return app;
    } else {
      throw new Lang.UnexpectedTypeException("Expected a RefWatchApp from App.getApp()", null, null);
    }
  }


  /*****************************************************************/
  /*  __  __       _       _      ____            _             _  */
  /* |  \/  | __ _| |_ ___| |__  / ___|___  _ __ | |_ _ __ ___ | | */
  /* | |\/| |/ _` | __/ __| '_ \| |   / _ \| '_ \| __| '__/ _ \| | */
  /* | |  | | (_| | || (__| | | | |__| (_) | | | | |_| | | (_) | | */
  /* |_|  |_|\__,_|\__\___|_| |_ \____\___/|_| |_|\__|_|  \___/|_| */
  /*****************************************************************/
  function handleInput(evt as Ui.KeyEvent) as Void {
    if (evt.getKey() == Ui.KEY_ENTER) {
      if (isIdle()) {
        startMatch();
      }
    }
  }

  function startMatch() as Void {
    Logging.debug("Starting Match");

    // Initialize Tracker and Enable GPS
    Act.initTracker(method(:onPosition));

    // Start Activity Tracking
    Act.startTracking();

    // Start the match state
    currentState = PLAYING_PERIOD;
    curPeriod = 1;
    period = new Period(AppSettings.getPeriodLength());
    stoppage = new StoppageTracker();

    period.start();
  }

  function isIdle() as Boolean {
    return currentState == IDLE;
  }


  /**************************************************************/
  /* __     ___ _        _            _     _              _    */
  /* \ \   / (_| |__    / \   ___ ___(_)___| |_ __ _ _ __ | |_  */
  /*  \ \ / /| | '_ \  / _ \ / __/ __| / __| __/ _` | '_ \| __| */
  /*   \ V / | | |_)  / ___ \\__ \__ | \__ | || (_| | | | | |_  */
  /*    \_/  |_|_.__//_/   \_|___|___|_|___/\__\__,_|_| |_|\__| */
  /**************************************************************/
  // Provides helper methods for determining when time-based vibrations should happen
}
