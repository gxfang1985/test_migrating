{include file="grn/system_head.tpl"}
{include file="grn/system_header.tpl"}
{grn_title title=$page_title class=""}
{assign var="form_name" value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='star/system/command_common_set'}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
{php}
$this->assign('app_name', array(
    'app_name' => mb_strtolower( cb_msg('grn.star', 'application_name') ),
));
{/php}
 <p>
 <table class="std_form">
  <!--category_items-->
  <tr>
   <th valign="top">{capture name='grn_star_system_STAR_NUM_LABEL'}{cb_msg module='grn.star.system' key='star_number_label' params=$app_name}{/capture}{grn_show_input_title title=$smarty.capture.grn_star_system_STAR_NUM_LABEL}</th>
   <td>
   <select name="star_limit">
   {foreach from=$star_limit_menu item=count}
     {if $count == -1}
      <option value="{$count}" {if $star_limit == $count}selected{/if}>{cb_msg module='grn.star.system' key='GRN_STAR_SY-6' replace='true'}</option>
     {else}
      <option value="{$count}" {if $star_limit == $count}selected{/if}>{$count}</option>
     {/if}
   {/foreach}
   </select>
   {cb_msg module='grn.star.system' key='GRN_STAR_SY-7' replace='true'}
   </td>
  </tr>
  <tr>
   <td><br></td>
   <td>
       {capture name='grn_star_system_GRN_STAR_SY_3'}{cb_msg module='grn.star.system' key='GRN_STAR_SY-3' replace='true'}{/capture}{grn_button_submit class="margin" caption=$smarty.capture.grn_star_system_GRN_STAR_SY_3}
       {grn_button_cancel}
   </td>
  </tr>
 </table>
</form>
{include file="grn/system_footer.tpl"}