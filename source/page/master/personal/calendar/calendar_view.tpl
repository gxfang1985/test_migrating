{include file='grn/personal_head.tpl'}
{include file='grn/personal_header.tpl'}
{grn_delete title=$delete_info_all.title page=$delete_info_all.page no_confirm=$delete_info_all.no_confirm data=$delete_info_all.data handler=$delete_info_all.handler before_delete=$delete_info_all.before_delete}
{grn_delete title=$delete_info_multi.title page=$delete_info_multi.page no_confirm=$delete_info_multi.no_confirm data=$delete_info_multi.data handler=$delete_info_multi.handler multi_target=$delete_info_multi.multi_target form_target=$delete_info_multi.form_target}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}
{literal}
    <script type="text/javascript">
        function get_all_checkbox(formS)
        {
            var list = jQuery("form[name='personal/calendar/calendar_view']").find("input[name='eid[]']");
            var span_delete_count = jQuery(formS).find("span.delete_count").get(0);
            span_delete_count.innerHTML = list.length;
            list.each(function (idx, check) {
                var input_elm = document.createElement("input");
                input_elm.setAttribute("type", "hidden");
                input_elm.setAttribute("name", check.name);
                input_elm.setAttribute("value", check.value);
                formS.appendChild(input_elm);
            });
        }
    </script>
{/literal}
<form name="{$form_name}" method="post" action="{grn_pageurl page='personal/calendar/event_delete_multi'}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">

<div id="main_menu_part">
<span class="menu_item">{capture name='grn_personal_calendar_GRN_PRS_CA_12'}{cb_msg module='grn.personal.calendar' key='GRN_PRS_CA-12' replace='true'}{/capture}{grn_link page='personal/calendar/event_add' caption=$smarty.capture.grn_personal_calendar_GRN_PRS_CA_12 image='write20.gif' bdate=$bdate->year}</span>
<span class="menu_item" >{capture name='grn_personal_calendar_GRN_PRS_CA_13'}{cb_msg module='grn.personal.calendar' key='GRN_PRS_CA-13' replace='true'}{/capture}{grn_link page='personal/calendar/event_delete_all' all=1 caption=$smarty.capture.grn_personal_calendar_GRN_PRS_CA_13 image='delete20.gif' disabled=$not_exist script="javascript:void(0);" id='lnk_delete_all'}</span>
<span class="menu_item">{capture name='grn_personal_calendar_GRN_PRS_CA_14'}{cb_msg module='grn.personal.calendar' key='GRN_PRS_CA-14' replace='true'}{/capture}{grn_link page='personal/calendar/import1' caption=$smarty.capture.grn_personal_calendar_GRN_PRS_CA_14 image='import20.gif' bdate=$bdate->year}</span>
<span class="menu_item">{capture name='grn_personal_calendar_GRN_PRS_CA_15'}{cb_msg module='grn.personal.calendar' key='GRN_PRS_CA-15' replace='true'}{/capture}{grn_link page='personal/calendar/export' caption=$smarty.capture.grn_personal_calendar_GRN_PRS_CA_15 image='export20.gif' bdate=$bdate->year disabled=$not_exist}</span>
</div>

<p>
<div class="margin_bottom">
<div class="sub_title">
{grn_date_format date=$bdate format="DateFull_Y"}&nbsp;
<button onclick="location.href='{grn_pageurl page=$page_info.all bdate=$bdate->year-1}';return false;">&nbsp;&nbsp;<img src="{$app_path}/grn/image/cybozu/arrow_back_single.gif?{$build_date}" align='absmiddle'>&nbsp;&nbsp;</button>
      <button onclick="location.href='{grn_pageurl page=$page_info.all }';return false;"> {cb_msg module='grn.personal.calendar' key='GRN_PRS_CA-17' replace='true'} </button>
      <button onclick="location.href='{grn_pageurl page=$page_info.all bdate=$bdate->year+1}';return false;">&nbsp;&nbsp;<img src="{$app_path}/grn/image/cybozu/arrow_next_single.gif?{$build_date}" align='absmiddle'>&nbsp;&nbsp;</button
>
</div>
</div>

<div class="list_menu">
<span class="list_menu_item">{include file='grn/checkall.tpl' elem_name='eid[]'}</span>
<span class="margin_top" id='lnk_delete_multi'>
{capture name='grn_personal_calendar_GRN_PRS_CA_19'}{cb_msg module='grn.personal.calendar' key='GRN_PRS_CA-19' replace='true'}{/capture}{grn_button_submit caption=$smarty.capture.grn_personal_calendar_GRN_PRS_CA_19 onclick="return false;"}
</span>
</div>
<table class="list_column">
 <colgroup>
  <col width="5%">
  <col width="10%">
  <col width="65%">
  <col width="20%">
 </colgroup>
 <tr>
  <th nowrap>&nbsp;</th>
  <th nowrap>{cb_msg module='grn.personal.calendar' key='GRN_PRS_CA-20' replace='true'}</th>
  <th nowrap>{cb_msg module='grn.personal.calendar' key='GRN_PRS_CA-21' replace='true'}</th>
  <th nowrap>{cb_msg module='grn.personal.calendar' key='GRN_PRS_CA-22' replace='true'}</th>
 </tr>
{foreach from=$selected.event item=event}
    {capture name=_date}{grn_date_format date=$event.date format="DateFull_MD"}{/capture}
 <tr valign="top">
  <td><input type="checkbox" name="eid[]" value="{$event.id}"></td>
  <td>{grn_link page='personal/calendar/event_view' caption=$smarty.capture._date event=$event.id image='detail20.gif'}</td>
     {if $event.type == 2}
  <td>{$event.detail|escape|nl2br}</td><td>{cb_msg module='grn.personal.calendar' key='GRN_PRS_CA-23' replace='true'}</td>
     {else}
  <td>{$event.detail|escape|nl2br}</td><td>{cb_msg module='grn.personal.calendar' key='GRN_PRS_CA-24' replace='true'}</td>
     {/if}
 </tr>
{/foreach}
</table>

<input type="hidden" name="bdate" value="{$bdate->year}">
</form>

{include file='grn/personal_footer.tpl'}
