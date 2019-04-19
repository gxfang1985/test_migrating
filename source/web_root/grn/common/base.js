if( typeof grn == "undefined"){
    /*jshint -W079 */ /* W079: Redefinition of '{a}'. */
    var grn = {};
    /*jshint +W079 */
    grn.base = {};
}

grn.base.namespace = function(namespace){
    var node = grn;
    var nameList = namespace.split(".");
    
    if (nameList.length < 2 || nameList[0] != 'grn') return;
    
    for (var i=1; i < nameList.length; i++){
        node[nameList[i]] = node[nameList[i]] || {};
        node = node[nameList[i]];
    }
};

grn.base.isNamespaceDefined = function(namespace){
    var nameList = namespace.split(".");
    var node = window[nameList[0]] || {};

    for (var i = 1; i < nameList.length; i++) {
        if (node[nameList[i]]) {
            node = node[nameList[i]];
        } else {
            return false;
        }
    }
    return true;
};

grn.base.extendClass = function (parentClass, childClassName, childProto) {
    // Make inheritance from the given object
    function inherit_(proto) {
        if (typeof Object.create == 'function') {
            return Object.create(proto);
        } else {
            function F() {}
            F.prototype = proto;
            /*jshint -W058 */ /* Missing '()' invoking a constructor. */
            return new F;
        }
    }

    // Create the constructor of the child class
    // it will invoke the "_construct" method when the object is instantiated
    var childClass = (function () {
        return function () {
            if (typeof this._construct == 'function') {
                this._construct.apply(this, arguments);
            }
        };
    })();

    // Make inheritance from the parent class
    childClass.prototype = inherit_(parentClass.prototype);

    // "_super" helps us can invoke the method of to the parent class
    childClass.prototype._super = parentClass.prototype;

    // Set the class name will help us to easy identify the class when debugging
    childClass.prototype._className = childClassName;

    // Copy the defined methods/properties to child class
    for (var i in childProto) {
        childClass.prototype[i] = childProto[i];
    }

    return childClass;
};