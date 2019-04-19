{grn_load_javascript file="grn/html/component/pubsub.js"}
{grn_load_javascript file="grn/html/component/member_list_dialog.js"}
{include file='grn/window_simple_dialog.tpl'}
<script language="JavaScript" type="text/javascript">
    <!--
    new grn.component.member_list_dialog.MemberListDialog(
                {literal}{{/literal}
                url: "{$url}",
                access_plugin_encoded: "{$access_plugin_encoded}",
                app_id: "{$app_id}",
                {literal}}{/literal}
    );
    //-->
</script>