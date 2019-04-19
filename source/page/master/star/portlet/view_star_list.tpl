{if $settings.font_size == "large"}
 {assign var="font_size" value='font-size:140%;'}
 {assign var="style" value='font-size:140%;'}
{elseif $settings.font_size == "normal"}
 {assign var="font_size" value=''}
 {assign var="style" value=''}
{elseif $settings.font_size == "small"}
 {assign var="font_size" value='font-size:70%;'}
 {assign var="style" value='font-size:70%;'}
{/if}
<table class="top_title">{strip}
    <tbody>
    <tr>
        <td>
            <span class="portlet_title_grn">
                {if strcmp('all', $settings.app) === 0}
                    {capture name='grn_star_portlet_APP_NAME'}{cb_msg module='grn.star.portlet' key='GRN_STAR_PO-15' replace='true'}{/capture}
                    <a href="{grn_pageurl page='star/index'}">
                        <span class="portlet_title_name_grn" >{$page_title}</span>&nbsp;-&nbsp;{cb_msg module='grn.star.portlet' key='GRN_STAR_PO-9' replace='true'}{$smarty.capture.grn_star_portlet_APP_NAME}{cb_msg module='grn.star.portlet' key='GRN_STAR_PO-13' replace='true'}
                    </a>
                {elseif $is_supported_application}
                    {capture name='grn_star_portlet_APP_NAME'}{$supported_application_name|grn_noescape}{/capture}
                    <a href="{grn_pageurl page='star/index' app_id=$portlet.settings.app|substr:4}">
                        <span class="portlet_title_name_grn" ">{$page_title}</span>&nbsp;-&nbsp;{cb_msg module='grn.star.portlet' key='GRN_STAR_PO-9' replace='true'}{$smarty.capture.grn_star_portlet_APP_NAME}{cb_msg module='grn.star.portlet' key='GRN_STAR_PO-13' replace='true'}
                    </a>
                {else}
                    {capture name='grn_star_portlet_APP_NAME'}{cb_msg module='grn.star.portlet' key='GRN_STAR_PO-14' replace='true'}{/capture}
                    <a href="{grn_link page='star/index'}">
                        <span class="portlet_title_name_grn" ">{$page_title}</span>&nbsp;-&nbsp;{cb_msg module='grn.star.portlet' key='GRN_STAR_PO-9' replace='true'}{$smarty.capture.grn_star_portlet_APP_NAME}{cb_msg module='grn.star.portlet' key='GRN_STAR_PO-13' replace='true'}
                    </a>
                {/if}
            </span>
        </td>
    </tr>
    </tbody>
</table>{/strip}

<div class="portal_frame portal_frame_favorite_grn">
{if strcmp('all', $settings.app) === 0 || $is_supported_application}
<table class="list_column" style="{$font_size}" id="star_list{$portlet.plid}">
<colgroup>
<col width="50%" />
{if $settings.time}
<col width="50%" />
{/if}
</colgroup>
<tr>
  <th>{cb_msg module='grn.star.portlet' key='GRN_STAR_PO-3' replace='true'}</th>
  {if $settings.time}
  <th>{cb_msg module='grn.star.portlet' key='GRN_STAR_PO-6' replace='true'}</th>
  {/if}
</tr>
{foreach from=$star_list key=star_id item=star}
{assign var=app_id value=$star.module_id|substr:4} {*// grn. will trim*}
<tr>
  <td nowrap>
  {if $app_id eq 'message'}
    {if $star.org_data.mtype eq '2'}
      {grn_link page='message/draft_view' caption=$star.subject cid=$star.org_data.cid mid=$star.org_data.mid rid=$star.org_data.rid image='msg_star20.gif' truncated_caption=$subject_width}
    {else}
      {grn_link page='message/view' caption=$star.subject cid=$star.org_data.cid mid=$star.org_data.mid rid=$star.org_data.rid image='msg_star20.gif' truncated_caption=$subject_width}
    {/if}
  {elseif $app_id eq 'schedule'}
    {grn_link page="schedule/view" caption=$star.subject params=$star.org_data image="event_star20.gif" truncated_caption=$subject_width}
  {elseif $app_id eq 'mail'}
    {if $star.org_data.type eq '2'}
      {grn_link page='mail/draft_view' caption=$star.subject mid=$star.org_data.mid image='mail_star20.gif' truncated_caption=$subject_width}
    {else}
      {grn_link page='mail/view' caption=$star.subject mid=$star.org_data.mid image='mail_star20.gif' truncated_caption=$subject_width}
    {/if}
  {elseif $app_id eq 'cabinet'}
    {grn_link page="cabinet/view" caption=$star.subject params=$star.org_data image="file_star20.gif" truncated_caption=$subject_width}
  {elseif $app_id eq 'report'}
    {if $star.org_data.draft}
        {grn_link page="report/view_draft" caption=$star.subject rid=$star.org_data.rid image="report_star20.gif" truncated_caption=$subject_with}
    {else}
        {grn_link page="report/view" caption=$star.subject rid=$star.org_data.rid image="report_star20.gif" truncated_caption=$subject_width}
    {/if}
  {elseif $app_id eq 'bulletin'}
    {if $star.org_data.type eq 'draft'}
        {grn_link page="bulletin/draft_view" caption=$star.subject truncated_caption=$subject_width aid=$star.org_data.aid image="bulletin_star20.gif"}
    {elseif $star.org_data.type eq 'wait'}
        {grn_link page="bulletin/wait_view" caption=$star.subject truncated_caption=$subject_width aid=$star.org_data.aid image="bulletin_star20.gif"}
    {else}
        {grn_link page="bulletin/view" caption=$star.subject truncated_caption=$subject_width cid=$star.org_data.cid aid=$star.org_data.aid image="bulletin_star20.gif"}
    {/if}
  {elseif $app_id eq 'space'}
    {grn_link page="space/application/discussion/index" caption=$star.subject truncated_caption=$subject_width spid=$star.org_data.spid fragment=$star.org_data.tid image="spaceDiscussion_star20.png"}
  {/if}
  </td>
  {if $settings.time}
  <td nowrap>{grn_date_format date=$star.ctime format="DateTimeCompact"}</td>
  {/if}
</tr>
{/foreach}
</table>
{/if}
</div> <!--end of portal_frame -->
