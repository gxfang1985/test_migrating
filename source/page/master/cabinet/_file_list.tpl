{if $page_info.last == "garbage"}{assign var='trashbox' value=1}{/if}
{if ! $page_prefix}
 {assign var="page_prefix" value="cabinet"}
{/if}
{if $page_info.parts[1] == 'system'}
 {assign var="is_system" value="1"}
 {assign var="navi_class" value="contents_navi"}
{else}
 {assign var="is_system" value="0"}
 {assign var="navi_class" value="navi"}
{/if}

<table class="maincontents_list"><tbody><tr><td class="maincontents_list_td">
<table style="width:100%">
<tr valign="top">
<td id="tree_part">
{include file='grn/org_tree_26.tpl'}
{if $page_info.last != "garbage" && !$folder_deleted}
    <script language="javascript">
    <!--
    {literal}
    YAHOO.util.Event.onDOMReady(function(){
    {/literal}
        var trash_url = "{if !$is_system}{grn_pageurl page='cabinet/garbage'}{else}{grn_pageurl page='cabinet/system/garbage'}{/if}";
        var trash_oid = "{$folder_tree.selected_oid|escape:javascript|escape:html}";
        var trash_caption = "{cb_msg module='grn.cabinet' key='garbage'}";
        var tree = obj_folder_tree.getTree();
        var root = tree.getRoot();
    {literal}
        var node_trash = obj_folder_tree.createNode({oid:trash_oid, name:trash_caption, link_url:trash_url, parent:root, count:0, expanded:0});
        tree.draw();
    });
    {/literal}
    -->
    </script>
{/if}
</td>
<td id="view_part" width="90%">

{if $folder.memo|count_words}
<div class="margin_bottom">
{include file='grn/memo.tpl' category_memo=$folder.memo}
</div>
{/if}

{assign var='form_name' value=$smarty.template|basename}

<form name="{$form_name}" method="post" action="{grn_pageurl page=$page_prefix|cat:'/command_'|cat:$page_info.last}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
<input type="hidden" name="hid" value="{$folder_id}">
{if $trashbox !=""}<div class="sub_title" style="margin-right:0%">{cb_msg module='grn.cabinet' key='GRN_CAB-63' replace='true'} <span class="bold">{$trash_period} {cb_msg module='grn.cabinet' key='GRN_CAB-64' replace='true'} </span>{cb_msg module='grn.cabinet' key='GRN_CAB-65' replace='true'}</div>{/if}

