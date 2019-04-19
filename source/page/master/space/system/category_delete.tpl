{include file="grn/system_head.tpl"}
{include file="grn/system_header.tpl"}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var="form_name" value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='space/system/command_category_delete'}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
  <input type="hidden" name="cid" value="{$cid}">
  <p>
    {cb_msg module='grn.space.system' key='GRN_SPACE_SY-23' replace='true'}<br>
    {cb_msg module='grn.space.system' key='GRN_SPACE_SY-24' replace='true'}{grn_sentence caption=$category_name image='category20.gif' class='bold'}
  </p>
  <p>
    {capture name='grn_space_GRN_SPACE_SY_25'}{cb_msg module='grn.space.system' key='GRN_SPACE_SY-25' replace='true'}{/capture}
    {grn_button_submit class='margin' caption=$smarty.capture.grn_space_GRN_SPACE_SY_25}
    {capture name='grn_space_system_GRN_SPACE_SY_26'}{cb_msg module='grn.space.system' key='GRN_SPACE_SY-26' replace='true'}{/capture}
    {grn_button_cancel class='margin' caption=$smarty.capture.grn_space_system_GRN_SPACE_SY_26}
  </p>
</form>
{include file="grn/system_footer.tpl"}