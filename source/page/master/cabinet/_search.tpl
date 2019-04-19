{if $page_info.parts[1] == 'system'}
 {assign var="page_prefix" value="cabinet/system"}
 {assign var="index_page" value="cabinet/system/folder_list"}
 {assign var="is_system" value="1"}
 {assign var="navi_class" value="contents_navi"}
{else}
 {assign var="page_prefix" value="cabinet"}
 {assign var="index_page" value="cabinet/index"}
 {assign var="is_system" value="0"}
 {assign var="navi_class" value="navi"}
{/if}

 <table class="std_form">
  <tr>
   <th>{cb_msg module='grn.cabinet' key='GRN_CAB-105' replace='true'}</th>
   <td>
    {grn_text necessary=true name="text" value=$search_text size="50"}
    <input type="submit" name="Search" value="{cb_msg module='grn.cabinet' key='GRN_CAB-106' replace='true'}"><br>
   </td>
  </tr>
  <tr>
   <th>{cb_msg module='grn.cabinet' key='GRN_CAB-107' replace='true'}</th>
   <td>
{if $folder.id}
    {if 'all' == $target_folder}
    {grn_radio name="target_folder" id="select" value="select" caption=$folder.title}{cb_msg module='grn.cabinet' key='GRN_CAB-108' replace='true'}{capture name='grn_cabinet_GRN_CAB_109'}{cb_msg module='grn.cabinet' key='GRN_CAB-109' replace='true'}{/capture}{grn_radio name="target_folder" id="all" value="all" caption=$smarty.capture.grn_cabinet_GRN_CAB_109 checked=TRUE}
    {else}
    {grn_radio name="target_folder" id="select" value="select" caption=$folder.title checked=TRUE}{cb_msg module='grn.cabinet' key='GRN_CAB-110' replace='true'}{capture name='grn_cabinet_GRN_CAB_111'}{cb_msg module='grn.cabinet' key='GRN_CAB-111' replace='true'}{/capture}{grn_radio name="target_folder" id="all" value="all" caption=$smarty.capture.grn_cabinet_GRN_CAB_111}
    {/if}
{else}
    {cb_msg module='grn.cabinet' key='GRN_CAB-112' replace='true'}
{/if}
   </td>
  </tr>
  <tr>
   <th>{cb_msg module='grn.cabinet' key='GRN_CAB-113' replace='true'}</th>
   <td>{capture name='grn_cabinet_GRN_CAB_114'}{cb_msg module='grn.cabinet' key='GRN_CAB-114' replace='true'}{/capture}{grn_checkbox name="search_keys[]" id="sub" value="sub" checked=$search_keys.sub caption=$smarty.capture.grn_cabinet_GRN_CAB_114}</td>
  </tr>
  <tr>
   <th>{cb_msg module='grn.cabinet' key='GRN_CAB-115' replace='true'}</th>
   <td>
    <select name="search_term">
     <option value="1"{if 1 == $search_term} selected{/if}>{cb_msg module='grn.cabinet' key='GRN_CAB-116' replace='true'}
     <option value="3"{if 3 == $search_term} selected{/if}>{cb_msg module='grn.cabinet' key='GRN_CAB-118' replace='true'}
     <option value="6"{if 6 == $search_term} selected{/if}>{cb_msg module='grn.cabinet' key='GRN_CAB-120' replace='true'}
     <option value="12"{if 12 == $search_term} selected{/if}>{cb_msg module='grn.cabinet' key='GRN_CAB-122' replace='true'}
     <option value="-1"{if -1 == $search_term} selected{/if}>{cb_msg module='grn.cabinet' key='GRN_CAB-124' replace='true'}
    </select>
   </td>
  </tr>
  <tr>
   <th>{cb_msg module='grn.cabinet' key='GRN_CAB-125' replace='true'}</div>
   <td>
    {capture name='grn_cabinet_GRN_CAB_126'}{cb_msg module='grn.cabinet' key='GRN_CAB-126' replace='true'}{/capture}{grn_checkbox name="search_keys[]" id="folder_name" value="folder_name" checked=$search_keys.folder_name caption=$smarty.capture.grn_cabinet_GRN_CAB_126}
    {capture name='grn_cabinet_GRN_CAB_127'}{cb_msg module='grn.cabinet' key='GRN_CAB-127' replace='true'}{/capture}{grn_checkbox name="search_keys[]" id="file_name" value="file_name" checked=$search_keys.file_name caption=$smarty.capture.grn_cabinet_GRN_CAB_127}
    {capture name='grn_cabinet_GRN_CAB_128'}{cb_msg module='grn.cabinet' key='GRN_CAB-128' replace='true'}{/capture}{grn_checkbox name="search_keys[]" id="title" value="title" checked=$search_keys.title caption=$smarty.capture.grn_cabinet_GRN_CAB_128}
    {capture name='grn_cabinet_GRN_CAB_129'}{cb_msg module='grn.cabinet' key='GRN_CAB-129' replace='true'}{/capture}{grn_checkbox name="search_keys[]" id="description" value="description" checked=$search_keys.description caption=$smarty.capture.grn_cabinet_GRN_CAB_129}
    {capture name='grn_cabinet_GRN_CAB_130'}{cb_msg module='grn.cabinet' key='GRN_CAB-130' replace='true'}{/capture}{grn_checkbox name="search_keys[]" id="creator" value="creator" checked=$search_keys.creator caption=$smarty.capture.grn_cabinet_GRN_CAB_130}
    {capture name='grn_cabinet_GRN_CAB_131'}{cb_msg module='grn.cabinet' key='GRN_CAB-131' replace='true'}{/capture}{grn_checkbox name="search_keys[]" id="modifier" value="modifier" checked=$search_keys.modifier caption=$smarty.capture.grn_cabinet_GRN_CAB_131}
   </td>
  </tr>
  <tr>
   <td></td>
   <td>
       <div class="mTop10">
           {capture name='grn_cabinet_GRN_CAB_132'}{cb_msg module='grn.cabinet' key='GRN_CAB-132' replace='true'}{/capture}
           {grn_button id="cabinet_button_search" ui='main' action='submit' caption=$smarty.capture.grn_cabinet_GRN_CAB_132}
       </div>
   </td>
  </tr>
 </table>

