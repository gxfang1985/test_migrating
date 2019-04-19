{include file="grn/head.tpl"}
{include file="grn/header.tpl"}

{grn_title title=$page_title class=""}

{assign var="form_name" value=$smarty.template|basename}
<form name="{$form_name}" method="get" action="{grn_pageurl page='memo/search'}">
<input type="hidden" name="did" value="{$folder_id}">
<input type="hidden" name="in" value="1">

 <p>
 <table class="std_form">
  <tr valign="top">
   <th>{cb_msg module='grn.memo' key='GRN_MEM-73' replace='true'}</th>
   <td>
    {grn_text necessary=true name="text" value=$search.text size="50"}
    <input type="submit" name="Search" value="{cb_msg module='grn.memo' key='GRN_MEM-74' replace='true'}"><br>
    {capture name='grn_memo_GRN_MEM_75'}{cb_msg module='grn.memo' key='GRN_MEM-75' replace='true'}{/capture}{grn_checkbox name="se" id="sensitive" value="1" checked=$search.sensitive caption=$smarty.capture.grn_memo_GRN_MEM_75}
   </td>
  </tr>
  <tr>
   <th>{cb_msg module='grn.memo' key='GRN_MEM-76' replace='true'}</th>
   <td>
{if ! $folder_id}
 <input type="hidden" name="sdid" value="">{cb_msg module='grn.memo' key='GRN_MEM-77' replace='true'}
{else}
 {if $search.sdid == $folder_id}
 {grn_radio name="sdid" id="select" value=$folder_id caption=$folder.name checked=true}{cb_msg module='grn.memo' key='GRN_MEM-78' replace='true'}{capture name='grn_memo_GRN_MEM_79'}{cb_msg module='grn.memo' key='GRN_MEM-79' replace='true'}{/capture}{grn_radio name="sdid" id="all" value="" caption=$smarty.capture.grn_memo_GRN_MEM_79}
 {else}
 {grn_radio name="sdid" id="select" value=$folder_id caption=$folder.name}{cb_msg module='grn.memo' key='GRN_MEM-80' replace='true'}{capture name='grn_memo_GRN_MEM_81'}{cb_msg module='grn.memo' key='GRN_MEM-81' replace='true'}{/capture}{grn_radio name="sdid" id="all" value="" caption=$smarty.capture.grn_memo_GRN_MEM_81 checked=true}
 {/if}
{/if}
   </td>
  </tr>
{if $folder_id}
  <tr>
   <th>{cb_msg module='grn.memo' key='GRN_MEM-82' replace='true'}</th>
   <td>{capture name='grn_memo_GRN_MEM_83'}{cb_msg module='grn.memo' key='GRN_MEM-83' replace='true'}{/capture}{grn_checkbox name="sb" id="sub" value="1" checked=$search.sub caption=$smarty.capture.grn_memo_GRN_MEM_83}</td>
  </tr>
{/if}
  <tr>
   <th>{cb_msg module='grn.memo' key='GRN_MEM-84' replace='true'}</th>
   <td>
    <select name="li">
     <option value="1"{if $search.limit == 1} selected{/if}>{cb_msg module='grn.memo' key='GRN_MEM-85' replace='true'}
     <option value="3"{if $search.limit == 3} selected{/if}>{cb_msg module='grn.memo' key='GRN_MEM-87' replace='true'}
     <option value="6"{if $search.limit == 6} selected{/if}>{cb_msg module='grn.memo' key='GRN_MEM-89' replace='true'}
     <option value="12"{if $search.limit == 12} selected{/if}>{cb_msg module='grn.memo' key='GRN_MEM-91' replace='true'}
     <option value="0"{if ! $search.limit} selected{/if}>{cb_msg module='grn.memo' key='GRN_MEM-93' replace='true'}
    </select>
   </td>
  </tr>
  <tr>
   <th>{cb_msg module='grn.memo' key='GRN_MEM-94' replace='true'}</th>
   <td>
{capture name='grn_memo_GRN_MEM_95'}{cb_msg module='grn.memo' key='GRN_MEM-95' replace='true'}{/capture}{grn_checkbox name="ti" id="subject" value="1" checked=$search.items.title  caption=$smarty.capture.grn_memo_GRN_MEM_95}
{capture name='grn_memo_GRN_MEM_96'}{cb_msg module='grn.memo' key='GRN_MEM-96' replace='true'}{/capture}{grn_checkbox name="da" id="data"    value="1" checked=$search.items.data   caption=$smarty.capture.grn_memo_GRN_MEM_96}
   </td>
  </tr>
  <tr>
   <td></td>
   <td>
        <div class="mTop10">
            {capture name='grn_memo_GRN_MEM_97'}{cb_msg module='grn.memo' key='GRN_MEM-97' replace='true'}{/capture}
            {grn_button ui="main" action="submit" caption=$smarty.capture.grn_memo_GRN_MEM_97 id="memo_button_search"}
        </div>
   </td>
  </tr>
 </table>
