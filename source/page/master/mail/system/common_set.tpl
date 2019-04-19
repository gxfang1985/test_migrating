{include file='grn/system_head.tpl'}
{include file='grn/system_header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}
{grn_load_javascript file="grn/html/wm.js"}
{grn_load_javascript file="grn/html/wmc.js"}
<form name="{$form_name}" method="post" action="{grn_pageurl page='mail/system/command_'|cat:$page_info.last}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
<table class="std_form">
 <tr>
  <td class="form_subtitle_td_grn" colspan="2">
      <div class="subtitle">{cb_msg module='grn.mail.system' key='GRN_MAIL_SY-518' replace='true'}</div>
  </td>
 </tr>
 <colgroup>
  <col style="width:15em">
 </colgroup>
 <tr>
  <th nowrap>{cb_msg module='grn.mail.system' key='GRN_MAIL_SY-132' replace='true'}</th>
  <td>
    {if $set.not_use_mail eq '1'}
           {capture name='grn_mail_system_GRN_MAIL_SY_133'}{cb_msg module='grn.mail.system' key='GRN_MAIL_SY-133' replace='true'}{/capture}{grn_radio name='not_use_mail' id='not_use_mail1' value='1' caption=$smarty.capture.grn_mail_system_GRN_MAIL_SY_133 checked=TRUE}&nbsp;{capture name='grn_mail_system_GRN_MAIL_SY_134'}{cb_msg module='grn.mail.system' key='GRN_MAIL_SY-134' replace='true'}{/capture}{grn_radio name='not_use_mail' id='not_use_mail0' value='0' caption=$smarty.capture.grn_mail_system_GRN_MAIL_SY_134}
    {else}
           {capture name='grn_mail_system_GRN_MAIL_SY_135'}{cb_msg module='grn.mail.system' key='GRN_MAIL_SY-135' replace='true'}{/capture}{grn_radio name='not_use_mail' id='not_use_mail1' value='1' caption=$smarty.capture.grn_mail_system_GRN_MAIL_SY_135}&nbsp;{capture name='grn_mail_system_GRN_MAIL_SY_136'}{cb_msg module='grn.mail.system' key='GRN_MAIL_SY-136' replace='true'}{/capture}{grn_radio name='not_use_mail' id='not_use_mail0' value='0' caption=$smarty.capture.grn_mail_system_GRN_MAIL_SY_136 checked=TRUE}
    {/if}
  <div class="br">&nbsp;</div>
  <div class="sub_explanation"><span class="attention">{cb_msg module='grn.mail.system' key='GRN_MAIL_SY-519' replace='true'}</span></div>
  </td>
 </tr>
 <tr>
 
  <th nowrap>{cb_msg module='grn.mail.system' key='GRN_MAIL_SY-137' replace='true'}{$app_name}{cb_msg module='grn.mail.system' key='GRN_MAIL_SY-138' replace='true'}</th>
  <td>
    {if $set.check_mail_login eq '1'}
           {capture name='grn_mail_system_GRN_MAIL_SY_139'}{cb_msg module='grn.mail.system' key='GRN_MAIL_SY-139' replace='true'}{/capture}{grn_radio name='check_mail_login' id='check_mail_login1' value='1' caption=$smarty.capture.grn_mail_system_GRN_MAIL_SY_139 checked=TRUE}&nbsp;{capture name='grn_mail_system_GRN_MAIL_SY_140'}{cb_msg module='grn.mail.system' key='GRN_MAIL_SY-140' replace='true'}{/capture}{grn_radio name='check_mail_login' id='check_mail_login0' value='0' caption=$smarty.capture.grn_mail_system_GRN_MAIL_SY_140}
    {else}
           {capture name='grn_mail_system_GRN_MAIL_SY_141'}{cb_msg module='grn.mail.system' key='GRN_MAIL_SY-141' replace='true'}{/capture}{grn_radio name='check_mail_login' id='check_mail_login1' value='1' caption=$smarty.capture.grn_mail_system_GRN_MAIL_SY_141}&nbsp;{capture name='grn_mail_system_GRN_MAIL_SY_142'}{cb_msg module='grn.mail.system' key='GRN_MAIL_SY-142' replace='true'}{/capture}{grn_radio name='check_mail_login' id='check_mail_login0' value='0' caption=$smarty.capture.grn_mail_system_GRN_MAIL_SY_142 checked=TRUE}
    {/if}
  </td>
 </tr>
 <tr>
  <th nowrap valign="top">{cb_msg module='grn.mail.system' key='GRN_MAIL_SY-143' replace='true'}</th>
  <td>
    {if $set.auto_receive eq '1'}
           {capture name='grn_mail_system_GRN_MAIL_SY_144'}{cb_msg module='grn.mail.system' key='GRN_MAIL_SY-144' replace='true'}{/capture}{grn_radio name='auto_receive' id='auto_receive1' value='1' caption=$smarty.capture.grn_mail_system_GRN_MAIL_SY_144 checked=TRUE onclick="display_onWM('display_auto_check_receive');display_onWM('display_auto_check_repeat');"}&nbsp;{capture name='grn_mail_system_GRN_MAIL_SY_145'}{cb_msg module='grn.mail.system' key='GRN_MAIL_SY-145' replace='true'}{/capture}{grn_radio name='auto_receive' id='auto_receive0' value='0' caption=$smarty.capture.grn_mail_system_GRN_MAIL_SY_145 onclick="display_offWM('display_auto_check_receive');display_offWM('display_auto_check_repeat');"}
    {else}
           {capture name='grn_mail_system_GRN_MAIL_SY_146'}{cb_msg module='grn.mail.system' key='GRN_MAIL_SY-146' replace='true'}{/capture}{grn_radio name='auto_receive' id='auto_receive1' value='1' caption=$smarty.capture.grn_mail_system_GRN_MAIL_SY_146 onclick="display_onWM('display_auto_check_receive');display_onWM('display_auto_check_repeat');"}&nbsp;{capture name='grn_mail_system_GRN_MAIL_SY_147'}{cb_msg module='grn.mail.system' key='GRN_MAIL_SY-147' replace='true'}{/capture}{grn_radio name='auto_receive' id='auto_receive0' value='0' caption=$smarty.capture.grn_mail_system_GRN_MAIL_SY_147 checked=TRUE onclick="display_offWM('display_auto_check_receive');display_offWM('display_auto_check_repeat');"}
    {/if}
    <div class="br">&nbsp;</div>
    <div class="sub_explanation">{cb_msg module='grn.mail.system' key='GRN_MAIL_SY-148' replace='true'}<br><span class="attention">{cb_msg module='grn.mail.system' key='GRN_MAIL_SY-149' replace='true'}</span></div>
  </td>
 </tr>
 <tr id="display_auto_check_receive" style="display:{if 1 != $set.auto_receive}none{/if};">
  <th nowrap valign="top">{cb_msg module='grn.mail.system' key='GRN_MAIL_SY-150' replace='true'}</th>
  <td>
<script language="JavaScript">
<!--
idNum = {$scheduled_times.count};
__wmc_box_prefix      = "fbox";
__wmc_def_prefix      = "fbox0";
__wmc_div_prefix      = "fdiv";
__wmc_time_prefix     = "scheduled_time_";
__wmc_time_replace    = "%id_number%";
__wmc_delete_text     = "{cb_msg module='grn.mail.system' key='GRN_MAIL_SY-151' replace='true'}";
__wmc_all_delete_text = "{cb_msg module='grn.mail.system' key='GRN_MAIL_SY-152' replace='true'}";
//-->
</script>
<div id="fbox0" style="display:none">
{grn_select_time prefix='scheduled_time_%id_number%_' minute_interval=$scheduled_times.minute_interval time=$scheduled_times.default_value}
</div>
<div id="fbox">
{if $scheduled_times.values}
 {foreach name=set from=$scheduled_times.values item=scheduled_time }
<div id="fdiv{$smarty.foreach.set.iteration}" {if $smarty.foreach.set.iteration > 1}style="margin-top:5px"{/if}>
{grn_select_time prefix='scheduled_time_'|cat:$smarty.foreach.set.iteration|cat:'_' minute_interval=$scheduled_times.minute_interval time=$scheduled_time.time_user}&nbsp&nbsp<span class="bold"> UTC : ({$scheduled_time.time_UTC.hour} : {$scheduled_time.time_UTC.minute})</span>
  {if 1 == $scheduled_times.count}
<input type="button" value="{cb_msg module='grn.mail.system' key='GRN_MAIL_SY-153' replace='true'}" onClick="javascript:odf('fdiv{$smarty.foreach.set.iteration}')" style="display:none;"></div>
  {else}
<input type="button" value="{cb_msg module='grn.mail.system' key='GRN_MAIL_SY-154' replace='true'}" onClick="javascript:odf('fdiv{$smarty.foreach.set.iteration}')" style="display:;"></div>
  {/if}
 {/foreach}
{else}
<div id="fdiv1">
{grn_select_time prefix='scheduled_time_1_' minute_interval=$scheduled_times.minute_interval time=$scheduled_times.default_value}
<input type="button" value="{cb_msg module='grn.mail.system' key='GRN_MAIL_SY-155' replace='true'}" onClick="javascript:odf('fdiv1')" style="display:none;"></div>
{/if}
</div>
<input style="margin-top:10px" type="button" name="time0" value="{cb_msg module='grn.mail.system' key='GRN_MAIL_SY-156' replace='true'}" onclick="return add();">
<span id="fdel">
{if 1 < $scheduled_times.count}
<span id="delete_all"><input type="button" value="{cb_msg module='grn.mail.system' key='GRN_MAIL_SY-157' replace='true'}" onclick="return adf();" style="display:;"></span>
{/if}
</span>
<br />

<div class="br">&nbsp;</div>
 </td>
 </tr>
 <tr id="display_auto_check_repeat" style="display:{if 1 != $set.auto_receive}none{/if};">
  <th nowrap>{cb_msg module='grn.mail.system' key='GRN_MAIL_SY-158' replace='true'}</th>
  <td>
       {grn_select name='interval_time' options=$interval_time}&nbsp;{cb_msg module='grn.mail.system' key='GRN_MAIL_SY-159' replace='true'}
  </td>
 </tr>
 <tr>
  <th nowrap>{cb_msg module='grn.mail.system' key='GRN_MAIL_SY-513' replace='true'}</th>
  <td>
    {capture name='grn_mail_system_GRN_MAIL_SY_509'}{cb_msg module='grn.mail.system' key='GRN_MAIL_SY-509' replace='true'}{/capture}
    {capture name='grn_mail_system_GRN_MAIL_SY_510'}{cb_msg module='grn.mail.system' key='GRN_MAIL_SY-510' replace='true'}{/capture}
    {if $set.incremental_search eq '1'}
        {grn_radio name='incremental_search' id='incremental_search1' value='1' caption=$smarty.capture.grn_mail_system_GRN_MAIL_SY_509 checked=TRUE}&nbsp;{grn_radio name='incremental_search' id='incremental_search0' value='0' caption=$smarty.capture.grn_mail_system_GRN_MAIL_SY_510}
    {else}
        {grn_radio name='incremental_search' id='incremental_search1' value='1' caption=$smarty.capture.grn_mail_system_GRN_MAIL_SY_509}&nbsp;{grn_radio name='incremental_search' id='incremental_search0' value='0' caption=$smarty.capture.grn_mail_system_GRN_MAIL_SY_510 checked=TRUE}
    {/if}
  </td>
 </tr>
 <tr>
  <th nowrap>HTML {$app_name}{cb_msg module='grn.mail.system' key='GRN_MAIL_SY-303' replace='true'}</th>
  <td>
    {if $set.use_html_pict eq '1'}
        {capture name='grn_mail_system_GRN_MAIL_SY_304'}{cb_msg module='grn.mail.system' key='GRN_MAIL_SY-304' replace='true'}{/capture}{grn_radio name='use_html_pict' id='use_html_pict1' value='1' caption=$smarty.capture.grn_mail_system_GRN_MAIL_SY_304 checked=TRUE}&nbsp;{capture name='grn_mail_system_GRN_MAIL_SY_305'}{cb_msg module='grn.mail.system' key='GRN_MAIL_SY-305' replace='true'}{/capture}{grn_radio name='use_html_pict' id='use_html_pict0' value='0' caption=$smarty.capture.grn_mail_system_GRN_MAIL_SY_305}
    {else}
        {capture name='grn_mail_system_GRN_MAIL_SY_306'}{cb_msg module='grn.mail.system' key='GRN_MAIL_SY-306' replace='true'}{/capture}{grn_radio name='use_html_pict' id='use_html_pict1' value='1' caption=$smarty.capture.grn_mail_system_GRN_MAIL_SY_306}&nbsp;{capture name='grn_mail_system_GRN_MAIL_SY_307'}{cb_msg module='grn.mail.system' key='GRN_MAIL_SY-307' replace='true'}{/capture}{grn_radio name='use_html_pict' id='use_html_pict0' value='0' caption=$smarty.capture.grn_mail_system_GRN_MAIL_SY_307 checked=TRUE}
    {/if}
  </td>
 </tr>
 <tr>
   <th nowrap>
       {cb_msg module='grn.mail.system' key='GRN_MAIL_SY-521' replace='true'}
   </th>
   <td>
       {capture name='grn_mail_system_GRN_MAIL_SY_522'}{cb_msg module='grn.mail.system' key='GRN_MAIL_SY-522' replace='true'}{/capture}
       {grn_checkbox caption=$smarty.capture.grn_mail_system_GRN_MAIL_SY_522 name='mail_display_plaintext' id='mail_display_plaintext' value='1' checked=$set.mail_display_plaintext}
   </td>
 </tr>
 <tr>
  <th nowrap>{cb_msg module='grn.mail.system' key='GRN_MAIL_SY-318' replace='true'}</th>
  <td>
      {if $set.use_history eq '1'}
          {capture name='grn_mail_system_GRN_MAIL_SY_319'}{cb_msg module='grn.mail.system' key='GRN_MAIL_SY-319' replace='true'}{/capture}{grn_radio name='use_history' id='use_history1' value='1' caption=$smarty.capture.grn_mail_system_GRN_MAIL_SY_319 checked=TRUE}&nbsp;{capture name='grn_mail_system_GRN_MAIL_SY_320'}{cb_msg module='grn.mail.system' key='GRN_MAIL_SY-320' replace='true'}{/capture}{grn_radio name='use_history' id='use_history0' value='0' caption=$smarty.capture.grn_mail_system_GRN_MAIL_SY_320}
      {else}
          {capture name='grn_mail_system_GRN_MAIL_SY_321'}{cb_msg module='grn.mail.system' key='GRN_MAIL_SY-321' replace='true'}{/capture}{grn_radio name='use_history' id='use_history1' value='1' caption=$smarty.capture.grn_mail_system_GRN_MAIL_SY_321}&nbsp;{capture name='grn_mail_system_GRN_MAIL_SY_322'}{cb_msg module='grn.mail.system' key='GRN_MAIL_SY-322' replace='true'}{/capture}{grn_radio name='use_history' id='use_history0' value='0' caption=$smarty.capture.grn_mail_system_GRN_MAIL_SY_322 checked=TRUE}
      {/if}
  </td>
 </tr>

<script language="JavaScript">
<!--
    window.onload = function(){literal}{{/literal}typeChangeWMC("{$form_name}","auto_receive:display_auto_check_receive");typeChangeWMC("{$form_name}","auto_receive:display_auto_check_repeat");{literal}}{/literal}

    {literal}
    function selectScreenLayout()
    {
        var layout_2pane0_element = jQuery("#screen_layout_2pane0");
        var layout_3pane0_element = jQuery("#screen_layout_3pane0");
        if (layout_2pane0_element.is(":checked"))
        {
            layout_3pane0_element.prop("disabled", true);
        }
        else
        {
            layout_3pane0_element.prop("disabled", false);
        }

        if (layout_3pane0_element.is(":checked"))
        {
            layout_2pane0_element.prop("disabled", true);
        }
        else
        {
            layout_2pane0_element.prop("disabled", false);
        }
    }
    {/literal}
//-->
</script>

 <tr>
  <td class="form_subtitle_td_grn" colspan="2">
    <div class="subtitle">{cb_msg module='grn.mail.system' key='GRN_MAIL_SY-520' replace='true'}</div>
  </td>
 </tr>
 <tr>
  <th nowrap>{cb_msg module='grn.mail.system' key='GRN_MAIL_SY-270' replace='true'}</th>
    <td>
      {capture name='grn_mail_system_GRN_MAIL_SY_271'}{cb_msg module='grn.mail.system' key='GRN_MAIL_SY-271' replace='true'}{/capture}
      {capture name='grn_mail_system_GRN_MAIL_SY_272'}{cb_msg module='grn.mail.system' key='GRN_MAIL_SY-272' replace='true'}{/capture}
      {if $set.user_all_permission eq '1' or $set.user_account_modify eq '1'}
          {grn_radio name='user_account_operation' id='user_account_operation1' value='1' caption=$smarty.capture.grn_mail_system_GRN_MAIL_SY_271 checked=TRUE onclick='javascript: jQuery("#user_account_permission").prop("disabled",false);'}&nbsp;{grn_radio name='user_account_operation' id='user_account_operation0' value='0' caption=$smarty.capture.grn_mail_system_GRN_MAIL_SY_272 onclick='javascript: jQuery("#user_account_permission").attr("disabled", "disabled");'}
      {else}
          {grn_radio name='user_account_operation' id='user_account_operation1' value='1' caption=$smarty.capture.grn_mail_system_GRN_MAIL_SY_271 onclick='javascript: jQuery("#user_account_permission").prop("disabled",false);'}&nbsp;{grn_radio name='user_account_operation' id='user_account_operation0' value='0' caption=$smarty.capture.grn_mail_system_GRN_MAIL_SY_272 checked=TRUE onclick='javascript: jQuery("#user_account_permission").attr("disabled", "disabled");'}
      {/if}
      <div>
        <select id="user_account_permission" name="user_account_permission" {if $set.user_all_permission neq '1' and $set.user_account_modify neq '1'}disabled="disabled"{/if}>
          <option value="all" {if $set.user_all_permission eq '1'}selected{/if}>{cb_msg module='grn.mail.system' key='GRN_MAIL_SY-273' replace='true'}</option>
          <option value="modify" {if $set.user_all_permission neq '1'}selected{/if}>{cb_msg module='grn.mail.system' key='GRN_MAIL_SY-274' replace='true'}</option>
        </select>
      </div>
   </td>
 </tr>
 <tr>
   <th nowrap>{cb_msg module='grn.mail.system' key='GRN_MAIL_SY-280' replace='true'}{$app_name}{cb_msg module='grn.mail.system' key='GRN_MAIL_SY-281' replace='true'}</th>
   <td>
       {if $set.leaves_server_mail eq '1'}
           {capture name='grn_mail_system_GRN_MAIL_SY_282'}{cb_msg module='grn.mail.system' key='GRN_MAIL_SY-282' replace='true'}{/capture}{grn_radio name='leaves_server_mail' id='leaves_server_mail1' value='1' caption=$smarty.capture.grn_mail_system_GRN_MAIL_SY_282 checked=TRUE}&nbsp;{capture name='grn_mail_system_GRN_MAIL_SY_283'}{cb_msg module='grn.mail.system' key='GRN_MAIL_SY-283' replace='true'}{/capture}{grn_radio name='leaves_server_mail' id='leaves_server_mail0' value='0' caption=$smarty.capture.grn_mail_system_GRN_MAIL_SY_283}
       {else}
           {capture name='grn_mail_system_GRN_MAIL_SY_284'}{cb_msg module='grn.mail.system' key='GRN_MAIL_SY-284' replace='true'}{/capture}{grn_radio name='leaves_server_mail' id='leaves_server_mail1' value='1' caption=$smarty.capture.grn_mail_system_GRN_MAIL_SY_284}&nbsp;{capture name='grn_mail_system_GRN_MAIL_SY_285'}{cb_msg module='grn.mail.system' key='GRN_MAIL_SY-285' replace='true'}{/capture}{grn_radio name='leaves_server_mail' id='leaves_server_mail0' value='0' caption=$smarty.capture.grn_mail_system_GRN_MAIL_SY_285 checked=TRUE}
       {/if}
   </td>
 </tr>
 <tr>
   <th nowrap>{cb_msg module='grn.mail.system' key='GRN_MAIL_SY-286' replace='true'}{$app_name}{cb_msg module='grn.mail.system' key='GRN_MAIL_SY-287' replace='true'}</th>
   <td>
       {if $set.mail_check eq '1'}
           {capture name='grn_mail_system_GRN_MAIL_SY_288'}{cb_msg module='grn.mail.system' key='GRN_MAIL_SY-288' replace='true'}{/capture}{grn_radio name='mail_check' id='mail_check1' value='1' caption=$smarty.capture.grn_mail_system_GRN_MAIL_SY_288 checked=TRUE}&nbsp;{capture name='grn_mail_system_GRN_MAIL_SY_289'}{cb_msg module='grn.mail.system' key='GRN_MAIL_SY-289' replace='true'}{/capture}{grn_radio name='mail_check' id='mail_check0' value='0' caption=$smarty.capture.grn_mail_system_GRN_MAIL_SY_289}
       {else}
           {capture name='grn_mail_system_GRN_MAIL_SY_290'}{cb_msg module='grn.mail.system' key='GRN_MAIL_SY-290' replace='true'}{/capture}{grn_radio name='mail_check' id='mail_check1' value='1' caption=$smarty.capture.grn_mail_system_GRN_MAIL_SY_290}&nbsp;{capture name='grn_mail_system_GRN_MAIL_SY_291'}{cb_msg module='grn.mail.system' key='GRN_MAIL_SY-291' replace='true'}{/capture}{grn_radio name='mail_check' id='mail_check0' value='0' caption=$smarty.capture.grn_mail_system_GRN_MAIL_SY_291 checked=TRUE}
       {/if}
   </td>
 </tr>
 <tr>
   <th nowrap>{cb_msg module='grn.mail.system' key='GRN_MAIL_SY-292' replace='true'}{$app_name}{cb_msg module='grn.mail.system' key='GRN_MAIL_SY-293' replace='true'}</th>
   <td>
       {if $set.all_receive eq '1'}
           {capture name='grn_mail_system_GRN_MAIL_SY_294'}{cb_msg module='grn.mail.system' key='GRN_MAIL_SY-294' replace='true'}{/capture}{grn_radio name='all_receive' id='all_receive1' value='1' caption=$smarty.capture.grn_mail_system_GRN_MAIL_SY_294 checked=TRUE}&nbsp;{capture name='grn_mail_system_GRN_MAIL_SY_295'}{cb_msg module='grn.mail.system' key='GRN_MAIL_SY-295' replace='true'}{/capture}{grn_radio name='all_receive' id='all_receive0' value='0' caption=$smarty.capture.grn_mail_system_GRN_MAIL_SY_295}
       {else}
           {capture name='grn_mail_system_GRN_MAIL_SY_296'}{cb_msg module='grn.mail.system' key='GRN_MAIL_SY-296' replace='true'}{/capture}{grn_radio name='all_receive' id='all_receive1' value='1' caption=$smarty.capture.grn_mail_system_GRN_MAIL_SY_296}&nbsp;{capture name='grn_mail_system_GRN_MAIL_SY_297'}{cb_msg module='grn.mail.system' key='GRN_MAIL_SY-297' replace='true'}{/capture}{grn_radio name='all_receive' id='all_receive0' value='0' caption=$smarty.capture.grn_mail_system_GRN_MAIL_SY_297 checked=TRUE}
       {/if}
   </td>
 </tr>
 <tr>
   <th nowrap>HTML {$app_name}{cb_msg module='grn.mail.system' key='GRN_MAIL_SY-298' replace='true'}</th>
   <td>
       {if $set.send_html_mail eq '1'}
           {capture name='grn_mail_system_GRN_MAIL_SY_299'}{cb_msg module='grn.mail.system' key='GRN_MAIL_SY-299' replace='true'}{/capture}{grn_radio name='send_html_mail' id='send_html_mail1' value='1' caption=$smarty.capture.grn_mail_system_GRN_MAIL_SY_299 checked=TRUE}&nbsp;{capture name='grn_mail_system_GRN_MAIL_SY_300'}{cb_msg module='grn.mail.system' key='GRN_MAIL_SY-300' replace='true'}{/capture}{grn_radio name='send_html_mail' id='send_html_mail0' value='0' caption=$smarty.capture.grn_mail_system_GRN_MAIL_SY_300}
       {else}
           {capture name='grn_mail_system_GRN_MAIL_SY_301'}{cb_msg module='grn.mail.system' key='GRN_MAIL_SY-301' replace='true'}{/capture}{grn_radio name='send_html_mail' id='send_html_mail1' value='1' caption=$smarty.capture.grn_mail_system_GRN_MAIL_SY_301}&nbsp;{capture name='grn_mail_system_GRN_MAIL_SY_302'}{cb_msg module='grn.mail.system' key='GRN_MAIL_SY-302' replace='true'}{/capture}{grn_radio name='send_html_mail' id='send_html_mail0' value='0' caption=$smarty.capture.grn_mail_system_GRN_MAIL_SY_302 checked=TRUE}
       {/if}
   </td>
 </tr>
 <tr>
   <th nowrap>
       {cb_msg module='grn.mail.system' key='GRN_MAIL_SY-515' replace='true'}
   </th>
   <td>
       {capture name='grn_mail_system_GRN_MAIL_SY_516'}{cb_msg module='grn.mail.system' key='GRN_MAIL_SY-516' replace='true'}{/capture}
       {capture name='grn_mail_system_GRN_MAIL_SY_517'}{cb_msg module='grn.mail.system' key='GRN_MAIL_SY-517' replace='true'}{/capture}
       {strip}
           {if $set.automatic_mail eq '1'}
               {grn_radio name='automatic_mail' id='automatic_mail1' value='1' caption=$smarty.capture.grn_mail_system_GRN_MAIL_SY_516 checked=TRUE}
               &nbsp;
               {grn_radio name='automatic_mail' id='automatic_mail0' value='0' caption=$smarty.capture.grn_mail_system_GRN_MAIL_SY_517}
           {else}
               {grn_radio name='automatic_mail' id='automatic_mail1' value='1' caption=$smarty.capture.grn_mail_system_GRN_MAIL_SY_516}
               &nbsp;
               {grn_radio name='automatic_mail' id='automatic_mail0' value='0' caption=$smarty.capture.grn_mail_system_GRN_MAIL_SY_517 checked=TRUE}
           {/if}
       {/strip}
   </td>
 </tr>
 <tr>
   <th nowrap>{cb_msg module='grn.mail.system' key='GRN_MAIL_SY-308' replace='true'}</th>
   <td>
       {if $set.use_confirm eq '1'}
           {capture name='grn_mail_system_GRN_MAIL_SY_309'}{cb_msg module='grn.mail.system' key='GRN_MAIL_SY-309' replace='true'}{/capture}{grn_radio name='use_confirm' id='use_confirm1' value='1' caption=$smarty.capture.grn_mail_system_GRN_MAIL_SY_309 checked=TRUE}&nbsp;{capture name='grn_mail_system_GRN_MAIL_SY_310'}{cb_msg module='grn.mail.system' key='GRN_MAIL_SY-310' replace='true'}{/capture}{grn_radio name='use_confirm' id='use_confirm0' value='0' caption=$smarty.capture.grn_mail_system_GRN_MAIL_SY_310}
       {else}
           {capture name='grn_mail_system_GRN_MAIL_SY_311'}{cb_msg module='grn.mail.system' key='GRN_MAIL_SY-311' replace='true'}{/capture}{grn_radio name='use_confirm' id='use_confirm1' value='1' caption=$smarty.capture.grn_mail_system_GRN_MAIL_SY_311}&nbsp;{capture name='grn_mail_system_GRN_MAIL_SY_312'}{cb_msg module='grn.mail.system' key='GRN_MAIL_SY-312' replace='true'}{/capture}{grn_radio name='use_confirm' id='use_confirm0' value='0' caption=$smarty.capture.grn_mail_system_GRN_MAIL_SY_312 checked=TRUE}
       {/if}
   </td>
 </tr>
 <tr>
   <th nowrap>{cb_msg module='grn.mail.system' key='GRN_MAIL_SY-313' replace='true'}</th>
   <td>
       {if $set.use_status eq '1'}
           {capture name='grn_mail_system_GRN_MAIL_SY_314'}{cb_msg module='grn.mail.system' key='GRN_MAIL_SY-314' replace='true'}{/capture}{grn_radio name='use_status' id='use_status1' value='1' caption=$smarty.capture.grn_mail_system_GRN_MAIL_SY_314 checked=TRUE}&nbsp;{capture name='grn_mail_system_GRN_MAIL_SY_315'}{cb_msg module='grn.mail.system' key='GRN_MAIL_SY-315' replace='true'}{/capture}{grn_radio name='use_status' id='use_status0' value='0' caption=$smarty.capture.grn_mail_system_GRN_MAIL_SY_315}
       {else}
           {capture name='grn_mail_system_GRN_MAIL_SY_316'}{cb_msg module='grn.mail.system' key='GRN_MAIL_SY-316' replace='true'}{/capture}{grn_radio name='use_status' id='use_status1' value='1' caption=$smarty.capture.grn_mail_system_GRN_MAIL_SY_316}&nbsp;{capture name='grn_mail_system_GRN_MAIL_SY_317'}{cb_msg module='grn.mail.system' key='GRN_MAIL_SY-317' replace='true'}{/capture}{grn_radio name='use_status' id='use_status0' value='0' caption=$smarty.capture.grn_mail_system_GRN_MAIL_SY_317 checked=TRUE}
       {/if}
   </td>
 </tr>
 <tr>
   <th nowrap valign="top">{cb_msg module='grn.mail.system' key='GRN_MAIL_SY-506' replace='true'}</th>
   <td>
     <table class="table_grn">
       <tr>
         <td>{grn_image image='image-common/2paine20.png'}<span class="mLeft3">{cb_msg module='grn.mail.system' key='GRN_MAIL_SY-507' replace='true'}</span></td>
         <td>{cb_msg module='grn.mail.system' key='GRN_MAIL_SY-512' replace='true'}</td>
         <td>
           <input id="screen_layout_2pane1" type="radio" {if $set.screen_layout.2pane eq '1'}checked="checked"{/if} onclick="selectScreenLayout()" value="1" name="screen_layout_2pane"><label onmouseout="this.style.color=''" onmouseover="this.style.color='#ff0000'" for="screen_layout_2pane1" style="">{cb_msg module='grn.mail.system' key='GRN_MAIL_SY-509' replace='true'}</label>
         </td>
         <td>
           <input id="screen_layout_2pane0" type="radio" {if $set.screen_layout.2pane eq '0'}checked="checked"{/if} onclick="selectScreenLayout()" value="0" name="screen_layout_2pane" {if $set.screen_layout.3pane eq '0'}disabled="disabled"{/if}><label onmouseout="this.style.color=''" onmouseover="this.style.color='#ff0000'" for="screen_layout_2pane0" style="">{cb_msg module='grn.mail.system' key='GRN_MAIL_SY-510' replace='true'}</label>
         </td>
       </tr>
       <tr>
         <td>{grn_image image='image-common/3paine20.png'}<span class="mLeft3">{cb_msg module='grn.mail.system' key='GRN_MAIL_SY-508' replace='true'}</span></td>
         <td>{cb_msg module='grn.mail.system' key='GRN_MAIL_SY-512' replace='true'}</td>
         <td>
           <input id="screen_layout_3pane1" type="radio" {if $set.screen_layout.3pane eq '1'}checked="checked"{/if} onclick="selectScreenLayout()" value="1" name="screen_layout_3pane"><label onmouseout="this.style.color=''" onmouseover="this.style.color='#ff0000'" for="screen_layout_3pane1" style="">{cb_msg module='grn.mail.system' key='GRN_MAIL_SY-509' replace='true'}</label>
         </td>
         <td>
           <input id="screen_layout_3pane0" type="radio" {if $set.screen_layout.3pane eq '0'}checked="checked"{/if} onclick="selectScreenLayout()" value="0" name="screen_layout_3pane" {if $set.screen_layout.2pane eq '0'}disabled="disabled"{/if}><label onmouseout="this.style.color=''" onmouseover="this.style.color='#ff0000'" for="screen_layout_3pane0" style="">{cb_msg module='grn.mail.system' key='GRN_MAIL_SY-510' replace='true'}</label>
         </td>
       </tr>
     </table>
     <div class="sub_explanation mLeft3">{cb_msg module='grn.mail.system' key='GRN_MAIL_SY-511' replace='true'}</div>
   </td>
 </tr>
 <tr>
   <td></td>
   <td>
       {capture name='grn_mail_system_GRN_MAIL_SY_160'}{cb_msg module='grn.mail.system' key='GRN_MAIL_SY-160' replace='true'}{/capture}{grn_button_submit class='margin' caption=$smarty.capture.grn_mail_system_GRN_MAIL_SY_160}
       {grn_button_cancel page='system/application_list' app_id='mail'}
   </td>
 </tr>
</table>
</form>
{include file='grn/system_footer.tpl'}