<table class="maincontents_list"><tbody><tr><td class="maincontents_list_td">
{if $search_keys.folder_name}
 <p>
 <div class="sub_title">{cb_msg module='grn.cabinet' key='GRN_CAB-133' replace='true'} {include file="grn/smart_data_count.tpl" start_num=$search_folder.view_set.start_count end_num=$search_folder.view_set.end_count all_num=$search_folder.view_set.count}</div>
 <div class="{$navi_class}"><nobr>{include file="cabinet/_folder_navi.tpl" navi=$search_folder.view_set.navi sp=$view_set.start_count}</nobr></div>
 <table class="list_column">
  <colgroup>
   <col width="30%">
   <col width="70%">
  </colgroup>
  <tr>
   <th nowrap>{cb_msg module='grn.cabinet' key='GRN_CAB-136' replace='true'}</th>
   <th nowrap>{cb_msg module='grn.cabinet' key='GRN_CAB-137' replace='true'}</th>
  </tr>
{foreach from=$search_folder.search_item item=search_item}
  <tr class="{cycle values='linetwo,lineone'}">
   <td nowrap>
    {grn_link page=$index_page caption=$search_item.foldername image='folder20.gif' hid=$search_item.folder_id}
   </td>
   <td nowrap>{grn_image image='folder20.gif'}{$search_item.path|escape}</td>
  </tr>
{/foreach}
 </table>
 <div class="{$navi_class}"><nobr>{include file="cabinet/_folder_navi.tpl" navi=$search_folder.view_set.navi sp=$view_set.start_count}</nobr></div>
{/if}

 <p>
 <div class="sub_title">{cb_msg module='grn.cabinet' key='GRN_CAB-138' replace='true'} {include file="grn/smart_data_count.tpl" start_num=$view_set.start_count end_num=$view_set.end_count all_num=$view_set.count}</div>
 <div class="{$navi_class}"><nobr>{include file="cabinet/_file_navi.tpl" navi=$view_set.navi sp=$search_folder.view_set.start_count}</nobr></div>
 <table class="list_column">
  <colgroup>
   <col width="20%">
   <col width="20%">
   <col width="20%">
   <col width="20%">
   <col width="20%">
  </colgroup>
  <tr>
   <th nowrap>{cb_msg module='grn.cabinet' key='GRN_CAB-141' replace='true'}</th>
   <th nowrap>{cb_msg module='grn.cabinet' key='GRN_CAB-142' replace='true'}</th>
   <th nowrap>{cb_msg module='grn.cabinet' key='GRN_CAB-143' replace='true'}</th>
   <th nowrap>{cb_msg module='grn.cabinet' key='GRN_CAB-144' replace='true'}</th>
   <th nowrap>{cb_msg module='grn.cabinet' key='GRN_CAB-145' replace='true'}</th>
  </tr>
{foreach from=$search.search_item item=search_item}
  <tr class="{cycle values='linetwo,lineone'}">
   <td nowrap>
    {grn_link page=$index_page caption=$search_item.foldername image='folder20.gif' unread=$file.unread hid=$search_item.folder_id}
   </td>
   <td nowrap>
 {if $search_item.filename}
    {if $search_item.enable_link}
        {grn_link page=$page_prefix|cat:'/download' caption=$search_item.filename image='disk20.gif' hid=$search_item.folder_id fid=$search_item.file_id postfix=$search_item.filename ticket=$download_ticket}
    {else}
        {grn_link page=$page_prefix|cat:'/download' caption=$search_item.filename image='disk20.gif' hid=$search_item.folder_id fid=$search_item.file_id postfix=$search_item.filename ticket=$download_ticket disabled=1}
    {/if}
 {/if}
   </td>
   <td nowrap>
 {if $search_item.title}
    {if $search_item.enable_link}
        {grn_link page=$page_prefix|cat:'/view' caption=$search_item.title image='file20.gif' unread=$file.unread hid=$search_item.folder_id fid=$search_item.file_id truncated_caption=$config.subject_width}
    {else}
        {grn_link page=$page_prefix|cat:'/view' caption=$search_item.title image='file20.gif' unread=$file.unread hid=$search_item.folder_id fid=$search_item.file_id truncated_caption=$config.subject_width disabled=1}
    {/if}
 {elseif $search_item.filename}
    {if $search_item.enable_link}
        {grn_link page=$page_prefix|cat:'/view' caption=$search_item.filename image='file20.gif' unread=$file.unread hid=$search_item.folder_id fid=$search_item.file_id truncated_caption=$config.subject_width}
    {else}
        {grn_link page=$page_prefix|cat:'/view' caption=$search_item.filename image='file20.gif' unread=$file.unread hid=$search_item.folder_id fid=$search_item.file_id truncated_caption=$config.subject_width disabled=1}
    {/if}
 {/if}
   </td>
   <td nowrap>
    {grn_user_name uid=$search_item.modifier_uid name=$search_item.modifier_name users_info=$users_info truncated=$config.name_width}
   </td>
   <td nowrap>
     {if $search_item.date }
     {grn_date_format date=$search_item.date format="DateTimeCompact"}
     {/if}
   </td>
  </tr>
{/foreach}
 </table>
 <div class="{$navi_class}"><nobr>{include file="cabinet/_file_navi.tpl" navi=$view_set.navi sp=$search_folder.view_set.start_count}</nobr></div>
</td></tr></tbody></table><!--end of maincontents_list-->

 <input type="hidden" name="optional_search" value="1">
 <input type="hidden" name="fn" value="{$folder.title}">
 <input type="hidden" name="hid" value="{$folder.id}">

