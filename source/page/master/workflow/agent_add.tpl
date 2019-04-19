{grn_load_javascript file="grn/html/user_add.js"}
{grn_load_javascript file="grn/html/workflow_user_add.js"}
{grn_load_javascript file="grn/html/component/user_select/user_select.js"}
{include file="grn/rewrite_category_options_wording.tpl"}
{literal}
<script language="JavaScript" type="text/javascript">
function AddMember(fname, cname, sname)
{
    var form = document.forms[fname];
    var c = form.elements[cname].options;
    if(CheckOptions(fname, sname, '0'))
    {
        ClearOptions(fname, sname);
    }
    if(CheckSelectedOptions(fname, cname, '0'))
    {
        ClearOptions(fname, sname);
        AddOption(fname, sname, cname, '0');
    }
    else
    {
        ClearOptions(fname, sname);
        AddOptions( fname, sname, c );
    }
}

function PrepareSubmitAll( form_name, sUID )
{
{/literal}{foreach from=$agent_type_list key=type item=agent_type}{literal}
    var agent_type_prefix = 'agent_type_' + '{/literal}{$type}{literal}'+'_';
    var agent_type_sUID = agent_type_prefix + sUID;
    PrepareSubmit(form_name, agent_type_sUID);
{/literal}{/foreach}{literal}
}
//-->
</script>
{/literal}
{literal}
<script language="JavaScript" type="text/javascript">
<!--
function Change{/literal}{$CGID}{literal}( form )
{
  var item_options = new Array();
{/literal}{foreach from=$item_options key=id item=options}{literal}
  item_options['{/literal}{$id}{literal}'] = new Array();
 {/literal}{foreach from=$options key=option_id item=option}{literal}
  item_options['{/literal}{$id}{literal}'][{/literal}{$option_id}{literal}] = new Option();
  item_options['{/literal}{$id}{literal}'][{/literal}{$option_id}{literal}].value = '{/literal}{$option->getValue()|escape:"javascript"}{literal}';
  item_options['{/literal}{$id}{literal}'][{/literal}{$option_id}{literal}].text = '{/literal}{$option->getName()|escape:"javascript"}{literal}';
  {/literal}{literal}
 {/literal}{/foreach}{literal}
{/literal}{/foreach}{literal}
  var selected_category = form.elements['{/literal}{$CGID}{literal}'].value;
  RewriteItemOptionsWithoutSelectedAttribute( form.name, '{/literal}{$CID}{literal}', item_options[selected_category]);

  ClearPopupUserSelect(form.name, '{/literal}{$CGID}{literal}');
  ClearSearch(form.name, '{/literal}{$CGID}{literal}');

  form.elements['{/literal}{$CID}{literal}'].focus();
}
function Search{/literal}{$CGID}{literal}( form, url )
{
    var parameters = {
        {/literal}
        "keyword_{$CGID}" : form.elements["keyword_{$CGID}"].value,
        "target_form_name_{$CGID}": "{$form_name}",
        "target_category_select_name_{$CGID}": "{$CGID}",
        "target_item_select_name_{$CGID}": "{$CID}",
        "search_login_name_{$CGID}": {if $system_flag == TRUE}"1"{else}"0"{/if}
        {literal}
    };
    {/literal}{if $access_plugin}
    parameters["plugin_session_name_{$CGID}"] = "{$plugin_session_name}";
    parameters["plugin_data_name_{$CGID}"] = "{$plugin_data_name}";
    {/if}{literal}

    var target = "sub_{/literal}{$CGID}{literal}";
    searchByKeyword(target, url, parameters);
}
//-->
</script>
{/literal}

<table cellspacing='1' class="std_form">
 <colgroup>
  <col width="10%">
  <col width="15%">
  <col width="10%">
  <col width="65%">
 </colgroup>
{if $user != FALSE}
 <tr>
  <th nowrap>{cb_msg module='grn.workflow' key='user_name' replace='true'}</th>
  <td>{grn_user_name uid=$user._id}</td>
  <td>&nbsp;</td>
  <td>&nbsp;</td>
 </tr>
{/if} 
{assign var="agent_type_counter" value="0"}
{counter assign="agent_type_counter" start=0 skip=1 print=false}
{foreach from=$agent_type_list key=type item=agent_type}
 <tr>
  <th align="center" nowrap>
   {cb_msg module='grn.workflow' key="col_agent_type_`$agent_type.col_agent_type`"}
  </th>
  <td nowrap>
   <select name="agent_type_{$type}_{$sUID}" size="2" multiple{if $agent_type.col_deny_change_path}
{assign var='user_selection' value=''}{assign var='disable_action' value=' disabled'}{else}{assign var='user_selection' value=' selected'}{assign var='disable_action' value=''}{/if}>
  {foreach from=$agent_type.users item=user}
    <option value="{$user._id}"{$user_selection}>{grn_user_name uid=$user._id}</option>
  {/foreach}
    <option value="">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</option>
   </select>
   <input type="hidden" name="all_agent_type_{$type}_{$sUID}" value="">
  </td>
  <td align="center" style="padding-left:0.5em; padding-right:0.5em">
   <input type="button" value="{cb_msg module='grn.workflow' key='add_left_arrow' replace='true'}"{if ! $preview}onClick="AddMember('{$form_name}', '{$CID}', 'agent_type_{$type}_{$sUID}');"{/if}{$disable_action}><br><br><input type="button" value="{cb_msg module='grn.workflow' key='delete_right_arrow' replace='true'}"{if ! $preview} onClick="RemoveMember('{$form_name}', 'agent_type_{$type}_{$sUID}' )"{/if}{$disable_action}>
  </td>
  {if $agent_type_counter == 0 }
  <td rowspan="{math equation='x' x=$agent_type_count}" nowrap>
