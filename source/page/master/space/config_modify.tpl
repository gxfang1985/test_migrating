{grn_space_show_expiration_date_warning space=$this->getSpace()}

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
<form name="space/modify" id="space/config_modify" method="post" action="{grn_pageurl page=space/command_config_modify}" enctype="multipart/form-data"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
<table class="std_form">
    <tr>
        <th>{cb_msg module="grn.space" key="modify-space-1" replace="true"}<span class="attention">*</span></th>
        <td>{grn_space_text_multilanguage element_name=$this_getMultilingualSpaceNameArray.element_name values=$this_getMultilingualSpaceNameArray.values}</td>
    </tr>
    <tr>
        <th>{cb_msg module="grn.space" key="modify-space-3" replace="true"}<span class="attention">*</span></th>
        <td>
          <input type="hidden" id="id-cid" name="cid" value="{$this_getSpace->getCategoryId()|escape}">
          <span id="categoryName" class="icon-category-grn">{cb_msg module="grn.space" key="modify-space-4" replace="true"}</span>
          <input id="showCategoryOverlay" value="{cb_msg module="grn.space" key="modify-space-5" replace="true"}" type="button"></input>
        </td>
    </tr>
    <tr>
        <th>{cb_msg module="grn.space" key="modify-space-6" replace="true"}<span class="attention">*</span></th>
        <td>
            <input type="hidden" value="1" name="icon" id="iconInput">
            <div class="space-createForm-iconSelector-grn" id="iconSelector">
            </div>
        </td>
    </tr>
    {include file="space/_member_set.tpl" selected_users=$this->getSelectedUserArray() selected_operators=$this->getSelectedOperatorArray() candidate_operators=$this->getSelectedUserArray()}
    {include file="space/_expiration_date.tpl"}
    <tr>
        <th>{cb_msg module="grn.space" key="modify-space-15" replace="true"}</th>
        <td>
            {capture name="grn_space_modify_space_16"}{cb_msg module="grn.space" key="modify-space-16" replace="true"}{/capture}
            {grn_checkbox id="join_leave" name="join_leave" is="join_leave" value="1" caption=$smarty.capture.grn_space_modify_space_16 checked=$this->isSpaceAllowJoinLeave()}
        </td>
    </tr>
    <tr>
        <th>{cb_msg module="grn.space" key="modify-space-7" replace="true"}<span class="attention">*</span></th>
        <td>{capture name="tmp"}{cb_msg module="grn.space" key="modify-space-8" replace="true"}{/capture}{grn_radio name="isPublic" id="isPublic1" value="1" caption=$smarty.capture.tmp checked=$this->isSpacePublic()}
            {capture name="tmp"}{cb_msg module="grn.space" key="modify-space-9" replace="true"}{/capture}{grn_radio name="isPublic" id="isPublic2" value="0" caption=$smarty.capture.tmp checked=$this->isSpacePrivate()}</td>
    </tr>
    <tr>
        <td>
        </td>
    <td>
        <input type="hidden" name="spid" value="{$this->getSpaceId()|escape}">
        <div class="mTop10">
            {strip}
                {capture name="grn_space_create_space_10"}{cb_msg module="grn.space" key="modify-space-10" replace="true"}{/capture}
                {grn_button id='buttonSubmit' ui='main' auto_disable=true caption=$smarty.capture.grn_space_create_space_10 spacing='normal'}
                {grn_button action='cancel' onclick="grn.page.space._expiration_date.spaceCancel(this, 'history_back')"}
            {/strip}
        </div>
    </td>
    </tr>
</table>
</form>
{include file="space/_category_set.tpl" folder_tree=$this->getCategoryTreeArrayForView() category_data_master=$category_data_master category_id=$this_getSpace->getCategoryId()}
{include file="space/_prepare_submit_js.tpl" form="space/modify"}

<script>{literal}

var iconSelector = new grn.component.icon.IconSelector(new Array(
  {/literal}{foreach from=$this->getIconCollection() item=icon name=icons}
  new grn.component.icon.Icon("{$icon->getId()|escape}", "{$icon->getDisplayIconPath()|escape}"){if ! $smarty.foreach.icons.last},{/if}
  {/foreach}{literal}
), "iconInput");
iconSelector.render("iconSelector");
iconSelector.selectIcon({/literal}{$this->getSelectedIconNumber()|escape}{literal});
{/literal}</script>