{include file="grn/login_head.tpl"}
{include file="grn/login_header.tpl"}

{if $necessary_password}
{capture name='grn_GRN_GRN_122'}{cb_msg module='grn' key='GRN_GRN-122' replace='true'}{/capture}
<form name="{$page_info.last}" method="POST" action="{$url|escape}" onsubmit="{literal}if (this._password.value.length == 0) { alert('{/literal}{$smarty.capture.grn_GRN_GRN_122}{literal}'); return false; } else return true;{/literal}">
{else}
<form name="{$page_info.last}" method="POST" action="{$url|escape}">
{/if}
<input type="hidden" name="_system" value="1">
{foreach from=$params item=value key=key}
<input type="hidden" name="{$key|escape}" value="{$value|escape}">
{/foreach}
<div id="one_parts">
 <div id="action">
  <div class="center_block">
   <div class="center_list">
{if $company_name}
    <div class="company">{$company_name|escape}</div>
    <div class="br">&nbsp;</div>
{/if}
<div class="login_info_area_grn">
    <div class="login_up_line_grn">
        <div class="login_label_grn">{cb_msg module='grn' key='GRN_GRN-123' replace='true'}</div><div class="login_input_up_grn">
            <div class="login_name_grn">
                {if $login_cookie}
                    {capture name='grn_GRN_GRN_124'}{cb_msg module='grn' key='GRN_GRN-124' replace='true'}{/capture}
                    <input name="_account" class="logintextfield" maxlength="100" value="{$login_cookie.foreign_key}" title={$smarty.capture.grn_GRN_GRN_124} onkeypress="return event.keyCode != 13;" type="text">
                {else}
                    {capture name='grn_GRN_GRN_125'}{cb_msg module='grn' key='GRN_GRN-125' replace='true'}{/capture}
                    <input name="_account" class="logintextfield" maxlength="100" value="" title={$smarty.capture.grn_GRN_GRN_125} onkeypress="return event.keyCode != 13;" type="text">
                {/if}
            </div>
        </div>
    </div>
    <div class="login_up_line_grn">
        <div class="login_label_grn">{cb_msg module='grn' key='GRN_GRN-126' replace='true'}</div><div class="login_input_up_grn">
            {capture name='grn_GRN_GRN_127'}{cb_msg module='grn' key='GRN_GRN-127' replace='true'}{/capture}
            <div class="login_name_grn">{grn_password name="_password" purpose='auth' class="logintextfield" maxlength="64" autocomplete=$password_autocomplete title=$smarty.capture.grn_GRN_GRN_127}</div>
            </div>
        </div>
    
   
        <div class="login_down_line_grn">
            <div class="login_input_down_grn">
                <div class="login_password_grn"></div>
                {if $login_cookie}
                    {capture name='grn_GRN_GRN_128'}{cb_msg module='grn' key='GRN_GRN-128' replace='true'}{/capture}
                    <div class="login_checkbox_grn"><input name="use_cookie" id="checkbox1" value="1" type="checkbox" class="login_check_grn" checked=true><label id="checkbox1_label" for="checkbox1">{$smarty.capture.grn_GRN_GRN_128}</label></div>
                {else}
                    {capture name='grn_GRN_GRN_129'}{cb_msg module='grn' key='GRN_GRN-129' replace='true'}{/capture}
                    <div class="login_checkbox_grn"><input name="use_cookie" id="checkbox1" value="1" type="checkbox" class="login_check_grn" ><label id="checkbox1_label" for="checkbox1">{$smarty.capture.grn_GRN_GRN_129}</label></div>
                {/if}
                
                <div class="login_button_grn"><input type="submit" name="login-submit" value="{cb_msg module='grn' key='GRN_GRN-130' replace='true'}" class="login_margin"></div>
            </div>
        </div>
    </div>
   </div>
  </div>
 </div><!--action_end--->
</div>
</form>
