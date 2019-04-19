{include file='grn/system_head.tpl'}
{include file='grn/system_header.tpl'}
{grn_title title=$page_title|cat:' - Step 2/2' class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}
{capture name='select_url'}v='{grn_pageurl page='system/logging/config'}category=' + options[selectedIndex].value;location.href=v;{/capture}
{grn_load_javascript file="grn/html/form_disable.js"}
<form name="{$form_name}" method="post" action="{grn_pageurl page='system/logging/command_config'}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
<input type="hidden" name="priority" value="{$priority|escape}">
<input type="hidden" name="category" value="{$category|escape}">

<table class="std_form">
 <tr>
  <th nowrap>{cb_msg module='grn.system.logging' key='GRN_SY_LO-51' replace='true'}</th>
  <td>
{foreach from=$categories item=item}
 {foreach from=$item.child item=child}
  {if $child.selected}
   {grn_image image='category20.gif'}{$child.label|escape}
   {assign var='selected' value=1}
  {/if}
 {/foreach}
{/foreach}
{if ! $selected}
  {cb_msg module='grn.system.logging' key='GRN_SY_LO-52' replace='true'}
{/if}
  </td>
 </tr>
{foreach from=$priorities item=item}
 <tr>
  <td colspan="2"><b>{$item.name}</b></td>
 </tr>
 <tr>
  <th nowrap>{cb_msg module='grn.system.logging' key='GRN_SY_LO-53' replace='true'}</th>
  <td>
 {if $smarty.const.ON_SAAS===1}
  {if $item.on}
       {capture name='grn_system_logging_GRN_SY_LO_54'}{cb_msg module='grn.system.logging' key='GRN_SY_LO-54' replace='true'}{/capture}{grn_radio name='log_on_'|cat:$item.code id='log_on_'|cat:$item.code|cat:'_1' value='1' caption=$smarty.capture.grn_system_logging_GRN_SY_LO_54 checked=TRUE}&nbsp;{capture name='grn_system_logging_GRN_SY_LO_55'}{cb_msg module='grn.system.logging' key='GRN_SY_LO-55' replace='true'}{/capture}{grn_radio name='log_on_'|cat:$item.code id='log_on_'|cat:$item.code|cat:'_2' value='0' caption=$smarty.capture.grn_system_logging_GRN_SY_LO_55}
  {else}
       {capture name='grn_system_logging_GRN_SY_LO_56'}{cb_msg module='grn.system.logging' key='GRN_SY_LO-56' replace='true'}{/capture}{grn_radio name='log_on_'|cat:$item.code id='log_on_'|cat:$item.code|cat:'_1' value='1' caption=$smarty.capture.grn_system_logging_GRN_SY_LO_56}&nbsp;{capture name='grn_system_logging_GRN_SY_LO_57'}{cb_msg module='grn.system.logging' key='GRN_SY_LO-57' replace='true'}{/capture}{grn_radio name='log_on_'|cat:$item.code id='log_on_'|cat:$item.code|cat:'_2' value='0' caption=$smarty.capture.grn_system_logging_GRN_SY_LO_57 checked=TRUE}
  {/if}
       <input type="hidden" name="output_{$item.code}" id="output_{$item.code}_1" value="1">
 {else}
  {if $item.on}
       {capture name='grn_system_logging_GRN_SY_LO_54'}{cb_msg module='grn.system.logging' key='GRN_SY_LO-54' replace='true'}{/capture}{grn_radio name='log_on_'|cat:$item.code id='log_on_'|cat:$item.code|cat:'_1' value='1' caption=$smarty.capture.grn_system_logging_GRN_SY_LO_54 checked=TRUE onclick="setDisabled(this.form,'2:3:4','off',this)"}&nbsp;{capture name='grn_system_logging_GRN_SY_LO_55'}{cb_msg module='grn.system.logging' key='GRN_SY_LO-55' replace='true'}{/capture}{grn_radio name='log_on_'|cat:$item.code id='log_on_'|cat:$item.code|cat:'_2' value='0' caption=$smarty.capture.grn_system_logging_GRN_SY_LO_55 onclick="setDisabled(this.form,'1:2:3','on',this)"}
  {else}
       {capture name='grn_system_logging_GRN_SY_LO_56'}{cb_msg module='grn.system.logging' key='GRN_SY_LO-56' replace='true'}{/capture}{grn_radio name='log_on_'|cat:$item.code id='log_on_'|cat:$item.code|cat:'_1' value='1' caption=$smarty.capture.grn_system_logging_GRN_SY_LO_56 onclick="setDisabled(this.form,'2:3:4','off',this)"}&nbsp;{capture name='grn_system_logging_GRN_SY_LO_57'}{cb_msg module='grn.system.logging' key='GRN_SY_LO-57' replace='true'}{/capture}{grn_radio name='log_on_'|cat:$item.code id='log_on_'|cat:$item.code|cat:'_2' value='0' caption=$smarty.capture.grn_system_logging_GRN_SY_LO_57 checked=TRUE onclick="setDisabled(this.form,'1:2:3','on',this)"}
  {/if}
 {/if}
  </td>
 </tr>

 {if $smarty.const.ON_SAAS!==1}
 <tr valign="top">
  <th nowrap>{capture name='grn_system_logging_GRN_SY_LO_58'}{cb_msg module='grn.system.logging' key='GRN_SY_LO-58' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_system_logging_GRN_SY_LO_58}</th>
  <td>
      {capture name='grn_system_logging_GRN_SY_LO_59'}{cb_msg module='grn.system.logging' key='GRN_SY_LO-59' replace='true'}{/capture}{grn_radio name='output_'|cat:$item.code id='output_'|cat:$item.code|cat:'_3' value='3' caption=$smarty.capture.grn_system_logging_GRN_SY_LO_59 checked=$item.both}<br>
      {capture name='grn_system_logging_GRN_SY_LO_60'}{cb_msg module='grn.system.logging' key='GRN_SY_LO-60' replace='true'}{/capture}{grn_radio name='output_'|cat:$item.code id='output_'|cat:$item.code|cat:'_1' value='1' caption=$smarty.capture.grn_system_logging_GRN_SY_LO_60 checked=$item.dblogging}<br>
      {capture name='grn_system_logging_GRN_SY_LO_61'}{cb_msg module='grn.system.logging' key='GRN_SY_LO-61' replace='true'}{/capture}{grn_radio name='output_'|cat:$item.code id='output_'|cat:$item.code|cat:'_2' value='2' caption=$smarty.capture.grn_system_logging_GRN_SY_LO_61 checked=$item.syslog}<br>
  </td>
 </tr>
 {/if}
{/foreach}
 <tr>
  <td></td>
  <td>
       {capture name='grn_system_logging_GRN_SY_LO_62'}{cb_msg module='grn.system.logging' key='GRN_SY_LO-62' replace='true'}{/capture}{grn_button_cancel class="margin" page='system/logging/config_category' priority=$priority category=$category caption=$smarty.capture.grn_system_logging_GRN_SY_LO_62}
       {capture name='grn_system_logging_GRN_SY_LO_63'}{cb_msg module='grn.system.logging' key='GRN_SY_LO-63' replace='true'}{/capture}{grn_button_submit class="margin" caption=$smarty.capture.grn_system_logging_GRN_SY_LO_63}
       {grn_button_cancel page='system/logging/admin'}
  </td>
 </tr>
</table>

</form>

 {if $smarty.const.ON_SAAS!==1}
<script language="JavaScript">
<!--
    var d = document.forms["{$form_name}"];
{foreach from=$priorities item=item}
  {if ! $item.on}
    setDisabled(d,'1:2:3','on',d.log_on_{$item.code}_2);
  {/if}
{/foreach}
//-->
</script>
{/if}

{include file='grn/system_footer.tpl'}
