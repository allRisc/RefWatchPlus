using Toybox.System as Sys;
using Toybox.Application as app;

using HelperFunctions as func;

class BreakPeriod extends Period {
    function initialize(dur) {
        Period.initialize(dur);
    }

    // Determine if the break is almost complete
    // @return [Boolean] True if there are less than RefWatchSettings.breakAlert minutes remaining in the period
    function isNearComplete() {
        return getSecRemaining() <= func.min2sec(app.getApp().getProperty("break_alert"));
    }
}