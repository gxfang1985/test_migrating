{grn_load_javascript file="grn/html/component/star_mobile.js"}
<script language="javascript" text="text/javascript">
var options = {ldelim}url: '{grn_pageurl page="star/ajax_request"}',
               csrf_ticket: '{$csrf_ticket}'{rdelim};
var obj_star_mobile = new grn.component.star_mobile.StarMobile();
obj_star_mobile.initialize(options);
</script>
