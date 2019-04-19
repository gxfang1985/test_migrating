{include file="cellular/header.tpl"}
{strip}

{grn_cellular_appname app_id='schedule'}<br>
{cb_msg module='grn.schedule.cellular' key="report_list"}<br>
<hr />
{$item.title}
<br />
{if $report_list}
  {foreach from=$report_list key=rid item=item}
      {grn_report_cellular_pictogram key="memo"}
      {grn_report_cellular_link page="report/cellular/look" rid=$item.id select=$select type=$type caption=$item.name|grn_report_cellular_truncate:$width}<br />
      {$item.form_name|grn_report_cellular_truncate:$width|escape}<br />
      {cb_date_format format='DateTimeCompact' date=$item.mtime}&nbsp;{$item.modifier_name|escape}<br />
  {/foreach}
    
  {if $navi.previous_page_start_position != -1}
    <a href="{grn_report_cellular_pageurl page="$pagepath/report_list" eid=$eid mid=$mid day=$day sp=$navi.previous_page_start_position params=$navi.params fragment=$navi.fragment}">{cb_msg module='grn.report.cellular' key="previous_list"}</a>&nbsp;
  {/if}
  {if $navi.next_page_start_position != -1}
    <a href="{grn_report_cellular_pageurl page="$pagepath/report_list" eid=$eid mid=$mid day=$day sp=$navi.next_page_start_position params=$navi.params fragment=$navi.fragment}">{cb_msg module='grn.report.cellular' key="next_list"}</a>   {/if}
{/if}
<hr>
{/strip}
{grn_cellular_link page="$pagepath/look1" eid=`$eid` mid=$mid day=$day accesskey="2" caption_module='grn.schedule.cellular' caption_key="link_look"}<br>
{include file="schedule/cellular/footer.tpl"}
{include file="cellular/footer.tpl"}