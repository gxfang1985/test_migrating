<file {grn_attr name="id" value=$file.id require=true} {grn_attr name="folder_id" value=$file.folder_id require=true}
        xmlns:cab="http://schemas.cybozu.co.jp/cabinet/2008">
    <cab:title>{if strlen($file.title) < 1}{grn_papi_text_format value=$file.filename}{else}{grn_papi_text_format value=$file.title}{/if}</cab:title>
    <cab:max_version>{grn_papi_text_format value=$file.max_version}</cab:max_version>
    <cab:name>{grn_papi_text_format value=$file.filename}</cab:name>
    <cab:size>{grn_papi_text_format value=$file.size}</cab:size>
    <cab:mime_type>{grn_papi_text_format value=$file.mime}</cab:mime_type>
    <cab:creator_id>{grn_papi_text_format value=$file.creator_uid}</cab:creator_id>
    <cab:creator_login_name>{grn_papi_text_format value=$file.creator_login_name}</cab:creator_login_name>
    <cab:creator_display_name>{grn_papi_text_format value=$file.creator_name}</cab:creator_display_name>
    <cab:create_time>{grn_papi_text_format value=$file.ctime}</cab:create_time>
    <cab:modifier_id>{grn_papi_text_format value=$file.modifier_uid}</cab:modifier_id>
    <cab:modifier_login_name>{grn_papi_text_format value=$file.modifier_login_name}</cab:modifier_login_name>
    <cab:modifier_display_name>{grn_papi_text_format value=$file.modifier_name}</cab:modifier_display_name>
    <cab:modify_time>{grn_papi_text_format value=$file.mtime}</cab:modify_time>
    <cab:description>{grn_papi_text_format value=$file.memo}</cab:description>
</file>
