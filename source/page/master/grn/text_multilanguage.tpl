<div id="{$element_name}">
{if $is_smarty_validate}
{validate form=$form_name field=$element_name|cat:"-def" criteria='notEmpty' transform='cb_trim' append='validation_errors' message=$error_message}
{/if}
<div id="{$element_name}-add_language"></div>
<table {if $input_style eq "kintone" }class="table_grn table_type2_in_grn"{/if}>
  <tbody id="{$element_name}-label-lines">
    {foreach from=$language_codes item=language_code}
    {if $values.$language_code || $language_code == "def"}
    <tr id="{$element_name}-label-line-{$language_code}">
    <td id="{$element_name}-label-line-lang-{$language_code}">{cb_language_name code=$language_code}{if $is_smarty_validate && $language_code=="def"}<span class="attention">*</span>{/if}:</td>
    <td><input id="{$element_name}-label-line-value-{$language_code}" type="text" name="{$element_name}-{$language_code}" value="{$values.$language_code}" size="50" maxlength="100"></td>
    <td>
      {if $language_code!="def"}
        {if $input_style eq "kintone" }
            <a title="{$resource.deleteLanguage}" href="javascript:void(0);" id="{$element_name}-label-line-button-{$language_code}">
                <span class="icon-close-sub-grn v-allign-middle"></span>
            </a>
        {else}
          <input id="{$element_name}-label-line-button-{$language_code}" value="{$resource.deleteLanguage}" type="button">
        {/if}
      {/if}
    </td>
    </tr>
    {/if}
    {/foreach}
  </tbody>
</table>
</div>
{if $show_addition_button}
  {if $input_style eq "kintone" }
  <div>
      <a href="javascript:void(0)" class="icon_add_grn" id="{$element_name}-add-language" >{$resource.addLanguage}</a>
  </div>
  {else}
    <input id="{$element_name}-add-language" value="{$resource.addLanguage}" type="button" />
  {/if}
{/if}

<script>
jQuery("#{$element_name}-add-language").ready(function() {literal}{
    var o = new MultiLanguageText( "{/literal}{$element_name|escape:javascript}{literal}", {
    choices:[
        {/literal}
        {foreach from=$lang_choice item=l name="langlist"}
        "{$l}"{if !$smarty.foreach.langlist.last},{/if}
        {/foreach}
        {literal}
    ] ,
    local_name:{
        {/literal}
        {foreach from=$lang_choice item=l name="langlist"}
        "{$l}":"{cb_language_name code=$l}"{if !$smarty.foreach.langlist.last},{/if}
        {/foreach}
        {literal}
    },
    resource:{
        {/literal}
        addLanguage:"{$resource.addLanguage|escape:javascript}",
        deleteLanguage:"{$resource.deleteLanguage|escape:javascript}"
        {literal}
    }
    },
    "{/literal}{$input_style}{literal}");
    o.show();
});
{/literal}</script>
