<!--delete-->
{grn_delete title=$delete_all_info.title page=$delete_all_info.page no_confirm=$delete_all_info.no_confirm data=$delete_all_info.data handler=$delete_all_info.handler}
{grn_delete title=$delete_multi_info.title page=$delete_multi_info.page no_confirm=$delete_multi_info.no_confirm data=$delete_multi_info.data handler=$delete_multi_info.handler multi_target=$delete_multi_info.multi_target form_target=$delete_multi_info.form_target before_delete=$delete_multi_info.before_delete}
<!--delete-->
<form name="{$form_name}" method="post" action="{grn_pageurl page='message/search'}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
 <p>
 <table class="std_form">
  <tr>
   <th>{cb_msg module='grn.message' key='GRN_MSG-163' replace='true'}</th>
   <td>
    {grn_text necessary=true name='search_text' value=$search_text size='50'}
    {capture name='grn_message_GRN_MSG_164'}{cb_msg module='grn.message' key='GRN_MSG-164' replace='true'}{/capture}{grn_button_submit caption=$smarty.capture.grn_message_GRN_MSG_164}
   </td>
  </tr>
  <tr>
   <th>{cb_msg module='grn.message' key='GRN_MSG-165' replace='true'}</th>
   <td>{capture name='grn_message_GRN_MSG_166'}{cb_msg module='grn.message' key='GRN_MSG-166' replace='true'}{/capture}{grn_message_select_folders select_name='tcid' selected_folder_id=$target_id hide_root_folder='0' hide_garbage_folder=$hide_garbage root_caption=$smarty.capture.grn_message_GRN_MSG_166}</td>
  </tr>
  <tr>
   <th>{cb_msg module='grn.message' key='GRN_MSG-167' replace='true'}</th>
   <td>{capture name='grn_message_GRN_MSG_168'}{cb_msg module='grn.message' key='GRN_MSG-168' replace='true'}{/capture}{grn_checkbox name='search_keys[]' id='sub' value='sub' checked=$search_keys.sub caption=$smarty.capture.grn_message_GRN_MSG_168}</td>
  </tr>
  <tr>
   <th>{cb_msg module='grn.message' key='GRN_MSG-169' replace='true'}</th>
   <td>
    <select name="search_term">
     <option value="1"{if 1 == $search_term} selected{/if}>{cb_msg module='grn.message' key='GRN_MSG-170' replace='true'}
     <option value="3"{if 3 == $search_term} selected{/if}>{cb_msg module='grn.message' key='GRN_MSG-172' replace='true'}
     <option value="6"{if 6 == $search_term} selected{/if}>{cb_msg module='grn.message' key='GRN_MSG-174' replace='true'}
     <option value="12"{if 12 == $search_term} selected{/if}>{cb_msg module='grn.message' key='GRN_MSG-176' replace='true'}
     <option value="-1"{if -1 == $search_term} selected{/if}>{cb_msg module='grn.message' key='GRN_MSG-178' replace='true'}
    </select>
   </td>
  </tr>
  <tr>
   <th>{cb_msg module='grn.message' key='GRN_MSG-179' replace='true'}</th>
   <td>
    {capture name='grn_message_GRN_MSG_180'}{cb_msg module='grn.message' key='GRN_MSG-180' replace='true'}{/capture}{grn_checkbox name='search_keys[]' id='subject' value='subject' checked=$search_keys.subject caption=$smarty.capture.grn_message_GRN_MSG_180}
    {capture name='grn_message_GRN_MSG_181'}{cb_msg module='grn.message' key='GRN_MSG-181' replace='true'}{/capture}{grn_checkbox name='search_keys[]' id='data' value='data' checked=$search_keys.data caption=$smarty.capture.grn_message_GRN_MSG_181}
    {capture name='grn_message_GRN_MSG_182'}{cb_msg module='grn.message' key='GRN_MSG-182' replace='true'}{/capture}{grn_checkbox name='search_keys[]' id='sender' value='sender' checked=$search_keys.sender caption=$smarty.capture.grn_message_GRN_MSG_182}
    {capture name='grn_message_GRN_MSG_183'}{cb_msg module='grn.message' key='GRN_MSG-183' replace='true'}{/capture}{grn_checkbox name='search_keys[]' id='addressee' value='addressee' checked=$search_keys.addressee caption=$smarty.capture.grn_message_GRN_MSG_183}
    {capture name='grn_message_GRN_MSG_184'}{cb_msg module='grn' key='grn.comment' replace='true'}{/capture}{grn_checkbox name='search_keys[]' id='follow' value='follow' checked=$search_keys.follow caption=$smarty.capture.grn_message_GRN_MSG_184}
   </td>
  </tr>
  <tr>
   <td></td>
   <td>{capture name='grn_message_GRN_MSG_185'}{cb_msg module='grn.message' key='GRN_MSG-185' replace='true'}{/capture}{grn_button_submit class='margin' caption=$smarty.capture.grn_message_GRN_MSG_185}</td>
  </tr>
 </table>
 <input type="hidden" name="optional_search" value="1">
 <input type="hidden" name="dcid" value="{$folder.id}">
