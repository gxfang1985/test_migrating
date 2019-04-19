{*
    {cb_msg module='grn.mail' key='GRN_MAIL-342' replace='true'}
    $mails       : {cb_msg module='grn.mail' key='GRN_MAIL-343' replace='true'}
    $no_checkbox : {cb_msg module='grn.mail' key='GRN_MAIL-344' replace='true'}
    $no_subject  : {cb_msg module='grn.mail' key='GRN_MAIL-345' replace='true'}
    $no_name     : {cb_msg module='grn.mail' key='GRN_MAIL-346' replace='true'}
    $no_date     : {cb_msg module='grn.mail' key='GRN_MAIL-347' replace='true'}
    $no_remarks  : {cb_msg module='grn.mail' key='GRN_MAIL-348' replace='true'}
    $no_status   : {cb_msg module='grn.mail' key='GRN_MAIL-349' replace='true'}
*}
    {capture assign="class_row"}{if $mail.unread}unread_color{else}{if $no_stripe != 1 && $smarty.foreach.mail_loop.iteration % 2 == 0}lineone{else}linetwo{/if}{/if}{/capture}
    <tr class="{$class_row}" id="mail_list-row_{$mail.mid}">
 {if ! $no_checkbox}
     <td nowrap><span class="drag_handle" id="draghandle_{$mail.mid}"
                      onmouseover="if(typeof(GRN_ListView_Util) != 'undefined') GRN_ListView_Util.initDrapDropItem('item_{$mail.mid}');">{grn_image image='grippy.png'}</span>
         <input type="checkbox" id="item_{$mail.mid}" name="ids[]" value="{$mail.mid}"
                onmouseover="if(typeof(GRN_ListView_Util) != 'undefined') GRN_ListView_Util.initDrapDropItem('item_{$mail.mid}');"
                {if $mail.type eq '0' || $mail.type eq '1'}{if $mail.attach_file}data-has-attachment="true"{/if}{/if}>
     </td>
 {/if}
 {*---Star---*}
 {if $use_star && $category.type neq '4'}<td>{grn_star_icon module="grn.mail" star_infos=$star_infos unique_id=$mail.mid mid=$mail.mid}</td>{/if}
 {*---End Star---*}
 <td><a id="toggle_link_{$mail.mid}" status="off" href="javascript:__thisPage.ToggleSummary('{$mail.mid}');">{grn_image image='plus.gif' id="toggle_image_`$mail.mid`"}</a></td>
 {if ! $no_subject}
     <td nowrap>
  {if $mail.type eq '0' || $mail.type eq '1'} {* 受信メッセージ/送信メッセージ *}
   {if $mail.attach_file}
    {if $mail.unread}
     {if $mail.subject eq ''}
      {grn_link page='mail/view' caption_module='grn.mail' caption_key='no_title' image='mail_clip30x20.gif' truncated_caption=$characters.subject unread=1 mid=$mail.mid mail_unread_id="mail_unread_`$mail.mid`" }
     {else}
         {if $mail.action eq '3'} {* forward *}
             {grn_link page='mail/view' caption=$mail.subject image='mail_clip30x20_f.gif' truncated_caption=$characters.subject unread=1 mid=$mail.mid mail_unread_id="mail_unread_`$mail.mid`"}
         {else}
             {grn_link page='mail/view' caption=$mail.subject image='mail_clip30x20.gif' truncated_caption=$characters.subject unread=1 mid=$mail.mid mail_unread_id="mail_unread_`$mail.mid`"}
         {/if}
     {/if}
    {else}
     {if $mail.action}
      {if $mail.action eq '1'}{* 返信 *}
       {if $mail.subject eq ''}
        {grn_link page='mail/view' caption_module='grn.mail' caption_key='no_title' image='mail_clip30x20_r.gif' truncated_caption=$characters.subject mid=$mail.mid}
       {else}
        {grn_link page='mail/view' caption=$mail.subject image='mail_clip30x20_r.gif' truncated_caption=$characters.subject mid=$mail.mid}
       {/if}
      {elseif $mail.action eq '2'}{* 全員に返信 *}
       {if $mail.subject eq ''}
        {grn_link page='mail/view' caption_module='grn.mail' caption_key='no_title' image='mail_clip30x20_a.gif' truncated_caption=$characters.subject mid=$mail.mid}
       {else}
        {grn_link page='mail/view' caption=$mail.subject image='mail_clip30x20_a.gif' truncated_caption=$characters.subject mid=$mail.mid}
       {/if}
      {elseif $mail.action eq '3'}{* 転送 *}
       {if $mail.subject eq ''}
        {grn_link page='mail/view' caption_module='grn.mail' caption_key='no_title' image='mail_clip30x20_f.gif' truncated_caption=$characters.subject mid=$mail.mid}
       {else}
        {grn_link page='mail/view' caption=$mail.subject image='mail_clip30x20_f.gif' truncated_caption=$characters.subject mid=$mail.mid}
       {/if}
      {/if}
     {else}
      {if $mail.subject eq ''}
       {grn_link page='mail/view' caption_module='grn.mail' caption_key='no_title' image='mail_clip30x20.gif' truncated_caption=$characters.subject mid=$mail.mid}
      {else}
       {grn_link page='mail/view' caption=$mail.subject image='mail_clip30x20.gif' truncated_caption=$characters.subject mid=$mail.mid}
      {/if}
     {/if}
    {/if}
   {else}
    {if $mail.unread}
     {if $mail.subject eq ''}
      {grn_link page='mail/view' caption_module='grn.mail' caption_key='no_title' image='mail20.gif' truncated_caption=$characters.subject unread=1 mid=$mail.mid mail_unread_id="mail_unread_`$mail.mid`"}
     {else}
         {if $mail.action eq '3'} {* forward *}
             {grn_link page='mail/view' caption=$mail.subject image='mail20_f.gif' truncated_caption=$characters.subject unread=1 mid=$mail.mid mail_unread_id="mail_unread_`$mail.mid`"}
         {else}
             {grn_link page='mail/view' caption=$mail.subject image='mail20.gif' truncated_caption=$characters.subject unread=1 mid=$mail.mid mail_unread_id="mail_unread_`$mail.mid`"}
         {/if}
     {/if}
    {else}
     {if $mail.action}
      {if $mail.action eq '1'}{* 返信 *}
       {if $mail.subject eq ''}
        {grn_link page='mail/view' caption_module='grn.mail' caption_key='no_title' image='mail20_r.gif' truncated_caption=$characters.subject mid=$mail.mid}
       {else}
        {grn_link page='mail/view' caption=$mail.subject image='mail20_r.gif' truncated_caption=$characters.subject mid=$mail.mid}
       {/if}
      {elseif $mail.action eq '2'}{* 全員に返信 *}
       {if $mail.subject eq ''}
        {grn_link page='mail/view' caption_module='grn.mail' caption_key='no_title' image='mail20_a.gif' truncated_caption=$characters.subject mid=$mail.mid}
       {else}
        {grn_link page='mail/view' caption=$mail.subject image='mail20_a.gif' truncated_caption=$characters.subject mid=$mail.mid}
       {/if}
      {elseif $mail.action eq '3'}{* 転送 *}
       {if $mail.subject eq ''}
        {grn_link page='mail/view' caption_module='grn.mail' caption_key='no_title' image='mail20_f.gif' truncated_caption=$characters.subject mid=$mail.mid}
       {else}
        {grn_link page='mail/view' caption=$mail.subject image='mail20_f.gif' truncated_caption=$characters.subject mid=$mail.mid}
       {/if}
      {/if}
     {else}
      {if $mail.subject eq ''}
       {grn_link page='mail/view' caption_module='grn.mail' caption_key='no_title' image='mail20.gif' truncated_caption=$characters.subject mid=$mail.mid}
      {else}
       {grn_link page='mail/view' caption=$mail.subject image='mail20.gif' truncated_caption=$characters.subject mid=$mail.mid}
      {/if}
     {/if}
    {/if}
   {/if}
  {else}
   {if $mail.attach_file}
    {if $mail.subject eq ''}
     {grn_link page='mail/draft_view' caption_module='grn.mail' caption_key='no_title' image='draft_clip30x20.gif' truncated_caption=$characters.subject mid=$mail.mid}
    {else}
     {grn_link page='mail/draft_view' caption=$mail.subject image='draft_clip30x20.gif' truncated_caption=$characters.subject mid=$mail.mid}
    {/if}
   {else}
    {if $mail.subject eq ''}
     {grn_link page='mail/draft_view' caption_module='grn.mail' caption_key='no_title' image='draft20.gif' truncated_caption=$characters.subject mid=$mail.mid}
    {else}
     {grn_link page='mail/draft_view' caption=$mail.subject image='draft20.gif' truncated_caption=$characters.subject mid=$mail.mid}
    {/if}
   {/if}
  {/if}
     </td>
 {/if}
 {if ! $no_status}
    {if $fontsize}
        <td nowrap style="{$fontsize}">{$mail.status_name|escape|default:" "}</td>
    {else}
        <td nowrap>
            {if $mail.status_id == 2}
                <span class="mail-statusUnCheck-grn">
            {elseif $mail.status_id == 3}
                <span class="mail-statusNeedSend-grn">
            {elseif $mail.status_id == 4}
                <span class="mail-statusCheck-grn">
            {elseif $mail.status_id == 5}
                <span class="mail-statusHold-grn">
            {elseif $mail.status_id == 6}
                <span class="mail-statusWaitSend-grn">
            {/if}
            {$mail.status_name|escape|default:" "}</span>
        </td>
    {/if}
 {else}
     <td></td>
 {/if}

 {if ! $no_name}
     <td nowrap {if $fontsize}style="{$fontsize}"{/if}>{grn_mail_name type=$name_type name_format=$name_format name=$mail.name email=$mail.email truncated=$characters.name aid=$mail.aid cid=$mail.cid mid=$mail.mid}</td>
 {else}
     <td></td>
 {/if}
 {if ! $no_date}
     <td nowrap {if $fontsize}style="{$fontsize}"{/if}>{grn_date_format date=$mail.time format="DateTimeDetailCompact"}</td>
 {else}
     <td></td> 
 {/if}

 {if ! $no_remarks}
     <td nowrap {if $fontsize}style="{$fontsize}"{else}class="m_small"{/if} align="left">
      {grn_format_filesize size=$mail.size unit="KB"}&nbsp;&nbsp;<br>
  {if $use_confirm}
   {if $mail.type eq '0'}{* 受信メッセージ *}
    {if $mail.open eq '3'}{* 開封確認要求メール *}
      {*開封確認要求*}
    {elseif $mail.open eq '4'}{* 開封通知 *}
      {cb_msg module='grn.mail' key='GRN_MAIL-350' replace='true'}
    {elseif $mail.open eq '2'}{* 開封通知メール送信済み *}
      {*開封確認済*}
    {/if}
   {else}{* 送信メッセージ *}
    {if $mail.open eq '3'}{* 開封確認要求メール *}
      {*開封確認要求*}
    {elseif $mail.open eq '4'}{* 開封確認メール *}
      {cb_msg module='grn.mail' key='GRN_MAIL-351' replace='true'}
    {/if}
   {/if}
  {/if}
     </td>
 {else}
  <td></td>
 {/if}
    </tr>
    {*Summary row*}
    
    <tr id="summary_row_{$mail.mid}" style="display:none;"> 
        {if isset($flag_run_from_portlet) && $flag_run_from_portlet == false}
            <td colspan="{if $use_star && $category.type neq '4'}3{else}2{/if}" class="summaryCell"></td>
        {else}
            <td colspan="{if $use_star && $category.type neq '4'}2{else}1{/if}" class="summaryCell"></td>
        {/if}
        <td colspan="5" class="summaryCell">
            <div class="summary {$class_row}" style="display:block">
            <div id="iframe_summary_item_{$mail.mid}" class="summary_content_grn" style="height: 20px;display:none;"></div>
            <div id="summary_item_{$mail.mid}" has_data="false">{grn_image image='spinner.gif'}</div>
            </div>
        </td>
    </tr>
