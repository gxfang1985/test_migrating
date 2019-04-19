<select name="{$selectid}_0" onChange="sso_select('{$selectid}_0','{$selectid}_1','{$textid}',{$sso_form})">
 <option value="">{cb_msg module='grn.system.sso.sso' key='GRN_SY_SS_SS-88' replace='true'}</option>
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
 <option value="%Name%">{cb_msg module='grn.system.sso.sso' key='GRN_SY_SS_SS-89' replace='true'}</option>
 <option value="%ID%">{cb_msg module='grn.system.sso.sso' key='GRN_SY_SS_SS-90' replace='true'}</option>
 <option value="%Account%">{cb_msg module='grn.system.sso.sso' key='GRN_SY_SS_SS-91' replace='true'}</option>
 <option value="%Mail%">{cb_msg module='grn.system.sso.sso' key='GRN_SY_SS_SS-92' replace='true'}</option>
 <option value="%Password%">{cb_msg module='grn.system.sso.sso' key='GRN_SY_SS_SS-93' replace='true'}</option>
 <option value="%Tel%">{cb_msg module='grn.system.sso.sso' key='GRN_SY_SS_SS-94' replace='true'}</option>
 <option value="%URL%">URL</option>
{/if}
</select>
