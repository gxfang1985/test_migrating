{* set link *}
{if $mode == 'system'}
    {assign var="portlet_display_modify_link" value="portal/system/portlet_display_modify"}
    {assign var="access_list_link" value="portal/system/access_list"}
    {assign var="move_link" value="portal/system/portlet_move"}
{elseif $mode == 'operation'}
    {assign var="portlet_display_modify_link" value="portal/operation/portlet_display_modify"}
    {assign var="access_list_link" value="portal/operation/access_list"}
    {assign var="move_link" value="portal/operation/portlet_move"}
{elseif $mode == 'personal'}
    {assign var="portlet_display_modify_link" value="portal/personal/portlet_display_modify"}
    {assign var="move_link" value="portal/personal/portlet_move"}
{elseif $mode == 'template'}
    {assign var="move_link" value="portal/system/base_portlet_move"}
{/if}
<li class="portlet_row">
    <div class="portlet_frame{if $item.is_open || $mode == 'personal' || $mode == 'template'} public{else} private{/if}">
        <table id="portlet_row_table_{$key}" class="portlet_row_table_grn">
            <tr>
                <td class="portlet_frame_portlet_name_grn">
                    <span class="portlet_parts_trigger_grn"><span class="icon_{$item.class}_grn icon_inline_grn"></span><span class="portlet_title">{if $item.name}{$item.name|escape}{else}{$item.title|escape}{/if}</span></span>
                </td>
                <td class="portlet_frame_action_grn" {if $mode == 'system' || $mode == 'operation'}width="130px"{else}width="30px"{/if}>
                    {if $mode == 'system' || $mode == 'operation'}
                        {capture name="on_msg"}{cb_msg module='grn.portal' key='GRN_POT-14' replace='true'}{/capture}
                        {capture name="off_msg"}{cb_msg module='grn.portal' key='GRN_POT-16' replace='true'}{/capture}
                        {include file="grn/component/toggle_button.tpl" id="open_button_"|cat:$item.plid button_on=$item.is_open on_msg=$smarty.capture.on_msg off_msg=$smarty.capture.off_msg}
                    {/if}
                    <a href="javascript:void(0)" class="setting_icon_grn action_base_grn vAlignMiddle-grn"><span class="icon_setting_grn icon_inline_grn icon_only_grn"></span></a>
                    <div id="portlet_setting_tab_{$key}" class="pulldown_menu_grn portlet_setting_menu">
                        {strip}
                        <ul>
                            {if !($item.type == 'grn.portal.application_menu' ||
                                  $item.type == 'grn.portal.information' ||
                                  $item.type == 'grn.portal.calendar' ||
                                  $item.type == 'grn.portal.send' ||
                                  $item.type == 'grn.portal.html' ||
                                  $item.type == 'grn.portal.php' ) }
                                <li id="portlet_modify_{$key}"{if $item.no_availability} class="pulldown_menu_disable_grn"{/if}>
                                    <a href="javascript:void(0)"{if ! $item.no_availability} onclick="grn.page.portal.setting.openPortletTitleModify({$portal_id}, {$item.plid}, {$item.ppid})"{/if}>
                                        <span class="icon_inline_grn icon_edit_grn"></span>
                                        <span class="vAlignMiddle-grn">{cb_msg module='grn.portal' key='GRN_POT-18' replace='true'}</span>
                                    </a>
                                </li>
                            {/if}

                            {if $mode == 'system' || $mode == 'operation' || $mode == 'personal'}
                                {if $item.set_template}
                                    <li id="portlet_setting_{$key}"{if $item.no_availability} class="pulldown_menu_disable_grn"{/if}>
                                        <a {if $item.no_availability}href="javascript:void(0)"{else}href="{grn_pageurl page=$portlet_display_modify_link pid=$portal_id plid=$item.plid ppid=$item.ppid}"{/if}>
                                            <span class="icon_inline_grn icon_setting_grn"></span>
                                            <span class="vAlignMiddle-grn">{cb_msg module='grn.portal' key='GRN_POT-19' replace='true'}</span>
                                        </a>
                                    </li>
                                {/if}
                            {/if}
                            {if $mode == 'system' || $mode == 'operation'}
                                <li id="portlet_privilege_{$key}"{if $item.no_availability} class="pulldown_menu_disable_grn"{/if}>
                                    <a {if $item.no_availability}href="javascript:void(0)"{else}href="{grn_pageurl page=$access_list_link pid=$portal_id plid=$item.plid  ppid=$item.ppid}"{/if}>
                                        <span class="icon_inline_grn icon_access_grn"></span>
                                        <span class="vAlignMiddle-grn">{cb_msg module='grn.portal' key='GRN_POT-20' replace='true'}</span>
                                    </a>
                                </li>
                            {/if}
                            {if $mode == 'system'}
                                <li>
                                    {if $item.type == 'grn.portal.php'}
                                        <a href="{grn_pageurl page='portal/system/php_portlet_modify' plid=$item.ppid}">
                                            <span class="icon_inline_grn icon_setting_grn"></span>
                                            <span class="vAlignMiddle-grn">{cb_msg module='grn.portal.system' key='php_portlet_modify'}</span>
                                        </a>
                                    {elseif $item.type == 'grn.portal.html'}
                                        <a href="{grn_pageurl page='portal/system/html_portlet_modify' plid=$item.ppid}">
                                            <span class="icon_inline_grn icon_setting_grn"></span>
                                            <span class="vAlignMiddle-grn">{cb_msg module='grn.portal.system' key='html_portlet_modify'}</span>
                                        </a>
                                    {/if}
                                </li>
                            {/if}
                            {if $browser.type eq 'mobilesafari' || $browser.type eq 'android' || $browser.screen_type eq 'touch'}
                                <li id="portlet_move_{$key}">
                                    <a href="{grn_pageurl page=$move_link pid=$portal_id position=$position plid=$item.plid  ppid=$item.ppid}">
                                        <span class="icon_inline_grn icon_move_grn"></span>
                                        <span class="vAlignMiddle-grn">{cb_msg module='grn.portal' key='GRN_POT-23' replace='true'}</span>
                                    </a>
                                </li>
                            {/if}
                            <li id="portlet_delete_{$key}">
                                <a href="javascript:void(0)" onclick="grn.page.portal.setting.deletePortlet({$item.plid})">
                                    <span class="icon_inline_grn icon_delete_grn"></span>
                                    <span class="vAlignMiddle-grn">{cb_msg module='grn.portal' key='GRN_POT-24' replace='true'}</span>
                                </a>
                            </li>
                        </ul>
                        {/strip}
                    </div>
                </td>
            </tr>
            <tr>
                <td colspan="2">
                    {if !$item.no_availability }
                    <div class="setting_portlet_frame_grn top_parts">{grn_portal_include_portlet portlet=$item display="view"}</div>
                    <div class="portlet_parts_trigger_bottom_grn"></div>
                    {/if}
                </td>
            </tr>
        </table>
    </div>
</li>
