{if ! $data_theme}{assign var='data_theme' value='c'}{/if}
{grn_load_javascript file="grn/html/page/schedule/mobile/handle_add.js"}

<script type="text/javascript" language="javascript">
    var handleAdd = grn.page.schedule.mobile.handle_add;
    handleAdd.ajaxURL = '{grn_pageurl page='schedule/mobile/command_add'}';
    handleAdd.defaultBackURL = '{grn_pageurl page='schedule/mobile/index'}';
    handleAdd.formId = '{$form_id}';
    {if $page_info.last == 'repeat_add'}
        handleAdd.conflict = '{cb_msg module='grn.schedule.personal' key='GRN_SCH_PE-71' replace='true'}';
        handleAdd.onlyNoConflict = '{cb_msg module='grn.schedule.personal' key='GRN_SCH_PE-72' replace='true'}';
        handleAdd.more = '{cb_msg module='grn.schedule.personal' key='GRN_SCH_PE-73' replace='true'}';
        handleAdd.conflictAll = '{cb_msg module='grn.schedule.personal' key='GRN_SCH_PE-74' replace='true'}';
        handleAdd.header = '<tr><th>{cb_msg module="grn.schedule.personal" key="GRN_SCH_PE-69" replace="true"}</th><th>{cb_msg module="grn.schedule.personal" key="GRN_SCH_PE-70" replace="true"}</th></tr>';
    {/if}
</script>

{if $page_info.last == 'repeat_add'}
<div data-role="popup" id="popup_duplicated" data-corners="false" data-overlay-theme="b" data-shadow="false">
    <div class="mobile_select_menu_titlebar_div_grn mobile_repeating_div_grn">
        <div data-role="listview" data-theme="{$data_theme}" class="mobile_ul_grn">
            <div class="mobile_repeating_grn">
                <div data-role="listview" data-theme="{$data_theme}" class="mobile_repeating_scroll_grn">
                    <span class="mobile_icon_attention_grn"></span>
                    <span class="mobile_repeating_text_grn"></span>
                    <table width="100%" border="0" class="mobile_repeating_table_grn">
                        <tr>
                            <th>{cb_msg module='grn.schedule.personal' key='GRN_SCH_PE-69' replace='true'}</th>
                            <th>{cb_msg module='grn.schedule.personal' key='GRN_SCH_PE-70' replace='true'}</th>
                        </tr>
                    </table>
                </div><!--mobile_error_scroll_grn end-->
            </div>
            <div class="mobile_button_area_grn mobile_button_delete_grn">
                <div class="mobile_ok_grn">
                    <input type="submit" value="{cb_msg module='grn.schedule' key='GRN_SCH-183' replace='true'}" data-inline="true" data-theme="{$data_theme}"/>
                </div>
                <div class="mobile_cancel_grn no_button">
                    <input type="button" value="{cb_msg module='grn.schedule' key='GRN_SCH-184' replace='true'}" data-inline="true" data-theme="{$data_theme}" data-disabled="false"/>
                </div>
                <div class="mobile_cancel_grn cancel_button">
                    <input type="reset" value="{cb_msg module='grn.schedule.mobile' key='GRN_SCH_MOBILE-17' replace='true'}" data-inline="true" data-theme="{$data_theme}" data-disabled="false"/>
                </div>
            </div>
        </div>
    </div><!--titlebar-->
</div><!--page-->
{/if}
<div class="mobile_margin_plus_button_grn"></div>
<div data-theme="{$data_theme}" class="mobile-buttonArea-grn">
    <div class="mobile_ok_grn">
      <input id="addBtn" type="button" value="{cb_msg module='grn.schedule.mobile' key='GRN_SCH_MOBILE-16' replace='true'}" data-inline="true" data-theme="{$data_theme}"/>
    </div>
    <div class="mobile_cancel_grn mobile_show_overlay_js">
      <input id="cancelBtn" class="cancel_button" type="reset" value="{cb_msg module='grn.schedule.mobile' key='GRN_SCH_MOBILE-17' replace='true'}" data-inline="true" data-theme="{$data_theme}" onclick="javascript:location.href='{if $is_reuse}{$back_link}{else}{grn_pageurl page=$breadcrumb_upper_page.page params=$breadcrumb_upper_page.params}{/if}'"/>
    </div>
</div>