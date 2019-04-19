{literal}
var tree_data = {/literal}{include org=$org file='grn/org_json_26.tpl'}{literal};
obj_folder_tree.init(tree_data);
{/literal}
{if $oid}
{literal}
if( ! document.getElementsByClassName('tree-select-current').length > 0 )
{
    onSelectCategory({/literal}{$oid}{literal});
    obj_folder_tree.init(tree_data);
}

(function(){
    // Using setTimeout because the YUI Treeview using setTimeout to render
    setTimeout(function() {
        var tree = obj_folder_tree.getTree();
        var node = tree.getNodeByProperty("oid", {/literal}{$oid}{literal});
        node.focus();
    }, 250);
})();
{/literal}
{/if}
{literal}{/literal}
