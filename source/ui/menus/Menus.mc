/***************************************************************************
 * RefWatchPlus is a FOSS app made for reffing soccer and tracking time.
 * Copyright (C) 2023  Benjamin Davis
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <https://www.gnu.org/licenses/>.
 ***************************************************************************/

using Toybox.WatchUi as Ui;

import Toybox.Lang;

module Menus {
  function itemId(item as Ui.MenuItem) as Object? {
    return item.getId();
  }

  function getMainMenu() as Ui.Menu2 {
    var menu = new Ui.Menu2({:title=>"Main Menu"});

    menu.addItem(
      new Ui.MenuItem("End Match", null, :Exit_MenuID, null)
    );

    menu.addItem(
      new Ui.MenuItem(Ui.loadResource(Rez.Strings.timingMenu_MenuLabel), null, :TimingMenu_MenuID, null)
    );

    menu.addItem(
      new Ui.ToggleMenuItem(Ui.loadResource(Rez.Strings.ncaaMode_MenuLabel), null, :NcaaMode_MenuID, AppSettings.getNcaaMode(), null)
    );

    menu.addItem(
      new Ui.ToggleMenuItem(Ui.loadResource(Rez.Strings.gpsOff_MenuLabel), null, :GpsOff_MenuID, AppSettings.getGpsOff(), null)
    );

    menu.addItem(
      new Ui.MenuItem(Ui.loadResource(Rez.Strings.reminderTimer_MenuLabel), null, :ReminderTimer_MenuID, null)
    );

    menu.addItem(
      new Ui.ToggleMenuItem(Ui.loadResource(Rez.Strings.separateActivities_MenuLabel), null, :SeparateActivities_MenuID, AppSettings.getSeparateActivities(), null)
    );

    menu.addItem(
      new Ui.ToggleMenuItem(Ui.loadResource(Rez.Strings.darkMode_MenuLabel), null, :DarkMode_MenuID, AppSettings.getDarkMode(), null)
    );

    menu.addItem(
      new Ui.ToggleMenuItem(Ui.loadResource(Rez.Strings.thickRing_MenuLabel), null, :ThickRing_MenuID, AppSettings.getThickRing(), null)
    );

    return menu;
  }

  function getTimingMenu() as Ui.Menu2 {
    var menu = new Ui.Menu2({:title=>"Timing Menu"});

    menu.addItem(
      new Ui.MenuItem(Ui.loadResource(Rez.Strings.periodLength_MenuLabel), null, :PeriodLength_MenuID, null)
    );

    menu.addItem(
      new Ui.MenuItem(Ui.loadResource(Rez.Strings.numPeriods_MenuLabel), null, :NumPeriods_MenuID, null)
    );

    menu.addItem(
      new Ui.MenuItem(Ui.loadResource(Rez.Strings.breakLength_MenuLabel), null, :BreakLength_MenuID, null)
    );

    menu.addItem(
      new Ui.MenuItem(Ui.loadResource(Rez.Strings.breakAlert_MenuLabel), null, :BreakAlert_MenuID, null)
    );

    menu.addItem(
      new Ui.MenuItem(Ui.loadResource(Rez.Strings.otPeriodLength_MenuLabel), null, :OtPeriodLength_MenuID, null)
    );

    menu.addItem(
      new Ui.MenuItem(Ui.loadResource(Rez.Strings.numOTPeriods_MenuLabel), null, :NumOTPeriods_MenuID, null)
    );

    return menu;
  }

}