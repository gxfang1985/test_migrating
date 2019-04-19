{**
 *  @param  string  config_id   (option)    'system' or 'prsonal'
**}

{include file="grn/`$config_id`_head.tpl"}
{include file="grn/`$config_id`_header.tpl"}

<!--page_title-->
{grn_title title=$page_title class=$page_info.parts[0]}

<!--menubar-->
<div id="main_menu_part">
    {if $config_id == 'system'}
        <span class="menu_item">{capture name='grn_rss_GRN_RSS_2'}{cb_msg module='grn.rss' key='GRN_RSS-2' replace='true'}{/capture}{grn_link page="rss/`$config_id`/add" caption=$smarty.capture.grn_rss_GRN_RSS_2 image='write20.gif'}</span>
        <span class="menu_item">{capture name='grn_rss_GRN_RSS_3'}{cb_msg module='grn.rss' key='GRN_RSS-3' replace='true'}{/capture}{grn_link page="rss/`$config_id`/separator_add" caption=$smarty.capture.grn_rss_GRN_RSS_3 image='write20.gif'}</span>
        <span class="menu_item">{capture name='grn_rss_GRN_RSS_4'}{cb_msg module='grn.rss' key='GRN_RSS-4' replace='true'}{/capture}{grn_link page="rss/`$config_id`/order" caption=$smarty.capture.grn_rss_GRN_RSS_4 image='order20.gif'}</span>
        <div id="rare_menu_part_under">
            {if $menubar_delete_all}
                <span class="menu_item">{capture name='grn_rss_GRN_RSS_5'}{cb_msg module='grn.rss' key='GRN_RSS-5' replace='true'}{/capture}{grn_link page="rss/`$config_id`/delete_all" caption=$smarty.capture.grn_rss_GRN_RSS_5 image='delete20.gif'}</span>
            {/if}
        </div>
    {else}
        <span class="menu_item">{capture name='grn_rss_GRN_RSS_6'}{cb_msg module='grn.rss' key='GRN_RSS-6' replace='true'}{/capture}{grn_link page="rss/`$config_id`/add" caption=$smarty.capture.grn_rss_GRN_RSS_6 image='write20.gif'}</span>
        <span class="menu_item">{capture name='grn_rss_GRN_RSS_7'}{cb_msg module='grn.rss' key='GRN_RSS-7' replace='true'}{/capture}{grn_link page="rss/`$config_id`/separator_add" caption=$smarty.capture.grn_rss_GRN_RSS_7 image='write20.gif'}</span>
        <span class="menu_item">{capture name='grn_rss_GRN_RSS_8'}{cb_msg module='grn.rss' key='GRN_RSS-8' replace='true'}{/capture}{grn_link page="rss/`$config_id`/order" caption=$smarty.capture.grn_rss_GRN_RSS_8 image='order20.gif'}</span>
        {if $menubar_delete_all}
            <span class="menu_item">{capture name='grn_rss_GRN_RSS_9'}{cb_msg module='grn.rss' key='GRN_RSS-9' replace='true'}{/capture}{grn_link page="rss/`$config_id`/delete_all" caption=$smarty.capture.grn_rss_GRN_RSS_9 image='delete20.gif'}</span>
        {/if}
    {/if}
</div>
<!--menubar_end-->

  <!--list-->
  <p>
  <table class="admin_list_table" width="100%">
   <tr>
    <th nowrap>{cb_msg module='grn.rss' key='GRN_RSS-10' replace='true'}</th>
   </tr>
{foreach from=$sites key=key item=item}
   <tr valign="top">
 {if $item.separator}
    <td nowrap>{grn_link caption=$item.title page="rss/`$config_id`/separator_view" key=$key}</td>
 {else}
    <td nowrap>{grn_link caption=$item.title page="rss/`$config_id`/view" key=$key image='folder20.gif'}{if $item.has_error}<a name='' title={$item.error}>(<span class="attention"><tt>!</tt></span>)</a>{/if}</td>
 {/if}
   </tr>
{/foreach}
  </table>
  <!--list_end-->

<!--footer-->
{include file="grn/`$config_id`_footer.tpl"}
