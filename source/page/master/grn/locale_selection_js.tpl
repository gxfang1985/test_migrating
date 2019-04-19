<script>{literal}
    jQuery(function(){
        jQuery("#{/literal}{$language_id}{literal}").on( "change", function(){
            var longDateFormats = {
                {/literal}{foreach from=$language_code_list item=l name="lang_list"}
                "{$l}":[
                {foreach from=$long_date_format_list.$l item=format name="format_list"}
                "{grn_date_format format=$format language=$l}"{if !$smarty.foreach.format_list.last},{/if}
                {/foreach}]
                {if !$smarty.foreach.lang_list.last},{/if}
                {/foreach}{literal}
            };

            var shortDateFormats = {
                {/literal}{foreach from=$language_code_list item=l name="lang_list"}
                "{$l}":[
                {foreach from=$short_date_format_list.$l item=format name="format_list"}
                "{grn_date_format format=$format language=$l}"{if !$smarty.foreach.format_list.last},{/if}
                {/foreach}]
                {if !$smarty.foreach.lang_list.last},{/if}
                {/foreach}{literal}
            };

            var timeFormats = {
                {/literal}{foreach from=$language_code_list item=l name="lang_list"}
                "{$l}":[
                {foreach from=$time_format_list.$l item=format name="format_list"}
                "{grn_date_format format=$format language=$l}"{if !$smarty.foreach.format_list.last},{/if}
                {/foreach}]
                {if !$smarty.foreach.lang_list.last},{/if}
                {/foreach}{literal}
            };

            function updateSelectBox( elementId, formats ) {
                var select_elm = jQuery("#" + elementId);
                select_elm.find("option").each(function(idx, elm){
                    jQuery(elm).remove();
                });

                for( var i = 0, formatsLength = formats.length; i < formatsLength; i++ ){
                    var format = formats[i];
                    var option = document.createElement("option");
                    option.setAttribute("value", i);
                    option.innerHTML = format;
                    select_elm.append(option);
                }
            }

            updateSelectBox( "{/literal}{$long_date_format_id}{literal}", longDateFormats[jQuery("#{/literal}{$language_id}{literal}").val()] );
            updateSelectBox( "{/literal}{$short_date_format_id}{literal}", shortDateFormats[jQuery("#{/literal}{$language_id}{literal}").val()] );
            updateSelectBox( "{/literal}{$time_format_id}{literal}", timeFormats[jQuery("#{/literal}{$language_id}{literal}").val()] );
        });
    });
{/literal}</script>
