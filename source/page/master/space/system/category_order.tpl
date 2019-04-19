{include file="grn/system_head.tpl"}
{include file="grn/system_header.tpl"}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var="form_name" value=$smarty.template|basename}

<form name="{$form_name}" method="post" action="{grn_pageurl page='space/system/command_category_order'}">
    <input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
    <div id="one_parts">
        <div id="action">
            <div class="sub_title">
                {cb_msg module='grn.bulletin' key='GRN_BLLT-199' replace='true'}{cb_msg module='grn.bulletin' key='GRN_BLLT-651' replace='true'}&nbsp;{grn_sentence caption=$category.category_name image='category20.gif'}
            </div>
            {grn_change_order form_name=$form_name select_name='order[]' options=$category.child_categories}
        </div>
    </div>
    <p>
        <input class="margin" type="submit"
            value="{cb_msg module='grn.bulletin' key='GRN_BLLT-200' replace='true'}"
            onclick="grn_onsubmit_common(this.form);">{grn_button_cancel}
    </p>
    <input type="hidden" name="cid" value="{$category.cid}">
</form>
{include file="grn/system_footer.tpl"}
