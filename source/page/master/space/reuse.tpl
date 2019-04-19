{grn_title title=$page_title class=$page_info.parts[0]}

{grn_load_css file="grn/html/component/overlay.css"}
{grn_load_javascript file="grn/html/space_text_multilanguage.js"}

{grn_load_javascript file="grn/html/component/overlay.js"}
{grn_load_javascript file="grn/html/component/icon.js"}
{grn_load_javascript file="grn/html/component/validator.js"}
{grn_load_javascript file="fw/yui/build/selector/selector-min.js"}
{grn_load_javascript file="grn/html/page/space/reuse.js"}

<div id="errorMessageField"></div>
<form name="space/reuse" id="space/reuse" method="post" action="{grn_pageurl page=space/command_reuse}" enctype="multipart/form-data">
<input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
<table class="std_form">
    <tr>
        <th>{cb_msg module="grn.space" key="reuse-space-1" replace="true"}<span class="attention">*</span></th>
        <td>{grn_space_text_multilanguage element_name=$space_name_arr.element_name values=$space_name_arr.values}</td>
    </tr>
    <tr>
        <th>{cb_msg module="grn.space" key="reuse-space-2" replace="true"}<span class="attention">*</span></th>
        <td>
          <input type="hidden" id="id-cid" name="cid" value="{$category_id|escape}">
          <span id="categoryName" class="icon-category-grn">{cb_msg module="grn.space" key="reuse-space-3" replace="true"}</span>
          <input id="showCategoryOverlay" value="{cb_msg module='grn.space' key='reuse-space-4' replace='true'}" type="button" style="vertical-align:text-bottom;"/>
        </td>
    </tr>
    <tr>
        <th>{cb_msg module="grn.space" key="reuse-space-9" replace="true"}<span class="attention">*</span></th>
        <td>
            <input type="hidden" value="1" name="icon" id="iconInput">
            <div class="space-createForm-iconSelector-grn" id="iconSelector">
            </div>
        </td>
    </tr>
    {include file="space/_member_set.tpl" selected_users=$this->getSelectedUserArray() selected_operators=$this->getSelectedOperatorArray() candidate_operators=$this->getSelectedUserArray() open_status=$this->getOpenStatus()}
    {include file="space/_expiration_date.tpl"}
    <tr class="js_folder_disc_container">
        <th>{cb_msg module="grn.space" key="reuse-space-5" replace="true"}</th>
        <td>
            {if $folderCollection->count() > 0}
                <div class="attention mBottom10">{cb_msg module="grn.space" key="reuse-space-6" replace="true"}
                    <br/>{cb_msg module="grn.space" key="reuse-space-7" replace="true"}
                </div>
                {if $isUsedFolder}
                    {assign var='class_discussion_reuse' value='reuse_discussion_list_grn'}
                {else}
                    {assign var='class_discussion_reuse' value='reuse_discussion_list_category_none_grn'}
                {/if}
                {foreach from=$folderCollection item=folder}

                    <div class="{$class_discussion_reuse} js_folder_discussion" data-folder-id="{$folder->getId()}">
                        {if $isUsedFolder  eq true}
                        <div class="label_grn mBottom7 js_folder">
                            {if $folder->getId() eq -1}
                                {$folder->getFolderName()}
                            {else}
                                {grn_checkbox name="folder[]" id=$folder->getId() value=$folder->getId() caption=$folder->getFolderName() checked=false}
                            {/if}
                        </div>
                        {/if}
                        <ul class="js_discussion">
                            {foreach from=$folder->ThreadCollection() item=discussion}
                                <li>
                                    {grn_checkbox name="discussion[]" class="js_discussion" id="discussion_"|cat:$discussion->getId() value=$discussion->getId() caption=$discussion->getTitle() checked=false}
                                </li>
                            {/foreach}
                        </ul>
                    </div>
                {/foreach}
            {else}
                <span class="attention">{cb_msg module="grn.space" key="reuse-space-14" replace="true"}</span>
            {/if}
        </td>
    </tr>
    <tr>
        <th>{cb_msg module="grn.space" key="reuse-space-8" replace="true"}</th>
        <td>
        {if $memo->isRichText()}
            {include file="grn/richeditor.tpl" html=$memo->getDisplayMemo() enable=1 name="data" class="form_textarea_grn"}
        {else}
            {include file="grn/richeditor.tpl" text=$memo->getMemo() enable=1 name="data" class="form_textarea_grn"}
        {/if}
        </td>
    </tr>
    <tr>
        <th>{cb_msg module="grn.space" key="modify-space-15" replace="true"}</th>
        <td>
            {capture name="grn_space_modify_space_16"}{cb_msg module="grn.space" key="modify-space-16" replace="true"}{/capture}
            {grn_checkbox id="join_leave" name="join_leave" is="join_leave" value="1" caption=$smarty.capture.grn_space_modify_space_16 checked=$this->isSpaceAllowJoinLeave()}
        </td>
    </tr>
    <tr>
        <th>{cb_msg module="grn.space" key="reuse-space-10" replace="true"}<span class="attention">*</span></th>
        <td>{capture name="tmp"}{cb_msg module="grn.space" key="reuse-space-11" replace="true"}{/capture}{grn_radio name="isPublic" id="isPublic1" value="1" caption=$smarty.capture.tmp checked=$this->isSpacePublic()}
            {capture name="tmp"}{cb_msg module="grn.space" key="reuse-space-12" replace="true"}{/capture}{grn_radio name="isPublic" id="isPublic2" value="0" caption=$smarty.capture.tmp checked=$this->isSpacePrivate()}</td>
    </tr>
    <tr>
        <td>
        </td>
    <td>
        <input type="hidden" name="spid" value="{$this->getSpaceId()|escape}">
        <div class="mTop10">
            {strip}
                {capture name="grn_space_create_space_13"}{cb_msg module="grn.space" key="reuse-space-13" replace="true"}{/capture}
                {grn_button id='buttonSubmit' ui='main' auto_disable=true caption=$smarty.capture.grn_space_create_space_13 spacing='normal'}
                {grn_button action='cancel' onclick="grn.page.space._expiration_date.spaceCancel(this, 'history_back')"}
            {/strip}
        </div>
    </td>
    </tr>
</table>
</form>
{include file="space/_category_set.tpl" folder_tree=$this->getCategoryTreeArrayForView() category_data_master=$this->getCategoryDataJson() category_id=$category_id}
{include file="space/_prepare_submit_js.tpl" form="space/reuse"}

<script>{literal}
var iconSelector = new grn.component.icon.IconSelector(new Array(
  {/literal}{foreach from=$this->getIconCollection() item=icon name=icons}
  new grn.component.icon.Icon("{$icon->getId()|escape}", "{$icon->getDisplayIconPath()|escape}"){if ! $smarty.foreach.icons.last},{/if}
  {/foreach}{literal}
), "iconInput");
iconSelector.render("iconSelector");
iconSelector.selectIcon({/literal}{$this->getSelectedIconNumber()|escape}{literal});
{/literal}</script>