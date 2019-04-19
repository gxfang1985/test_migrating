grn.base.namespace("grn.component.validator");

/**
 * Validator container
 *
 * Sample
 * {grn_load_javascript file="grn/html/component/validator.js"}
 * <div id="FieldToShowErrorMessage"></div>
 * <form name="createData">
 *   <input name="title" type="text">
 *   <input name="private" type="radio" value="1"> <input name="private" type="radio" value="2">
 *   <input type="button" id="buttonSubmit" value="submit">
 * </form>
 * <script>
 * $("buttonSubmit").observe("click", function(event){
 *   var validators = new grn.component.validator(document.forms["createData"], document.getElementById("FieldToShowErrorMessage"));
 *   validators.addValidator(new grn.component.validator.TextLengthLongerThan("title", "Title is required", 0) );
 *   validators.addValidator(new grn.component.validator.TextLengthShorterThan("title", "Title must be shorter than 256 characters", 256) );
 *   validators.addValidator(new grn.component.validator.CheckedOnlyOne("private", "Select whether it is private or not"));
 *   validators.clearErrorMessage();
 *   if(validators.validateAll()){
 *      grn_onsubmit_common(document.forms["createData"]);
 *      document.forms["createData"].submit();
 *  }
 * });
 * </script>

 * @param HTMLFormElement form the form element to validate
 * @param HTMLElement errorMessageElement the element in which error message shows
 */
grn.component.validator = function(form, errorMessageElement){
    this.form = form;
    this.errorMessageElement = errorMessageElement;
    this.validatorList = [];
};

/**
 * Add each validator
 * 
 * @param validator
 */
grn.component.validator.prototype.addValidator = function(validator){
    this.validatorList.push(validator);
};

/**
 * Execute all the validators
 * @returns {Boolean}
 */
grn.component.validator.prototype.validateAll = function(){
    var results = this.validatorList.map(this.validateEach_.bind(this));
    for(var i=0; i<results.length; i++){
        if(! results[i]){
            return false;
        }
    }
    return true;
};

grn.component.validator.prototype.validateAllAsync = function(){
    var results = this.validatorList.map(this.validateEachAsync_.bind(this));
    return jQuery.when.apply(jQuery, results).then(function(){
        var result = Array.prototype.slice.call(arguments);
        var is_invalid = result.some(function(element){
            return element === false;
        });

        if (is_invalid) {
            return jQuery.Deferred().reject();
        }

        return jQuery.Deferred().resolve();
    });
};

/**
 * Execute a validator. called by validateAll
 * @param eachValidator
 * @returns {Boolean}
 */
grn.component.validator.prototype.validateEach_ = function(eachValidator){
    var result = eachValidator.validate(this.form);
    if(! result){
        eachValidator.showErrorMessage(this.errorMessageElement);
    }
    return result;
};

/**
 * Execute a validator. called by validateAll
 * @param eachValidator
 * @returns {Object}
 */
grn.component.validator.prototype.validateEachAsync_ = function(eachValidator){
    var result = eachValidator.validate(this.form);
    var deferred = jQuery.Deferred();

    if (typeof result === "object" && typeof result.then === "function") {
        result.fail(function(){
            eachValidator.showErrorMessage(this.errorMessageElement);
            return deferred.resolve(false);
        }.bind(this));
        return result;
    }

    if(! result){
        eachValidator.showErrorMessage(this.errorMessageElement);
        return deferred.resolve(false);
    }

    return deferred.resolve(true);
};

/**
 * Clear error messages
 * 
 */
grn.component.validator.prototype.clearErrorMessage = function(){
    while(this.errorMessageElement.firstChild != null){
        this.errorMessageElement.removeChild(this.errorMessageElement.firstChild);
    }
};

/**
 * Show error message
 * 
 * @param errorMessageElement
 * @param errorMessage
 */
grn.component.validator.showErrorMessager = function(errorMessageElement, errorMessage){
    var span = document.createElement("div");
    span.setAttribute("class", "attention bold subnotify16");

    if (typeof span.textContent != "undefined") {
        span.textContent = errorMessage;
    } else {
        span.innerText = errorMessage;
    }
    if (errorMessageElement.style.display=='none')
    {
        errorMessageElement.style.display = '';
    }
    errorMessageElement.appendChild(span);
};


/**
 * Validator: Pass when the length of the content is longer than *minLength* 
 * @param name attribute of the input element to be checked
 * @param errorMessage shows when the value is invalid.
 * @param minLength boundary
 */
