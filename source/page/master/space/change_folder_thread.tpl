<dl id='{$pulldown_id}' class="selectmenu_grn selectmenu_style1_grn selectmenu_base_grn mRight10 selectmenu_disable_filter_grn">
    <dt>{strip}
        <a href="javascript:void(0)" class="nowrap-grn">
            <span></span>
            {cb_msg module='grn.space' key='move_discussion-5' replace='true'}
            <span class="pulldownbutton_arrow_down_grn mLeft3"></span>
            <input type='hidden' name='pulldown_head' value='-1'>
        </a>
    </dt>{/strip}
    <dd>
        <div class="pulldown_menu_grn" style="display: none;">
            <ul>
                {foreach from=$folder_collection item=folder}
                    {strip}
                        <li data-id="{$folder->getId()}">
                            <a href="javascript:void(0)">
                                <span class="js_name vAlignMiddle-grn">{$folder->getFolderName()|escape}</span>
                                <input type="hidden" value="{$folder->getId()}">
                            </a>
                        </li>
                    {/strip}
                {/foreach}
            </ul>
        </div>
    </dd>
</dl>