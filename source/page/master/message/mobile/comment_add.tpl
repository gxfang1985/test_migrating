{grn_load_javascript file="grn/html/component/validator_mobile.js"}
{grn_load_javascript file="js/dist/message_mobile.js"}
{if ! $data_theme}{assign var='data_theme' value='c'}{/if}
{assign var="form_name" value=$smarty.template|basename}

<div data-role="content" class="mobile-content-grn" data-theme="{$data_theme}">
  {include file="grn/mobile_breadcrumb.tpl"}
  <form name="{$form_name}" method="post" enctype="multipart/form-data" data-ajax="false" action="{grn_pageurl page='message/mobile/command_comment_add'}" class="mobile_comment_form_grn">
    <input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
    <input type="hidden" id="cid" name="cid" value="{$cid}">
    <input type="hidden" id="rid" name="rid" value="{$rid}">
    <input type="hidden" id="mid" name="mid" value="{$mid}">
    <input type="hidden" id="sp" name="sp" value="{$sp}">
    <input type="hidden" id="follow_id" name="follow_id" value="{$parent_fid}">
    <input type="hidden" name="mention" />
    <div id="error_message_field"></div>
    {include file="grn/mobile_comment_add.tpl"
        name=message_comment_add
        mention=TRUE
        mention_params=$mention_params
        mention_access_plugin_encoded=$mention_access_plugin_encoded
    }
    <div class="mobile-buttonArea-grn">
      <div class="mobile-buttonMain-grn mobile-button-left-grn mobile_show_overlay_js">
        <input type="button" class="js_submit_button" name="send" data-inline="true" data-theme="{$data_theme}" value="{cb_msg module='grn.message' key='GRN_MSG-417' replace='true'}" />
      </div>
      <div class="mobile-buttonNormal-grn mobile-button-right-grn mobile_show_overlay_js">
        <input type="button" data-inline="true" data-theme="{$data_theme}" value="{cb_msg module='grn.message' key='GRN_MSG-418' replace='true'}"
        {if $parent_fid}
            onclick='location.href="{grn_pageurl page='message/mobile/comment_detail' cid=$cid rid=$rid mid=$mid follow_id=$parent_fid sp=$sp}";' /></div>
        {else}
            onclick='location.href="{grn_pageurl page='message/mobile/view' cid=$cid rid=$rid mid=$mid sp=$sp}";' /></div>
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
            name: "message_comment_add_mention",
            formName: "{$form_name}"
            {literal}
        };
        new grn.js.page.message.mobile.CommentAdd(settings);
    });
</script>
{/literal}
<!-- end of content-->