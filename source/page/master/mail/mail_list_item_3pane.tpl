{strip}
<script language="JavaScript" type="text/javascript">
(function(){literal}
{{/literal}
    var __thisPage = grn.page.mail.mail_list;
    __thisPage.options = {ldelim}prev : '{$prev_offset|grn_noescape}',
                                 next : '{$next_offset|grn_noescape}',
                                 start : '{$start|grn_noescape}',
                                 end   : '{$end|grn_noescape}'{rdelim};
{literal}
    jQuery(document).ready(function () {
        if (grn.browser.msie) {
            jQuery("input[name$='ids[]']").click(function () {
                this.blur();
                this.focus();
            });
        }
    });
})();{/literal}
</script>
{foreach from=$mails item=mail key=rid name="mail_loop"}
  {capture assign="class_row"}{if $mail.unread}unread_grn{else}read_grn{/if}{/capture}
  <li class="{$class_row}" id="mail_list-row_{$mail.mid}" onmouseover="if(typeof(GRN_ListView_Util) != 'undefined') GRN_ListView_Util.initDrapDropItem('item_{$mail.mid}');">
    <div class="list_box_grn">
      <ul>
        <li class="nowrap-grn">
          <span class="list_left_grn">
            <input type="checkbox" id="item_{$mail.mid}" name="ids[]" value="{$mail.mid}" onChange="javascript:grn.page.mail.mail_list.clickCheckBox();" {if $mail.type eq '0' || $mail.type eq '1'}{if $mail.attach_file}data-has-attachment="true"{/if}{/if}>
          </span>
          <span class="list_right_grn" >
            <span class="list_text_overflow_grn name_grn" >{$mail.name|escape}</span>
            <span class="date_grn">{grn_date_format date=$mail.time format='DateTimeDetailCompact'}</span>
          </span>
        </li>
        <li class="nowrap-grn select_content_2line_grn">
          <span class="list_left_grn">
            {if $use_star && $category.type neq '4'}
              {grn_star_icon module="grn.mail" star_infos=$star_infos unique_id=$mail.mid mid=$mail.mid}
            {else}
              <span>&nbsp;</span>
            {/if}
          </span>
          <span class="list_right_grn" >
            <span class="list_text_overflow_grn" >
            {if $mail.action}
              {if $mail.action eq '1'}{*返信*}
                <span id="mail_mark_{$mail.mid}" class="mark_reply_grn" title="{cb_msg module='grn.mail' key='GRN_MAIL-447' replace='true'}"></span>
              {elseif $mail.action eq '2'}{*全員に返信*}
                <span id="mail_mark_{$mail.mid}" class="mark_reply_all_grn" title="{cb_msg module='grn.mail' key='GRN_MAIL-448' replace='true'}"></span>
              {elseif $mail.action eq '3'}{*転送*}
                <span id="mail_mark_{$mail.mid}" class="mark_forward_grn" title="{cb_msg module='grn.mail' key='GRN_MAIL-449' replace='true'}"></span>
              {/if}
            {else}
              <span id="mail_mark_{$mail.mid}" class="list_mark_grn" style="display: none;"></span>
            {/if}
            {if $mail.subject eq ''}{cb_msg module='grn.mail' key='no_title'}{else}{$mail.subject|escape}{/if}
            </span>
            <div class="align_right_grn">
            {if ! $no_status}
              {if $mail.status_id == 1 || ! $mail.status_id}
                <span id="mail_status_{$mail.mid}" class="status_2line_grn">
              {elseif $mail.status_id == 2}
                <span id="mail_status_{$mail.mid}" class="mail-statusUnCheck-grn status_2line_grn">
              {elseif $mail.status_id == 3}
                <span id="mail_status_{$mail.mid}" class="mail-statusNeedSend-grn status_2line_grn">
              {elseif $mail.status_id == 4}
                <span id="mail_status_{$mail.mid}" class="mail-statusCheck-grn status_2line_grn">
              {elseif $mail.status_id == 5}
                <span id="mail_status_{$mail.mid}" class="mail-statusHold-grn status_2line_grn">
              {elseif $mail.status_id == 6}
                <span id="mail_status_{$mail.mid}" class="mail-statusWaitSend-grn status_2line_grn">
              {/if}
              {$mail.status_name|escape|default:" "}</span>
            {else}
              <span>&nbsp;</span>
            {/if}
              <span class="size_grn">{grn_format_filesize size=$mail.size unit="KB"}</span>
            {if $mail.attach_file}
              <div class="display_inline_block_grn">
                <span class="attachment_small_grn"></span>
              </div>
            {/if}
            </div>
          </span>
        </li>
      </ul>
    </div>
  </li>
{/foreach}
{/strip}
