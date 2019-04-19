{include file="cbpapi/header.tpl"}
    <cabinet:{$action}Response>
        <returns xmlns="">
            {$file_info|smarty:nodefaults}
        </returns>
    </cabinet:{$action}Response>
{include file="cbpapi/footer.tpl"}