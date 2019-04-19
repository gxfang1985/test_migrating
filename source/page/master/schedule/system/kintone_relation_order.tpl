{include file="grn/system_head.tpl"}
{include file="grn/system_header.tpl"}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var="form_name" value=$smarty.template|basename}

<form name="{$form_name}" method="post" action="{grn_pageurl page='schedule/system/command_kintone_relation_order'}">
  <input type="hidden" name="csrf_ticket" value="{$csrf_ticket}"/>
  <div if="one_parts">
    <div id="action">
        {grn_change_order form_name=$form_name select_name='order[]' options=$relation_items}
    </div>
  </div>
  <p>
  <input class="margin" type="submit" value="{cb_msg module='grn.schedule' key='GRN_SCH-174' replace='true'}" onclick="grn_onsubmit_common(this.form);">
  {grn_button_cancel page='schedule/system/kintone_relation'}
</form>
{include file="grn/system_footer.tpl"}