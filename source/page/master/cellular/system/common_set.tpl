{include file="grn/system_head.tpl"}
{include file="grn/system_header.tpl"}
{grn_title title=$page_title class='bulletin'}
{assign var="form_name" value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='cellular/system/command_'|cat:$page_info.last}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">

<table class="std_form">
 <tr>
  <th style="vertical-align:top;" nowrap>{cb_msg module='grn.cellular.system' key='GRN_CLLL_SY-30' replace='true'}</th>
  <td>
    {if $is_user_item == 0}
    {assign var=is_user_item0 value=1}
    {/if}
    <div class="margin_bottom">{capture name='grn_cellular_system_GRN_CLLL_SY_31'}{cb_msg module='grn.cellular.system' key='GRN_CLLL_SY-31' replace='true'}{/capture}{grn_radio name="display_user_item" id="no-user-item" value="0" caption=$smarty.capture.grn_cellular_system_GRN_CLLL_SY_31 checked=$is_user_item0}</div>
  <div>{capture name='grn_cellular_system_GRN_CLLL_SY_32'}{cb_msg module='grn.cellular.system' key='GRN_CLLL_SY-32' replace='true'}{/capture}{grn_radio name="display_user_item" id="display-user-item" value="1" caption=$smarty.capture.grn_cellular_system_GRN_CLLL_SY_32 checked=$is_user_item}</div>
  <div id="display-field1-label" {if $is_user_item0}class="navi_off"{/if}style="margin-left:1em;">{cb_msg module='grn.cellular.system' key='GRN_CLLL_SY-33' replace='true'}
  <select name="display_field1" id="display-field1-select" {if $is_user_item0}disable{/if}>
    {foreach from=$items.0 key=item_key item=item_value}
    <option value="{$item_key}" {if $item_value.selected}selected{/if}>{$item_value.name}</option>
    {/foreach}
  </select>
  </div>
  <div id="display-field2-label" {if $is_user_item0}class="navi_off"{/if}style="margin-left:1em;">{cb_msg module='grn.cellular.system' key='GRN_CLLL_SY-34' replace='true'}
  <select name="display_field2" id="display-field2-select" {if $is_user_item0}disable{/if}>
    {foreach from=$items.1 key=item_key item=item_value}    
    <option value="{$item_key}" {if $item_value.selected}selected{/if}>{$item_value.name}</option>
    {/foreach}
  </select>
  </div>
  </td>
 </tr>
 
 <tr>
  <th style="vertical-align:top;" nowrap>{cb_msg module='grn.cellular.system' key='GRN_CLLL_SY-41' replace='true'}</th>
  <td>
    {if $allow_auto_login.allow_auto_login == 1}
        {assign var=is_auto_login value=1}
        
    {/if}
    <div class="margin_bottom">{capture name='grn_cellular_system_GRN_CLLL_SY_42'}{cb_msg module='grn.cellular.system' key='GRN_CLLL_SY-42' replace='true'}{/capture}{grn_checkbox name="checkbox_allow_auto_login" id="auto_login" value="1" caption=$smarty.capture.grn_cellular_system_GRN_CLLL_SY_42 checked=$is_auto_login}</div>
  </td>
 </tr>
 <tr>
  <td></td>
  <td>
       {capture name='grn_cellular_system_GRN_CLLL_SY_35'}{cb_msg module='grn.cellular.system' key='GRN_CLLL_SY-35' replace='true'}{/capture}{grn_button_submit class="margin" caption=$smarty.capture.grn_cellular_system_GRN_CLLL_SY_35}
       {grn_button_cancel}
  </td>
 </tr>
</table>
</form>

<script type="text/javascript" src="{$app_path}/fw/yui/build/yahoo/yahoo-min.js?{$build_date}" ></script>
<script type="text/javascript" src="{$app_path}/fw/yui/build/dom/dom-min.js?{$build_date}" ></script>
<script type="text/javascript" src="{$app_path}/fw/yui/build/event/event-min.js?{$build_date}" ></script>
<script type="text/javascript" language="javascript">
<!--
{literal}

function enableSelectBox()
{
    var yu = YAHOO.util;

    yu.Dom.get( "display-field1-select" ).disabled = false;
    yu.Dom.get( "display-field2-select" ).disabled = false;
    yu.Dom.removeClass( yu.Dom.get( "display-field1-label" ), 'navi_off' );
    yu.Dom.removeClass( yu.Dom.get( "display-field2-label" ), 'navi_off' );
}

function disableSelectBox()
{
    var yu = YAHOO.util;

    yu.Dom.get( "display-field1-select" ).disabled = true;
    yu.Dom.get( "display-field2-select" ).disabled = true;
    yu.Dom.addClass( yu.Dom.get( "display-field1-label" ), 'navi_off' );
    yu.Dom.addClass( yu.Dom.get( "display-field2-label" ), 'navi_off' );
}

function init()
{
    var yu = YAHOO.util;
    if ( yu.Dom.get( "no-user-item" ).checked )
    {
	disableSelectBox();
    }
    if ( yu.Dom.get( "display-user-item" ).checked )
    {
	enableSelectBox();
    }
    yu.Event.addListener( "no-user-item", "click", disableSelectBox );
    yu.Event.addListener( "display-user-item", "click", enableSelectBox );
}

YAHOO.util.Event.addListener(window, "load", init);
{/literal}
-->
</script>

{include file="grn/system_footer.tpl"}
