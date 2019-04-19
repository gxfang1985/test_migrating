{include file='grn/user_add_js.tpl'}

<table border="0" cellspacing="0">
 <tr>
  <td valign="bottom" style="padding-left:0">
   <table border="0" cellspacing="0" cellpadding="0">
    <tr>
     <td class="buttonSlectOrder-grn"  style="padding-left:0; padding-bottom:0">{if $order_by}
<a href="javascript:OrderTop('{$form_name}', '{$sUID}')">{grn_image image='order_top20.gif' alt='' class="mBottom10"}</a><a href="javascript:OrderUp('{$form_name}', '{$sUID}')">{grn_image image='order_up20.gif' alt='' class="mBottom10"}</a><a href="javascript:OrderDown('{$form_name}', '{$sUID}')">{grn_image image='order_down20.gif' alt='' class="mBottom10"}</a><a href="javascript:OrderBottom('{$form_name}', '{$sUID}')">{grn_image image='order_bottom20.gif' alt=''}</a>{/if}
     </td>
     <td class="item_select" style="padding-bottom:0">
      <div id='user_add'>
       <select name="{$sUID}" class="user_select_list" size="13" multiple id="selectbox_selected_users_{$sUID}" >
    {foreach from=$selected_users key=id item=user}
        <option value="{$id|escape}" selected>{$user|escape}</option>
    {/foreach}
        {if $os == 'mac' }
        <option value="">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</option>
        {else}
        <option value="">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</option>
        {/if}
       </select>
<input type="hidden" name="selected_groups_{$sUID}" value="">
<input type="hidden" name="selected_users_{$sUID}" value="">
      </div>
     </td>
    </tr>
   </table>
  </td>
  <td class="item_right_left">
   <input id="btn_add_{$CID}" type="button" value="{cb_msg module='grn.grn' key='GRN_GRN-808' replace='true'}" onClick="{$btn_add_onClick|grn_noescape}AddMember('{$form_name}', '{$CID}', '{$sUID}');"><br><br><input id="btn_rmv_{$CID}" type="button" value="{cb_msg module='grn.grn' key='GRN_GRN-809' replace='true'}" onClick="{$btn_rmv_onClick|grn_noescape}RemoveMember('{$form_name}', '{$sUID}' )">
  </td>
  <td>
   <input type="text" name="keyword_{$CGID}" size=22 maxlength="45" value="" onKeyPress="if(event.keyCode == 13) Search{$CGID}( this.form, '{grn_pageurl page='grn/user_add_search_users'}' ); return event.keyCode != 13;">
   <input type="button" value="{cb_msg module='grn.grn' key='GRN_GRN-810' replace='true'}" onClick="Search{$CGID}( this.form, '{grn_pageurl page='grn/user_add_search_users'}' );">
   <div class="margin_top">
{if $access_plugin}
 {capture name='grn_grn_GRN_GRN_811'}{cb_msg module='grn.grn' key='GRN_GRN-811' replace='true'}{/capture}{grn_popup_user_select_link caption=$smarty.capture.grn_grn_GRN_GRN_811 form_name=$form_name select_name=$sUID system=false system_display=false include_org=$popup_include_org access_plugin=$access_plugin plugin_session_name=$plugin_session_name plugin_data_name=$plugin_data_name}
{else}
 {capture name='grn_grn_GRN_GRN_812'}{cb_msg module='grn.grn' key='GRN_GRN-812' replace='true'}{/capture}{grn_popup_user_select_link caption=$smarty.capture.grn_grn_GRN_GRN_812 form_name=$form_name select_name=$sUID system=false system_display=false include_org=$popup_include_org}
{/if}
   </div>

