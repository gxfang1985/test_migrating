{include file='cbpapi/header.tpl'}
<schedule:ScheduleSearchFreeTimesResponse>
<returns>
{foreach name="candidates" from=$candidates key=faid item=candidate}
{foreach name="candidate" from=$candidate item=datetime}
<candidate {grn_attr name="start" value=$datetime.start require=true} {grn_attr name="end" value=$datetime.end require=true} {if $faid != GRN_SCHD_ADJUST_NO_FACILITY} {grn_attr name="facility_id" value=$faid require=true} {/if}/>
{/foreach}
{/foreach}
</returns>
</schedule:ScheduleSearchFreeTimesResponse>
{include file='cbpapi/footer.tpl'}