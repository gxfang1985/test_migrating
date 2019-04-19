{literal}
<script language='JavaScript' type='text/javascript'><!--
    grn.base.namespace("grn.page.space.todo._todo_date");

var __todo_date = grn.page.space.todo._todo_date;

__todo_date.change_enddate = function()
{
    var form = document.forms["{/literal}{$form_name}{literal}"];
    var start_year  = form.elements["start_year"];
    var start_month = form.elements["start_month"];
    var start_day   = form.elements["start_day"];
    var end_year  = form.elements["end_year"];
    var end_month = form.elements["end_month"];
    var end_day   = form.elements["end_day"];
    var start_year_options = start_year.options;
    var end_year_options = end_year.options;
    var curr_start_year =  start_year_options[start_year.selectedIndex].value;
    var curr_end_year = end_year_options[end_year.selectedIndex].value;
    
    var sd = curr_start_year;
    sd *= 100;
    sd += start_month.selectedIndex;
    sd *= 100;
    sd += start_day.selectedIndex;
    var ed = curr_end_year;
    ed *= 100;
    ed += end_month.selectedIndex;
    ed *= 100;
    ed += end_day.selectedIndex;

    if ( sd > ed )
    {
        // GTM 1605
        end_year.innerHTML = '';
        for (var i = 0; i < start_year_options.length; i++) {
            var o = document.createElement( "OPTION" );
            o.value = start_year_options[i].value;
            o.text = start_year_options[i].text;
            end_year.options.add(o);
        };
        end_year.selectedIndex = start_year.selectedIndex;
        // end GTM 1605

        cb_ui_select_date_init_day(form, 'end_');

        if( end_month.selectedIndex != start_month.selectedIndex )
        {
            end_month.selectedIndex = start_month.selectedIndex;
            cb_ui_select_date_init_day(form, 'end_');
        }
        end_day.selectedIndex = start_day.selectedIndex;
    }
}
__todo_date.on_change_date = function()
{
    var f = document.forms["{/literal}{$form_name}{literal}"];
    f.elements["nolimit"].checked = false;
}
__todo_date.on_click_calendar = function()
{
    var f = document.forms["{/literal}{$form_name}{literal}"];
    f.elements["nolimit"].checked = false;
    __todo_date.on_nolimit( f.elements["nolimit"] );
}
__todo_date.on_nolimit = function( c )
{
    var y = c.form.elements["end_year"];
    var m = c.form.elements["end_month"];
    var d = c.form.elements["end_day"];

    if( y ) y.disabled = c.checked;
    if( m ) m.disabled = c.checked;
    if( d ) d.disabled = c.checked;
}
__todo_date.start_date_disable = function( form, flag )
{
    var y = form.elements["start_year"];
    var m = form.elements["start_month"];
    var d = form.elements["start_day"];

    if( y ) y.disabled = flag;
    if( m ) m.disabled = flag;
    if( d ) d.disabled = flag;
}
__todo_date.enter_start_date = function()
{
    var f = document.forms["{/literal}{$form_name}{literal}"];

    if ( jQuery('#start_date').css('display') == 'none' )
    {
        f.elements["nolimit"].checked = false;
        __todo_date.on_nolimit( f.elements["nolimit"] );
        jQuery('#start_date_flag').html('{/literal}<a href="javascript:void(0);" onclick="__todo_date.enter_start_date();">{cb_msg module='grn.space.todo' key='GRN_SP_TOD-14' replace='true'}</a>{literal}');
        jQuery('#start_date').css('display', 'block');
        __todo_date.start_date_disable( f, false );
        jQuery('#end_date_nolimit').css('display', 'none');
    }
    else
    {
        jQuery('#start_date_flag').html('{/literal}<a href="javascript:void(0);" onclick="__todo_date.enter_start_date();">{cb_msg module='grn.space.todo' key='GRN_SP_TOD-13' replace='true'}</a>{literal}');
        jQuery('#start_date').css('display', 'none');
        __todo_date.start_date_disable( f, true );
        jQuery('#end_date_nolimit').css('display', 'inline');
    }

}
//--></script>
{/literal}
{* Start date is not null*}
{if $start_date}
    <div id="start_date">
    {grn_select_date prefix='start_' date=$start_date form_name=$form_name onchange='__todo_date.change_enddate();'}{cb_msg module='grn.space.todo' key='GRN_SP_TOD-12' replace='true'}
    </div>
    <div id="end_date">
    {grn_select_date prefix='end_' date=$end_date form_name=$form_name onchange="__todo_date.on_change_date()" onclick_calendar="__todo_date.on_click_calendar()"}
    <span id="end_date_nolimit">
    {capture name='grn_space_GRN_SP_TOD_10'}{cb_msg module='grn.space.todo' key='GRN_SP_TOD-10' replace='true'}{/capture}{grn_checkbox name='nolimit' id='0' value='1' caption=$smarty.capture.grn_space_GRN_SP_TOD_10 onclick="__todo_date.on_nolimit(this);"}
    </span>
    </div>
    <div id="start_date_flag"><a href="javascript:void(0);" onclick="__todo_date.enter_start_date();">{cb_msg module='grn.space.todo' key='GRN_SP_TOD-14' replace='true'}</a></div>
{* Start date is null*}
{else}
    <div id="start_date">
    {grn_select_date prefix='start_' date=$start_date form_name=$form_name onchange='__todo_date.change_enddate();'}{cb_msg module='grn.space.todo' key='GRN_SP_TOD-12' replace='true'}
    </div>
{* Due date is null or "None" is checked*}

