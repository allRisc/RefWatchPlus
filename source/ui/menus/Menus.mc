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

import Toybox.Lang;

module Menus {
  function itemId(item as Ui.MenuItem) as Symbol {
    return item.getId();
  }

  function getMainMenu() as Ui.Menu2 {
    var menu = new Ui.Menu2({:title=>"Main Menu"});

    menu.addItem(
      new Ui.MenuItem("End Match", null, :Exit_MenuID, null)
    );

    menu.addItem(
      new Ui.MenuItem(Rez.Strings.timingMenu_MenuLabel.toString(), null, :TimingMenu_MenuID, null)
    );

    menu.addItem(
      new Ui.ToggleMenuItem(Rez.Strings.ncaaMode_MenuLabel.toString(), null, :NcaaMode_MenuID, AppSettings.getNcaaMode(), null)
    );

    menu.addItem(
      new Ui.ToggleMenuItem(Rez.Strings.gpsOff_MenuLabel.toString(), null, :GpsOff_MenuID, AppSettings.getGpsOff(), null)
    );

    menu.addItem(
      new Ui.MenuItem(Rez.Strings.reminderTimer_MenuLabel.toString(), null, :ReminderTimer_MenuID, null)
    );

    menu.addItem(
      new Ui.ToggleMenuItem(Rez.Strings.separateActivities_MenuLabel.toString(), null, :SeparateActivities_MenuID, AppSettings.getSeparateActivities(), null)
    );

    menu.addItem(
      new Ui.ToggleMenuItem(Rez.Strings.darkMode_MenuLabel.toString(), null, :DarkMode_MenuID, AppSettings.getDarkMode(), null)
    );

    menu.addItem(
      new Ui.ToggleMenuItem(Rez.Strings.thickRing_MenuLabel.toString(), null, :ThickRing_MenuID, AppSettings.getThickRing(), null)
    );

    return menu;
  }

  function getTimingMenu() as Ui.Menu2 {
    var menu = new Ui.Menu2({:title=>"Timing Menu"});

    menu.addItem(
      new Ui.MenuItem(Rez.Strings.periodLength_MenuLabel.toString(), null, :PeriodLength_MenuID, null)
    );

    menu.addItem(
      new Ui.MenuItem(Rez.Strings.numPeriods_MenuLabel.toString(), null, :NumPeriods_MenuID, null)
    );

    menu.addItem(
      new Ui.MenuItem(Rez.Strings.breakLength_MenuLabel.toString(), null, :BreakLength_MenuID, null)
    );

    menu.addItem(
      new Ui.MenuItem(Rez.Strings.breakAlert_MenuLabel.toString(), null, :BreakAlert_MenuID, null)
    );

    menu.addItem(
      new Ui.MenuItem(Rez.Strings.otPeriodLength_MenuLabel.toString(), null, :OtPeriodLength_MenuID, null)
    );

    menu.addItem(
      new Ui.MenuItem(Rez.Strings.numOTPeriods_MenuLabel.toString(), null, :NumOTPeriods_MenuID, null)
    );

    return menu;
  }

}