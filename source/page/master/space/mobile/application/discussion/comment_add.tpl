{* diccussion mobile add entry *}
{grn_load_javascript file="grn/html/component/validator_mobile.js"}
{grn_load_javascript file="js/dist/space_mobile.js"}
{if ! $data_theme}{assign var='data_theme' value='c'}{/if}
{assign var="form_name" value=$smarty.template|basename}
<div data-role="content" class="mobile-content-grn" data-theme="{$data_theme}">
{include file='grn/mobile_breadcrumb.tpl'}
  <form class="mobile_comment_form_grn" name="{$form_name}" method="post" enctype="multipart/form-data" data-ajax="false" action="{grn_pageurl page='space/mobile/application/discussion/command_comment_add'}">
    <input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
    <input type="hidden" id="spid" name="spid" value="{$space_id}">
    <input type="hidden" id="tid" name="tid" value="{$thread_id}">
    <input type="hidden" id="reply_comment_id" name="reply_comment_id" value="{$parent_cmid}">
    <input type="hidden" id="reply_comment_istodo" name="reply_comment_istodo" value="{$reply_comment_istodo}">
    <input type="hidden" id="reply_comment_todo_id" name="reply_comment_todo_id" value="{$reply_comment_todo_id}">
    <input type="hidden" name="mention" />
    <div id="errorMessageField"></div>
    {include file="grn/mobile_comment_add.tpl"
        name=thread_comment_add
        mention=TRUE
        mention_params=$mention_params
        mention_access_plugin_encoded=$mention_access_plugin_encoded
    }
    <div class="mobile-buttonArea-grn">
      <div class="mobile-buttonMain-grn mobile-button-left-grn mobile_show_overlay_js">
        <input type="button" class="js_submit_button" name="send" data-inline="true" data-theme="{$data_theme}" value="{cb_msg module='grn.space.discussion' key='GRN_SP_DISC-35' replace='true'}" />
      </div>
      <div class="mobile-buttonNormal-grn mobile-button-right-grn mobile_show_overlay_js">
        <input type="button" data-inline="true" data-theme="{$data_theme}" value="{cb_msg module='grn.space.discussion' key='GRN_SP_DISC-41' replace='true'}" 
        {if $parent_cmid}
          onclick='location.href="{grn_pageurl page='space/mobile/application/discussion/comment_detail' spid=$space_id tid=$thread_id cmid=$parent_cmid}";' /></div>
        {else}
          onclick='location.href="{grn_pageurl page='space/mobile/application/discussion/detail' spid=$space_id tid=$thread_id}";' /></div>
        {/if}
    </div>
  </form>
</div>
{literal}
<script>
    $(document).on( "ready", function( event )
    {
        // Initialize Mention component
        var settings = {
            {/literal}
            name: "thread_comment_add_mention",
            formName: "{$form_name}"
            {literal}
        };
        new grn.js.page.space.mobile.application.discussion.CommentAdd(settings);
    });
</script>
{/literal}
<!-- end of content-->