</form>

<form name="{$form_name}_action" method="post" action="{grn_pageurl page='memo/command_index'}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
<input type="hidden" name="did" value="{$folder_id}">
<input type="hidden" name="cmd" value="">

<p>
<div class="sub_title">{cb_msg module='grn.memo' key='GRN_MEM-98' replace='true'} {include file="grn/smart_data_count_310.tpl" start_num=$navi.start_count end_num=$navi.end_count all_num=$navi.count}</div>
<div class="navi"><nobr>{include file="grn/word_navi.tpl" navi=$navi.navi}</nobr></div>

{strip}
<div class="list_menu"><nobr>
    <span class="list_menu_item">{include file="grn/checkall.tpl" form_name=$form_name|cat:"_action" elem_name="eid[]"}</span>
    <span class="list_menu_item">{capture name='grn_memo_GRN_MEM_106'}{cb_msg module='grn.memo' key='GRN_MEM-106' replace='true'}{/capture}{grn_button_submit id="btn_delete_multi1" caption=$smarty.capture.grn_memo_GRN_MEM_106 onclick="return false;"}</span>
    <span class="list_menu_item">
      <select id="mdid1" name="mdid" onchange="onChangeFolderSelect(this, 'mdid2', ['moveto', 'moveto2']);">
        <option value="-1" selected>{cb_msg module='grn.memo' key='GRN_MEM-182' replace='true'}</option>
        <option value="">{cb_msg module='grn.memo' key='lastest_folder_name'}</option>
        {foreach from=$folder_menu key=id item=folder_name}
        <option value="{$id|escape}">{$folder_name|escape}</option>
        {/foreach}
      </select>
      {capture name='grn_memo_GRN_MEM_107'}{cb_msg module='grn.memo' key='GRN_MEM-107' replace='true'}{/capture}{grn_button_submit id="moveto" caption=$smarty.capture.grn_memo_GRN_MEM_107 onclick="if(!grn_is_checked(this.form,'eid[]')) return false; cmd.value='move';" disabled=true}</span>
  </nobr>
</div>
{/strip}

<table class="list_column">
 <colgroup>
  <col width="1%">
  <col width="30%">
  <col width="20%">
  <col width="20%">
  <col width="15%">
  <col width="15%">
 </colgroup>

 <tr>
  <th nowrap></th>
  <th nowrap>{cb_msg module='grn.memo' key='GRN_MEM-101' replace='true'}</th>
  <th nowrap>{cb_msg module='grn.memo' key='GRN_MEM-102' replace='true'}</th>
  <th nowrap>{cb_msg module='grn.memo' key='GRN_MEM-103' replace='true'}</th>
  <th nowrap>{cb_msg module='grn.memo' key='GRN_MEM-104' replace='true'}</th>
  <th nowrap>{cb_msg module='grn.memo' key='GRN_MEM-105' replace='true'}</th>
 </tr>

