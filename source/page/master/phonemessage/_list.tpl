{capture name="navi_right"}{include file="grn/smart_data_count_310.tpl" start_num=$view_set.start_count end_num=$view_set.end_count all_num=$view_set.count}{/capture}
{include file="grn/smart_word_navi_310.tpl" navi=$view_set.navi navi_right=$smarty.capture.navi_right}

{if ! $search_page}
    <div class="list_menu"><nobr>
      {if $popup_confirm_delete}
           {grn_delete title=$delete_info_multi.title page=$delete_info_multi.page no_confirm=$delete_info_multi.no_confirm data=$delete_info_multi.data handler=$delete_info_multi.handler multi_target=$delete_info_multi.multi_target form_target=$delete_info_multi.form_target}
           <span class="list_menu_item">{include file="grn/checkall.tpl" elem_name="mids[]"}</span>
           <span class="list_menu_item">{capture name='grn_phonemessage_GRN_PHM_16'}{cb_msg module='grn.phonemessage' key='GRN_PHM-16' replace='true'}{/capture}{grn_button_submit caption=$smarty.capture.grn_phonemessage_GRN_PHM_16 onclick="return false;" id="btn_delete_multi1"}</span>
      {else}
           <span class="list_menu_item">{include file="grn/checkall.tpl" elem_name="mids[]"}</span>
<span class="list_menu_item">{capture name='grn_phonemessage_GRN_PHM_19'}{cb_msg module='grn.phonemessage' key='GRN_PHM-19' replace='true'}{/capture}{grn_button_submit caption=$smarty.capture.grn_phonemessage_GRN_PHM_19 onclick="if(!grn_is_checked(this.form,'mids[]')) return false;"}
</span>
      {/if}
</nobr></div>
{/if}

  
  <table class="list_column">
   <colgroup>
    <col width="1%">
    <col width="17%">
    <col width="13%">
    <col width="40%">
    <col width="20%">
   </colgroup>
   <tr>

    <th nowrap>&nbsp;</th>
    <th nowrap>{cb_msg module='grn.phonemessage' key='GRN_PHM-1' replace='true'}</th>
    <th nowrap>{cb_msg module='grn.phonemessage' key='GRN_PHM-2' replace='true'}</th>
    <th nowrap>{cb_msg module='grn.phonemessage' key='GRN_PHM-3' replace='true'}</th>
    <th nowrap>
{if $category_id == 'sent'}
    {cb_msg module='grn.phonemessage' key='GRN_PHM-4' replace='true'}
{else}
    {cb_msg module='grn.phonemessage' key='GRN_PHM-5' replace='true'}
{/if}
    </th>
   </tr>
{foreach from=$messages key=message_id item=message name="message_loop"}
    <tr class="{if $smarty.foreach.message_loop.iteration % 2 == 0}lineone{else}linetwo{/if}">
    <td nowrap>
    {* ログインユーザーが送信者、受信者なら削除できる *}
    {* 確認済みのメモは送信者は削除できない *}
    {if ! $search_page && ( ( ! $message.confirm_time && $login.id == $message.sender ) || $login.id == $message.receiver )}
     {grn_checkbox name='mids[]' id="mid_`$message_id`" value=$message_id}
    {else}
     &nbsp;
    {/if}
    </td>
    <td nowrap>{grn_date_format date=$message.send_time format='DateShort_MDW'}&nbsp;{grn_date_format date=$message.send_time format='TimeShort_HM'}</td>
    <td nowrap>
    {if $message.confirm_time}
     {cb_msg module='grn.phonemessage' key='GRN_PHM-6' replace='true'}<br>{cb_msg module='grn.phonemessage' key='GRN_PHM-7' replace='true'}{grn_date_format date=$message.confirm_time format='DateTimeCompact'}{cb_msg module='grn.phonemessage' key='GRN_PHM-8' replace='true'}
    {else}
        {* ログインユーザー以外の電話メモ履歴画面、送信一覧では確認ボタンを表示しない *}
        {if $login.id != $user_id || $category_id == 'sent' || $search_page}
     {cb_msg module='grn.phonemessage' key='GRN_PHM-9' replace='true'}
        {else}
     {capture name='page_path'}{grn_pageurl page='phonemessage/command_confirm'}{/capture}
     {assign var='page_path' value=$smarty.capture.page_path}
     <input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
     {capture name='grn_phonemessage_GRN_PHM_10'}{cb_msg module='grn.phonemessage' key='GRN_PHM-10' replace='true'}{/capture}{grn_button_submit caption=$smarty.capture.grn_phonemessage_GRN_PHM_10 onclick="form.action='$page_path';this.form.mid.value=`$message_id`;"}
        {/if}
    {/if}
    </td>
    <td>
    {if 0 < strlen( $message.client_name )}
     <b>{$message.client_name|escape}</b> {cb_msg module='grn.phonemessage' key='GRN_PHM-11' replace='true'}<br>
    {/if}
     {$message.matter}
    {if 0 < strlen( $message.telephone_number )}
     {cb_msg module='grn.phonemessage' key='GRN_PHM-12' replace='true'}<b>{$message.telephone_number|escape}</b>
    {/if}
     <br>
    {if 0 < strlen( $message.message )}
     {cb_msg module='grn.phonemessage' key='GRN_PHM-13' replace='true'}{grn_format body= $message.message}
    {/if}
    </td>
    {if $category_id == 'sent'}
    <td>{grn_user_name uid=$message.receiver name=$message.receiver_name users_info=$users_info}</td>
    {else}
    <td>{grn_user_name uid=$message.sender name=$message.sender_name users_info=$users_info}</td>
    {/if}
   </tr>
{/foreach}
  </table>
  
    {capture name="navi_right"}{include file="grn/smart_data_count_310.tpl" start_num=$view_set.start_count end_num=$view_set.end_count all_num=$view_set.count}{/capture}
    
{if ! $search_page}
           <div class="list_menu"><nobr>
      {if $popup_confirm_delete}
               <span class="list_menu_item">{include file="grn/checkall.tpl" elem_name="mids[]"}</span>
           <span class="list_menu_item">{capture name='grn_phonemessage_GRN_PHM_16'}{cb_msg module='grn.phonemessage' key='GRN_PHM-16' replace='true'}{/capture}{grn_button_submit caption=$smarty.capture.grn_phonemessage_GRN_PHM_16 onclick="return false;" id="btn_delete_multi2"}</span>
      {else}
               <span class="list_menu_item">{include file="grn/checkall.tpl" elem_name="mids[]"}</span>
<span class="list_menu_item">{capture name='grn_phonemessage_GRN_PHM_19'}{cb_msg module='grn.phonemessage' key='GRN_PHM-19' replace='true'}{/capture}{grn_button_submit caption=$smarty.capture.grn_phonemessage_GRN_PHM_19 onclick="if(!grn_is_checked(this.form,'mids[]')) return false;"}</span>
      {/if}
</nobr></div>
{/if}