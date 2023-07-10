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

using Menus;

class MainMenuInputDelegate extends Ui.Menu2InputDelegate {
  function initialize() {
    Menu2InputDelegate.initialize();
  }

  function onSelect(item as Ui.MenuItem) as Void {
    switch (Menus.itemId(item)) {
      case :Exit_MenuID :
        Ui.pushView(new Ui.Confirmation("End Match?"),
                    new ExitConfirmationDelegate(),
                    Ui.SLIDE_IMMEDIATE);
        break;

      case :TimingMenu_MenuID :
        Ui.pushView(Menus.getTimingMenu(),
                    new TimingMenuInputDelegate(),
                    Ui.SLIDE_LEFT);
        break;

      case :NcaaMode_MenuID :
        if (item instanceof Ui.ToggleMenuItem) { AppSettings.setNcaaMode(item.isEnabled()); }
        else { throw new UnexpectedTypeException("ToggleMenuItem required to set Boolean ncaaMode", null, null); }
        break;

      case :GpsOff_MenuID :
        if (item instanceof Ui.ToggleMenuItem) { AppSettings.setGpsOff(item.isEnabled()); }
        else { throw new UnexpectedTypeException("ToggleMenuItem required to set Boolean gpsOff", null, null); }
        break;

      case :ReminderTimer_MenuID :
        Ui.pushView(new NumPicker(Ui.loadResource(Rez.Strings.reminderTimer_MenuLabel).toString(), Ui.loadResource(Rez.Strings.reminderTimer_StorageID).toString()),
                    new NumPickerDelegate(Ui.loadResource(Rez.Strings.reminderTimer_StorageID).toString()),
                    Ui.SLIDE_LEFT);
        break;

      case :SeparateActivities_MenuID :
        if (item instanceof Ui.ToggleMenuItem) { AppSettings.setSeparateActivities(item.isEnabled()); }
        else { throw new UnexpectedTypeException("ToggleMenuItem required to set Boolean separateActivities", null, null); }
        break;

      case :DarkMode_MenuID :
        if (item instanceof Ui.ToggleMenuItem) { AppSettings.setDarkMode(item.isEnabled()); }
        else { throw new UnexpectedTypeException("ToggleMenuItem required to set Boolean darkMode", null, null); }
        break;

      case :ThickRing_MenuID :
        if (item instanceof Ui.ToggleMenuItem) { AppSettings.setThickRing(item.isEnabled()); }
        else { throw new UnexpectedTypeException("ToggleMenuItem required to set Boolean thickRing", null, null); }
        break;

    }
    Ui.requestUpdate();
  }
}