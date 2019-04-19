{if $is_popup}
    {capture name="left_box_style"}height:470px;{/capture}
    {capture name="center_box_style"}width:244px; height:360px;{/capture}
    {capture name="right_box_style"}width:244px; height:427px;{/capture}
{else}
    {if $is_system}
        {capture name="left_box_style"}height:490px;{/capture}
        {capture name="center_box_style"}height:380px;{/capture}
        {capture name="right_box_style"}height:448px;{/capture}
    {else}
        {capture name="left_box_style"}height:490px;{/capture}
        {capture name="center_box_style"}height:380px;{/capture}
        {capture name="right_box_style"}height:447px;{/capture}
    {/if}
{/if}

{if $is_popup}
<table class="table_plain_grn w_full_grn">
{else}
<div class="select_item_setting_grn multi_select_base_grn">
<table class="table_plain_grn">
{/if}
    <tbody>
    <tr>
        {** Selected Area Start **}
        <td class="vAlignTop-grn">
            <div class="select_item_base_grn">
                {** tab start **}
                <div class="tab_menu">
                    {if $selected_tab}
                        {assign var='tab_status' value='off'}
                    {else}
                        {assign var='tab_status' value='on'}
                    {/if}
                    <div class="tab">
                        <span class="tab_left_{$tab_status}"></span>
                                    <span class="tab_{$tab_status}">
                                    <span class="nowrap-grn ">
                                        {if $is_popup}
                                        {grn_link page=$page_info.all select_func='browse' selected_tab=0 s_oid=$s_oid s_rid=$s_rid params=$url_params caption=$user_tab_name searchword=''}
                                        {else}
                                        {grn_link page=$page_info.all poid=$poid params=$ous_params caption=$user_tab_name}
                                        {/if}
                                    </span></span>
                        <span class="tab_right_{$tab_status}"></span>
                    </div>

                    {if $is_system || ($require_role_tab && $permission_to_select_role)}
                        {if selected_tab}
                            <div class="tab">
                                {if $selected_tab}
                                    {assign var='tab_status' value='on'}
                                {else}
                                    {assign var='tab_status' value='off'}
                                {/if}
                                <span class="tab_left_{$tab_status}"></span>
                                            <span class="tab_{$tab_status}">
                                                <span class="nowrap-grn ">
                                                    {if $is_popup}
                                                    {grn_link page=$page_info.all select_func='browse' selected_tab=1 s_oid=$s_oid s_rid=$s_rid params=$url_params caption=$role_tab_name searchword=''}
                                                    {else}
                                                    {grn_link page=$page_info.all poid=$poid params=$ous_params caption=$role_tab_name menu='role'}
                                                    {/if}
                                                </span>
                                            </span>
                                <span class="tab_right_{$tab_status}"></span>
                            </div>
                        {/if}
                    {/if}

                </div>
                <div class="tab_menu_end"></div>
                <div class="clear_both_0px"></div>
                {** tab end **}

                <table width="100%" cellspacing="0" cellpadding="5" style="border-collapse: collapse;">
                    <tbody>
                    {** User/Group Tab Start **}
                    {if !$selected_tab }
                        <tr valign="top">
                            {** Tree **}
                            {include file='grn/org_tree.tpl'}
                            <td class="wrap-tree-view">
                                <div id="tree_view" class="tree-view" style="{$smarty.capture.left_box_style}">
                                    {if $is_popup}
                                        {if $org_id}
                                            {capture name='grn_grn_GRN_GRN_202'}{cb_msg module='grn.grn' key='GRN_GRN-202' replace='true'}{/capture}{grn_link page=$page_info.all top=1 caption=$smarty.capture.grn_grn_GRN_GRN_202 select_func='browse' selected_tab=0 params=$url_params searchword=''}
                                        {else}
                                            {capture name='grn_grn_GRN_GRN_203'}{cb_msg module='grn.grn' key='GRN_GRN-202' replace='true'}{/capture}{grn_link page=$page_info.all top=1 caption=$smarty.capture.grn_grn_GRN_GRN_203 select_func='browse' selected_tab=0 params=$url_params class='tree-select-current' searchword=''}
                                        {/if}
                                    {else}
                                        {if $org_id}
                                            {capture name='grn_grn_GRN_GRN_978'}{cb_msg module='grn.grn' key='GRN_GRN-978' replace='true'}{/capture}{grn_link page=$page_info.all top=1 params=$ous_params caption=$smarty.capture.grn_grn_GRN_GRN_978}
                                        {else}
                                            {capture name='grn_grn_GRN_GRN_979'}{cb_msg module='grn.grn' key='GRN_GRN-979' replace='true'}{/capture}{grn_link page=$page_info.all top=1 params=$ous_params caption=$smarty.capture.grn_grn_GRN_GRN_979 class='tree-select-current'}
                                        {/if}
                                    {/if}
                                    <div id="org_tree"></div>
                                </div>
                            </td>
                            {** End Tree **}

                            <td id="tree_view_right" class="wrap-tree-view-right">
                                <div class="mBottom10 nowrap-grn">
                                    {** search start **}
                                    <input type="hidden" name="" value="">
                                    {if $is_popup}
                                    <div class="search_navi" style="width:210px;">
                                    {else}
                                    <div class="search_navi">
                                    {/if}
                                        <div class="searchbox-grn">
                                            <div id="searchbox-keyword-user" class="input-text-outer-cybozu searchbox-keyword-area searchbox_keyword_grn">
                                                {if $is_popup}
                                                    <input type="text" maxlength="100" class="input-text-cybozu" style="width: 202px; " name="searchword" autocomplete="off" value="{if $s_oid == -1}{$url_params.searchword|escape}{/if}" placeholder="{cb_msg module='grn.grn' key='grn.member_select.user_search' replace='true'}" onkeypress="if (event.keyCode == 13) grn.component.popup_member_select.search(this.form,'user');">
                                                    <button class="searchbox-submit-cybozu" type="submit" title="{cb_msg module='grn.grn' key='grn.member_select.search' replace='true'}" aria-label="{cb_msg module='grn.grn' key='grn.member_select.search' replace='true'}" onclick="grn.component.popup_member_select.search(this.form,'user');"></button>
                                                {else}
                                                    <input type="text" maxlength="100" class="input-text-cybozu" style="width: 202px; " name="searchword" autocomplete="off"  value="{$searchword|escape}" placeholder="{cb_msg module='grn.grn' key='grn.member_select.user_search' replace='true'}" onkeypress="if (event.keyCode == 13) grn.component.member_select_add.search();">
                                                    <button class="searchbox-submit-cybozu" type="submit" title="{cb_msg module='grn.grn' key='grn.member_select.search' replace='true'}" aria-label="{cb_msg module='grn.grn' key='grn.member_select.search' replace='true'}" onclick="grn.component.member_select_add.search();"></button>
                                                {/if}
                                            </div>
                                        </div>
                                    </div>
                                    {include file="grn/member_select_search_info.tpl"}
                                    <div class="clear_both_0px"></div>
                                    {** search end **}
                                </div>

                                {if $s_oid == 0}
                                    <div class="bold_grn mBottom5">{cb_msg module='grn.grn' key='GRN_GRN-207' replace='true'}</div>
                                    <span class="inline_block_grn textSub-grn mBottom3">{cb_msg module='grn.grn' key='GRN_GRN-208' replace='true'}</span>
                                {elseif $s_oid != -1}
                                    <div class="bold_grn mBottom5">
                                        {if $org_id==-2}
                                            {** Not belonging organization **}
                                            {cb_msg module='grn.grn' key='GRN_GRN-210' replace='true'}
                                        {else}
                                            {grn_organize_name gid=$org_id noimage=true}
                                        {/if}
                                    </div>
                                    <span class="inline_block_grn textSub-grn mBottom3">{cb_msg module='grn.grn' key='GRN_GRN-211' replace='true'}</span>
                                {else}
                                    {** search result **}
                                    <div class="bold_grn mBottom5">
                                        {if $org_id==0}
                                            {** Top **}
                                            {cb_msg module='grn.grn' key='GRN_GRN-213' replace='true'}
                                        {elseif $org_id==-2}
                                            {** Not belonging organization **}
                                            {cb_msg module='grn.grn' key='GRN_GRN-214' replace='true'}
                                        {else}
                                            {grn_organize_name gid=$org_id noimage=true}
                                        {/if}
                                    </div>
                                    <span class="inline_block_grn textSub-grn mBottom3">{cb_msg module='grn.grn' key='GRN_GRN-215' replace='true'}</span>
                                {/if}

                                {grn_member_select_list selected_item_options=$candidate_item_options list_name=$smarty.capture.candidate_list position="candidate" select_all=true style=$smarty.capture.center_box_style is_calendar=$is_calendar}
                            </td>
                        </tr>
                        {** User/Group Tab End **}
                    {else}
                        {** Role Tab Start **}
                        <tr valign="top">
                            {** Role List Start **}
                            <td class="wrap-tree-view">
                                <div id="tree_view" class="tree-view" style="{$smarty.capture.left_box_style}">
                                    {if $is_popup}
                                        {foreach from=$role_list item=item}
                                            <span class="tree_view_list_grn">
                                                {if $item.id == $s_rid && $item.id|count_characters == $s_rid|count_characters}
                                                    {grn_link page=$page_info.all select_func='browse' selected_tab=1 s_oid=$s_oid s_rid=$item.id params=$url_params caption=$item.foreign_key class="tree-select-current" searchword=''}
                                                {else}
                                                    {grn_link page=$page_info.all select_func='browse' selected_tab=1 s_oid=$s_oid s_rid=$item.id params=$url_params caption=$item.foreign_key searchword=''}
                                                {/if}
                                            </span>
                                        {/foreach}
                                    {else}
                                        {foreach from=$role_list item=item}
                                            <span class="tree_view_list_grn">
                                                {if $item.rid == $prid}
                                                    {grn_link page=$page_info.all menu='role' poid=$poid prid=$item.rid params=$ous_params caption=$item.foreign_key element_id="`$page_info.all`/role" class="tree-select-current"}
                                                {else}
                                                    {grn_link page=$page_info.all menu='role' poid=$poid prid=$item.rid params=$ous_params caption=$item.foreign_key element_id="`$page_info.all`/role"}
                                                {/if}
                                            </span>
                                        {/foreach}
                                    {/if}
                                </div>
                            </td>
                            {** Role List End **}

                            <td id="tree_view_right" class="wrap-tree-view-right">
                                <div class="mBottom10 nowrap-grn">
                                    {** search start **}
                                    <input type="hidden" name="" value="">
                                    {if $is_popup}
                                    <div class="search_navi" style="width:210px;">
                                    {else}
                                    <div class="search_navi">
                                    {/if}
                                        <div class="searchbox-grn">
                                            <div id="searchbox-keyword-user" class="input-text-outer-cybozu searchbox-keyword-area searchbox_keyword_grn">
                                                {if $show_group_role}
                                                    {capture name="searchword_hint"}{cb_msg module='grn.grn' key='grn.member_select.user_role_search' replace='true'}{/capture}
                                                {else}
                                                    {capture name="searchword_hint"}{cb_msg module='grn.grn' key='grn.member_select.user_search' replace='true'}{/capture}
                                                {/if}

                                                {if $is_popup}
                                                    <input type="text" maxlength="100" class="input-text-cybozu" style="width: 202px; " name="searchword" autocomplete="off" value="{if $s_rid == -1}{$url_params.searchword|escape}{/if}" placeholder="{$smarty.capture.searchword_hint}" onkeypress="if (event.keyCode == 13) grn.component.popup_member_select.search(this.form,'role');">
                                                    <button class="searchbox-submit-cybozu" type="submit" title="{cb_msg module='grn.grn' key='grn.member_select.search' replace='true'}" aria-label="{cb_msg module='grn.grn' key='grn.member_select.search' replace='true'}" onclick="grn.component.popup_member_select.search(this.form,'role');"></button>
                                                {else}
                                                    <input type="text" maxlength="100" class="input-text-cybozu" style="width: 202px; " name="searchword" autocomplete="on" value="{$searchword|escape}" placeholder="{$smarty.capture.searchword_hint}" onkeypress="if (event.keyCode == 13) grn.component.member_select_add.search();">
                                                    <button class="searchbox-submit-cybozu" type="submit" title="{cb_msg module='grn.grn' key='grn.member_select.search' replace='true'}" aria-label="{cb_msg module='grn.grn' key='grn.member_select.search' replace='true'}" onclick="grn.component.member_select_add.search();"></button>
                                                {/if}
                                            </div>
                                        </div>
                                    </div>
                                    </nobr>
                                    {include file="grn/member_select_search_info.tpl"}
                                    <div class="clear_both_0px"></div>
                                    {** search end **}

                                </div>
                                <div class="bold_grn mBottom5">
                                    {if $s_rid == '0'}
                                        {cb_msg module='grn.grn' key='all_roles' replace='true'}
                                    {elseif $s_rid != -1}
                                        {grn_role_name rid=$role_id noimage=true}
                                    {else}
                                        <br>
                                    {/if}
                                </div>

                                            <span class="inline_block_grn textSub-grn mBottom3">
                                                {if $s_rid == '0'}
                                                    {cb_msg module='grn.grn' key='roles_list' replace='true'}
                                                {elseif $s_rid != -1}
                                                    {cb_msg module='grn.grn' key='GRN_GRN-208' replace='true'}
                                                {else}
                                                    {cb_msg module='grn.grn' key='GRN_GRN-215' replace='true'}
                                                {/if}
                                            </span>

                                {grn_member_select_list selected_item_options=$candidate_item_options list_name=$smarty.capture.candidate_list position="candidate" select_all=true style=$smarty.capture.center_box_style}

                            </td>
                        </tr>
                    {/if}
                    {** Role Area End **}
                    </tbody>
                </table>
            </div>
        </td>
        {** Selected Area End **}

        {** Add Button,Delete Button **}
        <td class="vAlignTop-grn tAlignCenter-grn">
            <div class="buttonSelectMove-grn" style="margin:180px 20px 0;">
                <div class="mBottom15">
                                <span class="aButtonStandard-grn">
                                    {if $is_popup}
                                    <a id="btn_add_CID" style="padding-right: 0px;" href="javascript:void(0);" role="button" onclick="grn.component.popup_member_select.addMember('selectlist_base_selectlist_{$smarty.capture.candidate_list}');">
                                    {else}
                                     <a id="btn_add_CID" style="padding-right: 0px;" href="javascript:void(0);" role="button" onclick="grn.component.member_select_add.addMember('selectlist_base_selectlist_aid')">
                                    {/if}
                                        <span class="aButtonText-grn">{cb_msg module='grn.grn' key='grn.member_select.add' replace='true'}</span><span class="icon-buttonArrowRightBehind-grn"></span>
                                    </a>
                                </span>
                </div>

                <div>
                                <span class="aButtonStandard-grn">
                                    {if $is_popup}
                                    <a id="btn_rmv_CID" style="padding-left: 0px;" href="javascript:void(0);" role="button" onclick="grn.component.popup_member_select.removeMember('selectlist_base_selectlist_{$smarty.capture.selected_list}');">
                                    {else}
                                    <a id="btn_rmv_CID" style="padding-left: 0px;" href="javascript:void(0);" role="button" onclick="grn.component.member_select_add.removeMember('selectlist_base_selectlist_rids');">
                                    {/if}
                                    <span class="icon-buttonArrowLeft-grn"></span><span class="aButtonText-grn">{cb_msg module='grn.grn' key='grn.member_select.remove' replace='true'}</span>
                                    </a>
                                </span>
                </div>
            </div>
        </td>

        <td class="vAlignTop-grn">
            <div class="select_item_candidacy_grn">
                <div class="label_grn label_sub_grn mBottom3">{cb_msg module='grn.grn' key='grn.member_select.selected' replace='true'}</div>
                {grn_member_select_list selected_item_options=$selected_item_options list_name=$smarty.capture.selected_list div_class_name="selectlist_l_grn focus_grn" select_all=true style=$smarty.capture.right_box_style is_calendar=$is_calendar}
            </div>
        </td>
    </tr>
    </tbody>
</table>
{if ! $is_popup}
</div>
{/if}