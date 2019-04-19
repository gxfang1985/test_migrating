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
<button class="check_button" onClick="javascript:{$func_name}();return false"{if $disabled} disabled{/if}>{capture name='grn_workflow_check_to_select_all'}{cb_msg module='grn.workflow' key='check_to_select_all' replace='true'}{/capture}{grn_image image='check10.gif' alt=$smarty.capture.grn_workflow_check_to_select_all}</button>
