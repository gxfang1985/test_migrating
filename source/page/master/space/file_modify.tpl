{grn_title title=$page_title class=$page_info.parts[0]}
{assign var="form_name" value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='space/command_file_modify'}">
<input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
<input type="hidden" name="fid" value="{$file.id}">
<input type="hidden" name="spid" value="{$space_id}">
<input type="hidden" name="tid" value="{$thread_id}">
<input type="hidden" name="from" value="{$from}">

<table class="std_form">
 <tr>
  <th>{cb_msg module='grn.grn' key='GRN_GRN-1271' replace='true'}</th>
  <td>{$file.filename|escape:"html"}</td>
 </tr>
 <tr>
  <th>{cb_msg module='grn.grn' key='GRN_GRN-1272' replace='true'}</th>
  <td>{capture name='grn_grn_GRN_GRN_1273'}{cb_msg module='grn.grn' key='GRN_GRN-1273' replace='true'}{/capture}{grn_text necessary=true name="title" value=$file.title size="50" title=$smarty.capture.grn_grn_GRN_GRN_1273 disable_return_key=true}</td>
 </tr>
 <tr>
  <th>{cb_msg module='grn.grn' key='GRN_GRN-1274' replace='true'}</th>
  <td>
   <select name="version">
 {if $version.current && $version.current != $version.default}
  {if $version.current == -1}
    <option value="-1" selected>{cb_msg module='grn.grn' key='GRN_GRN-1275' replace='true'}
  {else}
    <option value="{$version.current}" selected>{$version.current}
  {/if}
    <option value="">--
  {assign var='default_selected' value='1'}
 {/if}
 {foreach from=$version.options item=value}
  {if $value == 0}
    <option value="0"{if ! $default_selected && $version.default == 0} selected{/if}>{cb_msg module='grn.grn' key='GRN_GRN-1276' replace='true'}
  {elseif $value == -1}
    <option value="-1"{if ! $default_selected && $version.default == -1} selected{/if}>{cb_msg module='grn.grn' key='GRN_GRN-1277' replace='true'}
  {else}
    <option value="{$value}"{if ! $default_selected && $version.default == $value} selected{/if}>{$value}
  {/if}
 {/foreach}
   </select>&nbsp;{cb_msg module='grn.grn' key='GRN_GRN-1278' replace='true'}
  </td>
 </tr>
 <tr valign="top">
  <th>{cb_msg module='grn.grn' key='GRN_GRN-1279' replace='true'}</th>
  <td>{capture name='grn_grn_GRN_GRN_1280'}{cb_msg module='grn.grn' key='GRN_GRN-1280' replace='true'}{/capture}{grn_textarea name="memo" value=$file.memo rows="5" title=$smarty.capture.grn_grn_GRN_GRN_1280}</td>
 </tr>
 <tr>
  <td></td>
  <td>
   <div class="mTop10">
    {strip}
     {capture name='grn_grn_GRN_GRN_1281'}{cb_msg module='grn.grn' key='GRN_GRN-1281' replace='true'}{/capture}
     {grn_button action='submit' ui='main' caption=$smarty.capture.grn_grn_GRN_GRN_1281 spacing='normal'}
    {/strip}
    {if $appType == 1}
        {grn_button action='cancel' page='space/application/discussion/file_view' page_param_spid=$space_id page_param_tid=$thread_id page_param_fid=$file.id}
    {else}
        {grn_button action='cancel' page='space/application/todo/file_view' page_param_spid=$space_id page_param_tid=$thread_id page_param_fid=$file.id page_param_from=$from}
    {/if}
   </div>
  </td>
 </tr>
</table>
