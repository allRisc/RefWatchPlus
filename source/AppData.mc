using Toybox.Application.Storage as Store;
using Toybox.Test;
using Toybox.WatchUi as Ui;

class AppData {
    hidden static var periodLength;
    hidden static var numPeriods;
    hidden static var breakLength;
    hidden static var breakAlert;
    hidden static var otPeriodLength;
    hidden static var numOTPeriods;

    function initialize() {
        AppData.refreshAppData();
    }

    static function initAppData() {
        periodLength   = Store.getValue(Ui.loadResource(Rez.Strings.PeriodLength_StorageID));
        if (periodLength == null) {
            setPeriodLength(45);
        }

        numPeriods     = Store.getValue(Ui.loadResource(Rez.Strings.NumPeriods_StorageID));
        if (numPeriods == null) {
            setNumPeriods(2);
        }

        breakLength    = Store.getValue(Ui.loadResource(Rez.Strings.BreakLength_StorageID));
        if (breakLength == null) {
            setBreakLength(15);
        }

        breakAlert     = Store.getValue(Ui.loadResource(Rez.Strings.BreakAlert_StorageID));
        if (breakAlert == null) {
            setBreakAlert(3);
        }

        otPeriodLength = Store.getValue(Ui.loadResource(Rez.Strings.OTPeriodLength_StorageID));
        if (otPeriodLength == null) {
            setOTPeriodLength(15);
        }

        numOTPeriods   = Store.getValue(Ui.loadResource(Rez.Strings.NumOTPeriods_StorageID));
        if (numOTPeriods == null) {
            setNumOTPeriods(0);
        }

    }

    static function refreshAppData() {
        periodLength   = Store.getValue(Ui.loadResource(Rez.Strings.PeriodLength_StorageID));
        numPeriods     = Store.getValue(Ui.loadResource(Rez.Strings.NumPeriods_StorageID));
        breakLength    = Store.getValue(Ui.loadResource(Rez.Strings.BreakLength_StorageID));
        breakAlert     = Store.getValue(Ui.loadResource(Rez.Strings.BreakAlert_StorageID));
        otPeriodLength = Store.getValue(Ui.loadResource(Rez.Strings.OTPeriodLength_StorageID));
        numOTPeriods   = Store.getValue(Ui.loadResource(Rez.Strings.NumOTPeriods_StorageID));
    }

    static function get(id) {
        switch (id) {
            case Ui.loadResource(Rez.Strings.PeriodLength_StorageID)   :
                return periodLength;
                break;
            case Ui.loadResource(Rez.Strings.NumPeriods_StorageID)     :
                return numPeriods;
                break;
            case Ui.loadResource(Rez.Strings.BreakLength_StorageID)    :
                return breakLength;
                break;
            case Ui.loadResource(Rez.Strings.BreakAlert_StorageID)     :
                return breakAlert;
                break;
            case Ui.loadResource(Rez.Strings.OTPeriodLength_StorageID) :
                return otPeriodLength;
                break;
            case Ui.loadResource(Rez.Strings.NumOTPeriods_StorageID)   :
                return numOTPeriods;
                break;
        }
    }

    static function getPeriodLength() {
        return periodLength;
    }

    static function getNumPeriods() {
        return numPeriods;
    }

    static function getBreakLength() {
        return breakLength;
    }

    static function getBreakAlert() {
        return breakAlert;
    }

    static function getOTPeriodLength() {
        return otPeriodLength;
    }

    static function getNumOTPeriods() {
        return numOTPeriods;
    }

    static function setPeriodLength(val) {
        periodLength = val;
        Store.setValue(Ui.loadResource(Rez.Strings.PeriodLength_StorageID), val);
    }

    static function setNumPeriods(val) {
        numPeriods = val;
        Store.setValue(Ui.loadResource(Rez.Strings.NumPeriods_StorageID), val);
    }

    static function setBreakLength(val) {
        breakLength = val;
        Store.setValue(Ui.loadResource(Rez.Strings.BreakLength_StorageID), val);
    }

    static function setBreakAlert(val) {
        breakAlert = val;
        Store.setValue(Ui.loadResource(Rez.Strings.BreakAlert_StorageID), val);
    }

    static function setOTPeriodLength(val) {
        otPeriodLength = val;
        Store.setValue(Ui.loadResource(Rez.Strings.OTPeriodLength_StorageID), val);
    }

    static function setNumOTPeriods(val) {
        numOTPeriods = val;
        Store.setValue(Ui.loadResource(Rez.Strings.NumOTPeriods_StorageID), val);
    }

    static function set(id, val) {
        Store.setValue(id, val);
    }

}