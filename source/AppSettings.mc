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

import Toybox.System;
import Toybox.Lang;
using Toybox.Application.Storage as Store;
using Toybox.WatchUi as Ui;

class AppSettings {
  hidden static var periodLength as Number?;
  hidden static var numPeriods as Number?;
  hidden static var breakLength as Number?;
  hidden static var breakAlert as Number?;
  hidden static var otPeriodLength as Number?;
  hidden static var numOTPeriods as Number?;

  hidden static var ncaaMode as Boolean?;
  hidden static var gpsOff as Boolean?;
  hidden static var reminderTimer as Number?;
  hidden static var separateActivities as Boolean?;
  hidden static var darkMode as Boolean?;
  hidden static var thickRing as Boolean?;

  function initialize() {
    AppSettings.initAppSettings();
  }

  static function initAppSettings() as Void {
    periodLength = Store.getValue(Ui.loadResource(Rez.Strings.periodLength_StorageID) as String);
    if (periodLength == null) {
      setPeriodLength(45);
    }

    numPeriods = Store.getValue(Ui.loadResource(Rez.Strings.numPeriods_StorageID) as String);
    if (numPeriods == null) {
      setNumPeriods(2);
    }

    breakLength = Store.getValue(Ui.loadResource(Rez.Strings.breakLength_StorageID) as String);
    if (breakLength == null) {
      setBreakLength(15);
    }

    breakAlert = Store.getValue(Ui.loadResource(Rez.Strings.breakAlert_StorageID) as String);
    if (breakAlert == null) {
      setBreakAlert(3);
    }

    otPeriodLength = Store.getValue(Ui.loadResource(Rez.Strings.otPeriodLength_StorageID) as String);
    if (otPeriodLength == null) {
      setOtPeriodLength(15);
    }

    numOTPeriods = Store.getValue(Ui.loadResource(Rez.Strings.numOTPeriods_StorageID) as String);
    if (numOTPeriods == null) {
      setNumOTPeriods(0);
    }

    ncaaMode = Store.getValue(Ui.loadResource(Rez.Strings.ncaaMode_StorageID) as String);
    if (ncaaMode == null) {
      setNcaaMode(false);
    }

    gpsOff = Store.getValue(Ui.loadResource(Rez.Strings.gpsOff_StorageID) as String);
    if (gpsOff == null) {
      setGpsOff(false);
    }

    reminderTimer = Store.getValue(Ui.loadResource(Rez.Strings.reminderTimer_StorageID) as String);
    if (reminderTimer == null) {
      setReminderTimer(10);
    }

    separateActivities = Store.getValue(Ui.loadResource(Rez.Strings.separateActivities_StorageID) as String);
    if (separateActivities == null) {
      setSeparateActivities(false);
    }

    darkMode = Store.getValue(Ui.loadResource(Rez.Strings.darkMode_StorageID) as String);
    if (darkMode == null) {
      setDarkMode(true);
    }

    thickRing = Store.getValue(Ui.loadResource(Rez.Strings.thickRing_StorageID) as String);
    if (thickRing == null) {
      setThickRing(false);
    }

  }

  static function get(id as String) as Number or Boolean  {
    if (id == Ui.loadResource(Rez.Strings.periodLength_StorageID) as String) { return periodLength; }
    if (id == Ui.loadResource(Rez.Strings.numPeriods_StorageID) as String) { return numPeriods; }
    if (id == Ui.loadResource(Rez.Strings.breakLength_StorageID) as String) { return breakLength; }
    if (id == Ui.loadResource(Rez.Strings.breakAlert_StorageID) as String) { return breakAlert; }
    if (id == Ui.loadResource(Rez.Strings.otPeriodLength_StorageID) as String) { return otPeriodLength; }
    if (id == Ui.loadResource(Rez.Strings.numOTPeriods_StorageID) as String) { return numOTPeriods; }
    if (id == Ui.loadResource(Rez.Strings.ncaaMode_StorageID) as String) { return ncaaMode; }
    if (id == Ui.loadResource(Rez.Strings.gpsOff_StorageID) as String) { return gpsOff; }
    if (id == Ui.loadResource(Rez.Strings.reminderTimer_StorageID) as String) { return reminderTimer; }
    if (id == Ui.loadResource(Rez.Strings.separateActivities_StorageID) as String) { return separateActivities; }
    if (id == Ui.loadResource(Rez.Strings.darkMode_StorageID) as String) { return darkMode; }
    if (id == Ui.loadResource(Rez.Strings.thickRing_StorageID) as String) { return thickRing; }
    throw new Lang.InvalidValueException("AppSettings.get() got invalid ID: " + id);
  }

