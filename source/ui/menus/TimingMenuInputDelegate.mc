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

import Toybox.Lang;
using Toybox.WatchUi as Ui;

using Menus;

class TimingMenuInputDelegate extends Ui.Menu2InputDelegate {
  function initialize() {
    Menu2InputDelegate.initialize();
  }

  function onSelect(item as Ui.MenuItem) as Void {
    switch (Menus.itemId(item)) {
      case :PeriodLength_MenuID :
        Ui.pushView(new NumPicker(Ui.loadResource(Rez.Strings.periodLength_MenuLabel).toString(), Ui.loadResource(Rez.Strings.periodLength_StorageID) as String),
                    new NumPickerDelegate(Ui.loadResource(Rez.Strings.periodLength_StorageID) as String),
                    Ui.SLIDE_LEFT);
        break;

      case :NumPeriods_MenuID :
        Ui.pushView(new NumPicker(Ui.loadResource(Rez.Strings.numPeriods_MenuLabel).toString(), Ui.loadResource(Rez.Strings.numPeriods_StorageID) as String),
                    new NumPickerDelegate(Ui.loadResource(Rez.Strings.numPeriods_StorageID) as String),
                    Ui.SLIDE_LEFT);
        break;

      case :BreakLength_MenuID :
        Ui.pushView(new NumPicker(Ui.loadResource(Rez.Strings.breakLength_MenuLabel).toString(), Ui.loadResource(Rez.Strings.breakLength_StorageID) as String),
                    new NumPickerDelegate(Ui.loadResource(Rez.Strings.breakLength_StorageID) as String),
                    Ui.SLIDE_LEFT);
        break;

      case :BreakAlert_MenuID :
        Ui.pushView(new NumPicker(Ui.loadResource(Rez.Strings.breakAlert_MenuLabel).toString(), Ui.loadResource(Rez.Strings.breakAlert_StorageID) as String),
                    new NumPickerDelegate(Ui.loadResource(Rez.Strings.breakAlert_StorageID) as String),
                    Ui.SLIDE_LEFT);
        break;

      case :OtPeriodLength_MenuID :
        Ui.pushView(new NumPicker(Ui.loadResource(Rez.Strings.otPeriodLength_MenuLabel).toString(), Ui.loadResource(Rez.Strings.otPeriodLength_StorageID) as String),
                    new NumPickerDelegate(Ui.loadResource(Rez.Strings.otPeriodLength_StorageID) as String),
                    Ui.SLIDE_LEFT);
        break;

      case :NumOTPeriods_MenuID :
        Ui.pushView(new NumPicker(Ui.loadResource(Rez.Strings.numOTPeriods_MenuLabel).toString(), Ui.loadResource(Rez.Strings.numOTPeriods_StorageID) as String),
                    new NumPickerDelegate(Ui.loadResource(Rez.Strings.numOTPeriods_StorageID) as String),
                    Ui.SLIDE_LEFT);
        break;

    }
    Ui.requestUpdate();
  }
}