{capture name="navi_right"}{include file="grn/smart_data_count_310.tpl" start_num=$navi.start_count end_num=$navi.end_count all_num=$navi.count}{/capture}
{include file="grn/smart_word_navi_310.tpl" navi=$navi.navi navi_right=$smarty.capture.navi_right}
{if !$folder_deleted}
{if $is_system || $folder.auth.write || $folder.privileges.operation}
<div class="list_menu">
{if $is_system || $folder.auth.write || $folder.privileges.operation}
 <span class="list_menu_item">{include file="grn/checkall.tpl" form_name=$form_name elem_name="eid[]"}</span>
{/if}
{if $trashbox==""}
      {if $is_index }
	       <span class="list_menu_item">{capture name='grn_cabinet_GRN_CAB_69'}{cb_msg module='grn.cabinet' key='GRN_CAB-69' replace='true'}{/capture}{grn_button_submit id= 'btn_delete_multi1' caption=$smarty.capture.grn_cabinet_GRN_CAB_69 onclick="return false;"}</span>
	  {else}
	       <span class="list_menu_item">{capture name='grn_cabinet_GRN_CAB_70'}{cb_msg module='grn.cabinet' key='GRN_CAB-70' replace='true'}{/capture}{grn_button_submit id= '' caption=$smarty.capture.grn_cabinet_GRN_CAB_70 onclick="if(!grn_is_checked(this.form,'eid[]')) return false;cmd.value='delete';"}</span>
	  {/if}
  <span class="list_menu_item">{capture name='grn_cabinet_GRN_CAB_71'}{cb_msg module='grn.cabinet' key='GRN_CAB-71' replace='true'}{/capture}{grn_button_submit caption=$smarty.capture.grn_cabinet_GRN_CAB_71 onclick="if(!grn_is_checked(this.form,'eid[]')) return false;cmd.value='move';"}</span>
{else}
  <span class="list_menu_item">{capture name='grn_cabinet_GRN_CAB_72'}{cb_msg module='grn.cabinet' key='GRN_CAB-72' replace='true'}{/capture}{grn_button_submit caption=$smarty.capture.grn_cabinet_GRN_CAB_72 onclick="if(!grn_is_checked(this.form,'eid[]')) return false;cmd.value='restore';"}</span>
  {if $is_system}
    <span class="list_menu_item">{capture name='grn_cabinet_GRN_CAB_73'}{cb_msg module='grn.cabinet' key='GRN_CAB-73' replace='true'}{/capture}{grn_button_submit caption=$smarty.capture.grn_cabinet_GRN_CAB_73 onclick="if(!grn_is_checked(this.form,'eid[]')) return false;cmd.value='force_delete';"}</span>
  {/if}
{/if}
{/if}
</div>
{/if}
</div>
{if $page_info.last != "garbage"}
{include file="star/star_init.tpl" list_id="files_list" use_star=$use_star}
{/if}
<table class="list_column" style="width:100%;" id="files_list">
{foreach from=$files item=file}
 {if $file.locked == 'other'}
  {assign var='lockfiles' value=true}
 {elseif $file.locked == 'login'}
  {assign var='lockfiles' value=true}
 {/if}
{/foreach}
<colgroup>
{if !$folder_deleted}
{if $is_system || $folder.auth.write || $folder.privileges.operation}
<col width="1%">
{/if}
{/if}
{if $page_info.last != "garbage" && $use_star}
  <col width="1%">
{/if}
 <col width="17%">
{if !$folder_deleted}
 <col width="5%">
{/if}
 <col width="20%">
 {if $lockfiles}
 <col width="1%">
 {/if}
 <col width="20%">
 <col width="15%">
 <col width="10%">
</colgroup>
<tr valign="top">
{if !$folder_deleted}
{if $is_system || $folder.auth.write || $folder.privileges.operation}
 <th nowrap></th>
{/if}
{/if}
{if $page_info.last != "garbage" && $use_star}
<th nowrap></th>
{/if}
{if $sort == 'ftu'}
 <th nowrap>{capture name='grn_cabinet_GRN_CAB_74'}{cb_msg module='grn.cabinet' key='GRN_CAB-74' replace='true'}{/capture}{grn_title_sort title=$smarty.capture.grn_cabinet_GRN_CAB_74 page=$page_info.all hid=$folder_id sort='ftd' sp=0 reverse=1}</th>
{else}
 {if $sort == 'ftd'}
 <th nowrap>{capture name='grn_cabinet_GRN_CAB_75'}{cb_msg module='grn.cabinet' key='GRN_CAB-75' replace='true'}{/capture}{grn_title_sort title=$smarty.capture.grn_cabinet_GRN_CAB_75 page=$page_info.all hid=$folder_id sort='ftu' sp=0}</th>
 {else}
 <th nowrap>{capture name='grn_cabinet_GRN_CAB_76'}{cb_msg module='grn.cabinet' key='GRN_CAB-76' replace='true'}{/capture}{grn_title_sort title=$smarty.capture.grn_cabinet_GRN_CAB_76 page=$page_info.all hid=$folder_id sort='ftd' sp=0 disable=1}</th>
 {/if}
{/if}
{if !$folder_deleted}
 <th><br></th>
{/if}
{if $sort == 'fnu'}
 <th nowrap>{capture name='grn_cabinet_GRN_CAB_77'}{cb_msg module='grn.cabinet' key='GRN_CAB-77' replace='true'}{/capture}{grn_title_sort title=$smarty.capture.grn_cabinet_GRN_CAB_77 page=$page_info.all hid=$folder_id sort='fnd' sp=0 reverse=1}</th>
{else}
 {if $sort == 'fnd'}
 <th nowrap>{capture name='grn_cabinet_GRN_CAB_78'}{cb_msg module='grn.cabinet' key='GRN_CAB-78' replace='true'}{/capture}{grn_title_sort title=$smarty.capture.grn_cabinet_GRN_CAB_78 page=$page_info.all hid=$folder_id sort='fnu' sp=0}</th>
 {else}
 <th nowrap>{capture name='grn_cabinet_GRN_CAB_79'}{cb_msg module='grn.cabinet' key='GRN_CAB-79' replace='true'}{/capture}{grn_title_sort title=$smarty.capture.grn_cabinet_GRN_CAB_79 page=$page_info.all hid=$folder_id sort='fnd' sp=0 disable=1}</th>
 {/if}
{/if}

