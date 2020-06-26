using Toybox.WatchUi as Ui;
using Toybox.Graphics as Gfx;
using Toybox.Position as Pos;
using Toybox.Lang;
using Toybox.Math;
using Toybox.System as Sys;

using HelperFunctions as func;

module ViewDrawables {
    var backgroundColor = Gfx.COLOR_BLACK;

    function clearScreen(dc) {
        dc.setColor(backgroundColor, backgroundColor);
        dc.clear();
    }

    function gpsRing(dc) {
        var gpsinfos = Pos.getInfo();

        dc.setColor(getGPSQualityColor(gpsinfos), backgroundColor);
        dc.fillCircle(dc.getWidth()/2, dc.getHeight()/2, (dc.getWidth()/2)-1);
        dc.setColor(backgroundColor, backgroundColor);
        dc.fillCircle(dc.getWidth()/2, dc.getHeight()/2, (dc.getWidth()/2)-4);
    }

    function getGPSQualityColor(gpsInfo) {
        var gpsnfo;
        if( gpsInfo == null ) {
            gpsnfo = Pos.getInfo();
        } else {
            gpsnfo = gpsInfo;
        }

        if( gpsnfo.accuracy == Pos.QUALITY_GOOD ) {
            return Gfx.COLOR_DK_GREEN;
        } else if( gpsnfo.accuracy == Pos.QUALITY_USABLE ) {
            return Gfx.COLOR_YELLOW;
        }
        return Gfx.COLOR_DK_RED;
    }

    function timeRemainingRing(color, timeLeft, timeTotal, dc) {
        var degrees;
        var startDeg = 90;
        var endDeg;
        var xCenter  = dc.getWidth()/2;
        var yCenter  = dc.getHeight()/2;
        var rad      = xCenter;

        if (timeLeft < 0) {
            degrees = 360;
        } else {
            degrees = Math.ceil(360.0 * (timeTotal - timeLeft) / timeTotal);
        }

        endDeg   = ((startDeg - degrees).toNumber() % 360);

        dc.setColor(color, backgroundColor);
        dc.drawArc(xCenter, yCenter, rad-1, Gfx.ARC_CLOCKWISE, startDeg, endDeg);
        dc.drawArc(xCenter, yCenter, rad-2, Gfx.ARC_CLOCKWISE, startDeg, endDeg);
        dc.drawArc(xCenter, yCenter, rad-3, Gfx.ARC_CLOCKWISE, startDeg, endDeg);
    }

    function centerTime(color, time, dc) {
        time = func.sec2timer(time);
        dc.setColor(color, backgroundColor);
        dc.drawText(dc.getWidth()/2, dc.getHeight()/3, Gfx.FONT_NUMBER_THAI_HOT, time, Gfx.TEXT_JUSTIFY_CENTER);
    }

    function centerClock(color, dc) {
        var time = func.clockFace();

        dc.setColor(color, backgroundColor);
        dc.drawText(dc.getWidth()/2, dc.getHeight()/3, Gfx.FONT_NUMBER_THAI_HOT, time, Gfx.TEXT_JUSTIFY_CENTER);
    }

    function topLeftTime(color, time, dc) {
        time = func.sec2timer(time);
        dc.setColor(color, backgroundColor);
        dc.drawText(dc.getWidth()/3, dc.getHeight()/6, Gfx.FONT_LARGE, time, Gfx.TEXT_JUSTIFY_CENTER);
    }

    function topRightTime(color, time, dc) {
        time = func.sec2timer(time);
        dc.setColor(color, backgroundColor);
        dc.drawText(dc.getWidth() * 2/3, dc.getHeight()/6, Gfx.FONT_LARGE, time, Gfx.TEXT_JUSTIFY_CENTER);
    }

    function period(color, per, dc) {
        var curPeriod = Lang.format("Per: $1$", [per]);
        dc.setColor(color, backgroundColor);
        dc.drawText(dc.getWidth()/2, dc.getHeight()*2/3, Gfx.FONT_MEDIUM, curPeriod, Gfx.TEXT_JUSTIFY_CENTER);
    }
}