<script language="javascript">
<!--
function signValue(i,target)
{literal}
{
    var my = i;
    var num = my.selectedIndex;
    var sid = parseInt(my.options[num].value);
    switch(sid){
        {/literal}{foreach from=$sign_value item=value key=sid}
        case {$sid}:target.value = "{$value|escape:javascript}";break;
        {/foreach}
        {literal}
    }
    switch (sid) {
        {/literal}{foreach from=$sign_position item=value key=sid}
            case {$sid}:
                var signature_position = jQuery("#signature_position");
                if (signature_position.length > 0) {literal}{{/literal}
                    signature_position.html("{$value.data|escape:javascript}");
                    jQuery("#position").val("{$value.position|escape:javascript}");
                    if (jQuery("#position").val().length > 0) {literal}{
                        jQuery("#sub_position_signature").show();
                    }
                    else {
                        jQuery("#sub_position_signature").hide();
                    }{/literal}
                    {literal}}{/literal}
                break;
        {/foreach}
        {literal}
    }
}
{/literal}
//-->
</script>
{if $account_id}
 {assign var='aid' value=$account_id}
{/if}
{foreach name=sign_data from=$user_sign item=sign}
 {if $sign.menu}
  {if $aid == $sign.aid}
      <span id="change_sign_{$sign.aid}">{grn_select class="selectStandard-grn" name="user_sign"|cat:$sign.aid options=$sign.menu onchange="signValue(this,this.form.sign_value)"}</span>
  {else}
      <span id="change_sign_{$sign.aid}" style="display:none">{grn_select class="selectStandard-grn"  name='user_sign'|cat:$sign.aid options=$sign.menu onchange="signValue(this,this.form.sign_value)"}</span>
  {/if}
 {else}
      <span id="change_sign_{$sign.aid}" style="display:none">&nbsp;</span>
 {/if}
{/foreach}
        {if $page_send == false}
       <span id="sub_position_signature">&nbsp;<span class="mail-sendLabel-grn">{cb_msg module='grn.mail.personal' key='GRN_MAIL_PE-257' replace='true'}</span> : <span name="signature_position" id="signature_position" class="mail-sendLabel-grn">
       {if $position == "top"}
            {cb_msg module='grn.mail.personal' key='GRN_MAIL_PE-258' replace='true'}
       {else}
            {cb_msg module='grn.mail.personal' key='GRN_MAIL_PE-259' replace='true'}
       {/if}
       </span></span>
       {/if}
