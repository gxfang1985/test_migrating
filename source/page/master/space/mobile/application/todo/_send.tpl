{if ! $data_theme}{assign var='data_theme' value='c'}{/if}
{grn_load_javascript file="grn/html/component/validator_mobile.js"}
{grn_load_javascript file="grn/html/component/checkbox_mobile.js"}
{grn_load_javascript file="grn/html/page/space/mobile/todo/todo_edit.js"}
{literal}
<script language="JavaScript" text="text/javascript">
(function()
{
    var G = grn.page.space.mobile.todo.todo_edit;
{/literal}
    G.ERRMSG_TITLE_IS_REQUIRED = '{cb_msg module='grn.space.todo' key='GRN_SP_TOD-2' replace='true'}';
    G.ERRMSG_INVALID_START_DATE = '{cb_msg module='grn.space.todo' key='GRN_SP_TOD-21' replace='true'}';
    G.SHOW_CONTENT = '{cb_msg module='grn.space.todo' key='GRN_SP_TOD-68' replace='true'}';
    G.HIDE_CONTENT = '{cb_msg module='grn.space.todo' key='GRN_SP_TOD-69' replace='true'}';
{literal}
})();
</script>
{/literal}
{include file='grn/mobile_breadcrumb.tpl' not_need_withList=true}
<div class="mobile_breadcrumb_margin_grn"></div>
<div data-role="content" class="mobile-content-grn"  data-theme="{$data_theme}">
  <div id="FieldToShowErrorMessage" class="mobile-error-area-grn"></div>
  <div class="mobile-div-title-grn">
    <span class="mobile-label-grn">{cb_msg module='grn.space.todo' key='GRN_SP_TOD-1' replace='true'}<span class="mobile-required-grn">*</span></span>
    {grn_text necessary=true name="title" id="title" value=$title disable_return_key=true}
  </div>
    {include file="space/mobile/application/todo/_todo_date.tpl" form_name=$form_name start_date=$start_date end_date=$end_date modify_form=$modify_form}
  <ul id="todo_member" data-role="listview" data-theme="{$data_theme}" class="mobile-bottom-listview-grn mobile-li-PersonInCharge-grn" >
    <div class="mobile-separation-grn"></div>
    <li data-icon="false">
      <input type='hidden' id="user_ids" name="user_ids" value="{$user_ids}">
      <a class="ui-link-inherit" href="#_select">
        <div class="mobile-label-small-grn">{cb_msg module='grn.space.todo' key='GRN_SP_TOD-4' replace='true'}</div>
        &nbsp;<span class="mobile-font-warp-grn">{$user_names}</span>
        <span class="mobile-array-todo-grn"></span>
      </a>
    </li>
    <div class="mobile-separation-grn"></div>
  </ul>
{if ! $modify_form}
  <div class="mobile-div-title-grn">
    <span class="mobile-contentSubButton-grn">
      <a id="content_button" href="javascript:void(0);" data-role="button" data-icon="arrow-d" data-theme="{$data_theme}" class="mobile-showContent-grn">{cb_msg module='grn.space.todo' key='GRN_SP_TOD-68' replace='true'}</a>
    </span>
  </div>
  <div id="content_text" style="display:none">
{else}
  <div id="content_text">
{/if}
    <div class="mobile-div-title-grn">
      <span for="textarea" class="mobile-label-grn">{cb_msg module='grn.space.todo' key='GRN_SP_TOD-5' replace='true'}</span>
      {grn_textarea name='memo' value=$memo class="mobile-textarea-grn"}
    </div>
    {include file="grn/mobile_attach_file.tpl" attached_files=$attach_files}
  </div>
{if $modify_form}
  <div class="mobile-div-title-grn">
    {strip}
    <label for="status_initialize">
      <a href="javascript:void(0);" class="mobile-checkboxOff-todo-grn ui-link"></a>
      <span class="mobile_checkbox_grn">
        <input name="status_initialize" id="status_initialize" type="checkbox" value="1" data-role="none" class="mobile-input-grn"/>
      </span>
    </label>
    <span class="mobile_btn_checkboxtext_grn">{cb_msg module='grn.space.todo' key='GRN_SP_TOD-80' replace='true'}</span>
    {/strip}
  </div>
{/if}
  <div class="mobile-buttonArea-grn">
    <div class="mobile-buttonMain-grn mobile-button-left-grn mobile_show_overlay_js">
{if ! $modify_form}
      <input type="submit" id="todo_add_submit" value="{cb_msg module='grn.space.todo' key='GRN_SP_TOD-73' replace='true'}" 
        onclick="return grn.page.space.mobile.todo.todo_edit.validate(event, document.forms['{$form_name}'])" data-inline="true" data-theme="{$data_theme}"/></div>
      <div class="mobile-buttonNormal-grn mobile-button-right-grn mobile_show_overlay_js">
        <input type="button" value="{cb_msg module='grn.space.todo' key='GRN_SP_TOD-65' replace='true'}"
        {if $from eq '4'}
          onclick='location.href="{grn_pageurl page='space/mobile/application/discussion/detail' spid=$space_id tid=$thread_id}";'
        {else}
          onclick='location.href="{grn_pageurl page='space/mobile/application/todo/index' spid=$space_id tid=$thread_id}";'
        {/if}
         data-inline="true" data-theme="{$data_theme}"/></div>
{else}
      <input type="submit" id="todo_add_submit" value="{cb_msg module='grn.space.todo' key='GRN_SP_TOD-74' replace='true'}" 
        onclick="return grn.page.space.mobile.todo.todo_edit.validate(event, document.forms['{$form_name}'])" data-inline="true" data-theme="{$data_theme}"/></div>
      <div class="mobile-buttonNormal-grn mobile-button-right-grn mobile_show_overlay_js">
        <input type="button" value="{cb_msg module='grn.space.todo' key='GRN_SP_TOD-65' replace='true'}"
          onclick='location.href="{grn_pageurl page='space/mobile/application/todo/detail' spid=$space_id tdid=$todo_id}";' data-inline="true" data-theme="{$data_theme}"/></div>
{/if}
  </div>
