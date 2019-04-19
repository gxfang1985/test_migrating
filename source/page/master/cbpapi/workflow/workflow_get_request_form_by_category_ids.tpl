{include file="cbpapi/header.tpl"}
<workflow:{$action}Response>
<returns>
    {foreach from=$form_list_for_view key=cid item=list_request_form}
    <category 
        {grn_attr name="category_id" value=$cid require=true}
    >
    {if is_array($list_request_form) && count($list_request_form) > 0}
        {foreach from=$list_request_form item=request_form}
        <requestForm
            {grn_attr name="fid" value=$request_form.fid require=true}
            {grn_attr name="type" value=$request_form.type require=true}
            {grn_attr name="name" value=$request_form.name require=true}
            {grn_attr name="active" value=$request_form.active require=true}
            {grn_attr name="icon_type" value=$request_form.icon_type require=true}
            {grn_attr name="icon_id" value=$request_form.icon_id require=true}
            {grn_attr name="icon_url" value=$request_form.icon_url require=true}
        >
        </requestForm>
        {/foreach}
    {/if}
    </category>
    {/foreach}
</returns>
</workflow:{$action}Response>
{include file="cbpapi/footer.tpl"}