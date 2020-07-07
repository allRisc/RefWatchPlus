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

using Toybox.ActivityRecording as ActRec;
using Toybox.WatchUi as Ui;
using Toybox.Activity as Act;

module ActivityTracking {
    const METER_PER_MILE = 1609.344;

    var actRecSession;

    function initTracker() {

    }

    function startTracking() {
        actRecSession = ActRec.createSession( { :name=>"Match", :sport=>ActRec.SPORT_SOCCER, :subsport=>ActRec.SUB_SPORT_GENERIC } );
        if( actRecSession != null )
        {
            var started = false;
            do{
                started = actRecSession.start();
            }
            while(!started);
        }
    }

    function endTracking() {
        if( actRecSession != null && actRecSession.isRecording() )
        {
            var stopped = false;
            var saved   = false;
            do{
            stopped = actRecSession.stop();
            }
            while(stopped == false);

            do {
                saved = actRecSession.save();
            }
            while( saved == false );


            actRecSession = null;
            Ui.requestUpdate();
        }

        actRecSession = null;
    }

    function getCurHeartRate() {
        var info = Act.getActivityInfo().currentHeartRate;
        if (info != null) {
            return info;
        }

        return 0;
    }

    function getCurDistM() {
        var info = Act.getActivityInfo().elapsedDistance;
        if (info != null) {
            return info;
        }

        return 0;
    }

    function getCurDistKM() {
        return getCurDistM().toFloat() / 1000.0;
    }

    function getCurDistMi() {
        return getCurDistM().toFloat() / METER_PER_MILE;
    }
}