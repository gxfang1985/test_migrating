{if ! $data_theme}{assign var='data_theme' value='c'}{/if}
{assign var="form_name" value=$smarty.template|basename}
<div data-role="content" class="mobile-content-grn" data-theme="{$data_theme}">
  {include file="grn/mobile_breadcrumb.tpl"}
  <form name="{$form_name}" method="post" enctype="multipart/form-data" data-ajax="false" action="{grn_pageurl page='schedule/mobile/command_comment_add'}" class="mobile_comment_form_grn">
    <input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
    <input type="hidden" id="event" name="event" value="{$event_id}">
    <input type="hidden" id="bdate" name="bdate" value="{$bdate}">
    <input type="hidden" id="uid" name="uid" value="{$user_id}">
    <input type="hidden" id="gid" name="gid" value="{$group_id}">
    <input type="hidden" id="referer_key" name="referer_key" value="{$referer_key}">
    {if $event_type == 'repeat' || $event_type == 'share_repeat'}
    <div class="mobile_add_comment_information_grn">
          <span class="mobile_icon_information_grn"></span>
          <span class="mobile_text_information_grn">{cb_msg module='grn.schedule' key='GRN_SCH-298' replace='true'}</span>
    </div>
    {/if}
    {include file="grn/mobile_comment_add.tpl" form_name=$form_name}
    <div class="mobile-buttonArea-grn">
      <div class="mobile-buttonMain-grn mobile-button-left-grn mobile_show_overlay_js">
        <input type="submit" name="send" data-inline="true" data-theme="{$data_theme}" value="{cb_msg module='grn.schedule' key='GRN_SCH-973' replace='true'}" />
      </div>
      <div class="mobile-buttonNormal-grn mobile-button-right-grn mobile_show_overlay_js">
        <input type="button" data-inline="true" data-theme="{$data_theme}" value="{cb_msg module='grn.schedule' key='GRN_SCH-974' replace='true'}" onclick='location.href="{grn_pageurl page='schedule/mobile/view' event=$event_id bdate=$bdate uid=$user_id gid=$group_id referer_key=$referer_key}";' />
      </div>
    </div>
  </form>
</div>
<!-- end of content-->