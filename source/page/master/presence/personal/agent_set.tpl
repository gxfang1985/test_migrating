{include file='grn/personal_head.tpl'}
{include file='grn/personal_header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}

<form name="{$form_name}" method="post" action="{grn_pageurl page='presence/personal/command_'|cat:$page_info.last}">
<input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">

<!--explanation-->
<div class="explanation">
{cb_msg module='grn.presence.personal' key='GRN_PRSC_PE-3' replace='true'}
</div>
<p></p>
<!--explanation-->
<!--Search user box-->
{grn_user_add form_name=$form_name sUID='sUID[]' CGID='CGID' CID='CID[]' selected_users=$selected_users include_org=true order_by=false org_direct=TRUE popup_include_org=true}
{capture name='grn_presence_personal_GRN_PRSC_PE_2'}{cb_msg module='grn.presence.personal' key='GRN_PRSC_PE-2' replace='true'}{/capture}{grn_button_submit class='margin' caption=$smarty.capture.grn_presence_personal_GRN_PRSC_PE_2 onclick='grn_onsubmit_common(this.form);'}
{grn_button_cancel}
<!--Search user box-->
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
//-->
</script>
{/literal}

{include file='grn/personal_footer.tpl'}
