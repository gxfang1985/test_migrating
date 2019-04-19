{include file='grn/personal_head.tpl'}
{include file='grn/personal_header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}

<div class="explanation">{cb_msg module='grn.personal.ui' key="GRN_PRS_UI-161" replace='true'}</div>

<div class="margin_top tab_menu">

{foreach from=$tabs key=key item=item}
{grn_tab page_param=$item.page_param page=$item.page caption=$item.caption selected=$item.selected id=$item.tab_id}
{if ! $item.selected}
{capture name='grn_personal_ui_GRN_PRS_UI_176'}{cb_msg module='grn.personal.ui' key='GRN_PRS_UI-176' replace='true'}{/capture}{grn_delete title=$smarty.capture.grn_personal_ui_GRN_PRS_UI_176 page="personal/ui/_dropdown-confirm.tpl" handler=$item.tab_id data=$item.page_param form_target='dummy_form' multi_target='dummy_item'}
{/if}
{/foreach}
</div>

<div class="tab_menu_end"><div class="tab_menu_end_bg">&nbsp;</div></div>


{foreach from=$tabs key=key item=item}
{if $item.selected}
{include file=$item.file}
{/if}
{/foreach}

<form name="dummy_form">
  <input type="checkbox" id="dummy_item_id" name="dummy_item" style="display:none;" {if $confirm_on}checked{/if}>
</form>


{literal}
<script type="text/javascript" language="JavaScript">
    function confirm_on() {
        jQuery("#dummy_item_id").prop("checked", true);
    }

    function confirm_off() {
        jQuery("#dummy_item_id").prop("checked", false);
    }
</script>
{/literal}

{include file='grn/personal_footer.tpl'}
