{php}
// for php5 strict
$use_vars = array('extra_param','portlet','portlet_id','pid','date','view_set','group','selected_member','extension_items');
foreach( $use_vars as $v )
    if( is_null($this->get_template_vars($v)) )
        $this->assign($v,NULL);
{/php}

<div class="margin_bottom">
{if $page_info.last == 'personal_week'}
  <table class="personalWeekUpper-grn">
{elseif $page_info.last == 'personal_day'} 
  <table class="personalDayUpper-grn">
{else}
 <table width="100%">
{/if}
 <tr>
{if $page_info.last == 'personal_week' || $page_info.last == 'personal_day'}
 <td class="v-allign-middle" nowrap="nowrap" style="width:1%">
{else}
 <td class="v-allign-middle" nowrap="nowrap">
{/if}
{strip}
{if $page_info.last == 'index' || $page_info.last == 'group_day' }

<table cellspacing="0" cellpadding="0" border="0">
 <tbody>
 <tr>
  <td nowrap="nowrap">
<script language="JavaScript" type="text/javascript">
{literal}
function setUserGroups( group_obj ) {
{/literal} {if $group}
{foreach from=$group item=group1} {literal}
    group_obj.appendItem( new GRN_GroupItem( '{/literal}{$group1.id}', '{$group1.name|escape|escape:javascript}', 'window.parent.clickUserGroup', false, '{$group1.extra_param}{literal}' ) );
{/literal}{/foreach} {/if} {literal}

}
function clickUserGroup( gid, name, extra_param ) {
    document.getElementById( 'popup_group_list_iframe' ).style.display= 'none';
    updateDropdownButtonTitle( name );
    location.href = "{/literal}{grn_pageurl page=$form_name bdate=$bdate}{literal}&date=" + document.forms["{/literal}{$form_name}{literal}"].date.value + '&gid='+gid + '&p=' + extra_param;
}

function clickFacilityGroupTree( form_name, param ){
    document.getElementById( 'popup_facility_group_tree_iframe' ).style.display= 'none';

    if ( param['fagid'] != '0' && param['fagid'] != 'f' ) {
        if( param['fagid'] == 'r' || param['extra_param'] != 0 ){
            updateDropdownButtonTitle( param['name'] );
        }
        else{
            updateDropdownButtonTitle( param['name'] + ' {/literal}{cb_msg module='grn.schedule' key='GRN_SCH-218' replace='true'}{literal}');
        }
        changeDropDownWidth{/literal}{$portlet_id}{literal}( 'wrap_dropdown_facility_current{/literal}{$portlet.plid}{literal}' );
        location.href = "{/literal}{grn_pageurl page=$form_name bdate=$bdate}{literal}&date=" + document.forms["{/literal}{$form_name}{literal}"].date.value + '&gid=f' + param['fagid']+ '&p='+param['extra_param'];
    }else {
        updateDropdownButtonTitle( param['name'] );
        changeDropDownWidth{/literal}{$portlet_id}{literal}( 'wrap_dropdown_facility_current{/literal}{$portlet.plid}{literal}' );
        location.href = "{/literal}{grn_pageurl page=$form_name bdate=$bdate}{literal}&date=" + document.forms["{/literal}{$form_name}{literal}"].date.value + '&gid=f' + '&p='+param['extra_param'];
    }
}

function updateDropdownButtonTitle( newTitle )
{
    var node = window.document.getElementById( 'dropdown_current_a' );
    node.innerHTML = unescape( newTitle );
    changeDropDownWidth( 'wrap_dropdown_facility_current' );
}

{/literal}
</script>
{* _select_group.tpl start *}
{include file="schedule/portlet/_dropdown_part.tpl"}
{* _select_group.tpl end *}

{*   {include file="schedule/_select_group.tpl" show_user_button=true} *}

  </td>
  <td nowrap="nowrap">
  {capture name='grn_schedule_GRN_SCH_219'}{cb_msg module='grn.schedule' key='GRN_SCH-219' replace='true'}{/capture}{grn_popup_user_select_link caption=$smarty.capture.grn_schedule_GRN_SCH_219 app_id=$schedule_app_id form_name=$form_name include_org=$include_org system=false system_display=false multi_apply=true access_plugin=$access_plugin module="schedule"}
  </td>
 </tr>
</tbody>
	</table>

{* GTM-2140 *}
{elseif $page_info.last == 'personal_week' || $page_info.last == 'personal_day' }

<table cellspacing="0" cellpadding="0" border="0">
 <tbody>
 <tr>
  <td nowrap="nowrap">