  static function set(id as String, val as Number or Boolean ) as Void {
    if (id == Ui.loadResource(Rez.Strings.periodLength_StorageID) as String) {
        if (val instanceof Number) { setPeriodLength(val); } else { throw new UnexpectedTypeException("periodLength expected Number", null, null); }
    }
    if (id == Ui.loadResource(Rez.Strings.numPeriods_StorageID) as String) {
        if (val instanceof Number) { setNumPeriods(val); } else { throw new UnexpectedTypeException("numPeriods expected Number", null, null); }
    }
    if (id == Ui.loadResource(Rez.Strings.breakLength_StorageID) as String) {
        if (val instanceof Number) { setBreakLength(val); } else { throw new UnexpectedTypeException("breakLength expected Number", null, null); }
    }
    if (id == Ui.loadResource(Rez.Strings.breakAlert_StorageID) as String) {
        if (val instanceof Number) { setBreakAlert(val); } else { throw new UnexpectedTypeException("breakAlert expected Number", null, null); }
    }
    if (id == Ui.loadResource(Rez.Strings.otPeriodLength_StorageID) as String) {
        if (val instanceof Number) { setOtPeriodLength(val); } else { throw new UnexpectedTypeException("otPeriodLength expected Number", null, null); }
    }
    if (id == Ui.loadResource(Rez.Strings.numOTPeriods_StorageID) as String) {
        if (val instanceof Number) { setNumOTPeriods(val); } else { throw new UnexpectedTypeException("numOTPeriods expected Number", null, null); }
    }
    if (id == Ui.loadResource(Rez.Strings.ncaaMode_StorageID) as String) {
        if (val instanceof Boolean) { setNcaaMode(val); } else { throw new UnexpectedTypeException("ncaaMode expected Boolean", null, null); }
    }
    if (id == Ui.loadResource(Rez.Strings.gpsOff_StorageID) as String) {
        if (val instanceof Boolean) { setGpsOff(val); } else { throw new UnexpectedTypeException("gpsOff expected Boolean", null, null); }
    }
    if (id == Ui.loadResource(Rez.Strings.reminderTimer_StorageID) as String) {
        if (val instanceof Number) { setReminderTimer(val); } else { throw new UnexpectedTypeException("reminderTimer expected Number", null, null); }
    }
    if (id == Ui.loadResource(Rez.Strings.separateActivities_StorageID) as String) {
        if (val instanceof Boolean) { setSeparateActivities(val); } else { throw new UnexpectedTypeException("separateActivities expected Boolean", null, null); }
    }
    if (id == Ui.loadResource(Rez.Strings.darkMode_StorageID) as String) {
        if (val instanceof Boolean) { setDarkMode(val); } else { throw new UnexpectedTypeException("darkMode expected Boolean", null, null); }
    }
    if (id == Ui.loadResource(Rez.Strings.thickRing_StorageID) as String) {
        if (val instanceof Boolean) { setThickRing(val); } else { throw new UnexpectedTypeException("thickRing expected Boolean", null, null); }
    }
  }

  // Getter Methods
  static function getPeriodLength() as Number {
    return periodLength;
  }

  static function getNumPeriods() as Number {
    return numPeriods;
  }

  static function getBreakLength() as Number {
    return breakLength;
  }

  static function getBreakAlert() as Number {
    return breakAlert;
  }

  static function getOtPeriodLength() as Number {
    return otPeriodLength;
  }

  static function getNumOTPeriods() as Number {
    return numOTPeriods;
  }

  static function getNcaaMode() as Boolean {
    return ncaaMode;
  }

  static function getGpsOff() as Boolean {
    return gpsOff;
  }

  static function getReminderTimer() as Number {
    return reminderTimer;
  }

  static function getSeparateActivities() as Boolean {
    return separateActivities;
  }

  static function getDarkMode() as Boolean {
    return darkMode;
  }

  static function getThickRing() as Boolean {
    return thickRing;
  }


  // Setter Methods
  static function setPeriodLength(val as Number) as Void {
    periodLength = val;
    Store.setValue(Ui.loadResource(Rez.Strings.periodLength_StorageID) as String, val);
  }

  static function setNumPeriods(val as Number) as Void {
    numPeriods = val;
    Store.setValue(Ui.loadResource(Rez.Strings.numPeriods_StorageID) as String, val);
  }

  static function setBreakLength(val as Number) as Void {
    breakLength = val;
    Store.setValue(Ui.loadResource(Rez.Strings.breakLength_StorageID) as String, val);
  }

  static function setBreakAlert(val as Number) as Void {
    breakAlert = val;
    Store.setValue(Ui.loadResource(Rez.Strings.breakAlert_StorageID) as String, val);
  }

  static function setOtPeriodLength(val as Number) as Void {
    otPeriodLength = val;
    Store.setValue(Ui.loadResource(Rez.Strings.otPeriodLength_StorageID) as String, val);
  }

  static function setNumOTPeriods(val as Number) as Void {
    numOTPeriods = val;
    Store.setValue(Ui.loadResource(Rez.Strings.numOTPeriods_StorageID) as String, val);
  }

  static function setNcaaMode(val as Boolean) as Void {
    ncaaMode = val;
    Store.setValue(Ui.loadResource(Rez.Strings.ncaaMode_StorageID) as String, val);
  }

  static function setGpsOff(val as Boolean) as Void {
    gpsOff = val;
    Store.setValue(Ui.loadResource(Rez.Strings.gpsOff_StorageID) as String, val);
  }

  static function setReminderTimer(val as Number) as Void {
    reminderTimer = val;
    Store.setValue(Ui.loadResource(Rez.Strings.reminderTimer_StorageID) as String, val);
  }

  static function setSeparateActivities(val as Boolean) as Void {
    separateActivities = val;
    Store.setValue(Ui.loadResource(Rez.Strings.separateActivities_StorageID) as String, val);
  }

  static function setDarkMode(val as Boolean) as Void {
    darkMode = val;
    Store.setValue(Ui.loadResource(Rez.Strings.darkMode_StorageID) as String, val);
  }

  static function setThickRing(val as Boolean) as Void {
    thickRing = val;
    Store.setValue(Ui.loadResource(Rez.Strings.thickRing_StorageID) as String, val);
  }

}