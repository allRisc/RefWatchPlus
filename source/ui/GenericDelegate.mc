/***************************************************************************
 * RefWatchPlus is a FOSS app made for reffing soccer and tracking time.
 * Copyright (C) 2021  Benjamin Davis
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
using Toybox.System as Sys;

using Toybox.Application as App;

using HelperFunctions as func;
using Menus;

import Toybox.Lang;

class GenericDelegate extends Ui.InputDelegate {

  hidden static var escPressTime = 0;

  function initialize() {
    InputDelegate.initialize();
  }

  // Handle a keyed input
  function onKey(evt as Ui.KeyEvent) as Boolean {
    return GenericDelegate.onKeyStatic(evt);
  }

  static function onKeyStatic(evt as Ui.KeyEvent) as Boolean {
    Logging.debug("Handling Key Event: " + evt.getKey().toString());

    // If the start key is hit
    if (evt.getKey() == Ui.KEY_ENTER) {
      Logging.debug("Enter Key Pressed");
      sendEvtToApp(evt);
      return true;
    }

    // Handle the escape key. Only works on double press
    if (evt.getKey() == Ui.KEY_ESC) {
      var time = Sys.getTimer();

      Logging.debug("ESC Key Pressed at time: " + time.toString());

      if (time - escPressTime <= func.sec2msec(1)) {
        sendEvtToApp(evt);
        escPressTime = 0;
      } else {
        escPressTime = time;
      }
      return true;
    }

    // Handle the menu key press
    if (evt.getKey() == Ui.KEY_MENU) {
      Logging.debug("Menu Key Pressed");
      return dispMainMenu();
    }

    return false;
  }

  static function sendEvtToApp(evt as Ui.KeyEvent) as Void {
    var app = App.getApp();
    if (app instanceof RefWatchApp) {
      // TODO: app.handleInput(evt);
    } else {
      throw new Lang.UnexpectedTypeException("Expected RefWatchApp from App.getApp()", null, null);
    }
  }

  // Display the main menu
  static function dispMainMenu() as Boolean {
    var MainMenu = Menus.getMainMenu();
    Ui.pushView( MainMenu, new MainMenuInputDelegate(), Ui.SLIDE_RIGHT );
    Ui.requestUpdate();
    return true;
  }

  // Display the activity view
  function dispActivityView() as Boolean {
    Ui.pushView( new ActivityInfoView(), new ActivityInfoInputDelegate(), Ui.SLIDE_UP );
    Ui.requestUpdate();
    return true;
  }

  // Display the device info view
  function dispDevInfoView() as Boolean {
    Ui.pushView( new DeviceInfoView(), new DeviceInfoInputDelegate(), Ui.SLIDE_DOWN );
    Ui.requestUpdate();
    return true;
  }

  // Go back to the last display
  function dispBack() as Boolean {
    Ui.popView(Ui.SLIDE_DOWN);
    Ui.requestUpdate();

    return true;
  }
}