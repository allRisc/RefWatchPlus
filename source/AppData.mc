using Toybox.Application.Storage as Store;
using Toybox.Test;

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
        periodLength   = Store.getValue(Rez.Strings.PeriodLength_StorageID.toString());
        if (periodLength == null) {
            setPeriodLength(Rez.Strings.PeriodLength_StorageID.toString(),     45);
        }

        numPeriods     = Store.getValue(Rez.Strings.NumPeriods_StorageID.toString());
        if (numPeriods == null) {
            setNumPeriods(Rez.Strings.NumPeriods_StorageID.toString(),         2 );
        }

        breakLength    = Store.getValue(Rez.Strings.BreakLength_StorageID.toString());
        if (breakLength == null) {
            setBreakLength(Rez.Strings.BreakLength_StorageID.toString(),       15);
        }

        breakAlert     = Store.getValue(Rez.Strings.BreakAlert_StorageID.toString());
        if (breakAlert == null) {
            setBreakAlert(Rez.Strings.BreakAlert_StorageID.toString(),         3 );
        }

        otPeriodLength = Store.getValue(Rez.Strings.OTPeriodLength_StorageID.toString());
        if (otPeriodLength == null) {
            setOTPeriodLength(Rez.Strings.OTPeriodLength_StorageID.toString(), 15);
        }

        numOTPeriods   = Store.getValue(Rez.Strings.NumOTPeriods_StorageID.toString());
        if (numOTPeriods == null) {
            setNumOTPeriods(Rez.Strings.NumOTPeriods_StorageID.toString(),     0 );
        }

    }

    static function refreshAppData() {
        periodLength   = Store.getValue(Rez.Strings.PeriodLength_StorageID.toString());
        numPeriods     = Store.getValue(Rez.Strings.NumPeriods_StorageID.toString());
        breakLength    = Store.getValue(Rez.Strings.BreakLength_StorageID.toString());
        breakAlert     = Store.getValue(Rez.Strings.BreakAlert_StorageID.toString());
        otPeriodLength = Store.getValue(Rez.Strings.OTPeriodLength_StorageID.toString());
        numOTPeriods   = Store.getValue(Rez.Strings.NumOTPeriods_StorageID.toString());
    }

    static function get(id) {
        switch (id) {
            case Rez.Strings.PeriodLength_StorageID.toString()   :
                return periodLength;
                break;
            case Rez.Strings.NumPeriods_StorageID.toString()     :
                return numPeriods;
                break;
            case Rez.Strings.BreakLength_StorageID.toString()    :
                return breakLength;
                break;
            case Rez.Strings.BreakAlert_StorageID.toString()     :
                return breakAlert;
                break;
            case Rez.Strings.OTPeriodLength_StorageID.toString() :
                return otPeriodLength;
                break;
            case Rez.Strings.NumOTPeriods_StorageID.toString()   :
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
        Store.setValue(Rez.Strings.PeriodLength_StorageID.toString(), val);
    }

    static function setNumPeriods(val) {
        numPeriods = val;
        Store.setValue(Rez.Strings.NumPeriods_StorageID.toString(), val);
    }

    static function setBreakLength(val) {
        breakLength = val;
        Store.setValue(Rez.Strings.BreakLength_StorageID.toString(), val);
    }

    static function setBreakAlert(val) {
        breakAlert = val;
        Store.setValue(Rez.Strings.BreakAlert_StorageID.toString(), val);
    }

    static function setOTPeriodLength(val) {
        otPeriodLength = val;
        Store.setValue(Rez.Strings.OTPeriodLength_StorageID.toString(), val);
    }

    static function setNumOTPeriods(val) {
        numOTPeriods = val;
        Store.setValue(Rez.Strings.NumOTPeriods_StorageID.toString(), val);
    }

    static function set(id, val) {
        Test.assertMessage(id instanceof String, "AppData.set() \'id\' not a String");
        Store.setValue(id, val);
    }

}