{if $use_star}
{if !$star_not_load_js}
<script language="javascript" text="text/javascript" src="{$app_path}/grn/html/star.js?{$build_date}"></script>
{/if}
<script language="javascript" text="text/javascript">
var options = {ldelim}url: '{grn_pageurl page="star/ajax_request"}',
               csrf_ticket: '{$csrf_ticket}',
               list_id: '{$list_id}'{if $on_update},
               on_update: {$on_update}{/if}
               {rdelim};

var obj_star_list = new GRN_StarList(options);
</script>
{/if}