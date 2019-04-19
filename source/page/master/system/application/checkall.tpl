{if ! $elem_name}
 {assign var="elem_name" value="eid"}
{/if}
{if ! $form_name}
 {assign var="form_name" value=$page_info.last}
{/if}
{if ! $func_name}
 {assign var="func_name" value='CheckAll'}
{/if}
<script language="JavaScript" type="text/javascript">
<!--
function {$func_name}()
{literal}
{
    var e = document.forms["{/literal}{$form_name}{literal}"].elements;
    var l = e.length;
    var checked = false;
    for( i = 0 ; i < l ; i ++ ) { if( e[i].name == {/literal}"{$elem_name}"{literal} && ! e[i].checked  ) { checked = true; } }
    for( i = 0 ; i < l ; i ++ ) { if( e[i].name == {/literal}"{$elem_name}"{literal} ) { e[i].checked=checked; } }
}
{/literal}
//-->
</script>
{capture name='grn_system_GRN_SY_AP_96'}{cb_msg module='grn.system.application' key='GRN_SY_AP-96' replace='true'}{/capture}
<button class="check_button" title="{$smarty.capture.grn_system_GRN_SY_AP_96}" aria-label="{$smarty.capture.grn_system_GRN_SY_AP_96}" onClick="javascript:{$func_name}();return false"{if $disabled} disabled{/if}>{grn_image image='check10.gif'}</button>