<script language="JavaScript" type="text/javascript">
{literal}
function setUserGroups( group_obj ) {
{/literal} {if $group}
{foreach from=$group item=group1} {literal}
    group_obj.appendItem( new GRN_GroupItem( '{/literal}{$group1.id}', '{$group1.name|escape|escape:javascript}', 'window.parent.clickUserGroup', false, '{$group1.extra_param}{literal}' ) );
{/literal}{/foreach} {/if} {literal}

}
function clickUserGroup( gid, name, extra_param ) {
    document.getElementById( 'popup_group_list_iframe' ).style.display= 'none';
    updateDropdownButtonTitle( name );
    location.href = "{/literal}{grn_pageurl page=$form_name bdate=$bdate}{literal}&date=" + document.forms["{/literal}{$form_name}{literal}"].date.value + '&gid='+gid + '&p=' + extra_param;
}

function clickFacilityGroupTree( form_name, param ){
    document.getElementById( 'popup_facility_group_tree_iframe' ).style.display= 'none';

    if ( param['fagid'] != '0' && param['fagid'] != 'f' ) {
        if( param['fagid'] == 'r' || param['extra_param'] != 0 ){
            updateDropdownButtonTitle( param['name'] );
        }
        else{
            updateDropdownButtonTitle( param['name'] + ' {/literal}{cb_msg module='grn.schedule' key='GRN_SCH-218' replace='true'}{literal}');
        }
        changeDropDownWidth{/literal}{$portlet_id}{literal}( 'wrap_dropdown_facility_current{/literal}{$portlet.plid}{literal}' );
        location.href = "{/literal}{grn_pageurl page=$form_name bdate=$bdate}{literal}&date=" + document.forms["{/literal}{$form_name}{literal}"].date.value + '&gid=f' + param['fagid']+ '&p='+param['extra_param'];
    }else {
        updateDropdownButtonTitle( param['name'] );
        changeDropDownWidth{/literal}{$portlet_id}{literal}( 'wrap_dropdown_facility_current{/literal}{$portlet.plid}{literal}' );
        location.href = "{/literal}{grn_pageurl page=$form_name bdate=$bdate}{literal}&date=" + document.forms["{/literal}{$form_name}{literal}"].date.value + '&gid=f' + '&p='+param['extra_param'];
    }
}

function updateDropdownButtonTitle( newTitle )
{
    var node = window.document.getElementById( 'dropdown_current_a' );
    node.innerHTML = unescape( newTitle );
    changeDropDownWidth( 'wrap_dropdown_facility_current' );
}

{/literal}
</script>
{* _select_group.tpl start *}
{include file="schedule/portlet/_dropdown_part.tpl"}
{* _select_group.tpl end *}

{*   {include file="schedule/_select_group.tpl" show_user_button=true} *}

  </td>
  <td nowrap="nowrap">
    {include file='grn/window_simple_dialog.tpl' dialog_version=2}
    <div class="textSub-grn mLeft10"><a href="javascript:void(0);" id="select_users_facilities">{cb_msg module='grn.schedule' key='GRN_SCH-1056' replace='true'}</a></div>
  </td>
 </tr>
</tbody>
	</table>
{* End GTM-2140 *}

{else}
 {if $group}

  <select name="gid" onChange="i=this.selectedIndex;v=this.options[i].value;if(v)this.form.submit()">
  {if $selected_group}
   <option value="{$selected_group.id}" selected>{$selected_group.name|escape}</option>
  {/if}
  {foreach from=$group key=gid item=group}
   {if (string)$group_id === (string)$gid}
   <option value="{$gid}" selected>{$group|escape}</option>
   {else}
   <option value="{$gid}">{$group|escape}</option>
   {/if}
  {/foreach}

 {/if}
 {if $member}
  <select name="uid" onChange="this.form.submit()">
  {if $selected_member}
   <option value="{$selected_member.id}" selected>{$selected_member.name}</option>
  {/if}
  {foreach from=$member key=uid item=member}
   {if (string)$user_id === (string)$uid}
   <option value="{$uid}" selected>{$member|grn_noescape}</option>
   {else}
   <option value="{$uid}">{$member|grn_noescape}</option>
   {/if}
  {/foreach}
 {/if}
  </select>{if $page_info.last == 'personal_day' || $page_info.last == 'personal_week'}
  {capture name='grn_schedule_GRN_SCH_220'}{cb_msg module='grn.schedule' key='GRN_SCH-220' replace='true'}{/capture}{grn_popup_user_select_link_schedule caption=$smarty.capture.grn_schedule_GRN_SCH_220 send_cgi_parameter=true include_org=$include_org system=false system_display=false access_plugin=$access_plugin extension_items=$extension_items}
 {else}
  {assign var="window_url" value='schedule/popup_group'}
  {assign var="no_multiple" value='0'}
  {assign var="onChange" value='0'}
  <a href="javascript:popupWin('{grn_pageurl page='schedule/popup_group' bdate=$bdate return_url=$page_info.all}','html','','',0,0,1,1,0,1);">{grn_image image='blank20.gif'}{cb_msg module='grn.schedule' key='GRN_SCH-221' replace='true'}</a>
 {/if}

 {if $event_id}
<input type="hidden" name="event" value="{$event_id|escape}">
<input type="hidden" name="event_date" value="{$event_date|escape}">
 {/if}

