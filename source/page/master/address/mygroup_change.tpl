{include file="grn/head.tpl"}
{include file="grn/header.tpl"}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}
<br>&nbsp;
{cb_msg module='grn.address' key='GRN_ADDR-170' replace='true'}{cb_msg module='grn.address' key='GRN_ADDR-171' replace='true'}<br>
{grn_sentence image="myaddressgroup20.gif" class="bold" caption=$mygroup.name}

<form name="{$form_name}" method="post" enctype="multipart/form-data" action="{grn_pageurl page='address/command_'|cat:$page_info.last}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">

{grn_user_email_add form_name=$form_name sUID="sUID[]" CGID="CGID" CID="CID[]" selected_address_users=$initialize_address_users include_org=true mygroup_id=$mygroup.id}

<input type="hidden" name="mgid" value="{$mygroup.id}">
</form>

{literal}
<script language="JavaScript" type="text/javascript">
<!--
function grn_onsubmit_common(f)
{
    PrepareSubmit(f.name, 'sUID[]');
    var elements = f.elements;
    for( var i = 0 ; i < elements.length ; i ++ )
    {
        if ( elements[i].name && elements[i].name.indexOf("[]") > 0 )
        {
            var options = elements[i].options;
            if( options )
            {
                for( var j = 0 ; j < options.length ; j ++ )
                {
                    options[j].selected = false;
                }
            }
        }
    }
}

function PrepareSubmit( form_name, sUID )
{
    var form = document.forms[form_name];
    var src = form.elements[sUID].options;
    var selected_users = form.elements['selected_sUID'];
    selected_users.value = '';
    var udelim = '';
    for( i = 0 ; i < src.length ; i ++ )
    {
        var co = src[i];
        if( ! co.value ) continue;
        selected_users.value += udelim + co.value;
        udelim = ',';
    }
}
//-->
</script>
{/literal}

{include file="grn/footer.tpl"}
