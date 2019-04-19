{include file="grn/pwd_expired_head.tpl"}
{include file="grn/login_header.tpl"}

<form name="{$page_info.last}" method="POST" action="{$url|escape}">
<input type="hidden" name="_system" value="2">
<input type="hidden" name="_exec" value="">
<input type="hidden" name="_uid" value="{$pwd_expired.uid}">
<input type="hidden" name="_pwd_ticket" value="{$pwd_expired.ticket}">
{foreach from=$params item=value key=key}
<input type="hidden" name="{$key|escape}" value="{$value|escape}">
{/foreach}
<div id="one_parts">
 <div id="action">
  <div class="center_block">
   <div class="center_list">
    <div class="login_message_grn">
        {if $pwd_expired.expiration_days > 0}
            <div >{cb_msg module='grn' key='GRN_GRN-168' replace='true'}{$pwd_expired.expiration_days}{cb_msg module='grn' key='GRN_GRN-169' replace='true'}</div>
            <div >{cb_msg module='grn' key='GRN_GRN-169-2' replace='true'}</div>
            <input type="button" value="{cb_msg module='grn' key='GRN_GRN-170' replace='true'}" onClick="this.form._exec.value='0';this.form.submit();">
        {else}
            <div >{cb_msg module='grn' key='GRN_GRN-171' replace='true'}</div>
            <div >{cb_msg module='grn' key='GRN_GRN-171-2' replace='true'}</div>
        {/if}
    </div>
    <div class="br">&nbsp;</div>
    <div class="login_info_area_grn">
        <div class="login_up_line_grn">
            <div class="login_label_grn">{cb_msg module='grn' key='GRN_GRN-172' replace='true'}</div><div class="login_input_up_grn"><div class="login_name_grn">{$pwd_expired.account}</div></div>
        </div>
        <div class="login_up_line_grn">
            <div class="login_label_grn">{cb_msg module='grn' key='GRN_GRN-173' replace='true'}</div><div class="login_input_up_grn"><div class="login_name_grn">{capture name='grn_GRN_GRN_174'}{cb_msg module='grn' key='GRN_GRN-174' replace='true'}{/capture}{grn_password name="_password" class="logintextfield" purpose='init' maxlength=64 title=$smarty.capture.grn_GRN_GRN_174 disable_return_key=true}</div></div>
        </div>
        <div class="login_up_line_grn">
            <div class="login_label_grn">{cb_msg module='grn' key='GRN_GRN-175' replace='true'}<span class="pw_label_sub_grn">{cb_msg module='grn' key='GRN_GRN-175-2' replace='true'}</span></div><div class="login_input_up_grn"><div class="login_name_grn">{capture name='grn_GRN_GRN_176'}{cb_msg module='grn' key='GRN_GRN-176' replace='true'}{/capture}{grn_password name="_retype" class="logintextfield" purpose='init' maxlength=64 title=$smarty.capture.grn_GRN_GRN_176}</div></div>
        </div>
        <div class="login_down_line_grn">
            <div class="login_input_down_grn">
                <div class="login_password_grn"></div>
                <div class="login_button_grn"><input type="submit" class="login_margin" value="{cb_msg module='grn' key='GRN_GRN-177' replace='true'}" onClick="this.form._exec.value='1';"></div>
            </div>
        </div>
    </div>
   </div>
  </div>
 </div><!--action_end--->
</div>
</form>
