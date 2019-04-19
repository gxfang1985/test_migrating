{literal}
<script language="JavaScript" type="text/javascript">
<!--
function add_menu_submit(t)
{
    f = document.forms["{/literal}{$form_name}{literal}"];
    grn.page.schedule.add.grn_onsubmit_common( f );
    f.target = '_self';
    var tab_item = f.elements['tab'];
    if (t == 'normal')
    {
        f.action = '{/literal}{grn_pageurl page='schedule/add'}{literal}';
        if( tab_item )
            tab_item.value = '{/literal}{$page_info.last|escape}{literal}';
        f.submit();
    }
    else if (t == 'banner')
    {
        f.action = '{/literal}{grn_pageurl page='schedule/banner_add'}{literal}';
        if( tab_item )
            tab_item.value = '{/literal}{$page_info.last|escape}{literal}';
        f.submit();
    }
    else if (t == 'repeat')
    {
        f.action = '{/literal}{grn_pageurl page='schedule/repeat_add'}{literal}';
        if( tab_item ){
            tab_item.value = '{/literal}{$page_info.last|escape}{literal}';
          f.submit();
        }
    }
}

function insert_values( f, flg )
{
    var form = document.forms[ "schedule/add" ]; 

    $$("form[name=\"schedule/add\"] input[type=\"text\"]").each( function(i){ f.appendChild( new Element( "input", {type:"hidden", name:i.name, value:i.value} ) ) } );

    $$("form[name=\"schedule/add\"] input[type=\"hidden\"]").each( function(i){ f.appendChild( new Element( "input", {type:"hidden", name:i.name, value:i.value} ) ) } );

    var src_private = form.elements["private"];
    if(src_private != null)
    {
        for( var i = 0; i < src_private.length; i++ )
        {
          if(src_private[i].checked)
            f.appendChild(new Element("input", {type: "hidden", name:"private", value:src_private[i].value}) );
        }
    }

    var facility_list = grn.component.member_select_list.get_instance("sITEM");
    var selected_items = '';
    if (facility_list){
        if(flg === 'repeat') {
            selected_items = facility_list.getRepeatableSelectedFacilitiesValues().join(":");
        }
        if(flg === 'adjust'){
            selected_items = facility_list.getValues().join(":");
        }
    }
    if(0 < selected_items.length)
    {
        var el = f.elements["selected_users_sITEM"];
        if( el )
        {
            el.value = selected_items;
        }
        else
        {
            f.appendChild(new Element("input", {type: "hidden", name:"selected_users_sITEM", value:selected_items}) );
        }
    }

    var src_start_hour = form.elements["start_hour"];
       f.appendChild(new Element("input", {type: "hidden", name:src_start_hour.name, value:src_start_hour.value}) );

    var src_start_minute = form.elements["start_minute"];
       f.appendChild(new Element("input", {type: "hidden", name:src_start_minute.name, value:src_start_minute.value}) );

    var src_end_hour = form.elements["end_hour"];
       f.appendChild(new Element("input", {type: "hidden", name:src_end_hour.name, value:src_end_hour.value}) );

    var src_end_minute = form.elements["end_minute"];
       f.appendChild(new Element("input", {type: "hidden", name:src_end_minute.name, value:src_end_minute.value}) );

    var src_start_year = form.elements["start_year"];
       f.appendChild(new Element("input", {type: "hidden", name:src_start_year.name, value:src_start_year.value}) );

    var src_start_month = form.elements["start_month"];
       f.appendChild(new Element("input", {type: "hidden", name:src_start_month.name, value:src_start_month.value}) );

    var src_start_day = form.elements["start_day"];
       f.appendChild(new Element("input", {type: "hidden", name:src_start_day.name, value:src_start_day.value}) );

    var src_end_year = form.elements["end_year"];
       f.appendChild(new Element("input", {type: "hidden", name:src_end_year.name, value:src_end_year.value}) );

    var src_end_month = form.elements["end_month"];
       f.appendChild(new Element("input", {type: "hidden", name:src_end_month.name, value:src_end_month.value}) );

    var src_end_day = form.elements["end_day"];
       f.appendChild(new Element("input", {type: "hidden", name:src_end_day.name, value:src_end_day.value}) );

    var src_menu = form.elements["menu"];
       f.appendChild(new Element("input", {type: "hidden", name:src_menu.name, value:src_menu.value}) );

    var src_title = form.elements["title"];
       f.appendChild(new Element("input", {type: "hidden", name:src_title.name, value:src_title.value}) );

    var src_memo = form.elements["memo"];
       f.appendChild(new Element("input", {type: "hidden", name:src_memo.name, value:src_memo.value}) );

    var tab = f.appendChild(new Element("input", {type: "hidden", name:'tab', value:'add'}) );

    var csrf_ticket = form.elements["csrf_ticket"];
       f.appendChild(new Element("input", {type: "hidden", name:'csrf_ticket', value:'csrf_ticket'}) );


}

