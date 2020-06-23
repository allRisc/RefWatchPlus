using Toybox.WatchUi as Ui;
using Toybox.Graphics as Gfx;
using Toybox.Application;

class TimePicker extends Ui.Picker {
    function initialize() {
        var title = new Ui.Text({:text=>"Period Length", :locX=>Ui.LAYOUT_HALIGN_CENTER, :locY=>Ui.LAYOUT_VALIGN_BOTTOM, :color=>Gfx.COLOR_WHITE});
        var factories = new [1];

        factories[0] = new NumberFactory(0, 99, 1, {:font=>Graphics.FONT_MEDIUM});

        var defaults = new [1];
        defaults[0] = factories[0].getIndex(45);

        Picker.initialize({:title=>title, :pattern=>factories, :defaults=>defaults});
    }
}

class TimePickerDelegate extends Ui.PickerDelegate {
    function initialize() {
        PickerDelegate.initialize();
    }

    function onCancel() {
        Ui.popView(WatchUi.SLIDE_IMMEDIATE);
    }

    function onAccept(values) {
        var time = values[0];
        Application.getApp().setProperty("period_time", time);

        Ui.popView(WatchUi.SLIDE_IMMEDIATE);
    }
}