{capture name='list_title'}
  {if $request_page == 'report/mobile/ajax/attendee_list'}
    {cb_msg module="grn.report" key='GRN_RPRT-90' replace='true'}
  {else}
    {cb_msg module="grn.report" key='GRN_RPRT-86' replace='true'}
  {/if}
  {cb_msg module="grn.report" key='GRN_RPRT-87' replace='true'}
{/capture}
{include file='grn/mobile_userinfo_index.tpl'}
