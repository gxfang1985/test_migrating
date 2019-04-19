<select name="{$selectid}_0" onChange="sso_select('{$selectid}_0','{$selectid}_1','{$textid}',{$sso_form})">
 <option value="0">{cb_msg module='grn.personal.sso.sso' key='GRN_PRS_SO_S-11' replace='true'}</option>
 {foreach from=$application item=appl}
  {if $value.application == $appl.id}
  <option value="{$appl.id}" selected>{$appl.title}</option>
   {assign var='values_class' value='none'}
  {else}
  <option value="{$appl.id}">{$appl.title}</option>
  {/if}
 {/foreach}
</select>
<select name="{$selectid}_1" onChange="sso_input('{$selectid}_1','{$textid}',{$sso_form})" {if ! $values_class}style="display:none;"{/if}>
{foreach from=$application item=cfg}
 {if $value.application == $cfg.id}
  {foreach from=$cfg.option item=see}
   {if $value.option_id == $see.id}
 <option value="{$see.id}" selected>{$see.title}</option>
   {else}
 <option value="{$see.id}">{$see.title}</option>
   {/if}
  {/foreach}
 {/if}
{/foreach}
{if ! $value.option_id}
 <option value="%Name%">{cb_msg module='grn.personal.sso.sso' key='GRN_PRS_SO_S-12' replace='true'}</option>
 <option value="%ID%">{cb_msg module='grn.personal.sso.sso' key='GRN_PRS_SO_S-13' replace='true'}</option>
 <option value="%Account%">{cb_msg module='grn.personal.sso.sso' key='GRN_PRS_SO_S-14' replace='true'}</option>
 <option value="%Mail%">{cb_msg module='grn.personal.sso.sso' key='GRN_PRS_SO_S-15' replace='true'}</option>
 <option value="%Password%">{cb_msg module='grn.personal.sso.sso' key='GRN_PRS_SO_S-16' replace='true'}</option>
 <option value="%Tel%">{cb_msg module='grn.personal.sso.sso' key='GRN_PRS_SO_S-17' replace='true'}</option>
 <option value="%URL%">URL</option>
{/if}
</select>