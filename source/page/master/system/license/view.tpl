{include file="grn/system_head.tpl"}
{include file="grn/system_header.tpl"}
{grn_title title=$page_title class=$page_info.parts[0]}

<table class="view_table">
 {foreach from=$license item=data}
 <tr>
  <th nowrap>
     {$data.title|escape}
  </th>
  <td>
     {$data.value|escape}
  </td>
 </tr>
 {/foreach}
</table>

{include file="grn/system_footer.tpl"}