</div><!--content-->
{include file='grn/_mobile_footer_common.tpl' main_page=true}

<!-- Member select page -->
<div data-role="page" id="_select">
{include file='space/mobile/application/todo/_member_select_breadcrumb.tpl' not_need_withList=true}
<div data-role="content" class="mobile-content-grn" data-theme="{$data_theme}">
{if $modify_form}
{foreach from=$todo_users key=id item=username}
  {assign var='checkbox_id' value=$form_name|cat:'_'|cat:$id}
  <div class="mobile-check-user-grn">
    <label for="{$checkbox_id}">
    <a href="javascript:void(0);" class="mobile-checkbox-normal-grn"></a>
    <input name="todoMember[]" id="{$checkbox_id}" type="checkbox" value="{$id}" data-role="none" class="mobile-input-grn" checked="checked"/>
    <span>{$username}</span>
    </label></div>
{/foreach}
{/if}
{foreach from=$space_users key=id item=username}
  {assign var='checkbox_id' value=$form_name|cat:'_'|cat:$id}
  <div class="mobile-check-user-grn">
    <label for="{$checkbox_id}">
    <a href="javascript:void(0);" class="mobile-checkboxOff-todo-grn"></a>
    <input name="todoMember[]" id="{$checkbox_id}" type="checkbox" value="{$id}" data-role="none" class="mobile-input-grn"/>
    <span>{$username}</span>
    </label></div>
{/foreach}
<div class="mobile-buttonArea-grn">
 <div class="mobile-buttonMain-grn mobile-button-left-grn">
   <input type="button" value="{cb_msg module='grn.space.todo' key='GRN_SP_TOD-64' replace='true'}" data-inline="true"  data-theme="{$data_theme}"
     onclick="grn.page.space.mobile.todo.todo_edit.memberSelect();"/></div>
 <div class="mobile-buttonNormal-grn mobile-button-right-grn">
 <input  type="button" value="{cb_msg module='grn.space.todo' key='GRN_SP_TOD-65' replace='true'}" onclick="grn.page.space.mobile.todo.todo_edit.initialize();" data-inline="true"  data-theme="{$data_theme}"/></div>
</div>
</div>
{include file='grn/_mobile_footer_common.tpl'}
