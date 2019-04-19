{grn_load_css file="grn/html/fag_tree_26.css"}
{if $folder_tree}
<div>
    <input type="checkbox" name="enable_copy_{$key}" id="enable_copy_{$key}" value="1"{if $copy_checked} checked{/if}>
    <label onmouseout="this.style.color=''" onmouseover="this.style.color='#ff0000'" for="enable_copy_{$key}" id="enable_copy_{$key}_label">{capture assign='key_1'}{'grn.dropdown.'|cat:$obj|cat:'.'|cat:$key|cat:'-1'}{/capture}{cb_msg module="grn.grn" key=$key_1}</label>
</div>
<div id="{$key}_copy_selectbox"{if ! $copy_checked} style="display: none;"{/if}>
    <div class="mTop5 mBottom5">
        <table style="min-width: 250px; float: left;" class="wrap_dropdown_menu" id="{$key}_dropdown" border="0" cellpadding="0" cellspacing="0">
            <tbody>
            <tr>
                <td id="{$key}_dropdown_title" class="dropdown_menu_current" style="height: 20px; width: auto; white-space: nowrap;">{$select}</td>
                <td id="{$key}_dropdown_menu_common" class="dropdown_menu_common_grn" valign="center">{grn_image image='image-common/arrowDown.png'}</td>
            </tr>
            </tbody>
        </table>
        <span class="dropdown_menu_sublink_grn" id="dropdown_menu_sublink_{$key}"><a id="{$key}_confirm_link" href="javascript:void(0);">{grn_image image='image-common/blankB16.png'}{capture assign='key_2'}{'grn.dropdown.'|cat:$key|cat:'-2'}{/capture}{cb_msg module="grn.grn" key=$key_2}</a></span>
        <div id="{$key}_copy_popup" class="wrap_dropdown_option" style="display: none;">
            <div id="{$key}_dropdown_tree_div1" class="wrap_tree1" style="min-width: 320px;">
                <div id="{$key}_dropdown_tree_div2" class="wrap_tree2">
                {include file='grn/org_tree_26.tpl'}
                </div>
            </div>
        </div>
        <div class="clear_both_0px"></div>
    </div>
    <input type="hidden" name="{$key}_dropdown_selected" id="{$key}_dropdown_selected" value="{$folder_tree.selected_oid}">
</div>
{else}
<input type="checkbox" name="enable_copy_{$key}" id="enable_copy_{$key}" disabled="">
<label for="enable_copy_{$key}" id="enable_copy_{$key}_label" class="form_disable">{capture assign='key_1'}{'grn.dropdown.'|cat:$obj|cat:'.'|cat:$key|cat:'-1'}{/capture}{cb_msg module="grn.grn" key=$key_1}</label>
{/if}
{include file='grn/window_simple_dialog.tpl'}
<script language="JavaScript" type="text/javascript">
<!--
grn.component.window_simple_dialog = new grn.component.WindowSimpleDialog();

YAHOO.util.Event.onDOMReady(function()
{ldelim}
    jQuery("#{$key}_confirm_link").click(function(){ldelim}
        {capture assign='key_3'}{'grn.dropdown.'|cat:$key|cat:'-3'}{/capture}
        var title = "{cb_msg module='grn.grn' key=$key_3 }";
        var asyncURL = "{grn_pageurl page=$page_info.parts[0]|cat:'/'|cat:$page_info.parts[1]|cat:'/'|cat:'popup_'|cat:$key|cat:'_list'}";
        var asyncParams = {ldelim}
                          csrf_ticket: '{$csrf_ticket|escape:javascript}',
                          nid: getTargetID('{$key|escape:javascript}')
                          {rdelim}
        grn.component.window_simple_dialog.initialize( title, 'post', asyncURL, asyncParams );
        grn.component.window_simple_dialog.openDialog();
    {rdelim});
{rdelim});
function getTargetID(key)
{ldelim}
    if(! document.getElementById(key + '_dropdown_selected')) return;
    var id = document.getElementById(key + '_dropdown_selected').value;
    return (id && id > 0) ? id : 0;
{rdelim}
//-->
</script>