{*
{foreach from=$files item=file}
 {if $file.locked == 'other'}
  {assign var='lockfiles' value=true}
 <th><br></th>
 {elseif $file.locked == 'login'}
  {assign var='lockfiles' value=true}
 <th><br></th>
 {/if}
{/foreach}
*}
 {if $lockfiles}
 <th><br></th>
 {/if}
{if $sort == 'muu'}
 <th nowrap>{capture name='grn_cabinet_GRN_CAB_80'}{cb_msg module='grn.cabinet' key='GRN_CAB-80' replace='true'}{/capture}{grn_title_sort title=$smarty.capture.grn_cabinet_GRN_CAB_80 page=$page_info.all hid=$folder_id sort='mud' sp=0 reverse=1}</th>
{else}
 {if $sort == 'mud'}
 <th nowrap>{capture name='grn_cabinet_GRN_CAB_81'}{cb_msg module='grn.cabinet' key='GRN_CAB-81' replace='true'}{/capture}{grn_title_sort title=$smarty.capture.grn_cabinet_GRN_CAB_81 page=$page_info.all hid=$folder_id sort='muu' sp=0}</th>
 {else}
 <th nowrap>{capture name='grn_cabinet_GRN_CAB_82'}{cb_msg module='grn.cabinet' key='GRN_CAB-82' replace='true'}{/capture}{grn_title_sort title=$smarty.capture.grn_cabinet_GRN_CAB_82 page=$page_info.all hid=$folder_id sort='mud' sp=0 disable=1}</th>
 {/if}
{/if}

{if $sort == 'mtu'}
 <th nowrap>{capture name='grn_cabinet_GRN_CAB_83'}{cb_msg module='grn.cabinet' key='GRN_CAB-83' replace='true'}{/capture}{grn_title_sort title=$smarty.capture.grn_cabinet_GRN_CAB_83 page=$page_info.all hid=$folder_id sort='mtd' sp=0 reverse=1}</th>
{else}
 {if $sort == 'mtd'}
 <th nowrap>{capture name='grn_cabinet_GRN_CAB_84'}{cb_msg module='grn.cabinet' key='GRN_CAB-84' replace='true'}{/capture}{grn_title_sort title=$smarty.capture.grn_cabinet_GRN_CAB_84 page=$page_info.all hid=$folder_id sort='mtu' sp=0}</th>
 {else}
 <th nowrap>{capture name='grn_cabinet_GRN_CAB_85'}{cb_msg module='grn.cabinet' key='GRN_CAB-85' replace='true'}{/capture}{grn_title_sort title=$smarty.capture.grn_cabinet_GRN_CAB_85 page=$page_info.all hid=$folder_id sort='mtd' sp=0 disable=1}</th>
 {/if}
{/if}

