{include file='grn/system_head.tpl'}
{include file='grn/system_header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='system/sso/sso_method_delete_multi'}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">

<div class="explanation">{cb_msg module='grn.system.sso' key='GRN_SY_SS-1' replace='true'}</div>
<p>
<div id="main_menu_part">
<span class="menu_item">{capture name='grn_system_sso_GRN_SY_SS_2'}{cb_msg module='grn.system.sso' key='GRN_SY_SS-2' replace='true'}{/capture}{grn_link page='system/sso/sso_method_add1' caption=$smarty.capture.grn_system_sso_GRN_SY_SS_2 image='write20.gif'}</span>
<span class="menu_item">{if 0 == $view_set.count}{assign var='is_access_delete_all' value='true'}{/if}{capture name='grn_system_sso_GRN_SY_SS_3'}{cb_msg module='grn.system.sso' key='GRN_SY_SS-3' replace='true'}{/capture}{grn_link page='system/sso/sso_method_delete_all' caption=$smarty.capture.grn_system_sso_GRN_SY_SS_3 image='delete20.gif' disabled=$is_access_delete_all}</span>
</div>

   <p>
   <div class="sub_title">{cb_msg module='grn.system.sso' key='GRN_SY_SS-4' replace='true'} {include file="grn/smart_data_count.tpl" start_num=$view_set.start_count end_num=$view_set.end_count all_num=$view_set.count}</div>
   <table class="list_column" width="100%" border="1" cellspacing="0" cellpadding="2">
    <colgroup>
     <col width="1%">
     <col width="99%">
    </colgroup>
    <tr>
     <th nowrap>{include file="grn/checkall.tpl" elem_name="eid[]"}</th>
     <th nowrap>{cb_msg module='grn.system.sso' key='GRN_SY_SS-7' replace='true'}</th>
    </tr>
{foreach from=$sso_method item=sso_method}
    <tr valign="top">
     <td><input type="checkbox" name="eid[]" value="{$sso_method.smid}"></td>
     <td>{grn_link page='system/sso/sso_method_view' caption=$sso_method.display_name image='detail20.gif' smid=$sso_method.smid}</td>
    </tr>
{/foreach}
   </table>
     <div class="contents_navi">
      {include file="grn/word_navi.tpl" navi=$view_set.navi }
     </div>
       {cb_msg module='grn.system.sso' key='GRN_SY_SS-8' replace='true'}{capture name='grn_system_sso_GRN_SY_SS_9'}{cb_msg module='grn.system.sso' key='GRN_SY_SS-9' replace='true'}{/capture}{grn_button_submit caption=$smarty.capture.grn_system_sso_GRN_SY_SS_9 onclick="if(!grn_is_checked(this.form,'eid[]')) return false;"}

</form>

{include file='grn/system_footer.tpl'}
