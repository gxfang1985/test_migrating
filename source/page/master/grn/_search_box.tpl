{grn_load_javascript file="grn/html/component/search_box.js"}
<div class="search_navi">
    <div class="searchbox-grn">
        <div id="searchbox-cybozu-{$id_searchbox}"
             class="input-text-outer-cybozu searchbox-keyword-area searchbox_keyword_grn">
            <input class="input-text-cybozu {if !$search_text}prefix-grn{/if}" style="{if $width}{$width}{else}width:246px;{/if}" type="text"
                   id="keyword_{$id_searchbox}" name="{$name_searchbox}" autocomplete="off"
                   value="{if $search_text}{$search_text}{else}{$placeholder}{/if}"
                   maxlength="{if $maxlength}{$maxlength}{else}{/if}">
            <button id="searchbox-submit-{$id_searchbox}" class="searchbox-submit-cybozu" type="{$button_type|default:'button'}"
                    title="{cb_msg module='grn.grn' key='GRN_GRN-1568' replace='true'}"
                    aria-label="{cb_msg module='grn.grn' key='GRN_GRN-1568' replace='true'}"></button>
        </div>
        <div class="clear_both_0px"></div>
    </div>
</div>

{if $search_text}
    {literal}
    <script language="JavaScript" type="text/javascript">
    <!--
    window.onload = function() {
        var search_box_instance = grn.component.search_box.get_instance("{/literal}{$id_searchbox}{literal}");
        search_box_instance.firstFlag = false;
        search_box_instance.$textField.val("{/literal}{$search_text}{literal}");
        search_box_instance.defaultText = "{/literal}{$placeholder}{literal}";
    };
    //-->
    </script>
    {/literal}
{/if}