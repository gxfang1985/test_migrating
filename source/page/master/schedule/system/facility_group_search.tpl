{include file='grn/system_head.tpl'}
{include file='grn/system_header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}
<p></p>

<table  class="wrap-tree-view-result" cellspacing="0" cellpadding="5">
  <tr valign="top" class="wrap-wrap-tree-view-header">
   <td>

     <table class="wrap-tree-view-result-navi" cellspacing="0" cellpadding="0" width="100%">
       <tbody>
	 <tr valign="bottom">
	   <td class="maintain-tree-view-width">
	     <nobr><span class="sub_title">{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-424' replace='true'}</span></nobr>
	   </td>
	   <td>
	     <div style="padding:0.2em 0.5em;margin:0.2em;border:1px solid #dddddd;">
	       <table>
		 <tbody>
		   <tr>
		     <td style="padding: 1px;">
		       <form name="search" method="get" action="{grn_pageurl page='schedule/system/facility_group_search'}">
			 <input type="hidden" name="cmd" />
			 <input type="hidden" name="oid" value="{$org_id|escape}" />
			 <input type="text" name="search_text" size="20" value="{$search_text|escape}" maxlength="100" />
			 <input class="small" type="submit" value="{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-425' replace='true'}" />
		       </form>
		     </td>
		   </tr>
		 </tbody>
	       </table>
	     </div>
	   </td>
	 </tr>
       </tbody>
     </table>

     <div class="tree_view_result">
	  {foreach from=$search_result item=s_item}
	  <nobr><a class="" href="{grn_pageurl page="schedule/system/facility_group" oid=$s_item.fagid s=1}">{grn_image image="facilitygroup20.gif"}{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-426' replace='true'}{foreach from=$s_item.ancestor item=item} &gt; {$item.col_name} {/foreach}</a></nobr><br/>
	  {/foreach}
	  <br />
     </div>
   </td>
  </tr>
</tbody>
</table>

{include file='grn/system_footer.tpl'}
