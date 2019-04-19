{if ! $data_theme}{assign var='data_theme' value='c'}{/if}
{assign var="form_name" value=$smarty.template|basename}
<div data-role="content" class="mobile-content-grn" data-theme="{$data_theme}">
{include file='grn/mobile_breadcrumb.tpl'}
<div class="mobile_breadcrumb_margin_grn"></div>
<form name="{$form_name}" method="post" enctype="multipart/form-data" data-ajax="false" action="{grn_pageurl page='space/mobile/application/discussion/command_add'}">
<input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
{include file="space/mobile/application/discussion/_send.tpl" form_name=$form_name cancel_page="space/mobile/application/discussion/index"}
</form>
</div>
<!-- end of content-->