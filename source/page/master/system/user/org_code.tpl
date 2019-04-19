{include file="grn/popup_system_head.tpl"}
{grn_load_css file="grn/html/Design-admin.css"}
<div class="popup_title_grn">
    <div class="float_left">
        {grn_title title=$title_of_grn_title class=$page_info.parts[0]}
    </div>
    <a href="#" onclick="window.close();" role="button">
        <div title="{cb_msg module='grn.grn' key='GRN_GRN-840' replace='true'}" aria-label="{cb_msg module='grn.grn' key='GRN_GRN-840' replace='true'}" class="subWindowClose-grn"></div>
    </a>
    <div class="clear_both_0px"></div>
</div>
{if $is_sandbox_page}{include file="system/user/sandbox/_sandbox_title_label.tpl"}{/if}

{grn_image image='organize20.gif'}{cb_msg module='grn.system.user' key='GRN_SY_US-528' replace='true'}<br>
{include file='system/user/_org_code_tree.tpl' children=$org_tree}

</div><!--body_end-->
