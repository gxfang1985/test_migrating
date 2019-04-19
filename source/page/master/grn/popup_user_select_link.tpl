{strip}
    {if !$disable_link}
        {if $module == 'customization'}
            {grn_load_javascript file="grn/html/component/popup_user_select_link.js"}
            <div style="display:none; position:absolute; width:0em; height:0em;">
                <iframe id="popup_user_select_link_iframe" name="popup_user_select_link_iframe" frameborder="no" scrolling="no" style="position:absolute; width:0em; height:0em;" src=""></iframe>
            </div>
            <a href="javascript:void(0);" onClick="grn.component.popup_member_select_link.openPopupWindowWithPostData( 'popup_user_select_link_iframe', '{grn_pageurl page=$popup_url}', {$url_params|@json_encode|escape}, {ldelim}width: {$width}, height: {$height}{rdelim} );" title="{$caption}">
                {grn_image image='write20.gif'}{$caption}
            </a>
        {else}
            <a class="selectPulldownSub-grn" href="javascript:void(0);"
               onClick="javascript:popupWin('{grn_pageurl page=$popup_url params=$url_params}','html','{$width}','{$height}',0,0,1,1,0,1);"
               title="{if $module == 'schedule'}{$caption}{/if}">{if $module != 'schedule'}{grn_image image='image-common/blank16.png'}{$caption}{else}{grn_image image='image-common/blankB16.png'}{/if}</a>
        {/if}
    {else}
        {grn_image image='image-common/blank16.png'}{$caption}
    {/if}
{/strip}