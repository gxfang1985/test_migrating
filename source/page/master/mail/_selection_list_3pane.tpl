{strip}
    {grn_load_css file="grn/html/component/pulldown_menu/pulldown_menu.css"}
    <script type="text/javascript">
        var S = grn.page.mail.mail_list;
    </script>
    {* ステータスの絞り込み *}
    <span class="action_grn menu_item_dropdown_grn">
        <a id="{$stid}" href="javascript:void(0);" title="{cb_msg module='grn.mail' key='GRN_MAIL-444' replace='true'}" class="mRight3">
            <span class="filter_small_icon_grn"></span>
            <span class="arrow_down_small_icon_grn"></span>
        </a>
        <div class="mail-dropdownContents">
            <ul>
                <li>
                    <a class="mail-statusNormal-grn" href="javascript:void(0);" onclick="S.filter='';S.status_id='0';S.sortAndFilterMailList();return;">
                        <span class="pulldown_menu_select_mark_grn" id="filter_status_all"></span>{cb_msg module="grn.mail" key="GRN_MAIL-466" replace="true"}
                    </a>
                </li>
                <li>
                    <a class="mail-statusNormal-grn" href="javascript:void(0);" onclick="S.filter='unread';S.status_id='0';S.sortAndFilterMailList();return;">
                        <span class="pulldown_menu_select_mark_none_grn" id="filter_status_unread"></span>{cb_msg module="grn.mail" key="GRN_MAIL-467" replace="true"}
                    </a>
                </li>
                {if $options}
                    <li>
                        <div class="border_partition_pulldown_grn"></div>
                    </li>
                {/if}
                {foreach name=option_data from=$options item=option}
                    <li>
                        <a {if $option.class}class="{$option.class}" {else}style="color:#{$option.color}"{/if} href="javascript:void(0);" onclick="S.filter='';S.status_id='{$option.value}';S.sortAndFilterMailList();">
                            <span class="pulldown_menu_select_mark_none_grn" id="filter_status_{$option.value}"></span>{$option.label}
                        </a>
                    </li>
                {/foreach}
            </ul>
        </div>
    </span>
{/strip}