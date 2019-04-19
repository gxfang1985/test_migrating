{if !$select_size}
 {assign var='select_size' value='5'}
{/if}
{if ! $form_name}
 {assign var="form_name" value=$page_info.last}
{/if}
<table border="0" cellspacing="0">
 <tr>
  <td valign="bottom" style="padding-left:0">
   <table border="0" cellspacing="0" cellpadding="0">
    <tr>
     <td style="padding-left:0; padding-bottom:0">
{if ! $no_order}
      <a href="javascript:OrderTop('{$form_name}', 'sITEM[]')">{grn_image image='order_top20.gif' alt=''}</a><br><br><a href="javascript:OrderUp('{$form_name}', 'sITEM[]')">{grn_image image='order_up20.gif' alt=''}</a><br><br><a href="javascript:OrderDown('{$form_name}', 'sITEM[]')">{grn_image image='order_down20.gif' alt=''}</a><br><br><a href="javascript:OrderBottom('{$form_name}', 'sITEM[]')">{grn_image image='order_bottom20.gif' alt=''}</a>
{/if}
     </td>
     <td class="item_select" style="padding-bottom:0">
      <select name="sITEM[]" size="{$select_size}" multiple>
{foreach from=$initialize_item key=set_id item=set_name}
       <option value="{$set_id}" selected>{$set_name|escape}</option>
{/foreach}
{if $browser.os_type == 'mac'}
       <option value="">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</option>
{else}
       <option value="">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</option>
{/if}
      </select>
     </td>
    </tr>
   </table>
  </td>
  <td class="item_right_left">
   <input type="button" value="{cb_msg module='grn.personal.calendar' key='GRN_PRS_CA-76' replace='true'}" onClick="AddMember('{$form_name}', 'cITEM[]', 'sITEM[]')"><br><br><input type=button value="{cb_msg module='grn.personal.calendar' key='GRN_PRS_CA-77' replace='true'}" onClick="RemoveMember('{$form_name}', 'sITEM[]')">
  </td>
  <td valign="bottom" style="padding-left:0">
   <table border="0" cellspacing="0" cellpadding="0">
    <tr>
     <td class="item_select" style="padding-bottom:0">
      <select name="cITEM[]" size="{$select_size}" multiple>
{foreach from=$calendars key=scid item=calendar_name }
  {if !($scid == $user_base_calendars.calendar.id) }
      <option value="{$scid}" >{$calendar_name|escape}</option>
  {/if}
{/foreach}
{if $browser.os_type == 'mac'}
       <option value="">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</option>
{else}
       <option value="">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</option>
{/if}
      </select>
     </td>
    </tr>
   </table>
  </td>
 </tr>
</table>
<div class="sub_explanation">{cb_msg module='grn.personal.calendar' key='GRN_PRS_CA-75' replace='true'}</div>
