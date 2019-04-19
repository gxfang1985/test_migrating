{include file="grn/popup_head.tpl"}
<div class="popup_title_grn">
    <div class="float_left">
        {grn_title title=$page_title class=$page_info.parts[0]}
        <div class="explanation">{cb_msg module='grn.address' key='GRN_ADDR-46' replace='true'}</div>
    </div>
    <a href="#" onclick="window.close();" role="button">
        <div title="{cb_msg module='grn.grn' key='GRN_GRN-840' replace='true'}"
             aria-label="{cb_msg module='grn.grn' key='GRN_GRN-840' replace='true'}" class="subWindowClose-grn"></div>
    </a>
    <div class="clear_both_0px"></div>
</div>
<form name="list" method="POST" action="{cb_pageurl page='address/command_mail_address_index' bic=$book_id}">
    <input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
    <input type="hidden" name="selectType"  value="{$selectType}"/>

{include file="address/mail_address_select.tpl"}

{literal}
<script language="JavaScript" type="text/javascript"><!--

function submit_in( form )
{

    if( ! IsAliveWindow( opener ) )
    {
        window.close();
        return ;
    }
    if( ! form )
    {
        window.close();
        return;
    }
    var mail_form = opener.document.forms['{/literal}{$form_name}{literal}'];
    var selectType = '{/literal}{$selectType}{literal}';
    if( mail_form )
    {
        var options = [];
        var keys = [];
        var values = {};

        if( selectType === "default")
        {
            options['to'] = form.elements['s_uid_to[]'].options;
            options['cc'] = form.elements['s_uid_cc[]'].options;
            options['bcc'] = form.elements['s_uid_bcc[]'].options;
            keys = ['to', 'cc', 'bcc'];
            values = {
                "to"  : "",
                "cc"  : "",
                "bcc" : ""
            };
        }
        else if (selectType === "automaticForward")
        {
            options["forwardTo"] = form.elements["s_uid_forwardTo[]"].options;
            keys = ["forwardTo"];
            values = {
                "forwardTo" : ""
            };
        }


        // join addresses in list box to string
        for(i=0; i<keys.length; i++)
        {
            key = keys[i];
            var opts = options[key];
            value = '';
            for( j=0; j<opts.length; j++ )
            {
                if(! opts[j].value)
                {
                    continue;
                }
                if( ! value )
                {
                    value += opts[j].value.substr( opts[j].value.indexOf(":") + 1 );
                }
                else
                {
                    value += ", " + opts[j].value.substr( opts[j].value.indexOf(":") + 1 );
                }
            }
            values[key] = value;
        }
        
        // check length of addresses.
        var invalid_obj = '';
        for(i=0; i<keys.length; i++)
        {
            key = keys[i];
            field = mail_form[key];
            address_length = encodeURIComponent(values[key]).replace(/%../g, 'x').length; // get length of string in bytes
            if( field && address_length > field.maxLength )
            {
                invalid_obj = field;
                break;
            }
        }
        
        if(invalid_obj) //error: length is over limit
        {
            error_msg = '{/literal}{cb_msg module='grn.address' key='GRN_ADDR-49' replace='true'}{literal}'+invalid_obj.maxLength+'{/literal}{cb_msg module='grn.address' key='GRN_ADDR-50' replace='true'}{literal}';
            alert(error_msg);
            
            return;
        }
        else            // write addresses to fields
        {
            for(i=0; i<keys.length; i++)
            {
                key = keys[i];
                field = mail_form[key];
                if( field )
                {
                    field.value = values[key];
                }
            }
        }
        opener.ApplyAddress(values);
    }
    
    window.parent.close();
}
function PrepareSubmit( form, sUID )
{
    if( typeof form.elements[sUID] == "undefined" ) return;
    var src = form.elements[sUID].options;
    var selected_users = form.elements['selected_users_' + sUID];
    selected_users.value = '';
    var udelim = '';
    for( i = 0 ; i < src.length ; i ++ )
    {
        var co = src[i];
        if( ! co.value || ! co.selected ) continue;
        if ( co.value.length > 0 )
        {
            selected_users.value += udelim + co.value;
            udelim = ':';
        }
        co.selected = false;
    }
}
//--></script>
{/literal}
</form>
</div><!--body_end-->
