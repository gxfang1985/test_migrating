{assign var='send_button' value='btn_copy_multi'}
<script type="text/javascript" src="{$app_path}/grn/html/component/check_tree.js?{$build_date}" ></script>
<script language="javascript" type="text/javascript">
<!--
grn.component.check_tree = new grn.component.checkTree('{$folder_tree.oid_key}','{$form_name}','{$folder_tree.check_info.name}','{$send_button}');
var confirm_title = '{$page_title|escape:javascript}';
var confirm_link_url = '{grn_pageurl page=$confirm_link}';
var confirm_params = new Array();
confirm_params.push('csrf_ticket={$csrf_ticket|escape:javascript}');
confirm_params.push('{$folder_tree.reflection_info.source_key|escape:javascript}={$folder_tree.reflection_info.source_oid|escape:javascript}');
//-->
</script>
<div class="explanation mBottom10 mLeft10">
    {$smarty.capture.explanation1}<br>
    {grn_image image='attention16.gif'}<span class="bold">{$smarty.capture.explanation2}</span>
</div>
<div class="border-partition-common-grn mBottom5"></div>
<table width="100%">
    <tr valign="top">
        <td class="treepart_grn">
            <form id="{$form_name}" name="{$form_name}" method="post" action="{grn_pageurl page=$form_page}">
                <input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
                <input type="hidden" name="{$folder_tree.reflection_info.source_key}" value="{$folder_tree.reflection_info.source_oid}">
                {include file='grn/org_check_tree.tpl' form_name=$form_name send_button=$send_button}
                <div class="mTop15 buttonArea-grn nowrap-grn">
                    <input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
                    <input type="button" id="{$send_button}" class="mRight10" value="{cb_msg module='grn.grn' key='GRN_GRN-1384' replace='true'}" onclick="grn.component.check_tree.showPopupCopyMultiConfirm(confirm_title, confirm_link_url, confirm_params);" disabled="true">
                    <input type="button" value="{cb_msg module='grn.grn' key='GRN_GRN-1003' replace='true'}" onclick="location.href='{grn_pageurl page=$cancel_page params=$ous_params}'">
                </div>
            </form>
        </td>
        <td class="viewpart_grn">
            {if $is_privilege}
                <div class="mBottom5">
                    <span class="sub_title">{$node.name}</span>
                {if $folder_tree.reflection_info.source_oid == $node_id}
                    <span class="category_important_grn">{cb_msg module='grn.grn' key='GRN_GRN-1545' replace='true'}</span>
                {/if}
                {if $classification == "access"}
                    {if $display_model}
                        {if $is_grant}
                            {capture name='grn_grn_GRN_GRN_1547'}{cb_msg module='grn.grn' key='GRN_GRN-1547' replace='true'}{/capture}{grn_sentence caption=$smarty.capture.grn_grn_GRN_GRN_1547 image='access20.gif'}
                        {elseif $is_revoke}
                            {capture name='grn_grn_GRN_GRN_1548'}{cb_msg module='grn.grn' key='GRN_GRN-1548' replace='true'}{/capture}{grn_sentence caption=$smarty.capture.grn_grn_GRN_GRN_1548 image='access20.gif'}
                        {/if}
                    {/if}
                {elseif $classification == "notify"}
                    {if $display_model}
                        {if ! $notify.force}
                            {capture name='grn_grn_GRN_GRN_1549'}{cb_msg module='grn.grn' key='GRN_GRN-1549' replace='true'}{/capture}{grn_sentence caption=$smarty.capture.grn_grn_GRN_GRN_1549 image='subscribe20.png'}
                        {else}
                            {capture name='grn_grn_GRN_GRN_1550'}{cb_msg module='grn.grn' key='GRN_GRN-1550' replace='true'}{/capture}{grn_sentence caption=$smarty.capture.grn_grn_GRN_GRN_1550 image='subscribe20.png'}
                        {/if}
                    {/if}
                {/if}
                </div>
                <table width="100%">
                    <tr valign="top">
                        <td width="70%">
                        {if $classification == "access"}
                            {include file='grn/_access_list.tpl' view_mode=true}
                        {elseif $classification == "notify"}
                            {include file='grn/_notify_list.tpl' view_mode=true}
                        {/if}
                        </td>
                        <td width="30%"></td>
                    </tr>
                </table>
            {else}
                {capture assign='grn_privileg'}{'grn.privilege.'|cat:$object|cat:'.'|cat:$classification}{/capture}{cb_msg module="grn.grn" key=$grn_privileg}
            {/if}
        </td>
    </tr>
</table>
