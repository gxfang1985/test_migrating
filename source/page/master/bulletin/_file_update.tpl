<form name="form_file_update" method="post" action="{grn_pageurl page=$page}">
    <input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
    <input type="hidden" name="cid"       value="{$category_id}">
    <input type="hidden" name="aid"       value="{$article_id}">
    <input type="hidden" name="follow_id" value="{$follow_id}">
    <input type="hidden" name="fid"       value="{$file.id}">
</form>
