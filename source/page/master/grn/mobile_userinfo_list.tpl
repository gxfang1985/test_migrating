{foreach from=$user_info_list item=info}
{if $is_attendance_check_view}
  {capture name='user_view_url'}{strip}
  {if $smarty.const.ON_FOREST == 1}
    {$info.forestUserUrl|escape}
  {else}
    {grn_pageurl page='grn/user_view' uid=$info.id}
  {/if}
  {/strip}{/capture}
  <!-- GTM-1630 -->
  <li data-icon="false" class="mobile-list-member-grn" onclick="grn.component.mobile_common.toCommentDetail('{$smarty.capture.user_view_url}', 'true')">
    {if ! $info.deleted}
      <div class="mobile_attendance_userList_div_grn">
        {if $info.invalidUser}
          {grn_image image="image-mobile/userInvalidPlofile.png" height="40" width="40" class="mobile-image-member-grn"}
        {elseif ! $info.usingApp}
          {grn_image image="image-mobile/userInvalidAppPlofile.png" height="40" width="40" class="mobile-image-member-grn"}
        {elseif $info.image}
          <img src="{$info.image}" height="40" width="40" class="mobile-image-member-grn"/>
        {elseif $info.isLoginUser}
          {grn_image image="image-mobile/userLoginPlofile.png" height="40" width="40" class="mobile-image-member-grn"}
        {else}
          {grn_image image="image-mobile/userPlofile.png" height="40" width="40" class="mobile-image-member-grn"}
        {/if}
        <div class="mobile-list-member-name-grn" {if ! $info.primaryGroupName && ! $info.createTime}style="margin-top: 10px;"{elseif $info.primaryGroupName && $info.createTime}style="margin-top: 0px;"{/if}>
        {if $info.conflict} {*for confict uses of Schedule*}
            {grn_image image="image-mobile/attention_s.png" height="16" width="16"}
        {/if}
        {$info.displayName|escape}
        </div>
        {if $info.primaryGroupName}
          <div class="mobile-label-small-grn">{$info.primaryGroupName|escape}</div>
        {/if}
        {if $info.createTime}
          <div class="mobile-label-small-grn">{grn_date_format date=$info.createTime format="DateTimeMiddle_YMDW_HM"}</div>
        {/if}
        <span class="mobile-array-list-grn mobile-array-member-grn"></span>
      </div>
      {if $info.comment}
        <div class="mobile_attendance_comment_grn">{grn_mobile_format body=$info.comment}</div>
      {/if}
    {else}
      <div class="mobile_attendance_userList_div_grn">
        {grn_image image="image-mobile/userPlofile.png" height="40" width="40" class="mobile-image-member-grn"}
        <div class="mobile-list-member-name-grn" style="margin-top: 10px;">{$info.displayName|escape}</div>
      </div>
    {/if}
  </li>
  <!-- End GTM-1630 -->
{else}
  <li data-icon="false" class="mobile-list-member-grn">
    {if $info.type_group}
        <a href="javascript:void(0);">
            {grn_image image="image-mobile/groupPlofile.png" height="40" width="40" class="mobile-image-member-grn"}
            <div class="mobile-list-member-name-grn" style="margin-top: 10px;">{$info.name|escape}</div>
        </a>
    {else}
        {if ! $info.deleted}
          {if $smarty.const.ON_FOREST == 1}
            <a href="{$info.forestUserUrl|escape}" target="_blank">
          {else}
            <a href="{grn_pageurl page='grn/user_view' uid=$info.id}" target="_blank">
          {/if}
            {if $info.invalidUser}
              {grn_image image="image-mobile/userInvalidPlofile.png" height="40" width="40" class="mobile-image-member-grn"}
            {elseif ! $info.usingApp}
              {grn_image image="image-mobile/userInvalidAppPlofile.png" height="40" width="40" class="mobile-image-member-grn"}
            {elseif $info.image}
              <img src="{$info.image}" height="40" width="40" class="mobile-image-member-grn"/>
            {elseif $info.isLoginUser}
              {grn_image image="image-mobile/userLoginPlofile.png" height="40" width="40" class="mobile-image-member-grn"}
            {else}
              {grn_image image="image-mobile/userPlofile.png" height="40" width="40" class="mobile-image-member-grn"}
            {/if}
            <div class="mobile-list-member-name-grn" {if ! $info.primaryGroupName && ! $info.createTime}style="margin-top: 10px;"{elseif $info.primaryGroupName && $info.createTime}style="margin-top: 0px;"{/if}>
            {if $info.conflict} {*for confict uses of Schedule*}
                {grn_image image="image-mobile/attention_s.png" height="16" width="16"}
            {/if}
            {$info.displayName|escape}
            </div>
            {if $info.primaryGroupName}
              <div class="mobile-label-small-grn">{$info.primaryGroupName|escape}</div>
            {/if}
            {if $info.createTime}
              <div class="mobile-label-small-grn">{grn_date_format date=$info.createTime format="DateTimeMiddle_YMDW_HM"}</div>
            {/if}
            <span class="mobile-array-list-grn mobile-array-member-grn"></span>
          </a>
        {else}
          <a href="javascript:void(0);">
            {grn_image image="image-mobile/userPlofile.png" height="40" width="40" class="mobile-image-member-grn"}
            <div class="mobile-list-member-name-grn" style="margin-top: 10px;">{$info.displayName|escape}</div>
          </a>
        {/if}
    {/if}
  </li>
{/if}
{/foreach}
