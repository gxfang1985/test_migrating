{if ! $data_theme}{assign var='data_theme' value='c'}{/if}
{assign var='message_prefix' value='message/mobile'}
{if ! $file_dpage}{assign var='file_dpage' value='message/mobile/file_download'}{/if}

<div data-role="content" data-theme="{$data_theme}" class="mobile-content-padding-grn">
  {include file="grn/mobile_breadcrumb.tpl" not_need_withList=true}

  <ul data-role="none" class="mobile-ul-withStar-grn mobile-textspace-withStar-grn mobile-detailTitle-grn">
    <li>
      {strip}
        {if $use_star}
            {include file="grn/mobile_star_init.tpl"}
            {grn_mobile_star_icon module="grn.message" star_infos=$star_infos unique_id=$message.mid mid=$message.mid cid=$message.cid rid=$rid}
        {/if}
        <span>{$message.subject}</span>
      {/strip}
    </li>
  </ul>
  <div class="mobile-list-login-grn mobile-cmt-operate-grn mobile-todoBodyText-grn">
    <div class="mobile-separation-grn"></div>
    <div class="mobile-list-todoDetail-grn">
      <div class="mobile-label-small-grn">{cb_msg module='grn.message' key='GRN_MSG-106' replace='true'}</div>
      <div class="mobile-contents-todoDetail-grn mobile_todo_username_grn">{grn_user_name uid=$message.creator_uid name=$message.creator_name users_info=$users_info only_text=true}<span class="mobile-date-list-grn">{grn_date_format date=$message.ctime format="DateTimeMiddle_YMDW_HM"}</span></div>
    </div>
    <ul data-role="listview" data-theme="{$data_theme}" class="mobile-li-PersonInCharge-grn mobile-div-title-grn">
        <div class="mobile-separation-grn"></div>
        <li data-icon="false">
            {if $message.addressee_num gt 0}
            <a href="{grn_pageurl page=$message_prefix|cat:'/addressee_list' cid=$message.cid rid=$rid mid=$message.mid}">
              <div class="mobile-label-small-grn">{cb_msg module='grn.message' key='GRN_MSG-110' replace='true'}</div>
              <div class="mobile_for_totalnumber_grn">
                {foreach from=$message.addressee item=attendee_name}
                  <div class="mobile-font-warp-grn">{grn_user_name uid=$attendee_name.id name=$attendee_name.name users_info=$users_info only_text=true}</div>
                {/foreach}
              </div><!--mobile_for_totalnumber_grn-->
              <span class="totalNumber-grn">{$message.addressee_num}</span>
              <span class="mobile-array-todo-grn"></span>
            </a>
            {else}
            <div class="mobile-label-small-grn">{cb_msg module='grn.message' key='GRN_MSG-110' replace='true'}</div>
            {/if}
        </li>
        <div class="mobile-separation-grn"></div>
    </ul>
    <div class="mobile-list-todoDetail-grn">
        {if $message.modified}
        <div class="mobile-textspace-unread-grn">
        {elseif $message.data || $message.attach_files}
            <div class="mobile-textspace-div-grn">
        {/if}
            <div class="mobile-label-small-grn">{cb_msg module='grn.message' key='GRN_MSG-15' replace='true'}</div>
        {if $message.data || $message.attach_files}<div class="mobile-contents-todoDetail-grn">{/if}
        {if $message.data}
            <span class="mobile-font-normal-grn">{grn_mobile_format body=$message.data}</span>
        {/if}
        {if $message.attach_files}
            <div class="mobile-attachmentButton-grn">
            {foreach from=$message.attach_files item=file}
                {grn_mobile_attach_file_link name=$file.name dpage=$file_dpage cid=$message.cid rid=$rid mid=$message.mid rfid=$file.rfid}
            {/foreach}
            </div>
        {/if}
        {if $message.data || $message.attach_files}</div>{/if}
        {if $message.modified || $message.data || $message.attach_files}
            </div>
        {/if}
    </div>
    {if $message.is_snapshot neq '1' and $folder_type neq '4'}
        {if $message.type neq '1' and $message.need_confirm eq '1' and $message.confirmed neq '1'}
            <div class="mobile-separation-grn"></div>
            <div class="mobile-list-todoDetail-grn">
                <div class="mobile-label-small-grn">{cb_msg module='grn.message' key='GRN_MSG-19' replace='true'}</div>
                <div class="mobile-contents-todoDetail-grn mobile_todo_username_grn">{cb_msg module='grn.message' key='GRN_MSG-20' replace='true'}</div>
            </div>
        {/if}
    {/if}
  </div>
</div><!--content-->
