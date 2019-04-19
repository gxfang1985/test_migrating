{include file="cbpapi/header.tpl"}
<message:{$action}Response>
    <returns xmlns="">
        <file>
            <content>
                {$file_content}
            </content>
        </file>
    </returns>
</message:{$action}Response>
{include file="cbpapi/footer.tpl"}