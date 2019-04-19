{if $offset != -1}
{grn_load_javascript file="grn/html/component/mobile_list_more_view.js"}
{if ! $data_theme}{assign var='data_theme' value='c'}{/if}
{literal}
<script language="JavaScript" text="text/javascript">
(function(){
{/literal}
    grn.component.mobile_list_more_view.spinnerImage = '{$app_path}/grn/image/cybozu/image-mobile/spinner.gif?{$build_date}';

    var args = '';
    {foreach from=$more_view_args key=key item=item name='more_view_args'}
        {if $smarty.foreach.more_view_args.first}
            args += "{$key|escape:javascript}" + "=" + "{$item|escape:javascript}";
        {else}
            args += "&" + "{$key|escape:javascript}" + "=" + "{$item|escape:javascript}";
        {/if}
    {/foreach}

    var options = {ldelim}require_url : '{grn_pageurl page=$request_page}',
                          ul_id : '{$list_id|grn_noescape}',
                          arg : args,
                          sp : '{$offset|grn_noescape}'{rdelim};
    grn.component.mobile_list_more_view.setMoreView(options);
{literal}
})()
</script>
{/literal}
<ul data-role="listview" data-theme="{$data_theme}" id="ul_{$list_id|grn_noescape}" class="mobile-ul-top-grn mobile-ul-bottom-grn">
  <li class="mobile-showMore-grn">
    <input type="button" value="{cb_msg module='grn.space' key='space_mobile-1' replace='true'}" data-theme="{$data_theme}" onclick="grn.component.mobile_list_more_view.getMoreView('{$list_id|grn_noescape}', '{$trigger_create}')"/>
  </li>
</ul>
{/if}