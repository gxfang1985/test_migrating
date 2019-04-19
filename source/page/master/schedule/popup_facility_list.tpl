{assign var='popup_facility_list' value=true}
{if $system_display}
 {include file="grn/popup_system_head.tpl"}
{else}
 {include file="grn/popup_head.tpl"}
{/if}
<div class="popup_title_grn">
 <div class="float_left">
     {grn_title title=$page_title class='grn'}
 </div>
 <a href="#" onclick="window.close();" role="button">
  <div title="{cb_msg module='grn.grn' key='GRN_GRN-840' replace='true'}"
       aria-label="{cb_msg module='grn.grn' key='GRN_GRN-840' replace='true'}" class="subWindowClose-grn"></div>
 </a>
 <div class="clear_both_0px"></div>
</div>

{include file='schedule/_facility_list.tpl'}

<script language="JavaScript" type="text/javascript">
<!--
window.focus();
//-->
</script>

</div><!--body_end-->
