{grn_load_javascript file="grn/html/page/portal/portlet/set_information.js"}
{assign var='form_name' value=$smarty.template|basename}
{include file='grn/show_validation_errors.tpl'}
<form name="{$form_name}" method="post" action="{grn_pageurl page='portal/'|cat:$page_info.parts[1]|cat:'/command_'|cat:$page_info.last}" enctype="multipart/form-data"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
<input type="hidden" name="pid" value="{$portlet.pid}">
<input type="hidden" name="plid" value="{$portlet.plid}">
<input type="hidden" name="ppid" value="{$portlet.ppid}">
<input type="hidden" name="display" value="{$display}">

<table class="std_form">
    <tr valign="top">
        <th nowrap>{cb_msg module='grn.portal.portlet' key='GRN_POT_PO-11' replace='true'}</th>
        <td>{include file="grn/richeditor.tpl" name="data" html=$settings.html text=$settings.text cols=$richeditor.cols rows=$richeditor.rows enable=1 class="form_textarea_grn"}</td>
    </tr>
    <tr valign="top">
        <th nowrap="">{cb_msg module='grn.portal.portlet' key='GRN_POT_PO-41' replace='true'}</th>
        <td>
            <div class="mBottom5">
                <input type="checkbox" value="1" id="set_information_frame" name="use_frame" class="mRight3" onclick="grn.page.portal.portlet.set_information.informationFrameCheckboxHandler(this)" {if $settings.use_frame}checked{/if}><label onmouseout="this.style.color=''" onmouseover="this.style.color='#ff0000'" for="set_information_frame">{cb_msg module='grn.portal.portlet' key='GRN_POT_PO-42' replace='true'}</label>
            </div>
            <div id="portlet_information_frame_grn">
                <span class="nowrap-grn"><span><input type="radio" {if $settings.frame_style == "style1"}checked {/if}{if ! $settings.use_frame}disabled {/if}value="style1" id="set_information_frame_blue" name="frame_style" class="mRight3"></span><label onmouseout="this.style.color=''" onmouseover="this.style.color='#ff0000'" for="set_information_frame_blue"><span class="portlet_information_frame_thumbnail_grn portlet_information_frame_style1_grn">{cb_msg module='grn.portal.portlet' key='GRN_POT_PO-43' replace='true'}</span></label></span>
                <span class="nowrap-grn"><span><input type="radio" {if $settings.frame_style == "style2"}checked {/if}{if ! $settings.use_frame}disabled {/if}value="style2" id="set_information_frame_green" name="frame_style" class="mRight3"></span><label onmouseout="this.style.color=''" onmouseover="this.style.color='#ff0000'" for="set_information_frame_green"><span class="portlet_information_frame_thumbnail_grn portlet_information_frame_style2_grn">{cb_msg module='grn.portal.portlet' key='GRN_POT_PO-44' replace='true'}</span></label></span>
                <span class="nowrap-grn"><span><input type="radio" {if $settings.frame_style == "style3"}checked {/if}{if ! $settings.use_frame}disabled {/if}value="style3" id="set_information_frame_red" name="frame_style" class="mRight3"></span><label onmouseout="this.style.color=''" onmouseover="this.style.color='#ff0000'" for="set_information_frame_red" style=""><span class="portlet_information_frame_thumbnail_grn portlet_information_frame_style3_grn">{cb_msg module='grn.portal.portlet' key='GRN_POT_PO-45' replace='true'}</span></label></span>
                <span class="nowrap-grn"><span><input type="radio" {if $settings.frame_style == "style4"}checked {/if}{if ! $settings.use_frame}disabled {/if}value="style4" id="set_information_frame_yellow" name="frame_style" class="mRight3"></span><label onmouseout="this.style.color=''" onmouseover="this.style.color='#ff0000'" for="set_information_frame_yellow" style=""><span class="portlet_information_frame_thumbnail_grn portlet_information_frame_style4_grn">{cb_msg module='grn.portal.portlet' key='GRN_POT_PO-46' replace='true'}</span></label></span>
                <span class="nowrap-grn"><span><input type="radio" {if $settings.frame_style == "style5"}checked {/if}{if ! $settings.use_frame}disabled {/if}value="style5" id="set_information_frame_gray" name="frame_style" class="mRight3"></span><label onmouseout="this.style.color=''" onmouseover="this.style.color='#ff0000'" for="set_information_frame_gray" style=""><span class="portlet_information_frame_thumbnail_grn portlet_information_frame_style5_grn">{cb_msg module='grn.portal.portlet' key='GRN_POT_PO-47' replace='true'}</span></label></span>
                <span class="nowrap-grn"><span><input type="radio" {if $settings.frame_style == "style6"}checked {/if}{if ! $settings.use_frame}disabled {/if}value="style6" id="set_information_frame_white" name="frame_style" class="mRight3"></span><label onmouseout="this.style.color=''" onmouseover="this.style.color='#ff0000'" for="set_information_frame_white" style=""><span class="portlet_information_frame_thumbnail_grn portlet_information_frame_style6_grn">{cb_msg module='grn.portal.portlet' key='GRN_POT_PO-48' replace='true'}</span></label></span>
            </div>
        </td>
    </tr>
    <tr>
        <td></td>
        <td>
            <input class="margin" type="submit" value="{cb_msg module='grn.portal.portlet' key='GRN_POT_PO-12' replace='true'}">
            {if $display == 'set-system'}
                {capture name='grn_portal_portlet_GRN_POT_PO_13'}{cb_msg module='grn.portal.portlet' key='GRN_POT_PO-13' replace='true'}{/capture}{grn_button_cancel caption=$smarty.capture.grn_portal_portlet_GRN_POT_PO_13 page='portal/system/view' pid=$portlet.pid}
            {elseif $display == 'set-operation'}
                {capture name='grn_portal_portlet_GRN_POT_PO_14'}{cb_msg module='grn.portal.portlet' key='GRN_POT_PO-14' replace='true'}{/capture}{grn_button_cancel caption=$smarty.capture.grn_portal_portlet_GRN_POT_PO_14 page='portal/operation/view' pid=$portlet.pid}
            {else}
                {capture name='grn_portal_portlet_GRN_POT_PO_15'}{cb_msg module='grn.portal.portlet' key='GRN_POT_PO-15' replace='true'}{/capture}{grn_button_cancel caption=$smarty.capture.grn_portal_portlet_GRN_POT_PO_15 page='portal/personal/view' pid=$portlet.pid}
            {/if}
        </td>
    </tr>
</table>
</form>