grn.component.validator.TextLengthLongerThan = function(name, errorMessage, minLength, isStrip){
    if(arguments.length < 4 ) isStrip = true;

    this.name = name;
    this.errorMessage = errorMessage;
    this.minLength = minLength;
    this.isStrip = isStrip;
};

grn.component.validator.TextLengthLongerThan.prototype.validate = function(form){
    var text = form[this.name];
    var length;
    if(this.isStrip)
    {
        if (navigator.userAgent.toLowerCase().indexOf("msie") > -1)
            length = unescape(escape(text.value).replace(/^(%u3000|%20|%09)+|(%u3000|%20|%09)+$/g, "")).length;
        else
            length = text.value.trim().length;
    }
    else
    {
        length = text.value.length;
    }

    return length > this.minLength;
};

grn.component.validator.TextLengthLongerThan.prototype.showErrorMessage = function(errorMessageElement){
    grn.component.validator.showErrorMessager(errorMessageElement, this.errorMessage);
};

/**
 * Validator: Pass when the length of the content is shorter than *maxLength* 
 * @param name attribute of the input element to be checked
 * @param errorMessage shows when the value is invalid.
 * @param maxLength boundary
 */
grn.component.validator.TextLengthShorterThan = function(name, errorMessage, maxLength, isStrip){
    if(arguments.length < 4) isStrip = true;
    
    this.name = name;
    this.errorMessage = errorMessage;
    this.maxLength = maxLength;
    this.isStrip = isStrip;
};

grn.component.validator.TextLengthShorterThan.prototype.validate = function(form){
    var text = form[this.name];

    var length;
    if(this.isStrip)
    {
        if (navigator.userAgent.toLowerCase().indexOf("msie") > -1)
            length = unescape(escape(text.value).replace(/^(%u3000|%20|%09)+|(%u3000|%20|%09)+$/g, "")).length;
        else
            length = text.value.trim().length;
    }
    else
        length = text.value.length;

    return length < this.maxLength;
};

grn.component.validator.TextLengthShorterThan.prototype.showErrorMessage = function (errorMessageElement) {
    grn.component.validator.showErrorMessager(errorMessageElement, this.errorMessage);
};

/**
 * Validator: Pass when the datetime provides is valid
 * @param name attribute of the input element to be checked
 * @param url The url will be executed validate datetime
 */
grn.component.validator.DatetimeAsync = function (name, url) {
    this.name = name;
    this.url = url;
};

grn.component.validator.DatetimeAsync.prototype.validate = function () {
    var request = new grn.component.ajax.request({
        grnUrl: this.url,
        method: "post",
        data: {
            "year": jQuery("#" + this.name + "year").val(),
            "month": jQuery("#" + this.name + "month").val(),
            "day": jQuery("#" + this.name + "day").val(),
            "hour": jQuery("#" + this.name + "hour").val(),
            "minute": jQuery("#" + this.name + "minute").val(),
            "csrf_ticket": grn.data.CSRF_TICKET
        }
    });

    var deferred = jQuery.Deferred();

    request.send()
        .done(function (json_object) {
            if (typeof json_object !== "undefined" && json_object.success === false) {
                this.errorMessage = json_object.error_message;
                deferred.reject();
                return false;
            }
            deferred.resolve();
        }.bind(this));

    return deferred;
};

grn.component.validator.DatetimeAsync.prototype.showErrorMessage = function(errorMessageElement){
    grn.component.validator.showErrorMessager(errorMessageElement, this.errorMessage);
};

/**
 * Validator: Pass when the number of the option elements in a select element is more than the *minCount*
 * @param {string} name attribute of the input elements to be checked
 * @param {string} errorMessage shows when the value is invalid.
 * @param {integer} mincount boundary.
 */
grn.component.validator.SelectMoreThan = function(name, errorMessage, minCount){
    this.name = name;
    this.errorMessage = errorMessage;
    this.minCount = minCount;
};

grn.component.validator.SelectMoreThan.prototype.validate = function(form){
    var select = jQuery.grep(form[this.name].value.split(":"), function (s) {
        return s !== "";
    });
    if (select.length > this.minCount) {
        return true;
    }
    return false;
};

grn.component.validator.SelectMoreThan.prototype.showErrorMessage = function(errorMessageElement){
    grn.component.validator.showErrorMessager(errorMessageElement, this.errorMessage);
};


