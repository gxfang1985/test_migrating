{include file="cbpapi/header.tpl"}
<bulletin:{$action}Response>
    <returns xmlns="">
        <file>
            <content>
                {$file_content}
            </content>
        </file>
    </returns>
</bulletin:{$action}Response>
{include file="cbpapi/footer.tpl"}