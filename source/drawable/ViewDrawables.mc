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

module ViewDrawables {
    // Custom Declarations for coloring
    var backgroundColor = Gfx.COLOR_BLACK;
	var DEFAULT_COLOR   = Gfx.COLOR_WHITE;
    
    const dividerWidth    = 3;

	function setDarkMode(darkMode) {
		if (darkMode) {
			backgroundColor = Gfx.COLOR_BLACK;
			DEFAULT_COLOR   = Gfx.COLOR_WHITE;
		} else {
			backgroundColor = Gfx.COLOR_WHITE;
			DEFAULT_COLOR   = Gfx.COLOR_BLACK;
		}
	}

    function getMidWidth(dc) {
        return dc.getWidth() / 2.0 + 0.5;
    }

    function getMidHeight(dc) {
        return dc.getHeight() / 2.0 + 0.5;
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

	// Generate a ring for a given timeleft vs timetotal set
    function timeRemainingRing(color, timeLeft, timeTotal, dc) {
        var degrees;

        if (timeLeft < 0) {
            degrees = 360;
        } else {
            degrees = Math.ceil(360.0 * (timeTotal - timeLeft) / timeTotal);
        }

        ring(color, degrees, getRadius(dc), dc);
    }

	// Create a ring with the given color, arg degree, and radius
    function ring(color, degs, rad, dc) {
        if (degs == 0) {
            return;
        }

        if (Toybox has :Test) {
            Test.assertMessage(degs >=   0, "Degrees for arc out of range (low)");
            Test.assertMessage(degs <= 360, "Degrees for arc out of range (high)");
        }

        dc.setColor(color, backgroundColor);
        
        var xCenter = getMidWidth(dc);
        var yCenter = getMidHeight(dc);
        
        var degOffset = ((360-degs) + 90);
        var degFinish = degOffset.abs().toNumber() % 360;
        
        dc.drawArc(xCenter, yCenter, rad + 1, Gfx.ARC_CLOCKWISE, 90, degFinish);
        dc.drawArc(xCenter, yCenter, rad    , Gfx.ARC_CLOCKWISE, 90, degFinish);
        dc.drawArc(xCenter, yCenter, rad - 1, Gfx.ARC_CLOCKWISE, 90, degFinish);
        dc.drawArc(xCenter, yCenter, rad - 2, Gfx.ARC_CLOCKWISE, 90, degFinish);
        if (AppData.getThickRing()) {
        	dc.drawArc(xCenter, yCenter, rad - 3, Gfx.ARC_CLOCKWISE, 90, degFinish);
        	dc.drawArc(xCenter, yCenter, rad - 4, Gfx.ARC_CLOCKWISE, 90, degFinish);
        	dc.drawArc(xCenter, yCenter, rad - 5, Gfx.ARC_CLOCKWISE, 90, degFinish);
        }
    }

	// Place a text value in the center
    function center(color, txt, dc) {
        dc.setColor(color, Gfx.COLOR_TRANSPARENT);
        dc.drawText(getMidWidth(dc), dc.getHeight()/3, Gfx.FONT_NUMBER_THAI_HOT, txt, Gfx.TEXT_JUSTIFY_CENTER);
    }

	// Function to display the current period
    function period(color, per, dc) {
        var curPeriod = Lang.format("Per: $1$", [per]);
        dc.setColor(color, Gfx.COLOR_TRANSPARENT);
        dc.drawText(getMidWidth(dc), dc.getHeight()*2/3, Gfx.FONT_MEDIUM, curPeriod, Gfx.TEXT_JUSTIFY_CENTER);
    }
    
    // Display text at the center top of the screen
    function centerTop(color, txt, dc) {
    	dc.setColor(color, Gfx.COLOR_TRANSPARENT);
        dc.drawText(getMidWidth(dc), dc.getHeight()/7, Gfx.FONT_NUMBER_HOT, txt, Gfx.TEXT_JUSTIFY_CENTER);
    }
    
    function centerTopLabel(color, label, dc) {
        dc.setColor(color, Gfx.COLOR_TRANSPARENT);
    	dc.drawText(getMidWidth(dc), dc.getHeight()/14, Gfx.FONT_MEDIUM, label, Gfx.TEXT_JUSTIFY_CENTER);
    }
    
    // Display text at the center bottom of the screen
    function centerBottom(color, txt, dc) {
    	dc.setColor(color, Gfx.COLOR_TRANSPARENT);
        dc.drawText(getMidWidth(dc), dc.getHeight()*4/7, Gfx.FONT_NUMBER_HOT, txt, Gfx.TEXT_JUSTIFY_CENTER);
    }
    
    function centerBottomLabel(color, label, dc) {
        dc.setColor(color, Gfx.COLOR_TRANSPARENT);
    	dc.drawText(getMidWidth(dc), dc.getHeight()/2, Gfx.FONT_MEDIUM, label, Gfx.TEXT_JUSTIFY_CENTER);    	
    }

	// Places a text value into the top-left point    
    function topLeft(color, txt, dc) {
    	dc.setColor(color, Gfx.COLOR_TRANSPARENT);
    	dc.drawText(dc.getWidth()/3, dc.getHeight()/6, Gfx.FONT_LARGE, txt, Gfx.TEXT_JUSTIFY_CENTER);
    }

	// Places a time value into the top-right corner
	function topRight(color, txt, dc) {
        dc.setColor(color, Gfx.COLOR_TRANSPARENT);
        dc.drawText(dc.getWidth() * 2/3, dc.getHeight()/6, Gfx.FONT_LARGE, txt, Gfx.TEXT_JUSTIFY_CENTER);
	}


	// Create a horizontal divider on screen
    function hDivider(color, x, y, len, dc) {
        var yLoc = y - Math.floor(dividerWidth/2);
        var xLoc = x - Math.floor(len/2);
        dc.setColor(color, backgroundColor);
        dc.fillRectangle(xLoc, yLoc, len, dividerWidth);
    }

	// Create vertical divider on screen
    function vDivider(color, x, y, len, dc) {
        var xLoc = x - Math.floor(dividerWidth/2);
        var yLoc = y - Math.floor(len/2);
        dc.setColor(color, backgroundColor);
        dc.fillRectangle(xLoc, yLoc, dividerWidth, len);
    }
}