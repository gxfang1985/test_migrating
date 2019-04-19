{include file='grn/head.tpl'}
{include file='grn/header.tpl'}

{assign var='form_name' value=$smarty.template|basename}
{if ! $page_prefix}{assign var='page_prefix' value='report'}{/if}
{if ! $form}{assign var='disable_form' value=true}{/if}

{* メニュー、通知メッセージ *}
<div id="main_menu_part">
    <span class="menu_item">{capture name='grn_report_GRN_RPRT_329'}{cb_msg module='grn.report' key='GRN_RPRT-329' replace='true'}{/capture}{grn_link page='report/modify_draft' caption=$smarty.capture.grn_report_GRN_RPRT_329 image='modify20.gif' fid=$fid rid=$report_id disabled=$disable_form alt=''}</span>
    <span class="menu_item">{capture name='grn_report_GRN_RPRT_330'}{cb_msg module='grn.report' key='GRN_RPRT-330' replace='true'}{/capture}{grn_link caption=$smarty.capture.grn_report_GRN_RPRT_330 page='report/reuse' image='reuse20.gif' fid=$fid rid=$report_id mode='reuse' disabled=$disable_form alt=''}</span>
    <span class="menu_item">{capture name='grn_report_GRN_RPRT_331'}{cb_msg module='grn.report' key='GRN_RPRT-331' replace='true'}{/capture}{grn_link caption=$smarty.capture.grn_report_GRN_RPRT_331 page='report/print' image='print20.gif' fid=$fid rid=$report_id alt=''}</span>
    <span class="menu_item">
        {grn_delete title=$delete_info.title page=$delete_info.page no_confirm=$delete_info.no_confirm data=$delete_info.data handler=$delete_info.handler}
        {capture name='grn_report_GRN_RPRT_332'}{cb_msg module='grn.report' key='GRN_RPRT-332' replace='true'}{/capture}{grn_link caption=$smarty.capture.grn_report_GRN_RPRT_332 image='delete20.gif' script='javascript:void(0);' id="lnk_delete" alt=''}
    </span>
</div>

{if $use_star}
    {include file="star/star_init.tpl" list_id="report_list"}
    <div id="report_list">
    {grn_star_icon module="grn.report" star_infos=$star_infos unique_id=$report_id rid=$report_id no_style=1}
{/if}
{grn_title title=$report_title class=$page_info.parts[0]|cat:' inline_block_grn' no_style=1}
{if $use_star}</div>{/if}

<div class="contents_area">
    <table class="margin_top">
        <tr>
            <td nowrap>{cb_msg module='grn.report' key='GRN_RPRT-333' replace='true'}</td><td>&nbsp;{cb_msg module='grn.report' key='GRN_RPRT-334' replace='true'}&nbsp;</td>
            <td>{grn_user_name uid=$report.creator name=$report.creator_name}&nbsp;{grn_date_format date=$report.ctime format="DateTimeMiddle_YMDW_HM"}</td>
        </tr>
        {if $report.modifier neq ''}
            <tr>
                <td nowrap>{cb_msg module='grn.report' key='GRN_RPRT-335' replace='true'}</td><td>&nbsp;{cb_msg module='grn.report' key='GRN_RPRT-336' replace='true'}&nbsp;</td>
                <td>{grn_user_name uid=$report.modifier name=$report.modifier_name}&nbsp;{grn_date_format date=$report.mtime format="DateTimeMiddle_YMDW_HM"}</td>
            </tr>
        {/if}
        <tr valign="top">
            <td nowrap>{cb_msg module='grn.report' key='GRN_RPRT-361' replace='true'}</td><td>&nbsp;{cb_msg module='grn.report' key='GRN_RPRT-362' replace='true'}&nbsp;</td>
            <td>{if $report.private}{cb_msg module='grn.report' key='GRN_RPRT-363' replace='true'}{else}{cb_msg module='grn.report' key='GRN_RPRT-364' replace='true'}{/if}</td>
        </tr>
        <tr valign="top">
            <td nowrap>{cb_msg module='grn.report' key='GRN_RPRT-337' replace='true'}</td><td>&nbsp;{cb_msg module='grn.report' key='GRN_RPRT-338' replace='true'}&nbsp;</td>
            <td>
                {grn_report_notification users=$notificationUsers}
            </td>
        </tr>
    </table>
</div>

<div class="border-partition-common-grn"></div>
{* 内容 *}
{include file='report/_view.tpl' event_id=$event_id event=$event event_date=$event_date is_creator=$is_creator report=$report from='draft' members=$members partners=$partners item_data_list=$item_data_list draft=true}

<p></p>

{include file="grn/footer.tpl"}
