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
using Toybox.Position as Pos;

using Toybox.Lang as lang;

import Toybox.Lang;



module ActivityTracking {

  const METER_PER_MILE = 1609.344;

  var actRecSession as ActRec.Session?;

  function initTracker(callback as Method(loc as Pos.Info) as Void) as Void {
    if (AppSettings.getGpsOff()) {
      Pos.enableLocationEvents( Pos.LOCATION_DISABLE, callback);
    } else {
      Pos.enableLocationEvents( Pos.LOCATION_CONTINUOUS, callback);
    }
  }

  function startTracking() as Void {
    actRecSession = ActRec.createSession( { :name=>"Match", :sport=>ActRec.SPORT_RUNNING, :subsport=>ActRec.SUB_SPORT_GENERIC } );
    if( actRecSession  instanceof ActRec.Session ) {
      var started = false;
      do {
        started = actRecSession.start();
      } while(!started);
    }
  }

  function pauseTracking() as Void{
    if ( actRecSession  instanceof ActRec.Session ) {
      if (!actRecSession.isRecording()) {return;}
    }

    if ( actRecSession  instanceof ActRec.Session ) {
      var stopped = false;
      do {
        stopped = actRecSession.stop();
      } while( !stopped );
    }
  }

  function unpauseTracking() as Void {
    if( actRecSession instanceof ActRec.Session) {
      if (actRecSession.isRecording()) {return;}
    }

    if( actRecSession instanceof ActRec.Session) {
      var started = false;
      do {
        started = actRecSession.start();
      } while( !started );
    }
  }

  function endTracking() as Void {
    if( actRecSession instanceof ActRec.Session) {
      if (!actRecSession.isRecording()) {return;}
    }

    var stopped = false;
    var saved   = false;

    if( actRecSession instanceof ActRec.Session) {
      do {
        stopped = actRecSession.stop();
      } while( !stopped );
    }

    if( actRecSession instanceof ActRec.Session) {
      do {
        saved = actRecSession.save();
      } while( !saved );
    }

      Ui.requestUpdate();

    actRecSession = null;
  }

  function isActiveSession() as Boolean {
    return (actRecSession instanceof ActRec.Session);
  }

  function addLap() as Void {
    if (actRecSession instanceof ActRec.Session) {
      actRecSession.addLap();
    }
  }

  function getCurHeartRate() as Number {
    var info = Act.getActivityInfo();
    if (info != null) {
      if (info.currentHeartRate != null) {
        return info.currentHeartRate;
      }
    }

    return 0;
  }

  function getCurDistM() as Numeric {
    var info = Act.getActivityInfo();
    if (info != null) {
      if (info.elapsedDistance != null) {
        return info.elapsedDistance;
      }
    }

    return 0;
  }

  function getCurDistKM() as Numeric {
    return getCurDistM().toFloat() / 1000.0;
  }

  function getCurDistMi() as Numeric {
    return getCurDistM().toFloat() / METER_PER_MILE;
  }
}