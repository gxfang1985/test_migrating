{include file="cbpapi/header.tpl"}
<bulletin:{$action}Response>
    <returns xmlns="">
        {$category_info|smarty:nodefaults}
    </returns>
</bulletin:{$action}Response>
{include file="cbpapi/footer.tpl"}