{capture name='list_title'}
  {if $request_page == 'schedule/mobile/ajax/attendee_list'}
    {cb_msg module="grn.schedule" key='GRN_SCH-43' replace='true'}
  {else}
    {cb_msg module="grn.schedule" key='GRN_SCH-318' replace='true'}
  {/if}
  {cb_msg module="grn.schedule" key='GRN_SCH-933' replace='true'}
{/capture}
{include file='grn/mobile_userinfo_index.tpl' trigger_create='true'}
<script language="JavaScript" text="text/javascript">
{literal}
(function($){
    var attendeeList = $('#member_list');
    attendeeList.on('create', function(e, data)
    {
        var redirect = data.responseData.list.redirect;
        if( redirect )
        {
            location.href = redirect;
        }
    });
})(jQuery)
</script>
{/literal}
