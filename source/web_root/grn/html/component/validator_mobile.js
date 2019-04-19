grn.base.namespace("grn.component.validator_mobile");

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
 *   var validators = new grn.component.validator_mobile(document.forms["createData"], document.getElementById("FieldToShowErrorMessage"));
 *   validators.addValidator(new grn.component.validator_mobile.TextLengthLongerThan("title", "Title is required", 0) );
 *   validators.addValidator(new grn.component.validator_mobile.TextLengthShorterThan("title", "Title must be shorter than 256 characters", 256) );
 *   validators.addValidator(new grn.component.validator_mobile.CheckedOnlyOne("private", "Select whether it is private or not"));
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
grn.component.validator_mobile = function(form, errorMessageElement){
    this.form = form;
    this.errorMessageElement = errorMessageElement;
    this.validatorList = [];
};

/**
 * Add each validator
 * 
 * @param validator
 */
grn.component.validator_mobile.prototype.addValidator = function(validator){
    this.validatorList.push(validator);
};

/**
 * Execute all the validators
 * @returns {Boolean}
 */
grn.component.validator_mobile.prototype.validateAll = function(){
    var parentobj = this;
    var results = [];
    $.each( this.validatorList, function(){
        results.push(parentobj.validateEach_(this));
    });
    for(var i=0; i<results.length; i++){
        if(! results[i]){
            return false;
        }
    }
    return true;
};

/**
 * Execute a validator. called by validateAll
 * @param eachValidator
 * @returns {Boolean}
 */
grn.component.validator_mobile.prototype.validateEach_ = function(eachValidator){
    var result = eachValidator.validate(this.form);
    if(! result){
        eachValidator.showErrorMessage(this.errorMessageElement);
    }
    return result;
};

/**
 * Clear error messages
 * 
 */
