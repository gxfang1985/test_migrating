{if count($favourer_list) > 0 }
  {foreach from=$favourer_list item=favourer name='favourer_list'}
    <div class="favour-favourerList-grn">
      <table class="table_grn">
        <tr>
          {assign var='user_id' value=$favourer.favourer_id}
          {if $image_icon}
            <td width="1%">
              <div class="mRight5">
                {grn_user_image_icon userInfo=$users_info.$user_id photoUrl=$users_info.$user_id.photoUrl userId=$user_id loginId=$login_id size=$icon_size class="mRight5" app_id=$favourer.module_id|substr:4}
              </div>
            </td>
            <td>
              {grn_user_name uid=$user_id name=$favourer.favourer_name users_info=$users_info noimage="true" app_id=$favourer.module_id|substr:4}
          {else}
            <td>
              {grn_user_name uid=$user_id name=$favourer.favourer_name users_info=$users_info app_id=$favourer.module_id|substr:4}
          {/if}
          </td>
          <td>
            <div class="favour-datetime-grn">
              {grn_date_format date=$favourer.timestamp format='ShortDateFormat' user=$login_id}
              {grn_date_format date=$favourer.timestamp format='TimeFormat' user=$login_id}
            </div>
          </td>
        </tr>
      </table>
    </div>
    {if $smarty.foreach.favourer_list.iteration == $max_count_favourer && count($favourer_list) > $max_count_favourer}
      <span id="display_favourer_close">
        <a class="moreButton-grn" href="javascript:void(0);display_on_off('display_favourer_close:display_favourer_open')">
          {cb_msg module='grn.favour' key='GRN_FAV-8' replace='true'}
        </a>
      </span>
      <span id="display_favourer_open" style="display:none;">
    {/if}
  {/foreach}
  {if count($favourer_list) > $max_count_favourer}
    </span>
  {/if}
{else}
  {cb_msg module='grn.favour' key='GRN_FAV-9' replace='true'}
{/if}
