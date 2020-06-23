using Toybox.WatchUi as Ui;
using Toybox.System as Sys;

class MainMenuInputDelegate extends Ui.MenuInputDelegate {

    function initialize() {
        MenuInputDelegate.initialize();
    }

    function onMenuItem(item) {
        if (item == :end_match) {
            Sys.exit();
        } else if (item == :period_length) {
            Ui.pushView(new TimePicker(), new TimePickerDelegate(), Ui.SLIDE_LEFT);
            Ui.requestUpdate();
        }
    }
}

class PeriodLengthSettingsInputDelegate extends Ui.MenuInputDelegate {

    function initialize() {
        MenuInputDelegate.initialize();
    }

    function onMenuItem(item) {

    }
}