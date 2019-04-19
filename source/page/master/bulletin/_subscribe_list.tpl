{grn_load_javascript file="grn/html/component/category_list.js"}
<script language="JavaScript" type="text/javascript">
    <!--
    var urlParams = new Object();
    {foreach from=$list_for_view.params key=param_key item=param_value}
        urlParams["{$param_key}"] = "{$param_value}";
    {/foreach}

    new grn.component.category_list("{$list_for_view.list_name}",
        {ldelim}
            sessionManagerUrl: "{$list_for_view.session_url}",
            urlParams: urlParams,
        {rdelim}
    );
    //-->
</script>

<table class="list_column list_column_grn mTop10 mBottom15">
    <tbody>
        <tr>
            <th style="width:1%;"></th>
            <th style="width:30%;">{cb_msg module='grn.bulletin' key='GRN_BLLT-659' replace='true'}</th>
            <th>{cb_msg module='grn.bulletin' key='GRN_BLLT-660' replace='true'}</th>
        </tr>
{foreach from=$list_for_view.list item=item}
        <tr class="{cycle values='linetwo,lineone'}">
            <td>
                <input type="checkbox" name="ids[]" value="{$item.category_id}" class="mTop7 mBottom7" onclick="{$list_for_view.on_click}('{$item.category_id}', this)" checked="checked" {if $item.force_notify}disabled{/if}>
            </td>
            <td>
                <a href="{$item.page_url}">{$item.name}</a>
            </td>
            <td>
                {if $item.parent_category_id}
                    <a href="{$item.parent_page_url}">{$item.parent_category_path}</a>
                {/if}
            </td>
        </tr>
{/foreach}
    </tbody>
</table>

{if $no_result_message}
    <div class="list_message_grn">
        <div class="list_message_balloon_grn">
            <span class="bold_grn">{cb_msg module='grn.bulletin' key='GRN_BLLT-661' replace='true'}</span>
        </div>
        <div class="balloon_arrow_down_grn"></div>
        <div class="list_message_icon_grn">
            <span class="message_middle_icon_size_grn bulletin_message_middle_icon_grn"></span>
        </div>
    </div>
{/if}