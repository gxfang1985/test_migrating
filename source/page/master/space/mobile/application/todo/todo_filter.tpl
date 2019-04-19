{if !$data_theme}{assign var='data_theme' value='c'}{/if}
{assign var="form_name" value=$smarty.template|basename}
{literal}
<script type="text/javascript">
$(document).ready(function()
{
    if($('input[name=s]').get(1).checked)
    {
        $('select:jqmData(id=user)').selectmenu('disable');
    }
});
</script>
{/literal}
{include file='grn/mobile_breadcrumb.tpl' not_need_withList=true}
<div class="mobile_breadcrumb_margin_grn"></div>
<div data-role="content" class="mobile-content-grn"  data-theme="{$data_theme}">
    <form name="{$form_name}" method="get" action="{grn_pageurl page='space/mobile/application/todo/index'}">
        <input type="hidden" name="spid" value="{$space_id}">
        <div class="mobile-narrowdownsearch-selectchoice-grn">
            <div class="mobile-select-grn mobile-div-title-grn">
                <div class="mobile-label-grn">{cb_msg module='grn.space.todo' key='GRN_SP_TOD-75' replace='true'}</div>
                {if !$has_folder_view}
                    <div data-role="fieldcontain" class="mobile_select_grn">
                     <select name="tid">
                         <option value="">{cb_msg module='grn.space.todo' key='GRN_SP_TOD-38' replace='true'}</option>
                         {foreach from=$discussion_collection item=discussion}
                         <option value="{$discussion->getId()}" {if $discussion->getId() == $discussion_id}selected{/if}>{$discussion->getTitle()|escape}</option>
                         {/foreach}
                     </select>
                    </div>
                {else}
                    {capture name='grn_space_todo_filter_menu'}{cb_msg module='grn.space.todo' key='GRN_SP_TOD-75' replace='true'}{/capture}
                    {capture name='grn_space_todo_filter_all'}{cb_msg module='grn.space.todo' key='GRN_SP_TOD-38' replace='true'}{/capture}
                    <a id="menu_space_todo_filter" href="#popup_menu_space_todo_filter" data-rel="popup" data-transition="pop" data-shadow="true" data-wrapperels="span" class="mobile_select_view_grn">
                        <span class="mobile_event_menu_content_grn">{cb_msg module='grn.space.todo' key='GRN_SP_TOD-38' replace='true'}</span>
                        <span class="mobile_select_icon_grn"></span>
                    </a>
                    <input type="hidden" value="" name="tid" id="tid">
                    {include file="grn/mobile_select_menu.tpl"
                    selectMenuTitle=$smarty.capture.grn_space_todo_filter_menu
                    select_items=$thread_collection_for_view
                    selectMenuUI='menu_space_todo_filter'
                    selectMenuValue='tid'
                    popupMenu='popup_menu_space_todo_filter'
                    default_title=$smarty.capture.grn_space_todo_filter_all
                    }
                {/if}
            </div>
            <div class="mobile-select-grn mobile-div-title-grn">
                <div class="mobile-label-grn">{cb_msg module='grn.space.todo' key='GRN_SP_TOD-76' replace='true'}</div>
                <div data-role="fieldcontain" class="mobile_select_grn">
                    <select name="uid" data-id="user">
                        <option value="" selected>{cb_msg module='grn.space.todo' key='GRN_SP_TOD-38' replace='true'}</option>
                        {foreach from=$space_user_collection item=space_user}
                        <option value="{$space_user->getMemberId()}">{$space_user->getDisplayName()|escape}</option>
                        {/foreach}
                    </select>
                </div>
            </div>
            <div class="mobile-radiospace-div-grn mobile-div-title-grn">
                <fieldset data-role="controlgroup" data-type="horizontal" class="mobile-radiospace-fieldset-grn">
                    <input type="radio" name="s" id="radio-pet-1a" value="2" checked="checked" data-inline="true" class="mobile-radio-grn" onclick="javascript:$('select:jqmData(id=user)').selectmenu('enable');"/>
                    <label for="radio-pet-1a" id="label-pet-1a">{cb_msg module='grn.space.todo' key='GRN_SP_TOD-30' replace='true'}</label>
                    <input type="radio" name="s" id="radio-pet-2a" value="1" data-inline="true" class="mobile-radio-grn" onclick="javascript:$('select:jqmData(id=user)').selectmenu('disable');"/>
                    <label for="radio-pet-2a" id="label-pet-2a">{cb_msg module='grn.space.todo' key='GRN_SP_TOD-29' replace='true'}</label>
                </fieldset>
            </div>
        </div>
        <div class="mobile-buttonArea-grn">
            <div class="mobile-buttonMain-grn mobile-button-left-grn">
                <input type="submit" value="{cb_msg module='grn.space.todo' key='GRN_SP_TOD-71' replace='true'}" data-inline="true" data-theme="{$data_theme}"/>
            </div>
            <div class="mobile-buttonNormal-grn mobile-button-right-grn">
                <input type="button" value="{cb_msg module='grn.space.todo' key='GRN_SP_TOD-65' replace='true'}" data-inline="true" data-theme="{$data_theme}" 
                  onclick='location.href="{grn_pageurl page='space/mobile/application/todo/index' spid=$space_id uid=$login.id}";'/>
            </div>
        </div>
    </form>
</div>
