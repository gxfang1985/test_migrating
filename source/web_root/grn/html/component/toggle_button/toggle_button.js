grn.base.namespace("grn.component.toggle_button");

(function(){
    "use strict";
    var G = grn.component.toggle_button;
    G.onClass = "button_state_on_grn";
    G.offClass = "button_state_off_grn";
    G.attentionClass = "button_state_attention_grn";
    /**
     * @type {{on_msg: string, off_msg: string, turn_on_msg: string, turn_off_msg: string}}
     */
    G.msgResources = {
        'on_msg': 'ON',
        'off_msg': 'OFF',
        'turn_on_msg': 'TURN ON',
        'turn_off_msg': 'TURN OFF'
    };
    /**
     * @type {{turn_on: Function, turn_off: Function}}
     */
    G.callbackFunctions = {
        'turn_on': function(){},
        'turn_off': function(){}
    };
    /**
     * @type {{ON: number, TURN_OFF: number, OFF: number, TURN_ON: number}}
     */
    G.buttonStateList = {
        'ON': 1,
        'TURN_OFF': 2,
        'OFF': 3,
        'TURN_ON': 4
    };

    /**
     * @param id
     * @param {{on_msg: string, off_msg: string, turn_on_msg: string, turn_off_msg: string}} msgResources
     * @param {{turn_on: Function, turn_off: Function}} callbackFunctions
     * @constructor
     */
    G.ToggleButton = function ToggleButton(id, msgResources, callbackFunctions) {
        this.obj = jQuery("#" + id);
        this.status = (this.obj.find('div').hasClass(G.onClass)) ? G.buttonStateList.ON : G.buttonStateList.OFF;
        this.msgResources = (msgResources) ? msgResources : G.msgResources;
        this.callbackFunctions = (callbackFunctions) ? callbackFunctions : G.callbackFunctions;
        this.setButtonControl();
    };

    /**
     * @param obj
     * @param {String} addClass
     */
    G.ToggleButton.prototype.classChange = function(obj, addClass) {
        obj.removeAttr('class').addClass(addClass);
    };

    G.ToggleButton.prototype.setButtonControl = function() {
        var buttonDiv = this.obj.find("div");
        var buttonLink = this.obj.find("a");
        this.obj.mouseover(function(){
            if (this.status == G.buttonStateList.ON) {
                buttonLink.html(this.msgResources.turn_off_msg);
                this.classChange(buttonDiv, G.attentionClass);
                this.status = G.buttonStateList.TURN_OFF;
            } else {
                buttonLink.html(this.msgResources.turn_on_msg);
                this.classChange(buttonDiv, G.onClass);
                this.status = G.buttonStateList.TURN_ON;
            }
        }.bind(this));

        this.obj.mouseout(function(){
            if (this.status == G.buttonStateList.TURN_OFF) {
                buttonLink.html(this.msgResources.on_msg);
                this.classChange(buttonDiv, G.onClass);
                this.status = G.buttonStateList.ON;
            } else if (this.status == G.buttonStateList.TURN_ON) {
                buttonLink.html(this.msgResources.off_msg);
                this.classChange(buttonDiv, G.offClass);
                this.status = G.buttonStateList.OFF;
            }
        }.bind(this));

        this.obj.click(function(){
            if (this.status == G.buttonStateList.TURN_OFF || this.status == G.buttonStateList.ON) {
                this.callbackFunctions.turn_off(this);
            } else {
                this.callbackFunctions.turn_on(this);
            }
        }.bind(this));
    };

    G.ToggleButton.prototype.turnOn = function () {
        this.obj.find('a').html(this.msgResources.on_msg);
        this.classChange(this.obj.find('div'), G.onClass);
        this.status = G.buttonStateList.ON;
    };

    G.ToggleButton.prototype.turnOff = function () {
        this.obj.find('a').html(this.msgResources.off_msg);
        this.classChange(this.obj.find('div'), G.offClass);
        this.status = G.buttonStateList.OFF;
    };
})();
