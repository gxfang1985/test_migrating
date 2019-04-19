{include file='grn/head.tpl'}
{include file='grn/header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='cabinet/command_'|cat:$page_info.last}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">

{cb_msg module='grn.cabinet' key='GRN_CAB-99' replace='true'}<br>
{cb_msg module='grn.cabinet' key='GRN_CAB-100' replace='true'}<br>
 <p>
 <table class="std_form">
  <tr>
   <th>{cb_msg module='grn.cabinet' key='GRN_CAB-102' replace='true'}</th>
   <td>
{assign var="first_node" value="1"}
{grn_image image='folder20.gif'}
{foreach from=$file.position item=node}
 {if $first_node}
  {assign var="first_node" value="0"}
 {else}
&nbsp;&gt;&nbsp;
 {/if}
{$node.title|escape:"html"}
{/foreach}
   </td>
  </tr>
  {include file="grn/file_modify.tpl" disable_explanation=1 noframe=1}
 </table>
 <input type="hidden" name="hid" value="{$folder_id}">
</form>

{include file="grn/footer.tpl"}
