using Toybox.WatchUi as Ui;
using Toybox.Graphics as Gfx;
using Toybox.Application;
using Toybox.System as Sys;
using Toybox.Test;

class NumPicker extends Ui.Picker {

    function initialize(titleName, prop) {
        var title;

        Test.assertMessage(titleName instanceof String, "NumPicker: \'titleName\' not a string");
        Test.assertMessage(prop      instanceof String, "NumPicker: \'prop\' not a string");
        Test.assertMessage(Application.getApp().getProperty(prop) != null, "NumPicker: Invalid Property");

        title = new Ui.Text({:text=>titleName,     :locX=>Ui.LAYOUT_HALIGN_CENTER, :locY=>Ui.LAYOUT_VALIGN_BOTTOM, :color=>Gfx.COLOR_WHITE});

        var factories = new [1];

        factories[0] = new NumberFactory(0, 99, 1, {:font=>Graphics.FONT_MEDIUM});

        var defaults = new [1];
        defaults[0] = factories[0].getIndex(Application.getApp().getProperty(prop));

        Picker.initialize({:title=>title, :pattern=>factories, :defaults=>defaults});
    }
}

class NumPickerDelegate extends Ui.PickerDelegate {
    var pickerProperty;

    function initialize(prop) {
        PickerDelegate.initialize();
        pickerProperty = prop;
        Test.assertMessage(pickerProperty instanceof String, "NumPickerDelegate \'prop\' not a string");
    }

    function onCancel() {
        Ui.popView(WatchUi.SLIDE_IMMEDIATE);
    }

    function onAccept(values) {
        Application.getApp().setProperty(pickerProperty, values[0]);

        Ui.popView(WatchUi.SLIDE_IMMEDIATE);
    }
}