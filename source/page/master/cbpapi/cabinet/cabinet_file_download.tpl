{include file="cbpapi/header.tpl"}
<cabinet:{$action}Response>
    <returns xmlns="">
        <file>
            <content>
                {$file_content}
            </content>
        </file>
    </returns>
</cabinet:{$action}Response>
{include file="cbpapi/footer.tpl"}