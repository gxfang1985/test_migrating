{include file="cbpapi/header.tpl"}
<cabinet:{$action}Response>
    <returns xmlns="">
        <file id="{$file.id}" folder_id="{$file.folder_id}">
            <title>{if strlen($file.title) < 1}{grn_papi_text_format value=$file.filename}{else}{grn_papi_text_format value=$file.title}{/if}</title>
            <max_version>{grn_papi_text_format value=$file.max_version}</max_version>
            <name>{grn_papi_text_format value=$file.filename}</name>
            <size>{grn_papi_text_format value=$file.size}</size>
            <mime_type>{grn_papi_text_format value=$file.mime}</mime_type>
            <creator_id>{grn_papi_text_format value=$file.creator_uid}</creator_id>
            <creator_login_name>{grn_papi_text_format value=$file.creator_login_name}</creator_login_name>
            <creator_display_name>{grn_papi_text_format value=$file.creator_name}</creator_display_name>
            <create_time>{grn_papi_text_format value=$file.ctime->unix_ts}</create_time>
            <description>{grn_papi_text_format value=$file.description}</description>
        </file>
    </returns>
</cabinet:{$action}Response>
{include file="cbpapi/footer.tpl"}