<!-- category select -->
   <div class="margin_vert">
   <select id="{$CGID}" name="{$CGID}" onChange="Change{$CGID}( this.form );" {if $category_option_disabled}disabled{/if}>
   {if $category_option_disabled} <option>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</option> {/if}
{foreach from=$category_options item=option}
 {if $option.type == 1}
    <option value="{$option.value}">{$option.name|escape}{cb_msg module='grn.grn' key='GRN_GRN-813' replace='true'}{cb_msg module='grn.grn' key='GRN_GRN-814' replace='true'}</option>
 {elseif $option.type == 2}
    <option value="{$option.value}" selected>{$option.name|escape}{cb_msg module='grn.grn' key='GRN_GRN-815' replace='true'}</option>
 {elseif $option.type == 3}
    <option value="{$option.value}">{$option.name|escape}{cb_msg module='grn.grn' key='GRN_GRN-816' replace='true'}</option>
 {elseif $option.type == 4}
    <option value="{$option.value}">{cb_msg module="grn.common" key="title_frequent_group" name=$option.name}</option>
 {elseif $option.type == 5}
    <option value="{$option.value}">{cb_msg module='grn.grn' key='GRN_GRN-817' replace='true'}{cb_msg module="grn.common" key="title_frequent_users"}{cb_msg module='grn.grn' key='GRN_GRN-818' replace='true'}</option>
 {elseif $option.type == 6}
    <option value="{$option.value}">{cb_msg module="grn.common" key="title_oftenused_group" name=$option.name}</option>
 {/if}
{/foreach}
   </select>
   <iframe id="sub_{$CGID}" name="sub_{$CGID}" frameborder="no" scrolling="no" style="position:absolute; width:0em; height:0em;" src="{$app_path}/grn/html/space.html?{$build_date}">
   </iframe>
{literal}
<script language="JavaScript" type="text/javascript">
<!--
function Change{/literal}{$CGID}{literal}( form )
{
{/literal}
  var selected_category = form.elements['{$CGID}'].value;
  var user_list = form.elements['{$CID}'];
  var url = '{grn_pageurl page='grn/ajax_user_add_select_by_group'}';
  var post_params = 'gid='+selected_category+'&cid={$CID}&include_org={$include_org}&show_omitted={$skip}&access_plugin={$access_plugin_encoded}&plugin_session_name={$plugin_session_name}';

  document.getElementById( "spinner-loading-{$CID}" ).style.display="";

  var parent_form = form.elements['{$CID}'].parentNode;

  var spinner_img = document.createElement( 'div' );
  spinner_img.id = 'spinner-loading-{$CGID}';
  spinner_img.style.position = 'absolute';
  spinner_img.style.margin = '3px 0pt 0pt 3px';
  spinner_img.style.zIndex = '2';
  spinner_img.style.height = '16';
  spinner_img.style.width = '16';
  parent_form.insertBefore( spinner_img, document.getElementById( 'select_{$CID}' ) );

  form.elements['{$CID}'].disabled = true;

{literal}
jQuery.ajax(
    url,
    {
        type: "POST",
        data: post_params,
        success: function(data, textStatus, request)
        {
            // X-Cybozu-Error Check
            var headers = request.getAllResponseHeaders();
            var regex = /X-Cybozu-Error/i;
            if(headers.match(new RegExp( /X-Cybozu-Error/i )))
            {
                // display error
                document.write( request.responseText );
                document.close();
                return false;
            }
            {/literal}
            // update user list
            document.getElementById("div_{$CID}").innerHTML = request.responseText;
            user_list.focus();
            {literal}
        }
    });
}
function Search{/literal}{$CGID}{literal}( form, url )
{
    var parameters = {
        {/literal}
        "keyword_{$CGID}" : form.elements["keyword_{$CGID}"].value,
        "target_form_name_{$CGID}": "{$form_name}",
        "target_category_select_name_{$CGID}": "{$CGID}",
        "target_item_select_name_{$CGID}": "{$CID}",
        "search_login_name_{$CGID}": "0"
        {literal}
    };
    {/literal}{if $access_plugin}
    parameters["plugin_session_name_{$CGID}"] = "{$plugin_session_name}";
    parameters["plugin_data_name_{$CGID}"] = "{$plugin_data_name}";
    {/if}{literal}

    var target = "sub_{/literal}{$CGID}{literal}";
    searchByKeyword(target, url, parameters);
}
//-->
</script>
{/literal}
   </div>
<!-- category select -->

<!-- item select -->
   <div class="margin_vert" id="div_{$CID}">
<iframe id="spinner-loading-{$CID}" src="{$app_path}/grn/html/space.html?{$build_date}" frameborder="no" style="width:16; height:16; position:absolute; margin:3px 0 0 3px; z-index:2; display:none;"></iframe>

   <select id="select_{$CID}" name="{$CID}" class="user_select_list" size="8" multiple>

{foreach from=$selected_item_options item=option}
 {if $option.type == 'user'}
    <option value="{$option.value}">{$option.name|grn_noescape}</option>
 {elseif $option.type == 'group'}
    <option value="{$option.value}">[{$option.name|grn_noescape}]</option>
 {/if}
{/foreach}

    {if $os == 'mac' }
    <option value="">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</option>
    {else}
    <option value="">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</option>
    {/if}
   </select>
   </div>
<!-- item select -->

  </td>
 </tr>
 <tr>
  <td></td>
  <td></td>
  <td>

<!-- userinfo list -->
 {capture name='grn_grn_GRN_GRN_821'}{cb_msg module='grn.grn' key='GRN_GRN-821' replace='true'}{/capture}{grn_popup_user_list_link caption=$smarty.capture.grn_grn_GRN_GRN_821 form_name=$form_name var_CID=$CID system_display=false duplication=$duplication function_name=$function_name}
<!-- userinfo list -->

  </td>
 </tr>
</table>