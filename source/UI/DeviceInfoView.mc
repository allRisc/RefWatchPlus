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
using Toybox.System as Sys;

using VibrationController as Vib;
using ViewDrawables as draw;
using RefreshTimer;
using ActivityTracking as Tracker;

class DeviceInfoView extends Ui.View {
    function initialize() {
        View.initialize();
    }

    // Load your resources here
    function onLayout(dc) {}

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

		var bat = Sys.getSystemStats().battery;

        draw.centerTopClock(Gfx.COLOR_WHITE, dc);
        draw.centerBottom(Gfx.COLOR_WHITE, Lang.format("$1$%", [bat.format("%02.0f")]), dc);
        drawDividers(dc);
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
}