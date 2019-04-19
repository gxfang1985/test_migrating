(function(){
    "use strict";
    grn.base.namespace("grn.component.user_select.user_select");
    var userSelect = grn.component.user_select.user_select;
    userSelect.UserSelectParts = {};

    /**
     * @constructor
     */
    function UserSelectParts(selectElement, documentFragment, document) {
        this.domAPI = document;
        this.selectElement = selectElement;
        this.documentFragment = documentFragment;
        this.selectedIndex = 0;
        return this;
    }

    /**
     * Factory of UserSelectParts
     * @param formName
     * @param sUID
     * @returns {UserSelectParts}
     */
    userSelect.UserSelectParts.create = function(formName, sUID) {
        var selectElement = document.forms[formName].elements[sUID];
        var fragment = document.createDocumentFragment();
        return new UserSelectParts(selectElement, fragment, document);
    };
    
    /**
     * write fragment object to DOM
     */
    var applyToDOM = function() {
        var emptyOption = jQuery(this.selectElement).find("option").last();
        emptyOption.prop("selected", false);
        emptyOption.before(this.documentFragment);
        return this;
    };
    /**
     * add Option to fragment object(don't apply to DOM)
     * @public
     * @param option
     */
    UserSelectParts.prototype.addOption = function(option) {
        var optionElement = this.domAPI.createElement("option");
        optionElement.value = option.value;

        // GTM-1676
        if( option.className == "approval_facility_item" )
        {
            var beforeNewClass = optionElement.className == ''? '' : ' ';
            optionElement.className += beforeNewClass + 'approval_facility_item';
        }
        //end GTM-1676

        optionElement.appendChild(this.domAPI.createTextNode(option.text));
        this.documentFragment.appendChild(optionElement);
    };

    /**
     * set "selected" attribute on newly added options
     */
    UserSelectParts.prototype.applySelected = function() {
        var option = jQuery(this.selectElement).find("option");
        var start = this.selectedIndex;
        var lastIndex = option.last().index();
        option.filter(function(index){
            return start <= index && index < lastIndex;
        }).each(function(index, element) {
                element.setAttribute("selected", "selected");
        });
    };
    /**
     * rewrite all options
     * @param newOptions {Array.<Option>}
     */
    UserSelectParts.prototype.rewriteOptions = function(newOptions) {
        jQuery(this.selectElement).find("option").remove(":not(:last-child)");
        var userSelect = this;
        jQuery.each(newOptions, function(index, element) {
            userSelect.addOption(element);
        });
        return applyToDOM.call(this);
    };

    /**
     * add fragment document to DOM
     * @returns {UserSelectParts}
     */
    UserSelectParts.prototype.addToDOM = function() {
        var option = jQuery(this.selectElement).find("option");
        this.selectedIndex = option.last().index();
        return applyToDOM.call(this);

    };

})();