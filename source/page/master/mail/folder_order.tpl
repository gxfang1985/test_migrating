{include file="grn/head.tpl"}
{include file="grn/header.tpl"}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var="form_name" value=$smarty.template|basename}
<div class="mainarea-mail">
<form name="{$form_name}" method="post" action="{grn_pageurl page='mail/command_'|cat:$page_info.last}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
<div id="one_parts">
 <div id="action">
  <!----->
   <p>
    <div class="explanation">{cb_msg module='grn.mail' key='GRN_MAIL-230' replace='true'}</div>
    <div class="sub_explanation">{cb_msg module='grn.mail' key='GRN_MAIL-231' replace='true'} [{cb_msg module='grn.mail' key='GRN_MAIL-232' replace='true'}]{cb_msg module='grn.mail' key='GRN_MAIL-233' replace='true'}[{cb_msg module='grn.mail' key='GRN_MAIL-234' replace='true'}]{cb_msg module='grn.mail' key='GRN_MAIL-235' replace='true'}[{cb_msg module='grn.mail' key='GRN_MAIL-236' replace='true'}]{cb_msg module='grn.mail' key='GRN_MAIL-237' replace='true'}[{cb_msg module='grn.mail' key='GRN_MAIL-238' replace='true'}]{cb_msg module='grn.mail' key='GRN_MAIL-239' replace='true'}</div>
   </p>
   {grn_change_order form_name=$form_name select_name='order[]' options=$categorys}
  <!----->
 </div>
</div>
{strip}
    <div class="mTop10 mBottom15">
        {capture name='grn_mail_GRN_MAIL_240'}{cb_msg module='grn.mail' key='GRN_MAIL-240' replace='true'}{/capture}
        {capture assign="onmailfoldersave"}
            grn_onsubmit_common(document.forms['{$form_name}']);
            grn.component.button.util.submit(this);
        {/capture}
        {grn_button caption=$smarty.capture.grn_mail_GRN_MAIL_240 ui="main" spacing="normal" auto_disable=true id="mail_button_save" onclick=$onmailfoldersave}
        {grn_button page="mail/index" page_param_aid=$category.aid page_param_cid=$category.cid action="cancel"}
    </div>
{/strip}

<input type="hidden" name="aid" value="{$category.aid}">
<input type="hidden" name="cid" value="{$category.cid}">
<input type="hidden" name="pid" value="{$category.parent_id}">
</form>
</div>
{include file="grn/footer.tpl"}
