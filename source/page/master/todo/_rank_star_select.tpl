{grn_load_javascript file="grn/html/component/pulldown_menu/pulldown_menu.js"}
{grn_load_css file="grn/html/component/pulldown_menu/pulldown_menu.css"}
<span id="{$id}">{strip}
    <dl class="selectmenu_grn selectmenu_style1_grn selectmenu_base_grn">
        <dt>
            <a href="javascript:void(0)">
                <span class="rank_star_base_grn">
                    <span class="rank_star_grn"></span>
                    {if $priority >= 1 || strlen($priority) < 1}<span class="rank_star_grn"></span>{/if}
                    {if $priority == 2}<span class="rank_star_grn"></span>{/if}
                </span>
                <span class="pulldownbutton_arrow_down_grn mLeft3"></span>
            </a>
            <input type="hidden" name="{$name}" value="{if strlen($priority) < 1}1{else}{$priority}{/if}">
        </dt>
    </dl>
    <div class="pulldown_menu_grn" style="display: none;">
        <ul>
            <li>
                <a href="javascript:void(0)">
                    <span class="rank_star_base_grn">
                        <span class="rank_star_grn"></span>
                        <span class="rank_star_grn"></span>
                        <span class="rank_star_grn"></span>
                    </span>
                    <input type="hidden" value="2">
                </a>
            </li>
            <li>
                <a href="javascript:void(0)">
                    <span class="rank_star_base_grn">
                        <span class="rank_star_grn"></span>
                        <span class="rank_star_grn"></span>
                    </span>
                    <input type="hidden" value="1">
                </a>
            </li>
            <li>
                <a href="javascript:void(0)">
                    <span class="rank_star_base_grn">
                        <span class="rank_star_grn"></span>
                    </span>
                    <input type="hidden" value="0">
                </a>
            </li>
        </ul>
    </div>
</span>{/strip}

<script type="text/javascript" language="javascript">
{literal}
(function(){
    {/literal}
    var rankStarSelect = jQuery("#{$id}");
    {literal}
    var callback = function(element){
        var selected = jQuery(element);
        var selectMenu = selected.parents('div.pulldown_menu_grn').prev();
        var selectedHTML = selected.find('span.rank_star_base_grn').html();
        selectMenu.find('span.rank_star_base_grn').html('').html(selectedHTML);
    };
    grn.component.pulldown_menu.pulldown_menu.init(rankStarSelect, callback);
})();
{/literal}
</script>