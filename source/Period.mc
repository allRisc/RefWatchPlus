using Toybox.System as Sys;

using HelperFunctions as func;

class Period {

    hidden var startTime;
    hidden var periodDuration;

    // Initialized the period class with a given durations
    // @param [Number] dur The duration in minutes of the period
    function initialize(dur) {
        startTime      = 0;
        periodDuration = dur;
    }

    // Start the period timer
    function start() {
        startTime = Sys.getTimer();
    }

    // Stop the period timer
    function end() {
        startTime = 0;
    }


    /**********************************************************/
    /******************** Getter Functions ********************/
    /**********************************************************/

    // Get the number of milliseconds since the match started
    // @return [Number] The number of milliseconds since the match started
    function getMSecElapsed() {
        if (isStarted()) {
            return Sys.getTimer() - startTime;
        } else {
            return 0;
        }
    }

    // Get the number of seconds since the match started
    // @return [Number] The number of seconds since the match started
    function getSecElapsed() {
        return func.msec2sec(getMSecElapsed());
    }

    // Get the number of milliseconds until the end of the current period
    // @return [Number] The number of milliseconds until the end of the current period
    function getMSecRemaining() {
        return func.min2msec(periodDuration) - getMSecElapsed();
    }

    // Get the number of seconds until the end of the current period
    // @return [Number] The number of seconds until the end of the current period
    function getSecRemaining() {
        return func.msec2sec_ceil(getMSecRemaining());
    }

    // Determine if the match is currently in progress
    // @return [Boolean] True if the match is currently in progress
    function isStarted() {
        return startTime != 0;
    }
}