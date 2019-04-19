{strip}
    {if $multi_selected_group eq "true"}
        <div class="mobile-tab-grn">
            <div class="mobile_left_grn mobile_selected_grn">
                <span data-ajax="false">{cb_msg module='grn.mobile' key='GRN_MOBILE-24' replace='true'}</span>
            </div>
            <div class="mobile_right_grn mobile_unselected_grn">
                <a class="ui-link" data-ajax="false" href="#_popup_role_categories_tree_{$sUID}">{cb_msg module='grn.mobile' key='GRN_MOBILE-25' replace='true'}</a>
            </div>
        </div>
        <div class="mobile_separation_line_grn"></div>
    {elseif $multi_selected_role eq "true"}
        <div class="mobile-tab-grn">
            <div class="mobile_left_grn mobile_unselected_grn">
                <a class="ui-link" data-ajax="false" href="#_popup_group_categories_tree_{$sUID}">{cb_msg module='grn.mobile' key='GRN_MOBILE-24' replace='true'}</a>
            </div>
            <div class="mobile_right_grn mobile_selected_grn">
                <span data-ajax="false"">{cb_msg module='grn.mobile' key='GRN_MOBILE-25' replace='true'}</span>
            </div>
        </div>
        <div class="mobile_separation_line_grn"></div>
    {/if}
{/strip}