<!-- {cb_msg module='grn.workflow' key='select_user' replace='true'} -->
   <div>
   <input type="text" name="keyword_{$CGID}" size=22 maxlength="45" value="" onKeyPress="if(event.keyCode == 13) Search{$CGID}( this.form, '{grn_pageurl page='grn/user_add_search_users'}' ); return event.keyCode != 13;">
   <input type="button" value="{cb_msg module='grn.workflow' key='search_user' replace='true'}"{if ! $preview} onClick="Search{$CGID}( this.form, '{grn_pageurl page='grn/user_add_search_users'}' );"{/if}>
   </div>
   <div class="margin_top">
{if $preview}
{capture name='grn_workflow_select_from_all_group'}{cb_msg module='grn.workflow' key='select_from_all_group' replace='true'}{/capture}{grn_link page=$page_info.all params=$params fragment='' caption=$smarty.capture.grn_workflow_select_from_all_group image='blank20.gif' }
{else}
{if $access_plugin}
 {capture name='grn_workflow_select_from_all_group'}{cb_msg module='grn.workflow' key='select_from_all_group' replace='true'}{/capture}{grn_popup_user_select_link caption=$smarty.capture.grn_workflow_select_from_all_group form_name=$form_name select_name=$CID system=$system_flag system_display=$system_flag include_org=$include_org access_plugin=$access_plugin plugin_session_name=$plugin_session_name plugin_data_name=$plugin_data_name}
{else}
 {capture name='grn_workflow_select_from_all_group'}{cb_msg module='grn.workflow' key='select_from_all_group' replace='true'}{/capture}{grn_popup_user_select_link caption=$smarty.capture.grn_workflow_select_from_all_group form_name=$form_name select_name=$CID system=$system_flag system_display=$system_flag include_org=$include_org}
{/if}
{/if}
   </div>

<!-- category select -->
   <div class="marginBoth">
   <select id="{$CGID}" name="{$CGID}" onChange="Change{$CGID}( this.form );" {if $category_option_disabled}disabled{/if}>
   {if $category_option_disabled} <option>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</option> {/if}
{foreach from=$category_options item=option}
 {if $option.type == 1}
    <option value="{$option.value}">{$option.name|escape}{cb_msg module='grn.workflow' key='key_1_1' replace='true'}</option>
 {elseif $option.type == 2}
    <option value="{$option.value}" selected>{$option.name|escape}{cb_msg module='grn.workflow' key='priority_group_bracket' replace='true'}</option>
 {elseif $option.type == 3}
    <option value="{$option.value}">{$option.name|escape}{cb_msg module='grn.workflow' key='member_group_bracket' replace='true'}</option>
 {elseif $option.type == 4}
    <option value="{$option.value}">{cb_msg module="grn.common" key="title_frequent_group" name=$option.name}</option>
 {elseif $option.type == 5}
    <option value="{$option.value}">{cb_msg module='grn.workflow' key='opened_parenthesis' replace='true'}{cb_msg module="grn.common" key="title_frequent_users"}{cb_msg module='grn.workflow' key='closed_parenthesis' replace='true'}</option>
 {elseif $option.type == 6}
<option value="{$option.value}">{cb_msg module="grn.common" key="title_oftenused_group" name=$option.name}</option>
 {/if}
{/foreach}
   </select>
   <iframe id="sub_{$CGID}" name="sub_{$CGID}" frameborder="no" scrolling="no" style="position:absolute; width:0em; height:0em;" src="{$app_path}/grn/image/cybozu/spacer1.gif?{$build_date}">
   </iframe>
   </div>
<!-- category select -->

<!-- item select -->
   <div class="margin_both">
   <select name="{$CID}" size=8 class="select_multiple_display_grn" style="min-width:500px;">
{foreach from=$selected_item_options item=option}
    <option value="{$option->getValue()|escape}">{$option->getName()|escape}</option>
{/foreach}
    <option value="">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</option>
   </select>
   </div>
<!-- item select -->

<!-- userinfo list -->
{if $preview}
 <input type="button" value="{cb_msg module='grn.workflow' key='user_information_detail' replace='true'}">
{else}
 {capture name='grn_workflow_user_information_detail'}{cb_msg module='grn.workflow' key='user_information_detail' replace='true'}{/capture}{grn_popup_user_list_link caption=$smarty.capture.grn_workflow_user_information_detail caption_noescape=true form_name=$form_name var_CID=$CID system_display=false duplication=$duplication}
{/if}
<!-- userinfo list -->
  </td>
 
  {/if}
 </tr>
 {assign var="next_flag" value="1"}
 {counter print=false}
{/foreach}
 <tr>
  <td>&nbsp;</td>
  <td nowrap colspan="3">
     <input class="margin" type="submit" name="modify" value="{cb_msg module='grn.workflow' key='change' replace='true'}" onclick="PrepareSubmitAll(this.form.name, 'sUID[]');">
     {capture name='grn_workflow_do_cancel'}{cb_msg module='grn.workflow' key='do_cancel' replace='true'}{/capture}{grn_button_cancel caption=$smarty.capture.grn_workflow_do_cancel page=$cancel_page oid=$oid sf=$sf}
  </td>
 </tr>
</table>
