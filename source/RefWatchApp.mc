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

using Toybox.Application as App;
using Toybox.Position as Pos;
using Toybox.Sensor as Sensor;
using Toybox.WatchUi as Ui;
using Toybox.Timer;
using Toybox.System as Sys;

using ActivityTracking as Act;
using Vibration;

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

    // TODO: Initialize Vibration engine as necessary
    Vibration.initialize();

    // TODO: Initialize Tracker

    // Enable GPS
    Act.initTracker(method(:onPosition));

    // Enable HeartRate Sensor
    Sensor.enableSensorType(Sensor.SENSOR_HEARTRATE);

    // TODO: Initialize MatchSession

    // Initialize Refresh Timer as necessary
    updateTimer = new Timer.Timer();
    updateTimer.start(method(:onTimer), TIMER_PERIOD_MS, true);
  }

  // onStart() is called on application start up
  function onStart(state as {:resume as Boolean?, :launchedFromGlance as Boolean?}?) as Void {}

  // onStop() is called when your application is exiting
  function onStop(state as {:suspend as Boolean?}?) as Void {
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

  /*****************************************************************/
  /*  __  __       _       _      ____            _             _  */
  /* |  \/  | __ _| |_ ___| |__  / ___|___  _ __ | |_ _ __ ___ | | */
  /* | |\/| |/ _` | __/ __| '_ \| |   / _ \| '_ \| __| '__/ _ \| | */
  /* | |  | | (_| | || (__| | | | |__| (_) | | | | |_| | | (_) | | */
  /* |_|  |_|\__,_|\__\___|_| |_ \____\___/|_| |_|\__|_|  \___/|_| */
  /*****************************************************************/

  // Function to perform app flow
  // @param evt [Ui.KeyEvent] the user input to handle
  function handleInput(evt as Ui.KeyEvent) as Void {
    switch (currentState) {
      case IDLE :
        if (evt.getKey() == Ui.KEY_ESC) {
          Sys.exit();
        } else if (evt.getKey() == Ui.KEY_ENTER) {
          startPlayingPeriod();
        }
        break;

      case PLAYING_PERIOD :
        if (evt.getKey() == Ui.KEY_ESC) {
          leavePlayingPeriod();
        } else if (evt.getKey() == Ui.KEY_ENTER) {
          stoppage.start();
          currentState = TRACKING_STOPPAGE;
          Vibration.startMidVib();
        }
        break;

      case TRACKING_STOPPAGE :
        if (evt.getKey() == Ui.KEY_ESC) {
          leavePlayingPeriod();
        } else if (evt.getKey() == Ui.KEY_ENTER) {
          stoppage.stop();
          currentState = PLAYING_PERIOD;
        }
        break;

      case BREAK_PERIOD :
        if (evt.getKey() == Ui.KEY_ESC) {
          currentState = WAITING_KICK;
        }
        break;

      case WAITING_KICK :
        if (evt.getKey() == Ui.KEY_ESC) {
          leavePlayingPeriod();
        } else if (evt.getKey() == Ui.KEY_ENTER) {
          startPlayingPeriod();
        }
        break;
    }
  }

  function startPlayingPeriod() as Void {
    curPeriod++;
    period = new Period(getPeriodTime(curPeriod));
    stoppage = new StoppageTracker();

    Vibration.startStrongVib();

    period.start();
    currentState = PLAYING_PERIOD;

    Ui.requestUpdate();
  }

  function leavePlayingPeriod() as Void {
    period.end();

    if (curPeriod >= AppSettings.getNumOTPeriods() + AppSettings.getNumPeriods()) {
      curPeriod = 0;
      currentState = IDLE;
    } else {
      period = new Period(AppSettings.getBreakLength());
      currentState = BREAK_PERIOD;
    }

    Ui.requestUpdate();
  }

  static function getPeriodTime(per as Number) as Number {
    if (per <= AppSettings.getNumPeriods()) {
      return AppSettings.getPeriodLength();
    } else if (per <= AppSettings.getNumOTPeriods() + AppSettings.getNumPeriods()) {
      return AppSettings.getOtPeriodLength();
    } else {
      return 0;
    }
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