{if $sort == 'fsu'}
 <th nowrap>{capture name='grn_cabinet_GRN_CAB_86'}{cb_msg module='grn.cabinet' key='GRN_CAB-86' replace='true'}{/capture}{grn_title_sort title=$smarty.capture.grn_cabinet_GRN_CAB_86 page=$page_info.all hid=$folder_id sort='fsd' sp=0 reverse=1}</th>
{else}
 {if $sort == 'fsd'}
 <th nowrap>{capture name='grn_cabinet_GRN_CAB_87'}{cb_msg module='grn.cabinet' key='GRN_CAB-87' replace='true'}{/capture}{grn_title_sort title=$smarty.capture.grn_cabinet_GRN_CAB_87 page=$page_info.all hid=$folder_id sort='fsu' sp=0}</th>
 {else}
 <th nowrap>{capture name='grn_cabinet_GRN_CAB_88'}{cb_msg module='grn.cabinet' key='GRN_CAB-88' replace='true'}{/capture}{grn_title_sort title=$smarty.capture.grn_cabinet_GRN_CAB_88 page=$page_info.all hid=$folder_id sort='fsd' sp=0 disable=1}</th>
 {/if}
{/if}
</tr>

{foreach from=$files item=file}
<tr class="{cycle values='linetwo,lineone'}" valign="top">
{if !$folder_deleted}
 {if $is_system || $folder.auth.write || $folder.privileges.operation}
  {if $file.locked != 'other'}
 <td nowrap><input type="checkbox" name="eid[]" value="{$file.id}"></td>
  {else}
 <td><br></td>
  {/if}
 {/if}
{/if}
 {if $page_info.last != "garbage" && $use_star}
 <td>
{grn_star_icon module="grn.cabinet" star_infos=$star_infos unique_id=$file.id fid=$file.id hid=$folder_id}
</td>
{/if}
 <td nowrap>
 {if $file.unread == 0}
  {assign var='unread' value=0}
 {else}
  {assign var='unread' value=1}
 {/if}
 {if $trashbox=="" && !$folder_deleted}
    {grn_link page=$page_prefix|cat:'/view' caption=$file.title image='file20.gif' unread=$unread hid=$folder_id fid=$file.id truncated_caption=$config.subject_width}
 {else}
    {grn_link caption=$file.title image='file20.gif' truncated_caption=$config.subject_width disabled=1}
 {/if}
 </td>
{if !$folder_deleted}
 <td nowrap>
   {if $trashbox=="" }
     {capture name='grn_cabinet_GRN_CAB_286'}{cb_msg module='grn.cabinet' key='GRN_CAB-286' replace='true'}{/capture}
     {grn_link page=$page_prefix|cat:'/download' caption='' image='downloadbutton20.gif' hid=$folder_id fid=$file.id postfix=$file.filename alt=$smarty.capture.grn_cabinet_GRN_CAB_286 ticket=$download_ticket}
     {if $file.locked != 'other' && $page_info.parts[1] != 'system' && $flag_update == true}
         <span class="nowrap-grn">
             <a class="" href="javascript:void(0)" onclick="prepare_file_upload('cabinet/lock', {$folder_id}, {$file.id}, 'true');document.forms['cabinet/lock'].submit();">
                 <img src="{$app_path}/grn/image/cybozu/uploadbutton20.gif?{$build_date}" alt="{cb_msg module='grn.cabinet' key='GRN_CAB-89' replace='true'}" title="{cb_msg module='grn.cabinet' key='GRN_CAB-89' replace='true'}" border="0">
             </a>
         </span>
     {/if} 
   {/if}
 </td>
{/if}
 <td nowrap>
   {$file.filename|escape}
 </td>
 {if $file.locked == 'other'}
 <td nowrap>{grn_user_name uid=$file.locked_owner_uid name=$file.locked_owner_name users_info=$users_info}{cb_msg module='grn.cabinet' key='GRN_CAB-91' replace='true'}</td>
 {elseif $file.locked == 'login'}
 <td nowrap>{grn_user_name uid=$login.id name=$login.name users_info=$users_info}{cb_msg module='grn.cabinet' key='GRN_CAB-92' replace='true'}</td>
 {elseif $lockfiles}
 <td>&nbsp;</td>
 {/if}
 <td nowrap>
 {grn_user_name uid=$file.modifier_uid name=$file.modifier_name truncated=$config.name_width users_info=$users_info}
 </td>
 <td nowrap>{grn_date_format date=$file.mtime format="DateTimeCompact"}</td>
 <td nowrap>{grn_format_filesize size=$file.size unit="KB" round='ceil'}</td>
