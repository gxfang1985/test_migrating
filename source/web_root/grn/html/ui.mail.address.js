// This is javascript file it use case reload/draft edit or reedit email address
grn.base.namespace("grn.ui.mail.address");
jQuery(document).ready(function(e) {
    var addressControls = ['#to','#cc','#bcc'];
    var selectControls = ['#selectTo','#selectCC','#selectBCC'];
    var email = "";
    var display = "";
    jQuery.each(addressControls, function(i, item){
        var strEmail = jQuery(item).text();
        var fields = jQuery.trim(strEmail).match(/("|\s")(\\\"|[^"])*"\s<[^>]+>+|[^,;]+/g);
        if(strEmail.length > 0 && fields.length > 0) {
            jQuery.each(fields, function(j, displayEmail) {
                var result = grn.ui.mail.address.getEmailAndDisplayName(displayEmail);
                jQuery(selectControls[i]).append("<option class='selected' value='" + result.email + "'>" + result.display + "</option>");
            });
        }
    });
});
grn.ui.mail.address.getEmailAndDisplayName = function (displayEmail)
{
    displayEmail = jQuery.trim(displayEmail);
    var  email = "",
        display = "";
    result = sliptDisplayAndEmail(displayEmail);
    if(result != null && result.length == 3) {
        display = xssPrevent(result[1],1);
        email = xssPrevent(result[2],1);
    }
    else {
        /*jshint -W049 */ /* Unexpected escaped character '{a}' in regular expression. */
        display = xssPrevent(displayEmail.replace(/^\<|\>$/g,''), 1);
        /*jshint +W049 */
        email = display;
    }

    return {
        "display" : display,
        "email" : email
    }
}

//v2.11 execute display and email complete
function sliptDisplayAndEmail(str) {
    var parternGetDisplay = new RegExp(/^\"(.+)\"\s*/gi);
    /*jshint -W049 */ /* Unexpected escaped character '{a}' in regular expression. */
    var parternGetDisplay1 = new RegExp(/(.+)\s*\</gi);
    /*jshint +W049 */
    str = jQuery.trim(str);
    var tmparr = str.match(parternGetDisplay);
    var display = null;
    var email = null;
    var result = new Array();
    var tmpval = null;
    if(tmparr != null && tmparr.length != 0) {
        display = jQuery.trim(tmparr[0]);
        tmpval = jQuery.trim(str.replace(display,""));
        if(display.length > 1 && display.charAt(0) == "\"" && display.charAt(display.length-1) == "\"") {
            display = display.substring(1, display.length-1);
            display = display.replace(/\\"/g,'"').replace(/\\\\/g,'\\');
        }
        if(tmpval.length > 0 && tmpval.charAt(tmpval.length-1) == ">" )
        {
            /*jshint -W049 */ /* Unexpected escaped character '{a}' in regular expression. */
            email = tmpval.replace(/^\<|\>$/g,'');
            /*jshint +W049 */
            result[0] = str;
            result[1] = display;
            result[2] = email;
        }
    }else {
        tmparr = str.match(parternGetDisplay1);
        if(tmparr != null && tmparr.length != 0) {//tranvien <  --> tranvien	
            display = jQuery.trim(tmparr[0].substring(0,tmparr[0].length-1));
            tmpval = str.replace(display);
            if(tmpval.length > 0 && tmpval.charAt(tmpval.length-1) == ">" )
            {
                /*jshint -W049 */ /* Unexpected escaped character '{a}' in regular expression. */
                email = jQuery.trim(str.replace(display,'')).replace(/^\<|\>$/g,'');
                /*jshint +W049 */
                result[0] = str;
                result[1] = display;
                result[2] = email;
            }
        }
    }
    return result;
}
//v2.1
function xssPrevent(string, flag) {
    var strR = string;
    if (typeof flag != "undefined") {
        strR = "";
        for (i = 0; i < string.length; i++) {
            var charcode = string.charCodeAt(i);
            if ((_key.exclamation <= charcode && charcode <= _key.slash) || (_key.colon <= charcode && charcode <= _key.at) || (_key.squarebricket_left <= charcode && charcode <= _key.apostrof)) {
                strR += escape(string[i]);
            } else {
                strR += string[i];
            }
        }
    }
    return strR;
}
function xssDisplay(string, flag) {
    string = string.toString();
    if (typeof flag != "undefined") {
        return string;
    }
    return unescape(string);
}
//v2.1
function  convertHTMLCodeToChar(str) {
    return str.replace(/&lt;/gi,"<").replace(/&gt;/gi,">").replace(/&quot;/gi,"\"");
}
//v2.1
function convertHTMLCharToCode(str) {
    return str.replace(/</gi,"&lt;").replace(/>/gi,"&gt;").replace(/"/gi,"&quot;");
}
function isValidEmailAddress(emailAddress) {
    emailAddress = convertHTMLCodeToChar(xssDisplay(emailAddress));
    var strpattern = '([a-zA-Z0-9!#$%&\'*+\\-/=^_`{|}~]+(\\.[a-zA-Z0-9!#$%&\'*+\\-/=^_`{|}~]+)*@[a-zA-Z0-9!#$%&\'*+\\-/=^_`{|}~]+(\\.[a-zA-Z0-9!#$%&\'*+\\-/=^_`{|}~]+)*)';
    var pattern = new RegExp(strpattern);
    return pattern.test(emailAddress);
}
var _key = { 'enter': 13,
           'tab': 9,
           'comma': 188,
           'backspace': 8,
           'leftarrow': 37,
           'uparrow': 38,
           'rightarrow': 39,
           'downarrow': 40,
           'exclamation': 33,
           'slash': 47,
           'colon': 58,
           'at': 64,
           'squarebricket_left': 91,
           'apostrof': 96,
           'del': 46,
           'esc':27
         };