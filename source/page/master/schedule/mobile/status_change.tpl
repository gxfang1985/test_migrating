{strip}
{assign var="form_name" value=$smarty.template|basename}
{if ! $data_theme}{assign var='data_theme' value='c'}{/if}
{grn_load_javascript file="grn/html/component/validator_mobile.js"}
{grn_load_javascript file="grn/html/page/schedule/mobile/confirmation.js"}
{literal}
<script language="Javascript" text="text/javascript">
(function()
{
    var G = grn.page.schedule.mobile.confirmation;
    G.formName = '{/literal}{$form_name}{literal}';
    G.backUrl = '{/literal}{grn_pageurl page=$breadcrumb_upper_page.page params=$breadcrumb_upper_page.params}{literal}';
})();
</script>
{/literal}
<div data-role="content" data-theme="{$data_theme}" class="mobile-content-grn">
    <!--breadcrumb-->
    {include file="grn/mobile_breadcrumb.tpl"}
    <!--end breadcrumb-->
    
    <form method="post" name="{$form_name}" class="mobile_comment_form_grn" action="{cb_pageurl page='schedule/mobile/command_'|cat:$page_info.last}">
        <input name="csrf_ticket" value="{$csrf_ticket}" type="hidden">
        <input id="event" name="event" value="{$event_id}" type="hidden">
        <input id="bdate" name="bdate" value="{$bdate}" type="hidden">
        <input id="uid" name="uid" value="{$user_id}" type="hidden">
        <input id="gid" name="gid" value="{$group_id}" type="hidden">
        <input id="referer_key" name="referer_key" value="{$referer_key}" type="hidden">

        <div class="mobile-div-title-grn mobile_update_title_text_grn">
            <span>
                <span class="mobile-label-grn">
                    {cb_msg module='grn.schedule' key='GRN_SCH-1000' replace='true'}
                </span>
                {$event_title}
            </span>
        </div>  
        <div id="FieldToShowErrorMessage" class="mobile-error-area-grn"></div>
        <div class="mobile_schedule_grn">
            <div class="mobile_list_grn">
                <div class="mobile_title_grn">
                    {cb_msg module='grn.schedule.mobile' key='GRN_SCH_MOBILE-37' replace='true'}
                </div>

                <ul id="member">
                    <li>
                        {if $status eq $attendant}
                            <span class="mobile_icon_radiobutton_grn mobile_icon_radiobuttonon_grn"></span>
                        {else}
                            <span class="mobile_icon_radiobutton_grn mobile_icon_radiobuttonoff_grn"></span>
                        {/if}
                        <span class="mobile_radiobutton_grn"><input name="member" type="radio" value="{$attendant}" {if $status eq $attendant} checked='checked' {/if}></span>
                        <span class="mobile_text_grn ">{cb_msg module='grn.schedule.mobile' key='GRN_SCH_MOBILE-24' replace='true'}</span>
                    </li>
                    <li>
                        {if $status eq $absent}
                            <span class="mobile_icon_radiobutton_grn mobile_icon_radiobuttonon_grn"></span>
                        {else}
                            <span class="mobile_icon_radiobutton_grn mobile_icon_radiobuttonoff_grn"></span>
                        {/if}
                        <span class="mobile_radiobutton_grn"><input name="member" type="radio" value="{$absent}" {if $status eq $absent} checked='checked' {/if}></span>
                        
                        <span class="mobile_text_grn ">{cb_msg module='grn.schedule.mobile' key='GRN_SCH_MOBILE-25' replace='true'}</span>
                    </li>
                </ul>
            </div>
        </div>

        <div class="mobile-div-title-grn">
            <span class="mobile-label-grn">{cb_msg module='grn.schedule.mobile' key='GRN_SCH_MOBILE-38' replace='true'}</span>
            {grn_textarea necessary=true name="message_data" id="message_data" value=$message_data rows="50" class="mobile-textarea-grn" disable_return_key=true}
        </div>

        {if $conflict}
            <div class="mobile-list-todoDetail-grn mobile_schedule_information_alert_grn">
                <div class="mobile-font-warp-grn">
                    <span class="mobile_iconposition_attentions_grn mobile_icon_attentions_grn" style="margin-top:-8px;"></span>
                    <span class="mobile_text_information_grn">{cb_msg module='grn.schedule.mobile' key='GRN_SCH_MOBILE-26' replace='true'}</span>
                </div>
            </div>
        {/if}

        <div class="mobile-buttonArea-grn">
          <div class="mobile-buttonMain-grn mobile-button-left-grn mobile_show_overlay_js">
            <input type="submit" name="send" data-inline="true" data-theme="{$data_theme}" value="{cb_msg module='grn.schedule.mobile' key='GRN_SCH_MOBILE-36' replace='true'}" />
          </div>
          <div class="mobile-buttonNormal-grn mobile-button-right-grn mobile_show_overlay_js">
            <input type="button" data-inline="true" data-theme="{$data_theme}" value="{cb_msg module='grn.schedule' key='GRN_SCH-974' replace='true'}" onclick='location.href="{grn_pageurl page='schedule/mobile/view' event=$event_id bdate=$bdate uid=$user_id gid=$group_id referer_key=$referer_key}";' />
          </div>
        </div>
    </form>
</div>
{/strip}

