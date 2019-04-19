{include file="grn/personal_head.tpl"}
{include file="grn/personal_header.tpl"}
{grn_title title=$page_title class=$page_info.parts[0] id="personal_mail_filter_setting"}
{if $no_setting neq '0'}
 {include file='mail/_no_setting.tpl'}
{else}

<span class="menu_item">
   <form name="account" method="post" action="{grn_pageurl page='mail/personal/command_filter_account'}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
      {cb_msg module='grn.mail.personal' key='GRN_MAIL_PE-119' replace='true'}{grn_image image='mailaccount20.gif'}&nbsp;{grn_select name='user_account' options=$user_account onchange="this.form.submit()"}
   </form>
    {if $set.stop}
    <span class="attention">{cb_msg module='grn.mail.personal' key='GRN_MAIL_PE-20' replace='true'}</span>
    {/if}
</span>

<div id="main_menu_part">
<span class="menu_item">{capture name='grn_mail_personal_GRN_MAIL_PE_115'}{cb_msg module='grn.mail.personal' key='GRN_MAIL_PE-115' replace='true'}{/capture}{grn_link image='write20.gif' caption=$smarty.capture.grn_mail_personal_GRN_MAIL_PE_115 page='mail/personal/filter_add' aid=$set.aid element_id="mail_personal_filter_add"}</span>
<span class="menu_item">{capture name='grn_mail_personal_GRN_MAIL_PE_116'}{cb_msg module='grn.mail.personal' key='GRN_MAIL_PE-116' replace='true'}{/capture}{grn_link image='order20.gif' caption=$smarty.capture.grn_mail_personal_GRN_MAIL_PE_116 page='mail/personal/filter_order' aid=$set.aid disabled=$disabled_change_order element_id="mail_personal_order"}</span>
</div>

   <div class="explanation">{cb_msg module='grn.mail.personal' key='GRN_MAIL_PE-117' replace='true'}</div>
   <table class="admin_list_table" width="100%">
    <colgroup>
     <col width="1%">
     <col width="49%">
     <col width="15%">
     <col width="30%">
    </colgroup>
    <tr>
     <th>No.</th>
     <th>{cb_msg module='grn.mail.personal' key='GRN_MAIL_PE-120' replace='true'}</th>
     <th>{cb_msg module='grn.mail.personal' key='GRN_MAIL_PE-121' replace='true'}</th>
     <th>{cb_msg module='grn.mail.personal' key='GRN_MAIL_PE-122' replace='true'}</th>
    </tr>
 {foreach name=filters from=$filters item=filter}
    <tr valign="top">
  {if $filter.available eq "1"}
     <td>{$smarty.foreach.filters.iteration}</td>
     <td>
      {grn_link image='mailfilter20.gif' caption=$filter.title page='mail/personal/filter_view' aid=$set.aid mfid=$filter.mfid}
     </td>
     <td><div style="color: {$filter.status.color};">{$filter.status.name}</div></td>
     <td>{grn_mail_show_folder_position folder_id=$filter.cid show_icon=1}</td>
  {else}
     <td class="gray">{$smarty.foreach.filters.iteration}<span class="required">{cb_msg module='grn.mail.personal' key='GRN_MAIL_PE-123' replace='true'}</span></td>
     <td class="gray">
      {grn_link image='mailfilter20.gif' caption=$filter.title page='mail/personal/filter_view' aid=$set.aid mfid=$filter.mfid}
     </td>
     <td class="gray"><div style="color: {$filter.status.color};">{$filter.status.name}</div></td>
     <td class="gray">&nbsp;</td>
  {/if}
    </tr>
 {/foreach}
   </table>

   <p class="small_notes">{cb_msg module='grn.mail.personal' key='GRN_MAIL_PE-124' replace='true'}</p>
{/if}

{include file="grn/personal_footer.tpl"}
