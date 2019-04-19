{if ! $param_name}{assign var="param_name" value="pdid"}{/if}
{capture name='grn_message_GRN_MEM_182'}{cb_msg module='grn.memo' key='GRN_MEM-182' replace='true'}{/capture}
<select name="{$param_name}" id="{$param_name}"{if $onchange} onchange="{$onchange}"{/if}>{if $move_folder}<option value="-1">{$smarty.capture.grn_message_GRN_MEM_182}</option>{/if}<option value="">{cb_msg module="grn.memo" key="lastest_folder_name"}</option>
{foreach from=$folder_menu key=id item=folder_name}
 <option value="{$id|escape}"{if $id == $pdid} selected{/if}>{$folder_name|escape}</option>
{/foreach}</select>