function check_facility( f )
{
    insert_values(f, 'repeat');
    var facility_select = grn.component.facility_add.get_instance("facility_select");
    if ( ! facility_select){
        return true;
    }
    var facility_list = facility_select.facilityList.getList();
    for (var i = 0; i < facility_list.length; i++){
        var facility = jQuery(facility_list[i]);
        if( facility.attr("data-repeat") === "0" || facility.attr("approval") === "1" )
        {
            after_check_facility(f);
            return true;
        }
    }
{/literal}
{** -------------- VCBSCH0010 START ----------------- **}
{if $schedule_event.netmeeting}
{literal}
    if( typeof( netmeeting_is_selected ) === 'function' )
    {
        if( netmeeting_is_selected( facility_select.facilityList.getValues() ) )
        {
            after_check_facility(f);
            return true;
        }
    }
{/literal}
{/if}
{** -------------- VCBSCH0010 END   ----------------- **}
{literal}
    after_check_facility(f);
    return false;
}

function after_check_facility(f)
{
    var private_select = grn.component.member_add.get_instance("private_select");
    if (private_select){
        private_select.prepareSubmit();
    }
    var member_select = grn.component.member_add.get_instance("member_select");
    if (member_select) {
        member_select.prepareSubmit();
    }
    var facility_select = grn.component.facility_add.get_instance("facility_select");
    if (facility_select) {
        facility_select.prepareSubmit();
    }

    var form = document.forms['schedule/{/literal}{$page_info.last|escape}{literal}'];
    var el = form.elements['selected_users_sUID'];
    if( f.elements[el.name] )
    {
        f.elements[el.name].value = el.value;
    }
    else
    {
        f.appendChild(new Element("input", {type: "hidden", name:el.name, value:el.value}) );
    }
    el = form.elements['selected_users_p_sUID'];
    if( el )
    {
        if( f.elements[el.name] )
        {
            f.elements[el.name].value = el.value;
        }
        else
        {
            f.appendChild(new Element("input", {type: "hidden", name:el.name, value:el.value}) );
        }
    }
}
//-->
</script>
{/literal}
<input type="hidden" name="tab" value="">
<input type="hidden" name="bdate" value="{$bdate|escape}">
<input type="hidden" name="uid" value="{$user_id|escape|escape:"javascript"}">
<input type="hidden" name="gid" value="{$group_id|escape}">
<input type="hidden" name="referer_key" value="{$referer_key|escape}">

{if ! $kintone_dialog_mode}
{if $page_info.last == 'add'}
    {assign var='normal' value='on'}
    {assign var='repeat' value='off'}
    {assign var='banner' value='off'}
{elseif $page_info.last == 'repeat_add'}
    {assign var='normal' value='off'}
    {assign var='repeat' value='on'}
    {assign var='banner' value='off'}
{else}
    {assign var='normal' value='off'}
    {assign var='repeat' value='off'}
    {assign var='banner' value='on'}
{/if}
 <div class="tab">
  <span class="tab_left_{$normal}"></span>
  <span class="tab_{$normal}">
  {if $normal == 'off'}<span class="tab_text_noimage"><a href="javascript:add_menu_submit('normal')">{else}<span class="tab_text_noimage">{/if}
  {cb_msg module='grn.schedule' key='GRN_SCH-171' replace='true'}
  {if $normal == 'off'}</a></span>{else}</span>{/if}
  </span>
  <span class="tab_right_{$normal}"></span>
 </div>
 <div class="tab">
  <span class="tab_left_{$banner}"></span>
  <span class="tab_{$banner}">
  {if $banner == 'off'}<span class="tab_text_noimage"><a href="javascript:add_menu_submit('banner')">{else}<span class="tab_text_noimage">{/if}
  {cb_msg module='grn.schedule' key='GRN_SCH-172' replace='true'}
  {if $banner == 'off'}</a></span>{else}</span>{/if}
  </span>
  <span class="tab_right_{$banner}"></span>
 </div>
 <div class="tab">
  <span class="tab_left_{$repeat}"></span>
  <span id="tab-repeat-schedule" class="tab_{$repeat}">
   {if $before_delete}
     {grn_delete title=$before_delete.title page=$before_delete.page no_confirm=$before_delete.no_confirm data=$before_delete.data handler=$before_delete.handler before_delete=$before_delete.before_delete}
     <span class="tab_text_noimage">
        <a id='schedule/unrepeat_add' href="javascript:void(0)">{cb_msg module='grn.schedule' key='GRN_SCH-173' replace='true'}</a>
    </span>
   {else}
     {if $repeat == 'off'}<span class="tab_text_noimage"><a href="javascript:add_menu_submit('repeat')">{else}<span class="tab_text_noimage">{/if}
     {cb_msg module='grn.schedule' key='GRN_SCH-173' replace='true'}
     {if $repeat == 'off'}</a></span>{else}</span>{/if}
   {/if}
  </span>
  <span class="tab_right_{$repeat}"></span>
 </div>
<div class="tab_menu_end">&nbsp;</div>
<div class="clear_both_1px">&nbsp;</div>
{/if}
