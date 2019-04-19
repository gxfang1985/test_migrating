<div id="{$element_name}">
<div id="{$element_name}-add_language"></div>
<table>
  <tbody id="{$element_name}-label-lines">
    {foreach from=$language_codes item=language_code}
    {if array_key_exists($language_code, $values) || $language_code == "def"}
    <tr id="{$element_name}-label-line-{$language_code}">
    <td id="{$element_name}-label-line-lang-{$language_code}" style="padding:0px;"><span id="{$element_name}-label-line-span-lang-{$language_code}"{if count($values) <= 1} style="display:none;"{/if}>{cb_language_name code=$language_code}:</span></td>
    <td><input id="{$element_name}-label-line-value-{$language_code}" type="text" name="{$element_name}-{$language_code}" value="{$values.$language_code}" size="50" maxlength="100"></td>
    <td>{if $language_code!="def"}<input id="{$element_name}-label-line-button-{$language_code}" value="{$resource.deleteLanguage}" type="button">{/if}</td>
    </tr>
    {/if}
    {/foreach}
  </tbody>
</table>
</div>
{if $show_addition_button}
    <a id="{$element_name}-add-language" href="javascript:"><span style="font-size:80%;margin-left:6px;">{$resource.addLanguage}</span></a>
{/if}

<script>{literal}
    jQuery(function(){
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
        } );
        o.show();
    });
{/literal}</script>
