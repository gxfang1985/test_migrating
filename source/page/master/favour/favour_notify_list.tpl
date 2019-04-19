{include file="grn/xss_prevent.tpl"}
<script type="text/javascript">
    grn.html.com_header.updateFavourNumber('{$total_notify|escape:javascript}');
</script>

{capture name='last_updated'}{cb_msg module='grn.notification' key='GRN_NTFC-190' replace='true'}{/capture}
{capture name='update'}{cb_msg module='grn.notification' key='GRN_NTFC-191' replace='true'}{/capture}
{strip}
    <button type="button" class="cloudHeader-grnNotification-update-grn button_style_off_grn w_full_grn">
        <span class="icon-reload-grn"></span>
        <span>{$smarty.capture.update}</span>
        <span class="cloudHeader-grnNotification-lastDate-grn">{$smarty.capture.last_updated}: <span class="display_time_update">
                {grn_date_format date = $last_time_update}
            </span>
        </span>
    </button>
    {foreach from=$notify_data_list item=notify}
        {if $notify.page_info}
            <div class="cloudHeader-grnNotification-item-grn">
                <div class="cloudHeader-grnNotification-itemBody-grn">
                    {if $notify.unread}
                        <div class="unread_mark_grn"
                             title="{cb_msg module='grn.favour' key='GRN_FAV-16' replace='true'}"
                             aria-label="{cb_msg module='grn.favour' key='GRN_FAV-16' replace='true'}"></div>
                    {/if}
                    {assign var='user_id' value=$notify.sender_id}
                    <div class="reaction_info_appicon_grn"><span aria-label="{$notify.subject_icon_label}"
                                                                 title="{$notify.subject_icon_label}"
                                                                 class="{$notify.subject_icon} icon_inline_grn icon_only_grn"></span>
                    </div>
                    <div class="reaction_info_base_grn">
                        <div class="profile_image_base_grn">
                            {grn_user_image_icon userInfo=$users_info.$user_id photoUrl=$users_info.$user_id.photoUrl userId=$user_id loginId=$login_id size=$icon_size app_id=$notify.module_id|substr:4}
                        </div>
                        <div class="reaction_info_grn">
                            {strip}
                            <a class=""
                               href="{grn_pageurl page=$notify.page_info.subject_page params=$notify.page_info.url_params fragment=$notify.page_info.subject_fragment fnid=$notify.id}">
          <span class="text_color_sub_grn">
              {grn_user_name uid=$user_id name=$notify.sender_name users_info=$users_info only_text="true"}
              {/strip}{cb_msg module='grn.favour' key='GRN_FAV-10' replace='true'}
              {if $notify.count_favourer > 0}
                  {cb_msg module='grn.favour' key='GRN_FAV-11' replace='true'}
                  {$notify.count_favourer}
                  {cb_msg module='grn.favour' key='GRN_FAV-12' replace='true'}
              {/if}
              {strip}
                  {cb_msg module='grn.favour' key='GRN_FAV-13' replace='true'}
                  {if $html_lang == 'ja'}
                      <span class="text_linkcolor_grn">
                      {cb_msg module='grn.favour' key='grn.favour.start.quote' replace='true'}
                          {$notify.abstract}
                          {cb_msg module='grn.favour' key='grn.favour.end.quote' replace='true'}
                  </span>
                  {else}
                      <span class="reaction_word_grn">{grn_favour_app_name}</span>
                  {/if}
                  {* english and chinese wording is blank character *}
              {/strip}{cb_msg module='grn.favour' key='GRN_FAV-14' replace='true'}{strip}

              {if $html_lang == 'ja'}
                  {grn_favour_app_name}
              {else}
                  <span class="text_linkcolor_grn">
                      {cb_msg module='grn.favour' key='grn.favour.start.quote' replace='true'}
                      {$notify.abstract}
                      {cb_msg module='grn.favour' key='grn.favour.end.quote' replace='true'}
                  </span>
              {/if}
              {cb_msg module='grn.favour' key='GRN_FAV-15' replace='true'}
          </span>
                            </a>
                            {/strip}
                        </div>
                    </div>
                    <div class="clear_both"></div>
                </div>
            </div>
        {/if}
    {/foreach}
{/strip}
{include file="grn/end_xss_prevent.tpl"}