</form>

<table class="maincontents_list"><tbody><tr><td class="maincontents_list_td">
<form name="{$form_name|cat:'_cmd'}" method="post" action="{grn_pageurl page='message/command_search'}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
 <p>
 <div class="sub_title">{cb_msg module='grn.message' key='GRN_MSG-186' replace='true'} {include file="grn/smart_data_count.tpl" start_num=$navi.start_count end_num=$navi.end_count all_num=$navi.count}</div>
 <div class="navi"><nobr>{include file='grn/word_navi.tpl' navi=$navi.navi}</nobr></div>
 <div class="list_menu"><nobr>
 {include file='grn/checkall.tpl' form_name=$form_name|cat:'_cmd' elem_name="ids[]"}
 <span class="list_menu_item">{capture name='grn_message_GRN_MSG_194'}{cb_msg module='grn.message' key='GRN_MSG-194' replace='true'}{/capture}{grn_button_submit id="btn_delete_multi1" caption=$smarty.capture.grn_message_GRN_MSG_194 onclick="return false;"}</span>
 <span class="list_menu_item">{capture name='grn_message_GRN_MSG_404'}{cb_msg module='grn.message' key='GRN_MSG-404' replace='true'}{/capture}{grn_message_select_folders select_name='dcid' select_id='dcid1' hide_root_folder='1' hide_garbage_folder='1' exception_value="-1" exception_item=$smarty.capture.grn_message_GRN_MSG_404 onchange="onChangeFolderSelect(this, 'dcid2', ['moveto', 'moveto2']);"}{capture name='grn_message_GRN_MSG_195'}{cb_msg module='grn.message' key='GRN_MSG-195' replace='true'}{/capture}{grn_button_submit caption=$smarty.capture.grn_message_GRN_MSG_195 id='moveto' onclick="if( ! grn_is_checked( this.form, 'ids[]' ) ) return false;cmd.value='move';" disabled=true}</span></nobr></div>
 <table class="list_column">
  <colgroup>
   <col width="1%">
   <col width="25%">
   <col width="22%">
   <col width="22%">
   <col width="18%">
   <col width="12%">
  </colgroup>
  <tr>
   <th nowrap>&nbsp;</th>
   <th nowrap>{cb_msg module='grn.message' key='GRN_MSG-189' replace='true'}</th>
   <th nowrap>{cb_msg module='grn.message' key='GRN_MSG-190' replace='true'}</th>
   <th nowrap>{cb_msg module='grn' key='grn.comment' replace='true'}</th>
   <th nowrap>{cb_msg module='grn.message' key='GRN_MSG-192' replace='true'}</th>
   <th nowrap>{cb_msg module='grn.message' key='GRN_MSG-193' replace='true'}</th>
  </tr>
{foreach from=$search.search_item item=search_item}
  <tr {if $search_item.unread && $search_item.type eq '0'}class="unread_color"{/if}>
   <td nowrap><input type="checkbox" name="ids[]" value="{$search_item.rid},{$search_item.mid},{$search_item.is_sender},{$search_item.cid},{$search_item.type}"></td>
   <td nowrap>
     {if $search_item.type eq '2'}
       {* draft file *}
       {if $search_item.attached}
        {grn_link page='message/draft_view' caption=$search_item.subject truncated_caption=$subject_cols image='draft_clip30x20.gif' cid=$search_item.cid rid=$search_item.rid mid=$search_item.mid}
       {else}
        {grn_link page='message/draft_view' caption=$search_item.subject truncated_caption=$subject_cols image='draft20.gif' cid=$search_item.cid rid=$search_item.rid mid=$search_item.mid}
       {/if}
     {elseif $search_item.type eq '1'}
       {if $search_item.attached}
         {if $search_item.update}
          {grn_link page='message/view' caption=$search_item.subject truncated_caption=$subject_cols image='msg20_su_clip8.gif' cid=$search_item.cid rid=$search_item.rid mid=$search_item.mid unread=0}
         {else}
          {grn_link page='message/view' caption=$search_item.subject truncated_caption=$subject_cols image='msg20_s_clip8.gif' cid=$search_item.cid rid=$search_item.rid mid=$search_item.mid unread=0}
         {/if}
       {else}
         {if $search_item.update}
          {grn_link page='message/view' caption=$search_item.subject truncated_caption=$subject_cols image='msg20_su.gif' cid=$search_item.cid rid=$search_item.rid mid=$search_item.mid unread=0}
         {else}
          {grn_link page='message/view' caption=$search_item.subject truncated_caption=$subject_cols image='msg20_s.gif' cid=$search_item.cid rid=$search_item.rid mid=$search_item.mid unread=0}
         {/if}
       {/if}
     {else}
       {if $search_item.attached}
         {if $search_item.update}
          {grn_link page='message/view' caption=$search_item.subject truncated_caption=$subject_cols image='msg20_u_clip8.gif' cid=$search_item.cid rid=$search_item.rid mid=$search_item.mid unread=$search_item.unread}
         {else}
          {grn_link page='message/view' caption=$search_item.subject truncated_caption=$subject_cols image='msg20_clip8.gif' cid=$search_item.cid rid=$search_item.rid mid=$search_item.mid unread=$search_item.unread}
         {/if}
       {else}
         {if $search_item.update}
          {grn_link page='message/view' caption=$search_item.subject truncated_caption=$subject_cols image='msg20_u.gif' cid=$search_item.cid rid=$search_item.rid mid=$search_item.mid unread=$search_item.unread }
         {else}
          {grn_link page='message/view' caption=$search_item.subject truncated_caption=$subject_cols image='msg20.gif' cid=$search_item.cid rid=$search_item.rid mid=$search_item.mid unread=$search_item.unread }
         {/if}
       {/if}
     {/if}
   </td>
   <td nowrap>
     {if !$search_item.fid}
       {$search_item.data|escape:"html"|cb_mb_truncate:$truncate_cols}
     {/if}
   </td>
   <td nowrap>
     {if $search_item.fid}
     {grn_link page='message/view' caption=$search_item.follow truncated_caption=$truncate_cols class='' cid=$search_item.cid rid=$search_item.rid mid=$search_item.mid follow_id=$search_item.follow_id fragment='follow' unread=$search_item.unread}
     {/if}
   </td>
     {if $search_item.fid}
    <td nowrap>{grn_user_name uid=$search_item.follower_uid name=$search_item.follower_name users_info=$users_info truncated=$name_cols}</td>
     {else}
    <td nowrap>{grn_user_name uid=$search_item.creator_uid name=$search_item.creator_name users_info=$users_info truncated=$name_cols}</td>
     {/if}
   <td nowrap>{grn_date_format date=$search_item.mtime}</td>
  </tr>
{/foreach}
 </table>
 <div class="list_menu"><nobr>
 {include file='grn/checkall.tpl' form_name=$form_name|cat:'_cmd' elem_name="ids[]"}
 <span class="list_menu_item">{capture name='grn_message_GRN_MSG_194'}{cb_msg module='grn.message' key='GRN_MSG-194' replace='true'}{/capture}{grn_button_submit id="btn_delete_multi2" caption=$smarty.capture.grn_message_GRN_MSG_194 onclick="return false;"}</span>
 <span class="list_menu_item">{grn_message_select_folders select_name='dcid' select_id='dcid2' selected_folder_id="-1" hide_root_folder='1' hide_garbage_folder='1' exception_value="-1" exception_item=$smarty.capture.grn_message_GRN_MSG_404 onchange="onChangeFolderSelect(this, 'dcid1', ['moveto', 'moveto2']);"}{capture name='grn_message_GRN_MSG_195'}{cb_msg module='grn.message' key='GRN_MSG-195' replace='true'}{/capture}{grn_button_submit caption=$smarty.capture.grn_message_GRN_MSG_195 id='moveto2' onclick="if( ! grn_is_checked( this.form, 'ids[]' ) ) return false;cmd.value='move';" disabled=true}</span></nobr></div>
 <div class="navi"><nobr>{include file='grn/word_navi.tpl' navi=$navi.navi}</nobr></div>
 <input type="hidden" name="cid" value="{$folder.id}">
 <input type="hidden" name="cmd">
</form>
</td></tr></tbody></table><!--end of maincontents-->

{literal}
<script type="text/javascript">
function on_before_show_popup(form)
{
    //get create message
    var checks = jQuery(form).find("input[name='ids[]']");
    var count = 0;
    checks.each(function(idx,elm){
        var temp = elm.value.split(",");
        if( ( temp[2] == "1" ) && ( temp[4] !="2" ) ){/literal}{* is_sender=true and not draft *}{literal}
        {
            count++;
        }
    });
    var span_create_message = jQuery(form).find("span.create_message_count").get(0);
    if(span_create_message){
        span_create_message.innerHTML = count;
    }
    //not show popup
    if( count == 0)
    {
        var div_create_message = jQuery(form).find("div.create_message").eq(0);
        if(div_create_message.length > 0){
            div_create_message.hide();
        }
        return false;
    }
    else //show popup
    {
        return true;
    }
}
</script>
{/literal}
{grn_load_javascript file="grn/html/folder_select.js"}
