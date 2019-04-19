{foreach from=$child_node item=child_1}
<child_category
    {grn_attr name="id" value=$child_1._id require=true}
    {grn_attr name="code" value=$child_1.col_foreign_key require=true}
    {grn_attr name="name" value=$child_1.col_name require=true}
    {grn_attr name="parent_category" value=$child_1.col_parent require=true}
    {grn_attr name="memo" value=$child_1.col_memo require=true}
    {grn_attr name="created" value=$child_1.col_ctime require=true}
    {grn_attr name="last_update" value=$child_1.col_mtime require=true}
>
    {if is_array($child_1.childrent) && count($child_1.childrent) > 0}
        {assign var='child_node' value=$child_1.childrent}
            {include file="cbpapi/workflow/_list_category.tpl"}
    {/if}
</child_category>
{/foreach}