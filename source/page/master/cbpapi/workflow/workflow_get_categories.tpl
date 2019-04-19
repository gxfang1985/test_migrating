{include file="cbpapi/header.tpl"}
<workflow:{$action}Response>
<returns>
    <root 
        {grn_attr name="id" value=1 require=true}
        {grn_attr name="name" value='(root)' require=true}
        {grn_attr name="parent_folder_id" value='--' require=true}
    >
       {if is_array($categories) && count($categories) > 0 }
       {foreach from=$categories item=child}
        <child_category
            {grn_attr name="id" value=$child._id require=true}
            {grn_attr name="code" value=$child.col_foreign_key require=true}
            {grn_attr name="name" value=$child.col_name require=true}
            {grn_attr name="parent_category" value=$child.col_parent require=true}
            {grn_attr name="memo" value=$child.col_memo require=true}
            {grn_attr name="created" value=$child.col_ctime require=true}
            {grn_attr name="last_update" value=$child.col_mtime require=true}
        >
        {if is_array($child.childrent) && count($child.childrent) > 0}
            {assign var='child_node' value=$child.childrent}
                {include file="cbpapi/workflow/_list_category.tpl"}
        {/if}
        </child_category>
        {/foreach}
        {/if}
    </root>
</returns>
</workflow:{$action}Response>
{include file="cbpapi/footer.tpl"}