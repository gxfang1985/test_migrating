{include file="grn/system_head.tpl"}
{grn_load_javascript file="grn/html/form_disable.js"}
{grn_load_javascript file="grn/html/page/dezielink/system/modify.js"}
<script language="JavaScript" type="text/javascript">
    var G = grn.page.dezielink.system.modify;
    G.moduleName = '{cb_msg module='grn.dezielink.system' key='GRN_DZL_SY-138' replace='true'}';
    G.formName = '{$form_name}'
</script>
{include file="grn/system_header.tpl"}

{grn_title title=$page_title class=""}
<p></p>
<div class="explanation">{cb_msg module='grn.dezielink.system' key='GRN_DZL_SY-139' replace='true'}</div>
<p></p>
{include file='grn/show_validation_errors.tpl'}
{include file='grn/indispensable.tpl'}
<div>
  <form name="{$form_name}" id="form-content" method="POST" action="{grn_pageurl page='dezielink/system/command_'|cat:$page_info.last}">
    {include file='dezielink/system/_connector_modify.tpl' is_office_module=true}
  </form>
</div>
{include file="grn/system_footer.tpl"}