{foreach from=$items item=item}
 <tr class="{cycle values='linetwo,lineone'}">
  <td><input type="checkbox" name="eid[]" value="{$item.id}"></td>
 {if $item.type != 'file'}
  <td>{grn_link page='memo/view' caption=$item.data.title image='memo20.gif' iid=$item.id truncated_caption=$config.subject_width}</td>
  <td>{$item.data.data|cb_mb_truncate:$config.truncate_width|escape}</td>
  {if $item.folder}
  <td>{grn_link page='memo/index' caption=$item.folder.name image='folder20.gif' did=$item.folder.id truncated_caption=$config.truncate_width}</td>
  {else}
  <td><br></td>
  {/if}
  <td>{grn_date_format date=$item.data.mtime format="DateTimeCompact"}</td>
  <td>{grn_format_filesize size=$item.data.size unit="KB" round='ceil'}</td>
 {else}
  {if strlen($item.data.title)}
  <td>{grn_link page='memo/file_view' caption=$item.data.title image='file20.gif' iid=$item.id truncated_caption=$config.subject_width}</td>
  {else}
  <td>{grn_link page='memo/file_view' caption=$item.data.filename image='file20.gif' iid=$item.id truncated_caption=$config.subject_width}</td>
  {/if}
  <td>{grn_link page='memo/file_download' caption=$item.data.filename image='disk20.gif' iid=$item.id ticket=$download_ticket}</td>
  {if $item.folder}
  <td>{grn_link page='memo/index' caption=$item.folder.name image='folder20.gif' did=$item.folder.id truncated_caption=$config.truncate_width}</td>
  {else}
  <td>{cb_msg module='grn.memo' key='lastest_folder_name'}</td>
  {/if}
  <td>{grn_date_format date=$item.data.mtime format="DateTimeCompact"}</td>
  <td>{grn_format_filesize size=$item.data.size unit="KB" round='ceil'}</td>
 {/if}
 </tr>
{/foreach}

</table>

{strip}
<div class="list_menu"><nobr>
    <span class="list_menu_item">{include file="grn/checkall.tpl" form_name=$form_name|cat:"_action" elem_name="eid[]"}</span>
    <span class="list_menu_item">{capture name='grn_memo_GRN_MEM_106'}{cb_msg module='grn.memo' key='GRN_MEM-106' replace='true'}{/capture}{grn_button_submit id="btn_delete_multi2" caption=$smarty.capture.grn_memo_GRN_MEM_106 onclick="return false;"}</span>
    <span class="list_menu_item">
      <select id="mdid2" name="mdid" onchange="onChangeFolderSelect(this, 'mdid1', ['moveto', 'moveto2']);">
        <option value="-1" selected>{cb_msg module='grn.memo' key='GRN_MEM-182' replace='true'}</option>
        <option value="">{cb_msg module='grn.memo' key='lastest_folder_name'}</option>
        {foreach from=$folder_menu key=id item=folder_name}
        <option value="{$id|escape}">{$folder_name|escape}</option>
        {/foreach}
      </select>
      {capture name='grn_memo_GRN_MEM_107'}{cb_msg module='grn.memo' key='GRN_MEM-107' replace='true'}{/capture}{grn_button_submit id="moveto2" caption=$smarty.capture.grn_memo_GRN_MEM_107 onclick="if(!grn_is_checked(this.form,'eid[]')) return false; cmd.value='move';" disabled=true}</span>
  </nobr>
</div>
{/strip}
<div class="navi"><nobr>{include file='grn/word_navi.tpl' navi=$navi.navi}</nobr></div>

</form>
{grn_delete title=$delete_info.title page=$delete_info.page no_confirm=$delete_info.no_confirm data=$delete_info.data handler=$delete_info.handler multi_target=$delete_info.multi_target form_target=$delete_info.form_target}
{grn_load_javascript file="grn/html/folder_select.js"}

{include file="grn/footer.tpl"}