</tr>
{/foreach}
</table>
{if !$folder_deleted}
{if $is_system || $folder.auth.write || $folder.privileges.operation}
<div class="list_menu"><nobr>
 <span class="list_menu_item">{include file="grn/checkall.tpl" form_name=$form_name elem_name="eid[]"}</span>
{if $trashbox==""}
      { if $is_index }
	       {capture name='grn_cabinet_GRN_CAB_93'}{cb_msg module='grn.cabinet' key='GRN_CAB-93' replace='true'}{/capture}{grn_button_submit id= 'btn_delete_multi2' caption=$smarty.capture.grn_cabinet_GRN_CAB_93 onclick="return false;"}&nbsp;
	  {else}
	       {capture name='grn_cabinet_GRN_CAB_94'}{cb_msg module='grn.cabinet' key='GRN_CAB-94' replace='true'}{/capture}{grn_button_submit id= '' caption=$smarty.capture.grn_cabinet_GRN_CAB_94 onclick="if(!grn_is_checked(this.form,'eid[]')) return false;cmd.value='delete';"}&nbsp;
	  {/if}
  {capture name='grn_cabinet_GRN_CAB_95'}{cb_msg module='grn.cabinet' key='GRN_CAB-95' replace='true'}{/capture}{grn_button_submit caption=$smarty.capture.grn_cabinet_GRN_CAB_95 onclick="if(!grn_is_checked(this.form,'eid[]')) return false;cmd.value='move';"}
{else}
  {capture name='grn_cabinet_GRN_CAB_96'}{cb_msg module='grn.cabinet' key='GRN_CAB-96' replace='true'}{/capture}{grn_button_submit caption=$smarty.capture.grn_cabinet_GRN_CAB_96 onclick="if(!grn_is_checked(this.form,'eid[]')) return false;cmd.value='restore';"}&nbsp;
  {if $is_system}
    {capture name='grn_cabinet_GRN_CAB_97'}{cb_msg module='grn.cabinet' key='GRN_CAB-97' replace='true'}{/capture}{grn_button_submit caption=$smarty.capture.grn_cabinet_GRN_CAB_97 onclick="if(!grn_is_checked(this.form,'eid[]')) return false;cmd.value='force_delete';"}
  {/if}
{/if}
{/if}
<nobr></div>
{/if}
<div class="{$navi_class}"><nobr>{include file="grn/word_navi.tpl" navi=$navi.navi}</nobr></div>

<input type="hidden" name="cmd">
</form>
{include file="cabinet/lock.tpl" index_return=true csrf_ticket=$csrf_ticket only_form=true}
 <!----->
 </td>
</tr>
</table>
</td></tr></tbody></table><!--end of maincontents_list-->

{capture name='grn_cabinet_GRN_CAB_98'}{cb_msg module='grn.cabinet' key='GRN_CAB-98' replace='true'}{/capture}
 {literal}
    <script type="text/javascript">
        function prepare_upload(form_name, folder_id, file_upload_id)
        {
            form_upload = document.forms[form_name];
            form_upload.action = "command_lock";
            form_upload.appendChild( new Element("input", {type: "hidden", name: "fid", value: file_upload_id}) );
            form_upload.appendChild( new Element("input", 
            {type: "hidden", name: "upload", value: "{/literal}{$smarty.capture.grn_cabinet_GRN_CAB_98}{literal}"}
            ) );
            form_upload.appendChild( new Element("input", {type: "hidden", name: "index_return", value: "true"}) );
            form_upload['hid'].value = folder_id;
        }
        function prepare_file_upload(form_name, folder_id, file_upload_id, index_return)
        {
            form_upload = document.forms[form_name];
            form_upload['fid'].value = file_upload_id;
            form_upload['hid'].value = folder_id;
            form_upload['index_return'].value = index_return;
        }
    </script>
    {/literal}