grn.component.validator_mobile.prototype.clearErrorMessage = function(){
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
grn.component.validator_mobile.showErrorMessager = function(errorMessageElement, errorMessage){
    var icon = document.createElement('span');
    var span = document.createElement('span');
    var div  = document.createElement('div');
    icon.setAttribute('class', 'mobile-icon-error-grn');
    span.setAttribute('class', 'mobile-error-grn mobile-label-mark-grn');

    if (typeof span.textContent != "undefined") {
        span.textContent = errorMessage;
    } else {
        span.innerText = errorMessage;
    }
    if (errorMessageElement.style.display=='none')
    {
        errorMessageElement.style.display = '';
    }
    div.appendChild(icon);
    div.appendChild(span);
    errorMessageElement.appendChild(div);
};


/**
 * Validator: Pass when the length of the content is longer than *minLength* 
 * @param name attribute of the input element to be checked
 * @param errorMessage shows when the value is invalid.
 * @param minLength boundary
 */
grn.component.validator_mobile.TextLengthLongerThan = function(name, errorMessage, minLength, isStrip){
    if(arguments.length < 4 ) isStrip = true;

    this.name = name;
    this.errorMessage = errorMessage;
    this.minLength = minLength;
    this.isStrip = isStrip;
};

grn.component.validator_mobile.TextLengthLongerThan.prototype.validate = function(form){
    var text = form[this.name];

    var length;
    if(this.isStrip)
        length = $.trim(text.value).length;
    else
        length = text.value.length;

    if(length > this.minLength){
        return true;
    } else {
        return false;
    }
};

grn.component.validator_mobile.TextLengthLongerThan.prototype.showErrorMessage = function(errorMessageElement){
    grn.component.validator_mobile.showErrorMessager(errorMessageElement, this.errorMessage);
};

/**
 * Validator: Pass when the length of the content is shorter than *maxLength* 
 * @param name attribute of the input element to be checked
 * @param errorMessage shows when the value is invalid.
 * @param maxLength boundary
 */
grn.component.validator_mobile.TextLengthShorterThan = function(name, errorMessage, maxLength, isStrip){
    if(arguments.length < 4) isStrip = true;
    
    this.name = name;
    this.errorMessage = errorMessage;
    this.maxLength = maxLength;
    this.isStrip = isStrip;
};

grn.component.validator_mobile.TextLengthShorterThan.prototype.validate = function(form){
    var text = form[this.name];

    var length;
    if(this.isStrip)
        length = $.trim(text.value).length;
    else
        length = text.value.length;

    if(length < this.maxLength){
        return true;
    } else {
        return false;
    }
};

grn.component.validator_mobile.TextLengthShorterThan.prototype.showErrorMessage = function(errorMessageElement){
    grn.component.validator_mobile.showErrorMessager(errorMessageElement, this.errorMessage);
};


/**
 * Validator: Pass when the number of the option elements in a select element is more than the *minCount*
 * @param {string} name attribute of the input elements to be checked
 * @param {string} errorMessage shows when the value is invalid.
 * @param {integer} mincount boundary.
 */
grn.component.validator_mobile.SelectMoreThan = function(name, errorMessage, minCount){
    this.name = name;
    this.errorMessage = errorMessage;
    this.minCount = minCount;
};

grn.component.validator_mobile.SelectMoreThan.prototype.validate = function(form){
    var select = form[this.name];
    var options = select.options;
    var count = 0;
    
    for(var i=0; i<select.length; i++){
        if(options.item(i).value.length > 0){
            count ++;
        }
    }
    if(count > this.minCount) {
        return true;
    } else {
        return false;
    }
};

grn.component.validator_mobile.SelectMoreThan.prototype.showErrorMessage = function(errorMessageElement){
    grn.component.validator_mobile.showErrorMessager(errorMessageElement, this.errorMessage);
};


/**
 * Validator: Pass when only one of the input elements whose types are "radio" is selected.
 * @param {string} name attribute of the input elements to be checked
 * @param {string} errorMessage shows when the value is invalid.
 */
grn.component.validator_mobile.CheckedOnlyOne = function(name, errorMessage){
    this.name = name;
    this.errorMessage = errorMessage;
};

grn.component.validator_mobile.CheckedOnlyOne.prototype.validate = function(form){
    var elementList = form[this.name];
    var checked = false;
    if (elementList) {
        if (elementList.length) {
            for(var i=0; i < elementList.length; i++) {
                if(elementList[i].checked == true) {
                    if(checked == true){
                        return false;
                    }
                    checked = true;
                }
            }
        } else {
            return elementList.checked;
        }
    }
    return checked;
};

grn.component.validator_mobile.CheckedOnlyOne.prototype.showErrorMessage = function(errorMessageElement){
    grn.component.validator_mobile.showErrorMessager(errorMessageElement, this.errorMessage);
};

/**
 * Validator: Pass when the custom function returns true.
 * @param {string} func a custom function.
 * @param {string} errorMessage shows when the value is invalid.
 */
grn.component.validator_mobile.CustomValidate = function(func, errorMessage){
    this.func = func;
    this.errorMessage = errorMessage;
};

grn.component.validator_mobile.CustomValidate.prototype.validate = function(form){
    return this.func(form);
};

grn.component.validator_mobile.CustomValidate.prototype.showErrorMessage = function(errorMessageElement){
    grn.component.validator_mobile.showErrorMessager(errorMessageElement, this.errorMessage);
};
/**
 * Utility Functions
 */

grn.component.validator_mobile.util = {};
/**
 * Get Date object from grn_select_date component
 * 
 * @param prefix
 */
grn.component.validator_mobile.util.getDate = function(prefix, form) {
    var date, year, month, day, cdate_str, cdate_arr;
    if (form) {
        date  = form.elements[prefix].value;
    } else {
        date  = $(prefix).val();
    }
    /*jshint -W053 */ /* Do not use {a} as a constructor. */
    cdate_str = new String(date);
    /*jshint +W053 */
    cdate_arr = cdate_str.split("/");

    year  = (cdate_arr[0] == undefined) ? null : cdate_arr[0];
    month = (cdate_arr[1] == undefined) ? null : cdate_arr[1];
    day   = (cdate_arr[2] == undefined) ? null : cdate_arr[2];
    
    if (year && month && day) {
        return new Date(year, month-1, day);
    }
    
    return null;
};

/**
 * Validator: Check whether a file is uploaded.
 * @param {string} name attribute of the file upload elements
 * @param {string} errorMessage shows when the value is invalid.
 */
grn.component.validator_mobile.UploadedFile = function(flash, flash_file_name, file_name, errorMessage){
    this.flash = flash;
    this.flash_file_name = flash_file_name;
    this.file_name = file_name;
    this.errorMessage = errorMessage;
};

grn.component.validator_mobile.UploadedFile.prototype.validate = function(form){
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

grn.component.validator_mobile.UploadedFile.prototype.showErrorMessage = function(errorMessageElement){
    grn.component.validator_mobile.showErrorMessager(errorMessageElement, this.errorMessage);
};

/**
 * @param {string} url
 * @constructor
 */
grn.component.validator_mobile.TodoEndDateAsync = function (url) {
    this.url = url;
    this.errorMessage = null;
};

/**
 * @param {jqXHR} jq_xhr
 * @returns {object} or {null}
 */
grn.component.validator_mobile.TodoEndDateAsync.prototype.checkGaroonError = function (jq_xhr) {
    var error = null;
    if (grn.component.mobile_error_handler.hasCybozuError(jq_xhr)) {
        error = JSON.parse(jq_xhr.responseText);
    }
    return error;
};

/**
 * @param {object} form
 * @returns {object}
 */
grn.component.validator_mobile.TodoEndDateAsync.prototype.validate = function (form) {
    var end_date = form["end"].value;
    end_date = end_date.split('/');

    var data = {
        "year": end_date[0],
        "month": end_date[1],
        "day": end_date[2],
        "no_limit": form["nolimit"].checked,
        "spid": form["spid"].value,
        "csrf_ticket": grn.data.CSRF_TICKET,
        "use_ajax": 1
    };

    var deferred = $.Deferred();
    $.post(grn.component.url.page(this.url), data).done(function (json_object, text_status, jq_xhr) {
        var request_error = this.checkGaroonError(jq_xhr);
        if (request_error && typeof request_error.diagnosis !== "undefined") {
            this.errorMessage = request_error.diagnosis;
            deferred.reject();
        } else {
            deferred.resolve();
        }
    }.bind(this)).fail(function (jq_xhr) {
        var request_error = this.checkGaroonError(jq_xhr);
        if (request_error && typeof request_error.diagnosis !== "undefined") {
            this.errorMessage = request_error.diagnosis;
        }
        deferred.reject();
    }.bind(this));

    return deferred.promise();
};

/**
 * @param {object} error_message_element
 */
grn.component.validator_mobile.TodoEndDateAsync.prototype.showErrorMessage = function (error_message_element) {
    grn.component.validator_mobile.showErrorMessager(error_message_element, this.errorMessage);
};

grn.component.validator_mobile.prototype.validateAllAsync = function () {
    var deferred = $.Deferred();

    var results = this.validatorList.map(this.validateEachAsync.bind(this));
    $.when.apply($, results).done(function(){
        deferred.resolve();
    }).fail(function(){
        deferred.reject();
    });

    return deferred.promise();
};

/**
 * @param {object} each_validator
 * @returns {object}
 */
grn.component.validator_mobile.prototype.validateEachAsync = function (each_validator) {
    var result = each_validator.validate(this.form);
    var deferred = $.Deferred();

    if (result !== null && typeof result === "object" && typeof result.then === "function") {
        result.fail(function() {
            each_validator.showErrorMessage(this.errorMessageElement);
            deferred.reject();
        }.bind(this));

        result.done(function() {
            deferred.resolve();
        });
    } else {
        if (!result) {
            each_validator.showErrorMessage(this.errorMessageElement);
            deferred.reject();
        } else {
            deferred.resolve();
        }
    }

    return deferred.promise();
};


