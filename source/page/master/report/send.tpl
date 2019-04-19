{include file='grn/head.tpl'}
{include file='grn/header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}
{grn_load_javascript file="grn/html/report.js"}
{literal}
<script language="javascript">
<!--
    var formListUrl = "{/literal}{grn_pageurl page='report/ajax/send_form_list'}{literal}";
    var userType = "{/literal}{$page_info.parts[1]}{literal}";
    var csrf_ticket = "{/literal}{$csrf_ticket}{literal}";
//-->
</script>
{/literal}
<center>
<table border=0>
 <tr align="center">
  <td class="step_current_grn" valign="middle">{cb_msg module='grn.report' key='GRN_RPRT-35' replace='true'}</td>
  <td><span class="step_arrow_grn"></span></td>
  <td class="step_grn" valign="middle">{cb_msg module='grn.report' key='GRN_RPRT-37' replace='true'}</td>
  <td><span class="step_arrow_grn"></span></td>
  <td class="step_grn" valign="middle">{cb_msg module='grn.report' key='GRN_RPRT-39' replace='true'}</td>
 </tr>
</table>
</center>

<p class="explanation">{cb_msg module='grn.report' key='GRN_RPRT-41' replace='true'}</p>

<table width="100%">
<tr valign="top">
<td id="tree_part">
{include file='grn/org_tree_26.tpl'}
</td>
{* window.onload では、ツリーの初期化前に onSelectCategory が実行されてしまうため初期化イベントの設定後に設定 *}
<script type="text/javascript" src="{$app_path}/fw/yui/build/yahoo/yahoo-min.js?{$build_date}" ></script>
{literal}
<script language="javascript">
<!--
    YAHOO.util.Event.onDOMReady(function()
    {
        onSelectCategory({/literal}{$category_id}{literal});

        var ajaxRequest = new grn.component.ajax.request({
            grnUrl: "{/literal}{$folder_tree.async_url}{literal}",
            method: "post",
            data: "page=report/send",
            grnRedirectOnLoginError: true
        });

        ajaxRequest.send().done(function (data, textStatus, jqXHR) {
            obj_folder_tree._getResponse(data, jqXHR);
        });
    });
//-->
</script>
{/literal}
<td id="view_part" width="80%">
<img border="0" align="top" id="reportLoadingImage" src="{$app_path}/grn/image/cybozu/spinner.gif?{$build_date}"/>
 </td>
<tr>
</table>

{include file="grn/footer.tpl"}
