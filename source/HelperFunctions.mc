using Toybox.Lang;
using Toybox.Math;
using Toybox.System as Sys;
using Toybox.Position as Pos;
using Toybox.Graphics as Gfx;

module HelperFunctions {
    function min2sec(m) {
        return 60*m;
    }

    function min2msec(m) {
        return 60*m*1000;
    }

    function sec2msec(s) {
        return s * 1000;
    }

    function msec2sec(ms) {
        return Math.floor(ms / 1000);
    }

    function msec2sec_ceil(ms) {
        return Math.ceil(ms / 1000.0).toNumber();
    }

    function sec2timer(s) {
        var sign = "";
        var min  = s/60;
        var sec  = (s % 60).abs();

        if (s < 0) {
            sign = "-";
        }

        var myFormat = "$1$$2$:$3$";
        var myParams = [sign, min.toNumber(), sec.toNumber().format("%02d")];
        var myString = Lang.format(myFormat, myParams);

        return myString;
    }

    function clockFace() {
        var curTime = Sys.getClockTime();
        var hour = curTime.hour;

        if (!Sys.getDeviceSettings().is24Hour) {
            hour = hour % 12;
            if (hour == 0) {
                hour = 12;
            }
        }


        return hour.format("%02d") + ":" + curTime.min.format("%02d");
    }
}