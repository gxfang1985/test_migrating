{include file="report/cellular/header.tpl"}
{strip}

{grn_report_cellular_appname}<br />
{$pagetitle|escape}<br />
<hr />
{foreach from=$list item=item key=key}
{if $select == $key}
{$item.title}
{else}
<a href="{grn_report_cellular_pageurl page="$pagepath/list" select=$key}">{$item.title}</a>
{/if}
<br />
{/foreach}
{if $all_filters}
  {if $select == GRN_REPORT_ALL}
{cb_msg module='grn.report.cellular' key="all_filter"}
  {else}
<a href="{grn_report_cellular_pageurl page="$pagepath/list" select='all'}">{cb_msg module='grn.report.cellular' key="all_filter"}</a>
  {/if}
{/if}
<hr />

{if $filter_paging}
  {if $filter}
  {$filter.col_name}
  <hr />
  {/if}
  {if $filter_list}
    {foreach from=$filter_list item=filter}
        {grn_report_cellular_link page="report/cellular/list" type=$filter.id caption=$filter.name|grn_report_cellular_truncate:$width select=$select}<br />
    {/foreach}

    {if $navi.previous_page_start_position != -1}
        <a href="{grn_report_cellular_pageurl page="$pagepath/list" sp=$navi.previous_page_start_position params=$navi.params fragment=$navi.fragment}">{cb_msg module='grn.report.cellular' key="previous_list"}</a>&nbsp;
    {/if}
    {if $navi.next_page_start_position != -1}
        <a href="{grn_report_cellular_pageurl page="$pagepath/list" sp=$navi.next_page_start_position params=$navi.params fragment=$navi.fragment}">{cb_msg module='grn.report.cellular' key="next_list"}</a>
    {/if}
  {/if}
  {if $report_list}
    {foreach from=$report_list key=rid item=item}
        {grn_report_cellular_pictogram key="memo"}
        {grn_report_cellular_link page="report/cellular/look" rid=$item.id select=$select type=$type caption=$item.name|grn_report_cellular_truncate:$width}<br />
        {$item.form_name|grn_report_cellular_truncate:$width|escape}<br />
        {cb_date_format format='DateTimeCompact' date=$item.mtime}&nbsp;{$item.modifier_name|escape}<br />
    {/foreach}
    
    {if $navi.previous_page_start_position != -1}
        <a href="{grn_report_cellular_pageurl page="$pagepath/list" sp=$navi.previous_page_start_position params=$navi.params fragment=$navi.fragment}">{cb_msg module='grn.report.cellular' key="previous_list"}</a>&nbsp;
    {/if}
    {if $navi.next_page_start_position != -1}
        <a href="{grn_report_cellular_pageurl page="$pagepath/list" sp=$navi.next_page_start_position params=$navi.params fragment=$navi.fragment}">{cb_msg module='grn.report.cellular' key="next_list"}</a>
    {/if}
  {/if}
{else}
  {grn_report_cellular_form name="form" method="get" page="$pagepath/list" select=$select}
  <select name="type">
  {foreach from=$menu_list item=item}
    <option value="{$item.id|escape}"{if $type == $item.id} selected{/if}>
        {$item.name|escape}
    </option>
  {/foreach}
  </select><br />
  {grn_report_cellular_submit name="GO" accesskey="1" caption_module='grn.report.cellular' caption_key="submit_move"}<br />
  </form>

  {if $report_list}
    {foreach from=$report_list key=rid item=item}
        {grn_report_cellular_pictogram key="memo"}
        {grn_report_cellular_link page="report/cellular/look" rid=$item.id select=$select type=$type caption=$item.name|grn_report_cellular_truncate:$width}<br />
        {$item.form_name|grn_report_cellular_truncate:$width|escape}<br />
        {cb_date_format format='DateTimeCompact' date=$item.mtime}&nbsp;{$item.modifier_name|escape}<br />
    {/foreach}
    
    {if $navi.previous_page_start_position != -1}
        <a href="{grn_report_cellular_pageurl page="$pagepath/list" sp=$navi.previous_page_start_position params=$navi.params fragment=$navi.fragment}">{cb_msg module='grn.report.cellular' key="previous_list"}</a>&nbsp;
    {/if}
    {if $navi.next_page_start_position != -1}
        <a href="{grn_report_cellular_pageurl page="$pagepath/list" sp=$navi.next_page_start_position params=$navi.params fragment=$navi.fragment}">{cb_msg module='grn.report.cellular' key="next_list"}</a>
    {/if}
  {/if}
{/if}
<hr>
{grn_report_cellular_link page="$pagepath/search" accesskey=4 fid=$current_fid caption_module='grn.report.cellular' caption_key="search"}<br />

{/strip}
{include file="report/cellular/footer.tpl"}
