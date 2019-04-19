{foreach from=$category_list item=c}
    <div id="category_{$c.id}" >
        <div style="height:auto;margin-top:5px;">
            <span style="height:18px;">
                <img id="category_folder_status_{$c.id}" src="{$app_path}/grn/image/cybozu/plus.gif?{$build_date}" onclick="closeChildCategories({$c.id});"/>&nbsp;
                <a href="javascript:" class="category_link" id="link_{$c.id}" onclick="onCategorySelect({$c.id})">{$c.name|escape}</a>
                <img id="loading_{$c.id}" style="display:none;" align="top" src="{$app_path}/grn/image/cybozu/spinner.gif?{$build_date}" />
            </span>
        </div>
        <div id="category_content_{$c.id}" style="display:none">
            <div style="margin-left:20px" id="category_{$c.id}_child"></div>
        </div>
    </div>
{/foreach}     
{if $is_root}
    <div id="category_-1" style="margin-top:7px;">
        <div style="height:auto;">
            <img id="category_folder_status_-1" src="{$app_path}/grn/image/cybozu/plus.gif?{$build_date}" onclick="closeChildCategories(-1);"/>&nbsp;
            <a href="javascript:" class="category_link" id="link_-1" onclick="onCategorySelect(-1)">{cb_msg module='grn.report' key='nonparty'}</a>
            <img id="loading_-1" style="display:none" align="top" src="{$app_path}/grn/image/cybozu/spinner.gif?{$build_date}" />
        </div>
        <div id="category_content_-1" style="display:none">
            <div style="margin-left:20px" id="category_-1_child"></div>
        </div>
    </div>
{/if}