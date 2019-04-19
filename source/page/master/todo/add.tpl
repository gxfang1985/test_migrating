{include file="grn/head.tpl"}
{include file="grn/header.tpl"}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var="form_name" value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='todo/command_add'}">
    <input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
    <input type='hidden' name='cid' value="{$category_id}">
    {literal}
    <script language='JavaScript' type='text/javascript'><!--
    function on_change_date()
    {
        var f = document.forms["{/literal}{$form_name}{literal}"];
        f.elements["nolimit"].checked = false;
    }
    function on_click_calendar()
    {
        var f = document.forms["{/literal}{$form_name}{literal}"];
        f.elements["nolimit"].checked = false;
        on_nolimit( f.elements["nolimit"] );
    }
    function on_nolimit( c )
    {
        var y = c.form.elements["ldate_year"];
        var m = c.form.elements["ldate_month"];
        var d = c.form.elements["ldate_day"];
    
        if( y ) y.disabled = c.checked;
        if( m ) m.disabled = c.checked;
        if( d ) d.disabled = c.checked;
    }
    //--></script>
    {/literal}

    <p>
    {include file="grn/show_validation_errors.tpl"}
    {include file='grn/indispensable.tpl'}
    <table class="std_form">
        <tr>
            <th>{cb_msg module='grn.todo' key='GRN_TOD-4' replace='true'}</th>
            <td>
                <select name="category">
                <option value="">------------</option>
                {foreach from=$categories.category item=element}
                    <option value="{$element.cid}"{if $element.cid == $category.cid} selected{/if}>{$element.title|escape}</option>
                {/foreach}
                </select>
            </td>
        </tr>
        <tr>
            <th>{capture name='grn_todo_GRN_TOD_5'}{cb_msg module='grn.todo' key='GRN_TOD-5' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_todo_GRN_TOD_5 necessary=TRUE}</th>
            <td>{capture name='grn_todo_GRN_TOD_6'}{cb_msg module='grn.todo' key='GRN_TOD-6' replace='true'}{/capture}{validate form=$form_name field="title" criteria="notEmpty" message=$smarty.capture.grn_todo_GRN_TOD_6 transform="cb_trim" append="validation_errors"}{grn_text name='title' value=$title size='50' disable_return_key=true}</td>
        </tr>
        <tr>
            <th>{cb_msg module='grn.todo' key='GRN_TOD-7' replace='true'}</th>
            <td>
                {* 日付選択/チェックボックス連携用JavaScript未実装 *}
                {if $nolimit || ! $ldate}
                    {grn_select_date prefix='ldate_' date=$ldate form_name=$form_name onchange="on_change_date()" onclick_calendar="on_click_calendar()" disabled=true}
                    {capture name='grn_todo_GRN_TOD_8'}{cb_msg module='grn.todo' key='GRN_TOD-8' replace='true'}{/capture}{grn_checkbox name='nolimit' id='0' value='1' checked=true caption=$smarty.capture.grn_todo_GRN_TOD_8 onclick="on_nolimit(this);"}
                {else}
                    {grn_select_date prefix='ldate_' date=$ldate form_name=$form_name onchange="on_change_date()" onclick_calendar="on_click_calendar()"}
                    {capture name='grn_todo_GRN_TOD_9'}{cb_msg module='grn.todo' key='GRN_TOD-9' replace='true'}{/capture}{grn_checkbox name='nolimit' id='0' value='1' caption=$smarty.capture.grn_todo_GRN_TOD_9 onclick="on_nolimit(this);"}
                {/if}
            </td>
        </tr>
        <tr>
            <th>{cb_msg module='grn.todo' key='GRN_TOD-10' replace='true'}</th>
            <td>
                {* 重要度選択 *}
                {include file="todo/_rank_star_select.tpl" id="todo_add_rank_star_select" name='priority' priority=$priority}
            </td>
        </tr>
        <tr valign="top">
            <th>{cb_msg module='grn.todo' key='GRN_TOD-23' replace='true'}</th>
            <td>{grn_textarea name='memo' value=$memo rows='5'}</td>
        </tr>
        <tr>
            <td></td>
            <td>
                {strip}
                    <div class="mTop10">
                        {capture name="grn_todo_GRN_TOD_24"}{cb_msg module='grn.todo' key='GRN_TOD-24' replace='true'}{/capture}
                        {grn_button id="todo_button_add" html_name="todo-add-submit" ui="main" spacing="normal" auto_disable=true caption=$smarty.capture.grn_todo_GRN_TOD_24 onclick="grn.component.button.util.submit(this);"}
                        {grn_button id="todo_button_cancel" action="cancel" page='todo/index' page_param_cid=$category_id}
                    </div>
                {/strip}
            </td>
        </tr>
    </table>
</form>

{include file="grn/footer.tpl"}
