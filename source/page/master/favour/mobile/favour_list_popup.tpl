{foreach from=$user_info_list item=info name =user_info }
  <li data-icon="false" class="mobile-list-member-grn ui-li-has-thumb {if $smarty.foreach.user_info.first}ui-first-child {elseif $smarty.foreach.user_info.last} ui-last-child{/if}">
    {if $info.type_group}
    <a href="javascript:void(0);">
      {grn_image image="image-mobile/groupPlofile.png" height="40" width="40" class="mobile-image-member-grn"}
      <div class="mobile-list-member-name-grn" style="margin-top: 10px;">{$info.name|escape}</div>
    </a>
    {else}
    {if ! $info.deleted}
    {if $smarty.const.ON_FOREST == 1}
    <a href="{$info.forestUserUrl|escape}" class="ui-btn" target="_blank">
      {else}
      <a href="{grn_pageurl page='grn/user_view' uid=$info.id}" class="ui-btn" target="_blank">
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
{/foreach}

{if $offset != -1}
  {if ! $data_theme}{assign var='data_theme' value='c'}{/if}
{literal}
  <script language="JavaScript" text="text/javascript">
    (function(){
      {/literal}
      var args = '';
      {foreach from=$more_view_args key=key item=item name='more_view_args'}
      {if $smarty.foreach.more_view_args.first}
      args += "{$key|escape:javascript}" + "=" + "{$item|escape:javascript}";
      {else}
      args += "&" + "{$key|escape:javascript}" + "=" + "{$item|escape:javascript}";
      {/if}
      {/foreach}
      var options = {ldelim}require_url : grn.component.url.page("favour/mobile/ajax/user_list_popup"),
                            ul_id : 'favour_list_popup',
                            arg : args,
                            sp : '{$offset|grn_noescape}'{rdelim};
      grn.component.mobile_list_more_view.spinnerImage = grn.component.url.image("cybozu/spinner.gif");
      grn.component.mobile_list_more_view.setMoreView(options);
      {literal}
    })()
  </script>
{/literal}
  <li class="mobile-showMore-grn ui-li-static ui-body-inherit" id="ul_favour_list_popup">
    <div class="ui-btn ui-input-btn ui-btn-c ui-corner-all ui-shadow">{cb_msg module='grn.space' key='space_mobile-1' replace='true'}
      <input type="button" data-inline="true" data-theme="{$data_theme}" onclick="javascript:grn.component.mobile_list_more_view.getMoreView('favour_list_popup');"/>
    </div>
  </li>
{/if}