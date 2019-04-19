{include file='grn/system_head.tpl'}
{include file='grn/system_header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='workflow/system/command_'|cat:$page_info.last}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
<input type="hidden" name="cid" value="{$cid|escape}">
<input type="hidden" name="fid" value="{$fid|escape}">
<script language="JavaScript">
{literal}<!--
function SelectItem(form, select_id, change_id)
{
    var element = form.elements[select_id];
    var options = element.options; 
    for(i = 0; i < options.length; i++)
    {
        if(options[i].selected)
        {
            if(options[i].value)
            {
                var sub_options = form.elements[change_id].options;
                for(i = sub_options.length - 1; i >= 0; i--)
                {
                    
                    form.elements[change_id].options[0] = null;
                }
                var selected_element = form.elements[select_id].value;

                switch(selected_element)
                {{/literal}
{foreach from=$item_type_options key=foreign_key item=caption}
{literal}               case '{/literal}{$foreign_key|escape:"javascript"}{literal}':{/literal}
{assign var='item_option' value=$item_options.$foreign_key}
{foreach from=$item_option key=item_id item=caption}
{literal}                   AddItem(sub_options, '{/literal}{$item_id|escape:"javascript"}{literal}', '{/literal}{$caption|escape:"javascript"}{literal}');{/literal}
{/foreach}
{literal}                   break;{/literal}
{/foreach}
{literal}               default:
                    break;
                }
                form.elements[change_id].style.display = '';
                break;
            }
        }
    }
}
function AddItem(options, key, value)
{
    options[options.length] = new Option(value, key);
}
{/literal}
//-->
</script>
<div class="explanation mTop10 mBottom15">{cb_msg module='grn.workflow.system' key='w_select_route_to_split_y' replace='true'}
  <div class="mTop3">
    <span class="icon_information_sub_grn">{cb_msg module='grn.workflow' key='route_branching_settings_tip' replace='true'}</span>
  </div>
</div>
<table class="std_form">
 <tr>
  <th nowrap>{capture name='grn_workflow_system_w_item_type'}{cb_msg module='grn.workflow.system' key='w_item_type' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_workflow_system_w_item_type}</th>
  <td>
   <select name="col_item_type"  onChange="SelectItem(this.form, 'col_item_type', 'col_item')">
    {html_options options=$item_type_options selected=$path_skip.col_foreign_key}
   </select>
  </td>
 </tr>
 <tr>
  <th nowrap>{capture name='grn_workflow_system_w_split_item_y'}{cb_msg module='grn.workflow.system' key='w_split_item_y' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_workflow_system_w_split_item_y}</th>
  <td>
   <select name="col_item">
    {assign var='col_foreign_key' value=$path_skip.col_foreign_key}{html_options options=$item_options.$col_foreign_key selected=$path_skip.col_item}
   </select>
  </td>
 </tr>
 <tr>
  <td></td>
  <td>
   {capture name='grn_workflow_system_w_do_apply_y'}{cb_msg module='grn.workflow.system' key='w_do_apply_y' replace='true'}{/capture}{grn_button_submit class='margin' caption=$smarty.capture.grn_workflow_system_w_do_apply_y}
   {grn_button_cancel page='workflow/system/form_view' cid=$cid fid=$fid}
  </td>
 </tr>
</table>

</form>
{include file='grn/system_footer.tpl'}
