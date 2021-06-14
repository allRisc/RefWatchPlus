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
using Toybox.Timer;
using Toybox.Graphics as Gfx;
using Toybox.UserProfile as Usr;
using Toybox.System as Sys;

using VibrationController as Vib;
using ViewDrawables as draw;
using RefreshTimer;
using ActivityTracking as Tracker;

class ActivityInfoView extends Ui.View {

    function initialize() {
        View.initialize();
    }

    // Load your resources here
    function onLayout(dc) {
    }

    // Called when this View is brought to the foreground. Restore
    // the state of this View and prepare it to be shown. This includes
    // loading resources into memory.
    function onShow() {
        RefreshTimer.startTimer();
    }

    // Update the view
    function onUpdate(dc) {
        drawScreen(dc);
        Vib.handleVibration();
    }

    // Called when this View is removed from the screen. Save the
    // state of this View here. This includes freeing resources from
    // memory.
    function onHide() {}

    // Control function for main display panel
    function drawScreen(dc) {
        draw.clearScreen(dc);

        drawDividers(dc);
        drawHR(dc);
        drawDist(dc);
        draw.gpsRing(dc);
    }

    ///////////////////////////////////////////////////////////////////////////////
    // Functions for drawing                                                     //
    ///////////////////////////////////////////////////////////////////////////////
    function drawDividers(dc) {
        var color  = Gfx.COLOR_WHITE;
        var x      = draw.getMidWidth(dc);
        var y      = draw.getMidHeight(dc);
        var length = dc.getWidth();

        draw.hDivider(color, x, y, length, dc);
    }
    
    function drawHR(dc) {
		var hr = Tracker.getCurHeartRate();
		var hrColor = Gfx.COLOR_WHITE;
		var zoneInfo = Usr.getHeartRateZones(Usr.HR_ZONE_SPORT_RUNNING);
		
    	if (hr <= zoneInfo[0]) {
    		hrColor = Gfx.COLOR_WHITE;
    	} else if (hr <= zoneInfo [1]) {
    		hrColor = Gfx.COLOR_LT_GRAY;
    	} else if (hr <= zoneInfo[2]) {
    		hrColor = Gfx.COLOR_BLUE;
    	} else if (hr <= zoneInfo[3]) {
    		hrColor = Gfx.COLOR_GREEN;
    	} else if (hr <= zoneInfo[4]) {
    		hrColor = Gfx.COLOR_ORANGE;
    	} else {
    		hrColor = Gfx.COLOR_RED;
    	}
    
        draw.centerTopLabel(Gfx.COLOR_WHITE, "HR (bpm):", dc);
        draw.centerTop(hrColor, hr.toString(), dc);
    }
    
    function drawDist(dc) {
    	draw.centerBottomLabel(Gfx.COLOR_WHITE, "Distance (mi):", dc);
    	draw.centerBottom(Gfx.COLOR_WHITE, Tracker.getCurDistMi().format("%02.1f"), dc);
    }
}