{include file="grn/head.tpl"}
{include file="grn/header.tpl"}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename|cat:$tmp_key}

<form name="{$form_name}" method="post" enctype="multipart/form-data" action="{grn_pageurl page='address/command_'|cat:$page_info.last}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
 <p><div class="explanation">{cb_msg module='grn.address' key='GRN_ADDR-22' replace='true'}</div></p>
{include file='grn/show_validation_errors.tpl'}
{include file='grn/indispensable.tpl'}
 <table class="std_form">
  <tr>
   <th>{$book_info.items.display_name.display_name}</th>
   <td>
{if $book_id > 0}
    {$book_info.items.display_name.value|escape}
{else}
    {cb_msg module='grn.address' key='GRN_ADDR-23' replace='true'}{$resources.application_name|escape}
{/if}
   </td>
  </tr>
   <!--bulitin_items-->
{foreach from=$builtin_items key=item_id item=item}
    {if $item_id != 'route_time' && $item_id != 'route_fare' && $item_id != 'route_detail'}
        {if $item.use}
            {assign var='not_modify' value=$item.not_modify}
            {if $not_modify}
                {assign var='necessary' value=false}
            {else}
                {assign var='necessary' value=$item.necessary}
            {/if}
            {assign var='value' value=$card.$item_id}
            {capture name='front'}{/capture}
            {capture name='rear'}{/capture}
            {if $item_id == 'personal_name'}
                {capture name='grn_address_GRN_ADDR_24'}{cb_msg module='grn.address' key='GRN_ADDR-24' replace='true'}{/capture}{assign var='display_name' value=$smarty.capture.grn_address_GRN_ADDR_24}
                {capture name='front'}{capture name='grn_address_GRN_ADDR_25'}{cb_msg module='grn.address' key='GRN_ADDR-254' replace='true'}{/capture}{capture name='grn_address_GRN_ADDR_26'}{cb_msg module='grn.address' key='GRN_ADDR-255' replace='true'}{/capture}{include file='address/_action_item_contents_name.tpl' family_id='address_family_name' family_key='family_name' family_validate=$smarty.capture.grn_address_GRN_ADDR_25 given_id='address_given_name' given_key='given_name' given_validate=$smarty.capture.grn_address_GRN_ADDR_26}{/capture}
            {elseif $item_id == 'personal_sort_key'}
                {capture name='grn_address_GRN_ADDR_27'}{cb_msg module='grn.address' key='GRN_ADDR-27' replace='true'}{/capture}{assign var='display_name' value=$smarty.capture.grn_address_GRN_ADDR_27}
                {capture name='front'}{capture name='grn_address_GRN_ADDR_28'}{cb_msg module='grn.address' key='GRN_ADDR-256' replace='true'}{/capture}{capture name='grn_address_GRN_ADDR_29'}{cb_msg module='grn.address' key='GRN_ADDR-257' replace='true'}{/capture}{include file='address/_action_item_contents_name.tpl' family_id='address_family_sort_key' family_key='family_sort_key' family_validate=$smarty.capture.grn_address_GRN_ADDR_28 given_id='address_given_sort_key' given_key='given_sort_key' given_validate=$smarty.capture.grn_address_GRN_ADDR_29}{/capture}
            {else}
                {assign var='display_name' value=$item.display_name}
                {include file='address/_action_item_contents.tpl'}
            {/if}
{if $item.type == GRN_ADDRESS_ITEM_MULTIPLE_STRING || $item_id == 'route'}
  <tr valign="top">
{else}
  <tr>
{/if}
   <th>{grn_show_input_title title=$display_name necessary=$necessary}</th>
   <td>
         {if $item_id == 'route'}
     <table id="js_route_search">
         {else}
     <table>
         {/if}
      <tr>
            {if $smarty.capture.front && $smarty.capture.rear}
       <td>{$smarty.capture.front|grn_noescape}</td>
       <td>{$smarty.capture.rear|grn_noescape}</td>
            {else}
       <td>{$smarty.capture.front|grn_noescape}</td>
            {/if}
      </tr>
     </table>
   </td>
  </tr>
        {/if}
    {/if}
{/foreach}
   <!--builtin_items_end-->
   <!--extended_items-->
{foreach from=$extended_items key=item_id item=item}
    {if $item.use}
        {assign var='not_modify' value=$item.not_modify}
        {if $not_modify}
            {assign var='necessary' value=false}
        {else}
            {assign var='necessary' value=$item.necessary}
        {/if}
{if $item.type == GRN_ADDRESS_ITEM_MULTIPLE_STRING}
  <tr valign="top">
{else}
  <tr>
{/if}
   <th>{grn_show_input_title title=$item.display_name necessary=$item.necessary}</th>
   <td>
        {assign var='value' value=$card.$item_id}
        {capture name='front'}{/capture}
        {capture name='rear'}{/capture}
        {include file='address/_action_item_contents.tpl'}
    <table>
     <tr>
        {if $smarty.capture.front && $smarty.capture.rear}
      <td>{$smarty.capture.front|grn_noescape}</td>
      <td>{$smarty.capture.rear|grn_noescape}</td>
        {else}
      <td>{$smarty.capture.front|grn_noescape}</td>
        {/if}
     </tr>
    </table>
   </td>
  </tr>
    {/if}
{/foreach}
   <!--extended_items_end-->
{literal}
<script language="JavaScript" type="text/javascript">
<!--
function get_subject_type( f )
{
    if( f.family_name && f.family_name.value )
    {
        var personal_name = f.family_name.value;
        if( f.given_name && f.given_name.value )
        {
            personal_name += ' ' +  f.given_name.value;
        }

        if( personal_name == f.subject.value )
        {
            return 'personal_name';
        }
    }
    else if( f.given_name && f.given_name.value )
    {
        if( f.given_name.value == f.subject.value )
        {
            return 'personal_name';
        }
    }
    else if( f.company_name && f.company_name.value )
    {
        if( f.company_name.value == f.subject.value )
        {
            return 'company_name';
        }
    }

    return 'subject';
}
{/literal}
var g_subject_type = get_subject_type( document.forms['{$form_name}'] );
{literal}
function complete_subject( f, is_subject )
{
    if( is_subject && f.subject.value )
    {
        g_subject_type = 'subject';
    }
    else if( f.family_name && f.family_name.value )
    {
        var personal_name = f.family_name.value;
        if( f.given_name && f.given_name.value )
        {
            personal_name += ' ' +  f.given_name.value;
        }

        if( 'subject' != g_subject_type || f.subject.value == '' )
        {
            f.subject.value = personal_name;
            g_subject_type = 'personal_name';
        }
    }
    else if( f.given_name && f.given_name.value )
    {
        if( 'subject' != g_subject_type || f.subject.value == '' )
        {
            f.subject.value = f.given_name.value;
            g_subject_type = 'personal_name';
        }
    }
    else if( f.company_name && f.company_name.value )
    {
        if( 'company_name' == g_subject_type || f.subject.value == '' ||
            ( 'personal_name' == g_subject_type && '' == f.family_name.value && '' == f.given_name.value ) )
        {
            f.subject.value = f.company_name.value;
            g_subject_type = 'company_name';
        }
    }
}

//-->
</script>
{/literal}
  <tr>
   <td></td>
   <td>
       <div class="mTop10">
           {strip}
               {capture name='grn_address_GRN_ADDR_30'}{cb_msg module='grn.address' key='GRN_ADDR-30' replace='true'}{/capture}
               {grn_button id='address_book_button_save' ui='main' spacing='normal' action='submit' caption=$smarty.capture.grn_address_GRN_ADDR_30}
               {grn_button id='address_book_button_cancel' action='cancel' page='address/view' page_param_bid=$book_id page_param_cid=$card_id}
           {/strip}
       </div>
   </td>
  </tr>
 </table>
 <input type="hidden" name="bid" value="{$book_id}">
 <input type="hidden" name="cid" value="{$card_id}">
 <input type="hidden" name="company_code" value="">
 <input type="hidden" name="map" value="{$card.map}">
 <input type="hidden" name="tmp_key" value="{$tmp_key}">
</form>
{grn_load_javascript file="grn/html/component/auto_phonetic.js"}
{grn_load_javascript file="grn/html/page/address/address.js"}
{include file="grn/footer.tpl"}
