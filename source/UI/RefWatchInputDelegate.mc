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

using HelperFunctions as func;
using VibrationController as Vib;

class RefWatchInputDelegate extends Ui.InputDelegate {

    var escPressTime;

    function initialize() {
        InputDelegate.initialize();

        escPressTime = 0;
    }

    function onKey(evt) {
        var keynum = Lang.format("K $1$", [evt.getKey()]);
        Sys.println(keynum);

        if (evt.getKey() == Ui.KEY_ENTER) {
            if (!MatchData.isStarted())
            {
                Vib.startStrongVib();
                MatchData.startMatch();
                MatchData.getCurPeriod().start();
                Ui.requestUpdate();
                return true;
            }
            else if (MatchData.isPlayingPeriod())
            {
                if ( MatchData.getCurPeriod().isStarted() )
                {
                    MatchData.getCurPeriod().stoppage();
                }
                else
                {
                    MatchData.getCurPeriod().start();
                }
                return true;
            }

        }

        if (evt.getKey() == Ui.KEY_ESC) {
            if (!MatchData.isStarted())
            {
                return false;
            }

            var time = Sys.getTimer();

            if (time - escPressTime <= func.sec2msec(1)) {
                MatchData.nextPeriod();
                escPressTime = 0;
            } else {
                escPressTime = time;
            }
            return true;
        }

        return false;
    }


    function onSwipe(evt) {
        var swipenum = Lang.format("S $1$", [evt.getDirection()]);
        Sys.println(swipenum);

        if (evt.getDirection() == Ui.SWIPE_UP) {
            var MainMenu= new Rez.Menus.MainMenu();
            Ui.pushView( MainMenu, new MainMenuInputDelegate(), Ui.SLIDE_UP );
            Ui.requestUpdate();
            return true;
        } else if (evt.getDirection() == Ui.SWIPE_DOWN) {
            Ui.pushView( new ActivityInfoView(), new ActivityInfoInputDelegate(), Ui.SLIDE_UP );
            Ui.requestUpdate();
            return true;
        }

        return false;
    }
}