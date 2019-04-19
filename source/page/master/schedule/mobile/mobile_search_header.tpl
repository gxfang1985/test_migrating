{strip}
{*search part*}
<div class="mobile_schedulelist_search_grn" style="display: none">
    <div class="mobile_seletedUser_list_grn">
        <form name="SearchForm">
            <div class="mobile_user_search_grn">
                <input type="search" name="search_text" class="tbsearch" placeholder="{$place_holder}"/>
                <a href="javascript:void(0);" class="mobile_delete_icon_grn"></a>
                <a id="mobile_event_search" class="mobile_icon_grn"></a>
            </div>
            {* list *}
            <div class="mobile_pulldown_user_incremental_search_grn">
                <div class="mobile_userselect_space_grn"></div>
                <div class="mobile_user_list_scroll_grn">
                    <ul data-role="listview" data-theme="c"
                        class="mobile-ul-top-grn mobile-ul-bottom-grn mobile_user_list_grn">
                    </ul>
                </div>
                <!--mobile_user_list_scroll_grn-->
            </div>
            {* end list*}
        </form>
        <div class="mobile_userlines_grn"></div>
    </div>
</div>
{*end search part*}
{/strip}