{include file="grn/head.tpl"}
{include file="grn/header.tpl"}
{grn_title title=$portal.title class=$page_info.parts[0]}
<table class="top_parts">
 <tr>
  <td valign="top">
  {if $portlet}
   {grn_portal_include_portlet portlet=$portlet display="view"}
  {else}
   &nbsp;
  {/if}
  </td>
 </tr>
</table>
{include file="grn/footer.tpl"}
