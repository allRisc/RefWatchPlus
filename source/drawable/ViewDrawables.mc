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

using Toybox.WatchUi as Ui;
using Toybox.Graphics as Gfx;
using Toybox.Position as Pos;
using Toybox.Lang;
using Toybox.Math;
using Toybox.System as Sys;
using Toybox.Test;

using HelperFunctions as func;
using ActivityTracking as Tracker;

module ViewDrawables {
    const backgroundColor = Gfx.COLOR_BLACK;
    const dividerWidth    = 3;

    function getMidWidth(dc) {
        return dc.getWidth() / 2;
    }

    function getMidHeight(dc) {
        return dc.getHeight() / 2;
    }

    function getRadius(dc) {
        return (dc.getWidth() / 2) - 1;
    }

    function clearScreen(dc) {
        dc.setColor(backgroundColor, backgroundColor);
        dc.clear();
    }

    function gpsRing(dc) {
        var gpsinfos = Pos.getInfo();

        ring(getGPSQualityColor(gpsinfos), 360, getRadius(dc), dc);
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

        if (timeLeft < 0) {
            degrees = 360;
        } else {
            degrees = Math.ceil(360.0 * (timeTotal - timeLeft) / timeTotal);
        }

        ring(color, degrees, getRadius(dc), dc);
    }

    function ring(color, degs, rad, dc) {
        if (degs == 0) {
            return;
        }

        if (Toybox has :Test) {
            Test.assertMessage(degs >=   0, "Degrees for arc out of range (low)");
            Test.assertMessage(degs <= 360, "Degrees for arc out of range (high)");
        }

        dc.setColor(color, backgroundColor);
        if (degs <= 90) {
            upperRightArc(degs, rad, dc);
        } else if (degs <= 180) {
            upperRightArc(90, rad, dc);
            lowerRightArc(degs-90, rad, dc);
        } else if (degs <= 270) {
            upperRightArc(90, rad, dc);
            lowerRightArc(90, rad, dc);
            lowerLeftArc (degs-180, rad, dc);
        } else if (degs <= 360) {
            upperRightArc(90, rad, dc);
            lowerRightArc(90, rad, dc);
            lowerLeftArc (90, rad, dc);
            upperLeftArc (degs-270, rad, dc);
        }
    }

    function upperRightArc(degs, rad, dc) {
        var xCenter = getMidWidth(dc);
        var yCenter = getMidHeight(dc) - 1;

        dc.drawArc(xCenter, yCenter, rad  , Gfx.ARC_CLOCKWISE, 90, 90-degs);
        dc.drawArc(xCenter, yCenter, rad-1, Gfx.ARC_CLOCKWISE, 90, 90-degs);
        dc.drawArc(xCenter, yCenter, rad-2, Gfx.ARC_CLOCKWISE, 90, 90-degs);
    }

    function lowerRightArc(degs, rad, dc) {
        var xCenter = getMidWidth(dc);
        var yCenter = getMidHeight(dc);

        dc.drawArc(xCenter, yCenter, rad  , Gfx.ARC_CLOCKWISE, 0, 360-degs);
        dc.drawArc(xCenter, yCenter, rad-1, Gfx.ARC_CLOCKWISE, 0, 360-degs);
        dc.drawArc(xCenter, yCenter, rad-2, Gfx.ARC_CLOCKWISE, 0, 360-degs);
    }

    function lowerLeftArc(degs, rad, dc) {
        var xCenter = getMidWidth(dc) - 1;
        var yCenter = getMidHeight(dc);

        dc.drawArc(xCenter, yCenter, rad  , Gfx.ARC_CLOCKWISE, 270, 270-degs);
        dc.drawArc(xCenter, yCenter, rad-1, Gfx.ARC_CLOCKWISE, 270, 270-degs);
        dc.drawArc(xCenter, yCenter, rad-2, Gfx.ARC_CLOCKWISE, 270, 270-degs);
    }

    function upperLeftArc(degs, rad, dc) {
        var xCenter = getMidWidth(dc)  - 1;
        var yCenter = getMidHeight(dc) - 1;

        dc.drawArc(xCenter, yCenter, rad  , Gfx.ARC_CLOCKWISE, 180, 180-degs);
        dc.drawArc(xCenter, yCenter, rad-1, Gfx.ARC_CLOCKWISE, 180, 180-degs);
        dc.drawArc(xCenter, yCenter, rad-2, Gfx.ARC_CLOCKWISE, 180, 180-degs);
    }

    function centerTime(color, time, dc) {
        time = func.sec2timer(time);
        dc.setColor(color, backgroundColor);
        dc.drawText(getMidWidth(dc), dc.getHeight()/3, Gfx.FONT_NUMBER_THAI_HOT, time, Gfx.TEXT_JUSTIFY_CENTER);
    }

    function centerClock(color, dc) {
        var time = func.clockFace();

        dc.setColor(color, backgroundColor);
        dc.drawText(getMidWidth(dc), dc.getHeight()/3, Gfx.FONT_NUMBER_THAI_HOT, time, Gfx.TEXT_JUSTIFY_CENTER);
    }

    function centerTopClock(color, dc) {
        var time = func.clockFace();

        dc.setColor(color, backgroundColor);
        dc.drawText(getMidWidth(dc), dc.getHeight()/6, Gfx.FONT_NUMBER_HOT, time, Gfx.TEXT_JUSTIFY_CENTER);
    }

    function bottomLeftHeartRate(color, hr, dc) {
        var val = hr.toString();

        dc.setColor(color, backgroundColor);
        dc.drawText(getMidWidth(dc)/2, getMidHeight(dc)*7/6, Gfx.FONT_NUMBER_MEDIUM, val, Gfx.TEXT_JUSTIFY_CENTER);
    }

    function bottomRightDist(color, dist, dc) {
        var val = dist.format("%02.1f");

        dc.setColor(color, backgroundColor);
        dc.drawText(getMidWidth(dc)*3/2, getMidHeight(dc)*7/6, Gfx.FONT_NUMBER_MEDIUM, val, Gfx.TEXT_JUSTIFY_CENTER);
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
        dc.drawText(getMidWidth(dc), dc.getHeight()*2/3, Gfx.FONT_MEDIUM, curPeriod, Gfx.TEXT_JUSTIFY_CENTER);
    }

    function hDivider(color, x, y, len, dc) {
        var yLoc = y - Math.floor(dividerWidth/2);
        var xLoc = x - Math.floor(len/2);
        dc.setColor(color, backgroundColor);
        dc.fillRectangle(xLoc, yLoc, len, dividerWidth);
    }

    function vDivider(color, x, y, len, dc) {
        var xLoc = x - Math.floor(dividerWidth/2);
        var yLoc = y - Math.floor(len/2);
        dc.setColor(color, backgroundColor);
        dc.fillRectangle(xLoc, yLoc, dividerWidth, len);
    }
}