{include file="cellular/header.tpl"}
{strip}

{grn_cellular_appname app_id="notification"}<br>
{grn_cellular_appname app_id=$app_id}<br>

<hr>

{if count($data)}
 
 {foreach item=info from=$data}
 {if $info.status == 'update'}
 <a href="{grn_cellular_pageurl page=$info.subject_page params=$info.url_params uf=true}">
 {else}
 <a href="{grn_cellular_pageurl page=$info.subject_page params=$info.url_params }">
 {/if}
  {if $info.subject_icon}
   {grn_cellular_pictogram key=$info.subject_icon}
  {elseif $info.status == 'update'}
   {grn_cellular_pictogram key='follow'}
  {else}
   {grn_cellular_pictogram key='new'}
  {/if}
  {$info.subject|regex_replace:"/[ \t\r\n]/":""|default:"."|grn_cellular_truncate:$config.subject_width|escape}
 </a><br>
  {grn_date_format format='DateTimeCompact' date=$info.timestamp}
  &nbsp;{$info.sender_name|escape}<br>
 {/foreach}
 
 {if $navigation.count > $navigation.limit}
 <br>
  {if $navigation.navi.previous_page_start_position != -1}
   {grn_cellular_link page="notification/cellular/list" sp=$navigation.navi.previous_page_start_position caption_module='grn.cellular.common' caption_key="link_back" app_id=$app_id}&nbsp;
  {else}
   {* {cb_msg module='grn.cellular.common' key="link_back"}&nbsp; *}
  {/if}
  {if $navigation.navi.next_page_start_position != -1}
   {grn_cellular_link page="notification/cellular/list" sp=$navigation.navi.next_page_start_position caption_module='grn.cellular.common' caption_key="link_next" app_id=$app_id}
  {else}
   {* {cb_msg module='grn.cellular.common' key="link_next"} *}
  {/if}
 {/if}
 
{else}
 
 {cb_msg module='grn.notification.cellular' key="none"}
 
{/if}

<hr>

{/strip}
{include file="cellular/footer.tpl"}
