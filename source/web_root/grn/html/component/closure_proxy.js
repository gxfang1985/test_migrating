goog.provide('grn.closure_proxy');

goog.require('goog.i18n.DateTimeFormat');
goog.require('goog.i18n.DateTimeParse');
goog.require('goog.ui.DatePicker');
goog.require('goog.ui.InputDatePicker');
goog.require('goog.i18n.DateTimeSymbols_en');
goog.require('goog.i18n.DateTimeSymbols_ja');
goog.require('goog.i18n.DateTimeSymbols_zh');
goog.require('goog.i18n.DateTimeSymbols_zh_TW');
goog.require('goog.events');
goog.require('goog.ui.PopupBase');
goog.require('goog.positioning');

grn.closure_proxy.addDatePicker = function(inputElement, lang, opt_adjust) {
    var formatter = new goog.i18n.DateTimeFormat("yyyy'-'MM'-'dd");
    var parser = new goog.i18n.DateTimeParse("yyyy'-'MM'-'dd");
    var dtSymbols = goog.i18n.DateTimeSymbols_en;
    if ( lang === 'ja' ) {
        dtSymbols = goog.i18n.DateTimeSymbols_ja;
    } else if ( lang === 'zh' ) {
        dtSymbols = goog.i18n.DateTimeSymbols_zh;
    } else if ( lang === 'zh-tw' ) {
        dtSymbols = goog.i18n.DateTimeSymbols_zh_TW;
    }
    var datePicker = new goog.ui.DatePicker(null, dtSymbols);
    var idp = new goog.ui.InputDatePicker(formatter, parser, datePicker);

    if ( opt_adjust ) {
        // not to overflow and scroll over the window.
        goog.events.listen(idp, goog.ui.PopupBase.EventType.SHOW, function() {
            idp.popupDatePicker_.popup_.setPosition(new goog.positioning.AnchoredViewportPosition(inputElement, goog.positioning.Corner.BOTTOM_START, true));
        });
    }

    idp.decorate(inputElement);
};

goog.exportSymbol('grn.closure_proxy.addDatePicker', grn.closure_proxy.addDatePicker);
