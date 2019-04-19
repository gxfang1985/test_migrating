{strip}
  <div class="mobile_comment_action_base_grn">
    <span class="mobile_comment_action_left_grn">
      {if $favour_info}
        <span class="mobile_comment_reaction_base_grn">
          {include file="favour/mobile/_favour.tpl"}
        </span>
      {/if}

      {if $smarty.capture.reply_url}
        <span class="mobile_comment_action_item_grn">
            <a class="mobile_comment_action_grn mobile_icon_reply_sub_grn ui-link"
               href="{$smarty.capture.reply_url|grn_noescape}"
               title="{cb_msg module='grn.grn' key='GRN_GRN-1561' replace='true'}"
               aria-label="{cb_msg module='grn.grn' key='GRN_GRN-1561' replace='true'}">
                <span>{cb_msg module='grn.grn' key='GRN_GRN-1561' replace='true'}</span>
            </a>
        </span>
      {/if}

      {if $smarty.capture.reply_all_url}
        <span class="mobile_comment_action_item_grn">
          <a class="mobile_comment_action_grn mobile_icon_reply_all_sub_grn ui-link"
             href="{$smarty.capture.reply_all_url|grn_noescape}"
             title="{cb_msg module='grn.grn' key='GRN_GRN-1584' replace='true'}"
             aria-label="{cb_msg module='grn.grn' key='GRN_GRN-1584' replace='true'}">
              <span>{cb_msg module='grn.grn' key='GRN_GRN-1584' replace='true'}</span>
          </a>
        </span>
      {/if}

    </span>
    {if $deletable}
      <span class="mobile_comment_action_right_grn">
        <a aria-label="{cb_msg module='grn.grn' key='GRN_GRN-1561' replace='true'}"
         title="{cb_msg module='grn.grn' key='GRN_GRN-1562' replace='true'}"
         class="mobile_comment_action_grn mobile_icon_trash_sub_grn ui-link"
         href="{$smarty.capture.delete_url|grn_noescape}"></a>
      </span>
    {/if}
  </div>
{/strip}