{* GTM-1136 *}
{include file="cbpapi/header.tpl"}
<schedule:{$action}Response>
    <returns xmlns="">
        <file>
            <content>
                {$file_content}
            </content>
        </file>
    </returns>
</schedule:{$action}Response>
{include file="cbpapi/footer.tpl"}