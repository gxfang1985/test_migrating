{grn_title title=$page_title class=$page_info.parts[0]}

{grn_load_css file="grn/html/component/overlay.css"}
{grn_load_javascript file="grn/html/space_text_multilanguage.js"}
{* 
  This file is loaded in order to override the objects defined in grn/html/text_multilanguage.js which is loaded at hreader part. 
*}
{grn_load_javascript file="grn/html/component/overlay.js"}
{grn_load_javascript file="grn/html/component/icon.js"}
{grn_load_javascript file="grn/html/component/validator.js"}
{grn_load_javascript file="fw/yui/build/selector/selector-min.js"}
<div id="errorMessageField"></div>
<form name="space/create" id="space/create" method="post" action="{grn_pageurl page=space/command_create}" enctype="multipart/form-data"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
<table class="std_form">
    <tr>
        <th>{cb_msg module="grn.space" key="create-space-1" replace="true"}<span class="attention">*</span></th>
        <td>{grn_space_text_multilanguage element_name=$this_getMultilingualSpaceNameArray.element_name values=$this_getMultilingualSpaceNameArray.values}
        
        </td>
    </tr>
    <tr>
        <th>{cb_msg module="grn.space" key="create-space-3" replace="true"}<span class="attention">*</span></th>
        <td>
          <input type="hidden" id="id-cid" name="cid" value="{$this->getCategoryId()|escape}">
          <span id="categoryName" class="icon-category-grn">{cb_msg module="grn.space" key="create-space-4" replace="true"}</span>
          <input id="showCategoryOverlay" type="button" value="{cb_msg module="grn.space" key="create-space-5" replace="true"}" style="vertical-align:text-bottom;"/>
        </td>
    </tr>
    <tr>
        <th>{cb_msg module="grn.space" key="create-space-6" replace="true"}<span class="attention">*</span></th>
        <td>
            <input type="hidden" value="1" name="icon" id="iconInput">
            <div class="space-createForm-iconSelector-grn" id="iconSelector">
            </div>
        </td>
    </tr>
    {include file="space/_member_set.tpl" selected_users=$selected_users candidate_users=$selected_users candidate_operators=$selected_users}
    {include file="space/_expiration_date.tpl"}
    <tr>
        <th>{cb_msg module="grn.space" key="create-space-15" replace="true"}</th>
        <td>
            {capture name="grn_space_create_space_16"}{cb_msg module="grn.space" key="create-space-16" replace="true"}{/capture}
            {grn_checkbox name="join_leave" id="join_leave" value="1" caption=$smarty.capture.grn_space_create_space_16}
        </td>
    </tr>
    <tr>
        <th>{cb_msg module="grn.space" key="create-space-7" replace="true"}<span class="attention">*</span></th>
        <td>{capture name="tmp"}{cb_msg module="grn.space" key="create-space-8" replace="true"}{/capture}{grn_radio name="isPublic" id="isPublic1" value="1" caption=$smarty.capture.tmp checked=$privacy_default}
            {capture name="tmp"}{cb_msg module="grn.space" key="create-space-9" replace="true"}{/capture}{assign var="isPublic2checked" value="`$privacy_default-1`"}{grn_radio name="isPublic" id="isPublic2" value="0" caption=$smarty.capture.tmp checked=$isPublic2checked}</td>
    </tr>
    <tr>
        <td>
        </td>
    <td>
        <div class="mTop10">
            {strip}
                {capture name="grn_space_create_space_10"}{cb_msg module="grn.space" key="create-space-10" replace="true"}{/capture}
                {grn_button id='buttonSubmit' ui='main' auto_disable=true caption=$smarty.capture.grn_space_create_space_10 spacing='normal'}
                {grn_button action='cancel' onclick="grn.page.space._expiration_date.spaceCancel(this, 'history_back')"}
            {/strip}
        </div>
    </td>
    </tr>
</table>
</form>
{include file="space/_category_set.tpl" folder_tree=$category_tree category_data_master=$category_data_master category_id=$this->getCategoryId()}
{include file="space/_prepare_submit_js.tpl" form="space/create"}

<script>{literal}
var iconSelector = new grn.component.icon.IconSelector(new Array(
  {/literal}{foreach from=$this->getIconIterator() item=icon name=icons}
  new grn.component.icon.Icon("{$icon->getId()}", "{$icon->getDisplayIconPath()|escape}"){if ! $smarty.foreach.icons.last},{/if}
  {/foreach}{literal}
), "iconInput");
iconSelector.render("iconSelector");
iconSelector.selectIcon({/literal}{$selectedIconNumber}{literal});
{/literal}</script>