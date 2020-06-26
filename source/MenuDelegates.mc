using Toybox.WatchUi as Ui;
using Toybox.System as Sys;

class MainMenuInputDelegate extends Ui.MenuInputDelegate {

    function initialize() {
        MenuInputDelegate.initialize();
    }

    function onMenuItem(item) {
        switch (item) {
            case :EndMatch_MenuID       :
                Sys.exit();
                break;
            case :PeriodLength_MenuID   :
                Ui.pushView(new NumPicker(Rez.Strings.PeriodLength_MenuLabel.toString(), Rez.Strings.PeriodLength_PropID.toString()),
                            new NumPickerDelegate(Rez.Strings.PeriodLength_PropID.toString()),
                            Ui.SLIDE_LEFT);
                break;
            case :NumPeriods_MenuID     :
                Ui.pushView(new NumPicker(Rez.Strings.NumPeriods_MenuLabel.toString(), Rez.Strings.NumPeriods_PropID.toString()),
                            new NumPickerDelegate(Rez.Strings.NumPeriods_PropID.toString()),
                            Ui.SLIDE_LEFT);
                break;
            case :BreakLength_MenuID    :
                Ui.pushView(new NumPicker(Rez.Strings.BreakLength_MenuLabel.toString(), Rez.Strings.BreakLength_PropID.toString()),
                            new NumPickerDelegate(Rez.Strings.BreakLength_PropID.toString()),
                            Ui.SLIDE_LEFT);
                break;
            case :BreakAlert_MenuID     :
                Ui.pushView(new NumPicker(Rez.Strings.BreakAlert_MenuLabel.toString(), Rez.Strings.BreakAlert_PropID.toString()),
                            new NumPickerDelegate(Rez.Strings.BreakAlert_PropID.toString()),
                            Ui.SLIDE_LEFT);
                break;
            case :OTPeriodLength_MenuID :
                Ui.pushView(new NumPicker(Rez.Strings.OTPeriodLength_MenuLabel.toString(), Rez.Strings.OTPeriodLength_PropID.toString()),
                            new NumPickerDelegate(Rez.Strings.OTPeriodLength_PropID.toString()),
                            Ui.SLIDE_LEFT);
                break;
            case :NumOTPeriods_MenuID   :
                Ui.pushView(new NumPicker(Rez.Strings.NumOTPeriods_MenuLabel.toString(), Rez.Strings.NumOTPeriods_PropID.toString()),
                            new NumPickerDelegate(Rez.Strings.NumOTPeriods_PropID.toString()),
                            Ui.SLIDE_LEFT);
                break;
        }

        Ui.requestUpdate();
    }
}