{if ! $data_theme}{assign var='data_theme' value='c'}{/if}
{assign var="form_name" value=$smarty.template|basename}
<div data-role="content" class="mobile-content-grn" data-theme="{$data_theme}">
{include file='grn/mobile_breadcrumb.tpl'}
  <form class="mobile_comment_form_grn" name="{$form_name}" method="post" enctype="multipart/form-data" data-ajax="false" action="{grn_pageurl page='space/mobile/application/todo/command_comment_add'}">
    <input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
    <input type="hidden" id="spid" name="spid" value="{$space_id}">
    <input type="hidden" id="tdid" name="tdid" value="{$todo_id}">
    <input type="hidden" id="reply_comment_id" name="reply_comment_id" value="{$parent_cmid}">
    {include file="grn/mobile_comment_add.tpl" form_name=$form_name}
    <div class="mobile-buttonArea-grn">
      <div class="mobile-buttonMain-grn mobile-button-left-grn mobile_show_overlay_js">
        <input type="submit" name="send" data-inline="true" data-theme="{$data_theme}" value="{cb_msg module='grn.space.discussion' key='GRN_SP_DISC-35' replace='true'}" />
      </div>
      <div class="mobile-buttonNormal-grn mobile-button-right-grn mobile_show_overlay_js">
        <input type="button" data-inline="true" data-theme="{$data_theme}" value="{cb_msg module='grn.space.discussion' key='GRN_SP_DISC-41' replace='true'}"
        {if $parent_cmid}
            onclick='location.href="{grn_pageurl page='space/mobile/application/todo/comment_detail' spid=$space_id tdid=$todo_id cmid=$parent_cmid}";' /></div>
        {else}
            onclick='location.href="{grn_pageurl page='space/mobile/application/todo/detail' spid=$space_id tdid=$todo_id}";' /></div>
        {/if}
    </div>
  </form>
</div>
<!-- end of content-->