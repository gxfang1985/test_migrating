{strip}
{if $is_favour_active && ($is_favour_on || $favour_info.module_id == 'grn.space')}
{if ! $data_theme}{assign var='data_theme' value='c'}{/if}
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

<span id="favourer_count_span_{$favour_info.type}_{$favour_info.type_value}" {if $favour_info.count <= 0}style="display:none"{/if}>
<a id="favourer_count_link_{$favour_info.type}_{$favour_info.type_value}"
   class="mobile-favourLink-grn icon_reaction_sub_grn ui-link" href="#favour_user_list" data-transition="pop"
   data-shadow="true" data-wrapperels="span" data-rel="popup"
   onclick="javascript:grn.page.favour.mobile.favour.getFavourList('{$favour_info.module_id}','{$favour_info.sub_module_id}','{$favour_info.type}','{$favour_info.type_value}','{$param}');"
   role="button"
   title="{$smarty.capture.like_title}"
   aria-label="{$smarty.capture.like_title}">
    {include file='favour/favour_count.tpl' favour_count=$favour_info.count}
</a>
</span>
<span>
<a id="favour_link_{$favour_info.type}_{$favour_info.type_value}"
   class="mobile-favourLink-grn mobile_comment_action_grn {if $favour_info.count <= 0}icon_reaction_sub_grn{/if} ui-link"
   href="javascript:void(0);"
   onclick="javascript:grn.page.favour.mobile.favour.favour( '{$favour_info.module_id}', '{$favour_info.sub_module_id}', '{$favour_info.type}', '{$favour_info.type_value}' ,'{$param}');"
   role="button">
    {include file='favour/favour_word.tpl' is_favoured=$favour_info.is_favoured}
</a>
</span>
<span class="mobile_comment_action_spinner_grn" id="favour_loading_{$favour_info.type}_{$favour_info.type_value}"></span>
{/if}
{/strip}