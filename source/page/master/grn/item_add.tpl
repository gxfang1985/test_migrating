{if !$select_size}
 {assign var='select_size' value='5'}
{/if}
{if $item_group}
{literal}
<script language="JavaScript" type="text/javascript">
<!--
{/literal}
{if ! $multiple_str}
 {literal}
function EnterItem( form, selected, from )
{
    var opt = form.elements[from].options;
    li = opt.length - 1;
    for( i = 0; i < li ; ++i )
    {
        if( opt[i].selected )
        {
            form.eye.value = opt[i].text;
            form.ItemID.value = opt[i].value;
            return;
        }
    }
}
 {/literal}
{/if}
{literal}
function ChangeITEM( form )
{
    var a = form.elements['cITEM[]'].options;
    var lo = new Option( a[a.length-1].text, "" );
    for( i = a.length-1 ; i > 0 ; i-- ) a[i] = null;
    a[0] = lo;
    var nGID = form.ITEM.value
{/literal}{foreach from=$item_group item=select_item}
    if( nGID == "{$select_item.id}" )
{literal}    {{/literal}
 {foreach from=$select_item.item key=iid item=title}
 au(a,"{$iid}","{$title|escape:'javascript'}");
 {/foreach}
{literal}   }{/literal}
{/foreach}
{literal}   else
    {
        return;
    }
    form.elements['cITEM[]'].focus();
}
//-->
</script>{/literal}{/if}
{if ! $form_name}
 {assign var="form_name" value=$page_info.last}
{/if}
<table border="0" cellspacing="0">
 <tr>
  <td valign="bottom" style="padding-left:0">
   <br>
   <table border="0" cellspacing="0" cellpadding="0">
    <tr>
     <td style="padding-left:0; padding-bottom:0">
{if ! $multiple_str}
     <br><input type="text" readonly name="eye" value="{$initialize_item.title}"><input type="hidden" name="ItemID" value="{$initialize_item.id}"></td>
{else}
 {if ! $no_order}
      <a href="javascript:OrderUp('{$form_name}', 'sITEM[]')">{grn_image image='order_up20.gif' alt=''}</a><br><br><a href="javascript:OrderDown('{$form_name}', 'sITEM[]')">{grn_image image='order_down20.gif' alt=''}</a>
 {/if}
     </td>
     <td class="item_select" style="padding-bottom:0">
      <select name="sITEM[]" class="user_select_list" size="{$select_size}" multiple>
 {foreach from=$initialize_item key=set_id item=set_name}
       <option value="{$set_id}" selected>{$set_name|escape}</option>
 {/foreach}
       <option value="">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</option>
      </select>
     </td>
{/if}
    </tr>
   </table>
  </td>
  <td class="item_right_left"><br>
{if ! $multiple_str}
   <br><input type="button" value="{cb_msg module='grn.grn' key='GRN_GRN-1386' replace='true'}" onClick="EnterItem( this.form, 'cITEM[]', 'cITEM[]' ){if $enteritem_javascript};{$enteritem_javascript}{/if}">
{else}
   <br><input type="button" value="{cb_msg module='grn.grn' key='GRN_GRN-1387' replace='true'}" onClick="AddMember('{$form_name}', 'cITEM[]', 'sITEM[]');"><br><br><input type=button value="{cb_msg module='grn.grn' key='GRN_GRN-1388' replace='true'}" onClick="RemoveMember('{$form_name}', 'sITEM[]' );">
{/if}
  </td>
  <td valign="bottom" style="padding-left:0">
   <table border="0" cellspacing="0" cellpadding="0">

 {if ! $no_pulldown}
    <tr><td><select id="item_groupSelect" name="ITEM" onChange="ChangeITEM( this.form )"> {foreach from=$item_group item=itemg}
    <option value="{$itemg.id|escape}" >{$itemg.title|escape}
 {/foreach}
   </select></td></tr>
 {/if}
    <tr>
     <td class="item_select">
      <select name="cITEM[]" class="user_select_list" size="{$select_size}" multiple>
{foreach from=$item_group.0.item key=set_cid item=cITEM_set}
       <option value="{$set_cid}" >{$cITEM_set|escape}
{/foreach}
       <option value="">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</option>
      </select>
     </td>
    </tr>
   </table>
  </td>
 </tr>
</table>
