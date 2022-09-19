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
using Toybox.System as Sys;
using Toybox.Graphics as Gfx;

using ViewDrawables as draw;

module Menus {
	function getMainMenu() {
		var menu = new Ui.Menu2({:title=>"Main Menu"});
		
		menu.addItem(
			new Ui.MenuItem(Rez.Strings.EndMatch_MenuLabel, null, :EndMatch_MenuID, null)
		);
		
		menu.addItem(
			new Ui.MenuItem(Rez.Strings.TimingMenu_MenuLabel, null, :TimingMenu_MenuID, null)
		);

		menu.addItem(
			new Ui.MenuItem(Rez.Strings.ReminderInterval_MenuLabel, null, :ReminderInterval_MenuID, null)
		);
		
		menu.addItem(
			new Ui.ToggleMenuItem(Rez.Strings.NCAAMode_MenuLabel, null, :NCAAMode_MenuID, AppData.getNCAAMode(), null)
		);
		
		menu.addItem(
			new Ui.ToggleMenuItem(Rez.Strings.BatterySaver_MenuLabel, null, :BatterySaver_MenuID, AppData.getBatterySaver(), null)
		);
		
		menu.addItem(
			new Ui.ToggleMenuItem(Rez.Strings.DarkMode_MenuLabel, null, :DarkMode_MenuID, AppData.getDarkMode(), null)
		);
		
		menu.addItem(
			new Ui.ToggleMenuItem(Rez.Strings.ThickRing_MenuLabel, null, :ThickRing_MenuID, AppData.getThickRing(), null)
		);
		
		return menu;
	}
	
	function getTimingMenu() {
		var menu = new Ui.Menu2({:title=>"Timing menu"});
		 
		menu.addItem(
			new Ui.MenuItem(Rez.Strings.PeriodLength_MenuLabel, null, :PeriodLength_MenuID, null)
		);
		
		menu.addItem(
			new Ui.MenuItem(Rez.Strings.NumPeriods_MenuLabel, null, :NumPeriods_MenuID, null)
		);
		
		menu.addItem(
			new Ui.MenuItem(Rez.Strings.BreakLength_MenuLabel, null, :BreakLength_MenuID, null)
		);
		
		menu.addItem(
			new Ui.MenuItem(Rez.Strings.BreakAlert_MenuLabel, null, :BreakAlert_MenuID, null)
		);
		
		menu.addItem(
			new Ui.MenuItem(Rez.Strings.OTPeriodLength_MenuLabel, null, :OTPeriodLength_MenuID, null)
		);
		
		menu.addItem(
			new Ui.MenuItem(Rez.Strings.NumOTPeriods_MenuLabel, null, :NumOTPeriods_MenuID, null)
		);
		
		return menu;
	}
}