/**
 * Validator: Pass when only one of the input elements whose types are "radio" is selected.
 * @param {string} name attribute of the input elements to be checked
 * @param {string} errorMessage shows when the value is invalid.
 */
grn.component.validator.CheckedOnlyOne = function(name, errorMessage){
    this.name = name;
    this.errorMessage = errorMessage;
};

grn.component.validator.CheckedOnlyOne.prototype.validate = function(form){
    var elementList = form[this.name];
    var checked = false;
    for(var i=0; i < elementList.length; i++) {
        if(elementList[i].checked == true) {
            if(checked == true){
                return false;
            }
            checked = true;
        }
    }
    return checked;
};

grn.component.validator.CheckedOnlyOne.prototype.showErrorMessage = function(errorMessageElement){
    grn.component.validator.showErrorMessager(errorMessageElement, this.errorMessage);
};

/**
 * Validator: Pass when the custom function returns true.
 * @param {string} func a custom function.
 * @param {string} errorMessage shows when the value is invalid.
 */
grn.component.validator.CustomValidate = function(func, errorMessage){
    this.func = func;
    this.errorMessage = errorMessage;
};

grn.component.validator.CustomValidate.prototype.validate = function(form){
    return this.func(form);
};

grn.component.validator.CustomValidate.prototype.showErrorMessage = function(errorMessageElement){
    grn.component.validator.showErrorMessager(errorMessageElement, this.errorMessage);
};
/**
 * Utility Functions
 */

grn.component.validator.util = {};
/**
 * Get Date object from grn_select_date component
 * 
 * @param prefix
 */
grn.component.validator.util.getDate = function(prefix, form) {
    var year, month, day;
    if (form) {
        year  = form.elements[prefix + 'year'];
        month = form.elements[prefix + 'month'];
        day   = form.elements[prefix + 'day'];
    } else {
        year  = document.getElementById(prefix + 'year');
        month = document.getElementById(prefix + 'month');
        day   = document.getElementById(prefix + 'day');
    }
    if (year && month && day) {
        return new Date(year.options[year.selectedIndex].value,
                month.options[month.selectedIndex].value,
                day.options[day.selectedIndex].value);
    }
    
    return null;
};

/**
 * Validator: Check whether a file is uploaded.
 * @param {string} name attribute of the file upload elements
 * @param {string} errorMessage shows when the value is invalid.
 */
grn.component.validator.UploadedFile = function(flash, flash_file_name, file_name, errorMessage){
    this.flash = flash;
    this.flash_file_name = flash_file_name;
    this.file_name = file_name;
    this.errorMessage = errorMessage;
};

grn.component.validator.UploadedFile.prototype.validate = function(form){
    var flash = document.getElementById(this.flash).style.display;

    if (flash != "none") {
        var flashElementList = form[this.flash_file_name];
        if ( flashElementList == null || flashElementList.length < 1 ) {
            return false;
        } else {
            return true;
        }
    } else {
        var ElementList = form[this.file_name];
        if ( ElementList.value == null || ElementList.value == "") {
            return false;
        } else {
            return true;
        }
    }
};

grn.component.validator.UploadedFile.prototype.showErrorMessage = function(errorMessageElement){
    grn.component.validator.showErrorMessager(errorMessageElement, this.errorMessage);
};

/**
 * Validator: Check when the *chkName* checkbox checked and the number of the option elements is more than the *minCount*.
 * @param {string} name attribute of the checkbox.
 * @param {string} name attribute of the input elements.
 * @param {string} errorMessage shows when the value is invalid.
 * @param {integer} mincount boundary.
 */
grn.component.validator.CheckedAndSelectMoreThan = function(chkName, mulOpName, errorMessage, minCount){
    this.chkName = chkName;
    this.mulOpName = mulOpName;
    this.errorMessage = errorMessage;
    this.minCount = minCount;
};

grn.component.validator.CheckedAndSelectMoreThan.prototype.validate = function(form){
    if (form[this.chkName].checked) {
        var select = jQuery.grep(form[this.mulOpName].value.split(":"), function (s) {
            return s !== "";
        });
        if (select.length > this.minCount) {
            return true;
        }
        return false;
    }
    else
    {
        return true;
    }
};

grn.component.validator.CheckedAndSelectMoreThan.prototype.showErrorMessage = function(errorMessageElement){
    grn.component.validator.showErrorMessager(errorMessageElement, this.errorMessage);
};