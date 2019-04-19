{grn_load_javascript file="fw/jquery/jquery-ui-1.12.1.custom.min.js"}
{grn_load_javascript file="grn/html/component/pubsub.js"}
{grn_load_javascript file="grn/html/component/category_suggest_list.js"}
{grn_load_javascript file="grn/html/component/category_picker.js"}
{assign var="id_searchbox" value="bulletin_search_category"}

<div class="mTop10 mBottom10 {$tree_for_view.incremental_search_picker_css}">
    {capture name="placeholder"}{cb_msg module='grn.bulletin' key='GRN_BLLT-658' replace='true'}{/capture}
    {include file="grn/_search_box.tpl" id_searchbox=$id_searchbox name_searchbox="text" search_text="" placeholder=$smarty.capture.placeholder width=";"}
</div>

<div id="category_picker_tree_list" class="tree_base_scroll_y_grn inline_block_grn mBottom10" style=" min-width:500px; min-height:300px; max-height:450px;">
    <div class="tree_text_style1_grn mBottom10">
        {include file='grn/org_check_tree.tpl' folder_tree=$tree_for_view}
    </div>
</div>