{/if}
{/strip}
 </td>
 <td class="v-allign-middle" align="center">
  <span class="displaydate">{grn_date_format date=$bdate format="DateFull_YMDW"}</span>
{if $navi_cal_area_none_flag==''}
  <span class="viewSubCalendar-grn">
    <span id="showIcon-grn" class="{if $navi_cal_display_flag}showIconOn-grn{else}showIconOff-grn{/if}" title="{if $navi_cal_display_flag}{cb_msg module='grn.schedule' key='GRN_SCH-916' replace='true'}{else}{cb_msg module='grn.schedule' key='GRN_SCH-915' replace='true'}{/if}">
        <span class="subCalendar-grn" {if $page_info.last == 'personal_week' || $page_info.last == 'personal_day'}id="subCalendar-grn-image"{/if}></span>
        {if $page_info.last == 'personal_week' || $page_info.last == 'personal_day'}
        <img src="{$app_path}/grn/image/cybozu/spinner.gif?{$build_date}" id="wait_image" class="showicon_spinner_grn" name="wait_image" style="display:none">
        {/if}
    </span>
  </span>
{/if}
 </td>
{if $page_info.last == 'personal_week' || $page_info.last == 'personal_day'}
 <td class="v-allign-middle" nowrap="nowrap" align="right" style="width:1%">
{else}
 <td class="v-allign-middle" nowrap="nowrap" align="right">
{/if}
    <div class="moveButtonBlock-grn">
    {if $gid_is_empty}
        {assign var='group_id' value=''}
    {/if}
    {strip}
        <span class="moveButtonBase-grn">
            <a href="{grn_pageurl page=$page_info.all bdate=$bdate_prevweek uid=$user_id gid=$group_id event=$event_id event_date=$event_date pid=$pid sp=$view_set.offset search_text=$search_text p=$selected_group_type}"  title="{cb_msg module='grn.schedule' key='GRN_SCH-226' replace='true'}">
                <span class="moveButtonArrowLeftTwo-grn"></span>
            </a>
        </span>
        <span class="moveButtonBase-grn">
            <a href="{grn_pageurl page=$page_info.all bdate=$bdate_prevday uid=$user_id gid=$group_id event=$event_id event_date=$event_date pid=$pid sp=$view_set.offset search_text=$search_text p=$selected_group_type}" title="{cb_msg module='grn.schedule' key='GRN_SCH-229' replace='true'}">
                <span class="moveButtonArrowLeft-grn"></span>
            </a>
        </span>
        <span class="moveButtonBase-grn" title="">
            <a href="{grn_pageurl page=$page_info.all bdate=$date uid=$user_id gid=$group_id event=$event_id event_date=$event_date pid=$pid sp=$view_set.offset search_text=$search_text p=$selected_group_type}">
                {cb_msg module='grn.schedule' key='GRN_SCH-230' replace='true'}
            </a>
        </span>
        <span class="moveButtonBase-grn">
            <a href="{grn_pageurl page=$page_info.all bdate=$bdate_nextday uid=$user_id gid=$group_id event=$event_id event_date=$event_date pid=$pid sp=$view_set.offset search_text=$search_text p=$selected_group_type}" title="{cb_msg module='grn.schedule' key='GRN_SCH-231' replace='true'}">
                <span class="moveButtonArrowRight-grn"></span>
            </a>
        </span>
        <span class="moveButtonBase-grn">
            <a href="{grn_pageurl page=$page_info.all bdate=$bdate_nextweek uid=$user_id gid=$group_id event=$event_id event_date=$event_date pid=$pid sp=$view_set.offset search_text=$search_text p=$selected_group_type}" title="{cb_msg module='grn.schedule' key='GRN_SCH-233' replace='true'}">
                <span class="moveButtonArrowRightTwo-grn"></span>
            </a>
        </span>
    {/strip}
    </div>
    {if $page_info.last == 'index'}
        {include file='schedule/_display_options.tpl' page_key='index' schedule_id='schedule_groupweek' plid='index' expired_todo_option='true' show_full_title_option='true' apply_users_timezone='true' show_todos_option='true'}
    {/if}
    {if $page_info.last == 'group_day'}
        {include file='schedule/_display_options.tpl' page_key='group_day' schedule_id='event_list' group_day='true' plid='group_day'  show_full_title_option='true' apply_users_timezone='true' show_todos_option='true'}
    {/if}
    {if $page_info.last == 'personal_day'}
        {include file='schedule/_display_options.tpl' page_key='personal_day' schedule_id='view' plid='personal_day' expired_todo_option='true' show_todos_option='true'}
    {/if}
    {if $page_info.last == 'personal_week'}
        {include file='schedule/_display_options.tpl' page_key='personal_day' schedule_id='view' plid='personal_day' show_todos_option='true'}
    {/if}
 </td>
 </tr>
 </table>

</div>
{include file="schedule/_schedule_navi_calendar_js.tpl"}
