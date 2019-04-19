{if $is_favour_active && ($is_favour_on || $favour_info.module_id == 'grn.space')}
  {foreach from=$favour_info.params key=key item=value}
    {assign var=param value=$param|cat:'&'|cat:$key|cat:'='|cat:$value}
  {/foreach}

  {capture name="like_title"}{strip}
      {grn_favour_app_name}
      {cb_msg module='grn.grn' key='GRN_GRN-817' replace='true'}
      {$favour_info.count|intval}
      {cb_msg module='grn.favour' key='GRN_FAV-17' replace='true'}
      {cb_msg module='grn.grn' key='GRN_GRN-818' replace='true'}
  {/strip}{/capture}

  {strip}
  <a id="favour_count_{$favour_info.type}_{$favour_info.type_value}"
     title="{$smarty.capture.like_title}"
     aria-label="{$smarty.capture.like_title}"
     href="javascript:void(0);"
     onclick="javascript:favour.openFavourerList('{$favour_info.module_id}','{$favour_info.sub_module_id}','{$favour_info.type}','{$favour_info.type_value}','{$param}');"
     {if $favour_info.count <= 0}style="display:none"{/if}
     class="icon_reaction_sub_grn"
     role="button">
    {include file='favour/favour_count.tpl' favour_count=$favour_info.count}
  </a>
  {if $disable_link}
    <span {if $favour_info.count <= 0}class="icon_reaction_sub_grn"{/if}>
  {else}
    <a id="favour_link_{$favour_info.type}_{$favour_info.type_value}"
    href="javascript:void(0);"
    onclick="javascript:favour.favour('{$favour_info.module_id}','{$favour_info.sub_module_id}','{$favour_info.type}','{$favour_info.type_value}','{$param}');"
    {if $favour_info.count <= 0}class="icon_reaction_sub_grn"{/if}
    role="button">
  {/if}
    {include file='favour/favour_word.tpl' is_favoured=$favour_info.is_favoured}
  {if $disable_link}
    </span>
  {else}
    </a>
  {/if}
  <span id="favour_loading_{$favour_info.type}_{$favour_info.type_value}"></span>
  {/strip}
{/if}