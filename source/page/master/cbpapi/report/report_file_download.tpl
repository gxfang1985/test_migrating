{include file="cbpapi/header.tpl"}
<report:{$action}Response>
    <returns xmlns="">
        <file>
            <content>
                {$file_content}
            </content>
        </file>
    </returns>
</report:{$action}Response>
{include file="cbpapi/footer.tpl"}