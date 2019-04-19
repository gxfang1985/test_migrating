{if ! $data_theme}{assign var='data_theme' value='c'}{/if}
{assign var="form_name" value=$smarty.template|basename}
<div data-role="content" class="mobile-content-grn" data-theme="{$data_theme}">
  {include file="grn/mobile_breadcrumb.tpl"}
  <form class="mobile_comment_form_grn" name="{$form_name}" method="post" enctype="multipart/form-data" data-ajax="false" action="{grn_pageurl page='report/mobile/command_comment_add'}">
    <input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
    <input type="hidden" id="rid" name="rid" value="{$rid}">
    <input type="hidden" id="follow_id" name="follow_id" value="{$parent_fid}">
    {include file="grn/mobile_comment_add.tpl" form_name=$form_name}
    <div class="mobile-buttonArea-grn">
      <div class="mobile-buttonMain-grn mobile-button-left-grn mobile_show_overlay_js">
        <input type="submit" name="send" data-inline="true" data-theme="{$data_theme}" value="{cb_msg module='grn.report' key='GRN_RPRT-93' replace='true'}" />
      </div>
      <div class="mobile-buttonNormal-grn mobile-button-right-grn mobile_show_overlay_js">
        <input type="button" data-inline="true" data-theme="{$data_theme}" value="{cb_msg module='grn.report' key='report_mobile-4' replace='true'}"
        {if $parent_fid}
            onclick='location.href="{grn_pageurl page='report/mobile/comment_detail' rid=$rid follow_id=$parent_fid}";' /></div>
        {else}
            onclick='location.href="{grn_pageurl page='report/mobile/view' rid=$rid}";' /></div>
        {/if}
    </div>
  </form>
</div>
<!-- end of content-->