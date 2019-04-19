<script type="text/javascript" src="{$app_path}/fw/yui/build/yahoo/yahoo-min.js?{$build_date}" ></script>
<script type="text/javascript" src="{$app_path}/fw/yui/build/yahoo-dom-event/yahoo-dom-event.js?{$build_date}" ></script>
<script type="text/javascript" src="{$app_path}/fw/yui/build/dragdrop/dragdrop-min.js?{$build_date}" ></script>
<script type="text/javascript" src="{$app_path}/fw/yui/build/animation/animation-min.js?{$build_date}" ></script>
<script type="text/javascript" src="{$app_path}/grn/html/dragdrop_list2tree.js?{$build_date}"></script>

<div id="dragMsg" class="moving_message_grn" style="visibility:hidden; position:absolute; left:150px; top:400px;"><span class="mRight2"></span></div>

{literal}
<style>

.node_dragenter{
    background: #22A0D3;
}
.node_dragenter a:link, .node_dragenter a:visited, .node_dragenter a:hover{
    background: #22A0D3;
}
.row_highlight1{
    background: #FFFAD8 !important;
}

.drag_cursor,
body.drag_cursor a{
    cursor: url({/literal}{$app_path}{literal}/grn/image/cybozu/openhand.cur?{/literal}{$build_date}{literal}), auto;
}

.drag_handle img{
    padding: 0px 5px 0px 0px;
    cursor: url({/literal}{$app_path}{literal}/grn/image/cybozu/openhand.cur?{/literal}{$build_date}{literal}), auto;
}

</style>
{/literal}
