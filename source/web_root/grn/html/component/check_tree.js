/**
 * Component for Check Tree
 */
grn.base.namespace("grn.component.check_tree");

/**
 * Constructor
 * @param {String} key
 * @param {String} formName
 * @param {String} checkName
 * @param {String} sendButton
 */
grn.component.checkTree = function(key, formName, checkName, sendButton) {
    this.key = key;
    this.form_name = formName;
    this.check_name = checkName;
    this.send_button = sendButton;
};

/**
 * submit select category.
 * @param {String} id
 */
grn.component.checkTree.prototype.onSelectCategory = function(id) {
    var frm = document.forms[this.form_name];
    var el = document.createElement("input");
    el.type  = "hidden";

    if(id > 0)
    {
        el.name  = this.key;
        el.value = id;
    }
    else
    {
        el.name  = "top";
        el.value = 1;
    }
    frm.appendChild(el);
    frm.submit();
};

/**
 * Change Enable/Disable of submit button.
 * @param {Boolean} on_off
 */
grn.component.checkTree.prototype.toggleSendButton = function(on_off) {
    var btn = document.getElementById(this.send_button);
    if( on_off && btn.disabled )
    {
        btn.disabled = false;
    }
    else if( ! on_off && ! btn.disabled )
    {
        btn.disabled = true;
    }
};

/**
 * Click the checkbox.
 * @param {String} title
 * @param {String} url
 * @param {Array} params
 */
grn.component.checkTree.prototype.onClickTreeCheckbox = function() {
    var array = [];
    var obj = document.getElementsByName(this.check_name);
    var checkFlag = false;
    for(var i = 0; i < obj.length; i++)
    {
        if(obj[i].checked)
        {
            checkFlag = true;
            break;
        }
    }
    this.toggleSendButton(checkFlag);
};

/**
 * Get the checked category.
 */
grn.component.checkTree.prototype.getCheckList = function() {
    /*jshint -W058 */ /* Missing '()' invoking a constructor. */
    var array = new Array;
    /*jshint +W058 */
    var obj = document.getElementsByName( this.check_name );
    for(var i = 0; i < obj.length; i++)
    {
        if(obj[i].checked)
        {
            array.push(obj[i].value);
        }
    }
    return array;
};

/**
 * When the submit button is pressed to display a confirmation popup screen.
 * @param {String} title
 * @param {String} url
 * @param {Array} params
 */
grn.component.checkTree.prototype.showPopupCopyMultiConfirm = function(title, url, params) {
    var checks = this.getCheckList();
    // no check
    if( checks.length == 0) return;

    var postDataArray = new Array();
    for( var i = 0; i < params.length; i++ )
    {
        postDataArray.push( params[i] );
    }

    for(var i = 0; i < checks.length; i++)
    {
        postDataArray.push( this.check_name + '=' + checks[i] );
    }
    var postString = postDataArray.join( '&' );
    var conn = YAHOO.util.Connect;
    conn.asyncRequest(
            'POST',
            url,
            {
                success: function( obj ){
                    if ( obj.getResponseHeader['X-Cybozu-Error'] != null || obj.getResponseHeader['x-cybozu-error'] != null )
                    {
                        document.open();
                        document.clear();
                        document.write(obj.responseText);
                        document.close();
                        return;
                    }
                    if(! obj.responseText) return;

                    GRN_MsgBox.show(obj.responseText, title, GRN_MsgBoxButtons.yesno, {
                        ui       : {},
                        caption  : {
                            yes: grn.msg.YES,
                            no: grn.msg.NO
                        },
                        callback : function(result, form){
                            if(result == GRN_MsgBoxResult.yes){
                                form.submit();
                            }
                        }
                    });
                    return;
                },
                failure: function( obj ){
                }
            },
            postString
    );
};

