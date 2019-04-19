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
      {if ! $info.isDeleted}
        <div class="mobile_attendance_userList_div_grn">
          {if $info.isInvalidUser}
              <img src="{$app_path}/grn/image/cybozu/image-mobile/userInvalidPlofile.png?{$build_date}" height="40"
                   width="40" class="mobile-image-member-grn"
                   aria-label="{cb_msg module='grn.grn' key='GRN_GRN-INACTIVE_USER' replace='true'}">
          {elseif $info.isNotUsingApp}
              <img src="{$app_path}/grn/image/cybozu/image-mobile/userInvalidAppPlofile.png?{$build_date}" height="40"
                   width="40" class="mobile-image-member-grn"
                   aria-label="{cb_msg module='grn.grn' key='GRN_GRN-NOT_APPLICATION_USER' replace='true'}">
          {elseif $info.image}
              <img src="{$info.image}" height="40" width="40" class="mobile-image-member-grn" aria-label=""/>
          {elseif $info.isLoginUser}
              <img src="{$app_path}/grn/image/cybozu/image-mobile/userLoginPlofile.png?{$build_date}" height="40"
                   width="40" class="mobile-image-member-grn"
                   aria-label="{cb_msg module='grn.grn' key='GRN_GRN-LOGIN_USER' replace='true'}">
          {else}
              <img src="{$app_path}/grn/image/cybozu/image-mobile/userPlofile.png?{$build_date}" height="40" width="40"
                   class="mobile-image-member-grn" aria-label="">
          {/if}
          <div class="mobile-list-member-name-grn" {if ! $info.primaryGroupName && ! $info.createTime}style="margin-top: 10px;"{elseif $info.primaryGroupName && $info.createTime}style="margin-top: 0px;"{/if}>
            {if $info.conflict} {*for confict uses of Schedule*}
                <img src="{$app_path}/grn/image/cybozu/image-mobile/attention_s.png?{$build_date}" height="16"
                     width="16" aria-label="">
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
            <img src="{$app_path}/grn/image/cybozu/image-mobile/userPlofile.png?{$build_date}" height="40" width="40"
                 class="mobile-image-member-grn" aria-label="">
          <div class="mobile-list-member-name-grn" style="margin-top: 10px;">{$info.displayName|escape}</div>
        </div>
      {/if}
    </li>
    <!-- End GTM-1630 -->
  {else}
    <li data-icon="false" class="mobile-list-member-grn">
      {if $info.type eq "static_role"}
      <a href="{grn_pageurl page='mobile/role_user_list' rid=$info.id member_referer_key=$member_referer_key}">
          <img src="{$app_path}/grn/image/cybozu/image-mobile/role_profile.png?{$build_date}" height="40" width="40"
               class="mobile-image-member-grn" aria-label="{cb_msg module='grn.grn' key='GRN_GRN-ROLE' replace='true'}">
        <div class="mobile-list-member-name-grn" style="margin-top: 10px;">{$info.displayName|escape}</div>
        <span class="mobile-array-list-grn mobile-array-member-grn"></span>
      </a>
      {elseif $info.type eq "group"}
      {if $info.isAttendee}
        <a href="javascript:void(0);">
            <img src="{$app_path}/grn/image/cybozu/image-mobile/cal_group_profile.png?{$build_date}" height="40"
                 width="40" class="mobile-image-member-grn"
                 aria-label="{cb_msg module='grn.grn' key='GRN_GRN-ORGANIZATION_PLAN' replace='true'}">
          <div class="mobile-list-member-name-grn" style="margin-top: 10px;">{$info.displayName|escape}</div>
        </a>
      {else}
        <a href="{grn_pageurl page='mobile/group_user_list' gid=$info.id member_referer_key=$member_referer_key}">
            <img src="{$app_path}/grn/image/cybozu/image-mobile/groupPlofile.png?{$build_date}" height="40" width="40"
                 class="mobile-image-member-grn"
                 aria-label="{cb_msg module='grn.grn' key='GRN_GRN-ORGANIZATION' replace='true'}">
          <div class="mobile-list-member-name-grn" style="margin-top: 10px;">{$info.displayName|escape}</div>
          <span class="mobile-array-list-grn mobile-array-member-grn"></span>
        </a>
      {/if}
      {else}
      {if ! $info.isDeleted}
      {if $smarty.const.ON_FOREST == 1}
      <a href="{$info.forestUserUrl|escape}" target="_blank">
        {else}
        <a href="{grn_pageurl page='grn/user_view' uid=$info.id}" target="_blank">
          {/if}
          {if $info.isInvalidUser}
              <img src="{$app_path}/grn/image/cybozu/image-mobile/userInvalidPlofile.png?{$build_date}" height="40"
                   width="40" class="mobile-image-member-grn"
                   aria-label="{cb_msg module='grn.grn' key='GRN_GRN-INACTIVE_USER' replace='true'}">
          {elseif $info.isNotUsingApp}
              <img src="{$app_path}/grn/image/cybozu/image-mobile/userInvalidAppPlofile.png?{$build_date}" height="40"
                   width="40" class="mobile-image-member-grn"
                   aria-label="{cb_msg module='grn.grn' key='GRN_GRN-NOT_APPLICATION_USER' replace='true'}">
          {elseif $info.image}
            <img src="{$info.image}" height="40" width="40" class="mobile-image-member-grn"/>
          {elseif $info.isLoginUser}
              <img src="{$app_path}/grn/image/cybozu/image-mobile/userLoginPlofile.png?{$build_date}" height="40"
                   width="40" class="mobile-image-member-grn"
                   aria-label="{cb_msg module='grn.grn' key='GRN_GRN-LOGIN_USER' replace='true'}">
          {else}
              <img src="{$app_path}/grn/image/cybozu/image-mobile/userPlofile.png?{$build_date}" height="40" width="40"
                   class="mobile-image-member-grn" aria-label="">
          {/if}
          <div class="mobile-list-member-name-grn" {if ! $info.primaryGroupName && ! $info.createTime}style="margin-top: 10px;"{elseif $info.primaryGroupName && $info.createTime}style="margin-top: 0px;"{/if}>
            {if $info.conflict} {*for confict uses of Schedule*}
                <img src="{$app_path}/grn/image/cybozu/image-mobile/attention_s.png?{$build_date}" height="16"
                     width="16" aria-label="">
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
            <img src="{$app_path}/grn/image/cybozu/image-mobile/userPlofile.png?{$build_date}" height="40" width="40"
                 class="mobile-image-member-grn" aria-label="">
          <div class="mobile-list-member-name-grn" style="margin-top: 10px;">{$info.displayName|escape}</div>
        </a>
        {/if}
        {/if}
    </li>
  {/if}
{/foreach}
