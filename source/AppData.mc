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

using Toybox.Application.Storage as Store;
using Toybox.Test;
using Toybox.WatchUi as Ui;
using Toybox.Graphics as Gfx;
using Toybox.Position;
using Toybox.Lang;

using RefreshTimer as RTime;
using ViewDrawables as draw;

class AppData {
	hidden static var batterySaver;
	hidden static var ncaaMode;
	hidden static var gpsOff;
	hidden static var darkMode;
	hidden static var thickRing;
	
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
    	batterySaver    = Store.getValue(Ui.loadResource(Rez.Strings.BatterySaver_StorageID));
        if (batterySaver == null) {
            setBatterySaver(false);
        }
        
        ncaaMode        = Store.getValue(Ui.loadResource(Rez.Strings.NCAAMode_StorageID));
        if (ncaaMode == null) {
            setNCAAMode(false);
        }

        gpsOff        = Store.getValue(Ui.loadResource(Rez.Strings.GPSOff_StorageID));
        if (gpsOff == null) {
            setGPSOff(false);
        }
    
		darkMode        = Store.getValue(Ui.loadResource(Rez.Strings.DarkMode_StorageID));
		if (darkMode == null) {
			setDarkMode(false);
		}
		
		thickRing       = Store.getValue(Ui.loadResource(Rez.Strings.ThickRing_StorageID));
		if (thickRing == null) {
			setThickRing(false);
		}
    
        periodLength    = Store.getValue(Ui.loadResource(Rez.Strings.PeriodLength_StorageID));
        if (periodLength == null) {
            setPeriodLength(45);
        }

        numPeriods      = Store.getValue(Ui.loadResource(Rez.Strings.NumPeriods_StorageID));
        if (numPeriods == null) {
            setNumPeriods(2);
        }

        breakLength     = Store.getValue(Ui.loadResource(Rez.Strings.BreakLength_StorageID));
        if (breakLength == null) {
            setBreakLength(15);
        }

        breakAlert      = Store.getValue(Ui.loadResource(Rez.Strings.BreakAlert_StorageID));
        if (breakAlert == null) {
            setBreakAlert(3);
        }

        otPeriodLength  = Store.getValue(Ui.loadResource(Rez.Strings.OTPeriodLength_StorageID));
        if (otPeriodLength == null) {
            setOTPeriodLength(15);
        }

        numOTPeriods    = Store.getValue(Ui.loadResource(Rez.Strings.NumOTPeriods_StorageID));
        if (numOTPeriods == null) {
            setNumOTPeriods(0);
        }

    }

    static function refreshAppData() {
        ncaaMode       = Store.getValue(Ui.loadResource(Rez.Strings.NCAAMode_StorageID));

        gpsOff         = Store.getValue(Ui.loadResource(Rez.Strings.GPSOff_StorageID));
        setGPSOff(gpsOff);
    	
    	batterySaver   = Store.getValue(Ui.loadResource(Rez.Strings.BatterySaver_StorageID));
    	RTime.updateBatterSaver(batterySaver);
    	
    	darkMode       = Store.getValue(Ui.loadResource(Rez.Strings.DarkMode_StorageID));
		draw.setDarkMode(darkMode);
    	
    	thickRing       = Store.getValue(Ui.loadResource(Rez.Strings.ThickRing_StorageID));
    	
        periodLength   = Store.getValue(Ui.loadResource(Rez.Strings.PeriodLength_StorageID));
        numPeriods     = Store.getValue(Ui.loadResource(Rez.Strings.NumPeriods_StorageID));
        breakLength    = Store.getValue(Ui.loadResource(Rez.Strings.BreakLength_StorageID));
        breakAlert     = Store.getValue(Ui.loadResource(Rez.Strings.BreakAlert_StorageID));
        otPeriodLength = Store.getValue(Ui.loadResource(Rez.Strings.OTPeriodLength_StorageID));
        numOTPeriods   = Store.getValue(Ui.loadResource(Rez.Strings.NumOTPeriods_StorageID));
    }

    static function get(id) {
        switch (id) {
        	case Ui.loadResource(Rez.Strings.BatterySaver_StorageID)   :
        		return batterySaver;
        		break;
    		case Ui.loadResource(Rez.Strings.NCAAMode_StorageID)   :
        		return ncaaMode;
        		break;
			case Ui.loadResource(Rez.Strings.GPSOff_StorageID)   :
				return gpsOff;
				break;
    		case Ui.loadResource(Rez.Strings.DarkMode_StorageID)   :
        		return darkMode;
        		break;
    		case Ui.loadResource(Rez.Strings.ThickRing_StorageID) :
    			return thickRing;
    			break;
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
    
    static function set(id, val) {
        switch (id) {
        	case Ui.loadResource(Rez.Strings.BatterySaver_StorageID)   :
        		setBatterySaver(val);
        		break;
    		case Ui.loadResource(Rez.Strings.NCAAMode_StorageID)   :
        		setNCAAMode(val);
        		break;
            case Ui.loadResource(Rez.Strings.GPSOff_StorageID)   :
        		setGPSOff(val);
        		break;
    		case Ui.loadResource(Rez.Strings.DarkMode_StorageID)   :
        		setDarkMode(val);
        		break;
    		case Ui.loadResource(Rez.Strings.ThickRing_StorageID) :
    			setThickRing(val);
    			break;
            case Ui.loadResource(Rez.Strings.PeriodLength_StorageID)   :
                setPeriodLength(val);
                break;
            case Ui.loadResource(Rez.Strings.NumPeriods_StorageID)     :
                setNumPeriods(val);
                break;
            case Ui.loadResource(Rez.Strings.BreakLength_StorageID)    :
                setBreakLength(val);
                break;
            case Ui.loadResource(Rez.Strings.BreakAlert_StorageID)     :
                setBreakAlert(val);
                break;
            case Ui.loadResource(Rez.Strings.OTPeriodLength_StorageID) :
                setOTPeriodLength(val);
                break;
            case Ui.loadResource(Rez.Strings.NumOTPeriods_StorageID)   :
                setNumOTPeriods(val);
                break;
        }
    }
    
    // Getter Methods
	static function getBatterySaver() {
		return batterySaver;
	}
	
	static function getNCAAMode() {
		return ncaaMode;
	}

	static function getGPSOff() {
		return gpsOff;
    }
	
	static function getDarkMode() {
		return darkMode;
	}
	
	static function getThickRing() {
		return thickRing;
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

	// Setter Methods
	static function setBatterySaver(val) {
		batterySaver = val;
		RTime.updateBatterSaver(val);
        Store.setValue(Ui.loadResource(Rez.Strings.BatterySaver_StorageID), val);		
	}
	
	static function setNCAAMode(val) {
		ncaaMode = val;
		Store.setValue(Ui.loadResource(Rez.Strings.NCAAMode_StorageID), val);
	}

	static function setGPSOff(val) {
		gpsOff = val;

		var callback = new Lang.Method(RefWatchApp, :onPosition);
		if (val) {
			Position.enableLocationEvents(Position.LOCATION_DISABLE, callback);
		} else {
			Position.enableLocationEvents(Position.LOCATION_CONTINUOUS, callback);
		}

		Store.setValue(Ui.loadResource(Rez.Strings.GPSOff_StorageID), val);
	}
	
	static function setDarkMode(val) {
		darkMode = val;
		draw.setDarkMode(val);
		Store.setValue(Ui.loadResource(Rez.Strings.DarkMode_StorageID), val);
	}
	
	static function setThickRing(val) {
		thickRing = val;
		Store.setValue(Ui.loadResource(Rez.Strings.ThickRing_StorageID), val);
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

}