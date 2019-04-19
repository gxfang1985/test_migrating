/**
 * Implementing PubSub
 *
 * EXAMPLE:

 // --------------------------
 // "Greeting" component
 // --------------------------
 function Greeting(name) {
     // install PubSub methods to the Greeting component
     grn.component.pubsub.installTo(this);
     this.name = name;

     jQuery("#greeting_button").on("click", function () {
         this.say(this.name);
     }.bind(this));
 }

 Greeting.prototype.say = function (name) {
     // some logic here...
     // trigger the event called "say" to the subscriber
     this.trigger("say", { message: "Hello " + name });
 }

 // --------------------------
 // Example of the consumer
 // --------------------------
 MainController = {
     init: function () {
         this.greeting = new Greeting("World");
         this.greeting.on("say", this._onSay.bind(this));
     },
     _onSay: function (event, data) {
         console.log(data); // It should be Object {message: "Hello World"}
     }
 };

 MainController.init();
 */

grn.base.namespace("grn.component.pubsub");

(function ($) {
    "use strict";

    function PubSub() {
        this.$_pubsubChannels = $({});
    }

    // prototype

    PubSub.prototype.subscribe = function (/*channel, callback*/) {
        this.$_pubsubChannels.on.apply(this.$_pubsubChannels, arguments);
    };

    PubSub.prototype.unsubscribe = function (/*channel, callback*/) {
        this.$_pubsubChannels.off.apply(this.$_pubsubChannels, arguments);
    };

    PubSub.prototype.publish = function (channel, data) {
        var event = $.Event(channel);
        event.sender = this;

        this.$_pubsubChannels.trigger(event, data);

        return event;
    };

    // alias common names

    PubSub.prototype.on = PubSub.prototype.subscribe;
    PubSub.prototype.off = PubSub.prototype.unsubscribe;
    PubSub.prototype.trigger = PubSub.prototype.publish;

    // static members

    /**
     * Implement PubSub for the given target object
     * @param {Object} target - The target object which will be implemented PubSub
     * @param {Object} [options] - Options for implementation
     * @param {Object} options.useAliasMethods - Whether to implement the alias methods "on", "off", "trigger"
     */
    PubSub.installTo = function (target, options) {
        var default_options = {
            useAliasMethods: true
        };
        options = $.extend(default_options, options);

        var pubsub = new PubSub();

        ["$_pubsubChannels", "subscribe", "unsubscribe", "publish"].forEach(function (property) {
            target[property] = pubsub[property];
        });

        if (options["useAliasMethods"]) {
            ["on", "off", "trigger"].forEach(function (property) {
                target[property] = pubsub[property];
            });
        }
    };

    /**
     * This can be used for global communication
     * @type {PubSub}
     */
    PubSub.global = new PubSub();

    grn.component.pubsub = PubSub;

})(jQuery);
