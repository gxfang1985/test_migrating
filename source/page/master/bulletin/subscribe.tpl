{include file="grn/head.tpl"}
{include file="grn/header.tpl"}

{assign var="form_name" value=$smarty.template|basename}

<h2 class="bulletin inline_block_grn">{$page_title}</h2>

<div class="explanation mBottom5">
{cb_msg module='grn.bulletin' key='GRN_BLLT-654' replace='true'}
</div>

{if $selected_tab eq '1'}
    <div class="tab_memu">
        <div class="tab">
            <span class="tab_left_off"></span>
            <span class="tab_off">
                <a href="{grn_pageurl page='bulletin/'|cat:$page_info.last cid=$category_id selected_tab=0}">
                    {cb_msg module='grn.bulletin' key='GRN_BLLT-655' replace='true'}
                </a>
            </span>
            <span class="tab_right_off"></span>
        </div>
        <div class="tab">
            <span class="tab_left_on"></span>
            <span class="tab_on">
                {cb_msg module='grn.bulletin' key='GRN_BLLT-656' replace='true'}
            </span>
            <span class="tab_right_on"></span>
        </div>
    </div>
    <div class="tab_menu_end"></div>

    {include file='bulletin/_subscribe_list.tpl' no_result_message=$button_disabled}

{else}
    <div class="tab_memu">
        <div class="tab">
            <span class="tab_left_on"></span>
            <span class="tab_on">
                <span>{cb_msg module='grn.bulletin' key='GRN_BLLT-655' replace='true'}</span>
            </span>
            <span class="tab_right_on"></span>
        </div>
        <div class="tab">
            <span class="tab_left_off"></span>
            <span class="tab_off">
                <a href="{grn_pageurl page='bulletin/'|cat:$page_info.last cid=$category_id selected_tab=1}">
                    {cb_msg module='grn.bulletin' key='GRN_BLLT-656' replace='true'}
                </a>
            </span>
            <span class="tab_right_off"></span>
        </div>
    </div>
    <div class="tab_menu_end"></div>

    {include file='bulletin/_subscribe_tree.tpl'}

{/if}

<form name="{$form_name}" method="post" action="{grn_pageurl page='bulletin/command_'|cat:$page_info.last}">
    <input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
    <input type="hidden" name="session_key" value="{$session_key}">
    <input type="hidden" name="cid" value="{$category_id}">
    {strip}
        <div class="mBottom15">
            {capture name='grn_bulletin_GRN_BLLT_657'}{cb_msg module='grn.bulletin' key='GRN_BLLT-657' replace='true'}{/capture}
            {if $selected_tab eq '1'}
                {grn_button action="submit" ui="main" spacing="normal" caption=$smarty.capture.grn_bulletin_GRN_BLLT_657 onclick=$button_submit_onclick disabled=$button_disabled}
            {else}
                {grn_button action="submit" ui="main" spacing="normal" caption=$smarty.capture.grn_bulletin_GRN_BLLT_657 onclick=$button_submit_onclick disabled=$button_disabled}
            {/if}
            {grn_button action="cancel" page="bulletin/index" page_param_cid=$category_id id="bulletin_set_subscribe_cancel" disabled=$button_disabled}
        </div>
    {/strip}
</form>

{include file="grn/footer.tpl"}
