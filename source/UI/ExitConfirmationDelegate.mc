using Toybox.System as Sys;
using Toybox.WatchUi as Ui;

class ExitConfirmationDelegate extends Ui.ConfirmationDelegate{
    function initialize() {
        ConfirmationDelegate.initialize();
    }

    function onResponse(response) {
        if (response == WatchUi.CONFIRM_NO) {
            System.println("Don't Exit");
            Ui.popView(Ui.SLIDE_IMMEDIATE);
        } else {
            System.println("Exiting");
            Sys.exit();
        }
    }
}