/* global ES6Promise */
import base from "./garoon/base";
import connect from "./garoon/connect";
import events from "./garoon/events";

window.garoon = {
    /**
     * ES6 Promise polyfill which used for JS customization
     * @type {*}
     */
    Promise: ES6Promise.Promise,
    base,
    connect,
    events,
};