{if $form_name == "todo_add"}
    <div id="end_date">
    {grn_select_date prefix='end_' date=$end_date form_name=$form_name onchange="__todo_date.on_change_date()" onclick_calendar="__todo_date.on_click_calendar()"}
    <span id="end_date_nolimit">
    {capture name='grn_space_GRN_SP_TOD_10'}{cb_msg module='grn.space.todo' key='GRN_SP_TOD-10' replace='true'}{/capture}{grn_checkbox name='nolimit' id='0' value='1' caption=$smarty.capture.grn_space_GRN_SP_TOD_10 onclick="__todo_date.on_nolimit(this);"}
    </span>
    </div>
{elseif $nolimit || ! $end_date}
    <div id="end_date">
    {grn_select_date prefix='end_' date=$end_date form_name=$form_name onchange="__todo_date.on_change_date()" onclick_calendar="__todo_date.on_click_calendar()" disabled=true}
    <span id="end_date_nolimit">
    {capture name='grn_space_GRN_SP_TOD_10'}{cb_msg module='grn.space.todo' key='GRN_SP_TOD-10' replace='true'}{/capture}{grn_checkbox name='nolimit' id='0' value='1' checked=true caption=$smarty.capture.grn_space_GRN_SP_TOD_10 onclick="__todo_date.on_nolimit(this);"}
    </span>
    </div>
{else}
    <div id="end_date">
    {grn_select_date prefix='end_' date=$end_date form_name=$form_name onchange="__todo_date.on_change_date()" onclick_calendar="__todo_date.on_click_calendar()"}
    <span id="end_date_nolimit">
    {capture name='grn_space_GRN_SP_TOD_10'}{cb_msg module='grn.space.todo' key='GRN_SP_TOD-10' replace='true'}{/capture}{grn_checkbox name='nolimit' id='0' value='1' caption=$smarty.capture.grn_space_GRN_SP_TOD_10 onclick="__todo_date.on_nolimit(this);"}
    </span>
    </div>
{/if}
    <div id="start_date_flag"><a href="javascript:void(0);" onclick="__todo_date.enter_start_date();">{cb_msg module='grn.space.todo' key='GRN_SP_TOD-13' replace='true'}</a></div>
{/if}

{literal}
<script language='JavaScript' type='text/javascript'><!--
    jQuery(document).ready(function () {
        var f = document.forms["{/literal}{$form_name}{literal}"];
        {/literal}
        {if $start_date}{literal}
        f.elements["nolimit"].checked = false;
        __todo_date.on_nolimit(f.elements["nolimit"]);
        jQuery('#start_date').css('display', 'block');
        __todo_date.start_date_disable(f, false);
        jQuery('#end_date_nolimit').css('display', 'none');{/literal}
        {else}{literal}
        jQuery('#start_date').css('display', 'none');
        __todo_date.start_date_disable(f, true);
        jQuery('#end_date_nolimit').css('display', 'inline');{/literal}
        {/if}{literal}
    });

    //--></script>
{/literal}
