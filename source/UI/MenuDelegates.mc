using Toybox.WatchUi as Ui;
using Toybox.System as Sys;

class MainMenuInputDelegate extends Ui.MenuInputDelegate {

    function initialize() {
        MenuInputDelegate.initialize();
    }

    function onMenuItem(item) {
        switch (item) {
            case :EndMatch_MenuID       :
                Ui.pushView(new Ui.Confirmation("Quit Match?"),
                            new ExitConfirmationDelegate(),
                            Ui.SLIDE_IMMEDIATE);
                break;
            case :PeriodLength_MenuID   :
                Ui.pushView(new NumPicker(Ui.loadResource(Rez.Strings.PeriodLength_MenuLabel), Ui.loadResource(Rez.Strings.PeriodLength_StorageID)),
                            new NumPickerDelegate(Ui.loadResource(Rez.Strings.PeriodLength_StorageID)),
                            Ui.SLIDE_LEFT);
                break;
            case :NumPeriods_MenuID     :
                Ui.pushView(new NumPicker(Ui.loadResource(Rez.Strings.NumPeriods_MenuLabel), Ui.loadResource(Rez.Strings.NumPeriods_StorageID)),
                            new NumPickerDelegate(Ui.loadResource(Rez.Strings.NumPeriods_StorageID)),
                            Ui.SLIDE_LEFT);
                break;
            case :BreakLength_MenuID    :
                Ui.pushView(new NumPicker(Ui.loadResource(Rez.Strings.BreakLength_MenuLabel), Ui.loadResource(Rez.Strings.BreakLength_StorageID)),
                            new NumPickerDelegate(Ui.loadResource(Rez.Strings.BreakLength_StorageID)),
                            Ui.SLIDE_LEFT);
                break;
            case :BreakAlert_MenuID     :
                Ui.pushView(new NumPicker(Ui.loadResource(Rez.Strings.BreakAlert_MenuLabel), Ui.loadResource(Rez.Strings.BreakAlert_StorageID)),
                            new NumPickerDelegate(Ui.loadResource(Rez.Strings.BreakAlert_StorageID)),
                            Ui.SLIDE_LEFT);
                break;
            case :OTPeriodLength_MenuID :
                Ui.pushView(new NumPicker(Ui.loadResource(Rez.Strings.OTPeriodLength_MenuLabel), Ui.loadResource(Rez.Strings.OTPeriodLength_StorageID)),
                            new NumPickerDelegate(Ui.loadResource(Rez.Strings.OTPeriodLength_StorageID)),
                            Ui.SLIDE_LEFT);
                break;
            case :NumOTPeriods_MenuID   :
                Ui.pushView(new NumPicker(Ui.loadResource(Rez.Strings.NumOTPeriods_MenuLabel), Ui.loadResource(Rez.Strings.NumOTPeriods_StorageID)),
                            new NumPickerDelegate(Ui.loadResource(Rez.Strings.NumOTPeriods_StorageID)),
                            Ui.SLIDE_LEFT);
                break;
        }

        Ui.requestUpdate();
    }
}