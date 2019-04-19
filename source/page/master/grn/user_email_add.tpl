{grn_load_javascript file="grn/html/user_add.js"}
{grn_load_javascript file="grn/html/component/user_select/user_select.js"}

{literal}
<script language="JavaScript" type="text/javascript">

<!--
/**
 * overwrite function defined in grn/html/user_add.js
 * It is used in AddOptions (grn/html/user_add.js)
 * @param option
 * @returns {String}
 */
function getOptionValue(option) {
    return option.value;
}
/**
 * overwrite function defined in grn/html/user_add.js
 * It is used in AddOptions (grn/html/user_add.js)
 * @param valueA
 * @param valueB
 * @returns {boolean}
 */
function compareOptionsValue(valueA, valueB) {
    return valueA == valueB;
}

function AddMember(fname, cname, sname)
{
    var form = document.forms[fname];
    var c = form.elements[cname].options;
    var co;

    if(CheckOptions(fname, sname, '0'))
    {
        ClearOptions(fname, sname);
    }
    if(CheckSelectedOptions(fname, cname, '0'))
    {
        ClearOptions(fname, sname);
        AddOption(fname, sname, cname, '0');
    }
    else
    {
        AddOptions( fname, sname, c );
    }
}

//-->
</script>
 {/literal}
 
 {literal}
<script language="JavaScript" type="text/javascript">
<!--
function Change{/literal}{$CGID}{literal}( form )
{
  var item_options = new Array();
{/literal}{foreach from=$item_options key=id item=options}{literal}
  item_options['{/literal}{$id}{literal}'] = new Array();
 {/literal}{foreach from=$options key=option_id item=option}{literal}
  item_options['{/literal}{$id}{literal}'][{/literal}{$option_id}{literal}] = new Option();
  {/literal}{if $option.type == 'sharedbook'}{literal}
  item_options['{/literal}{$id}{literal}'][{/literal}{$option_id}{literal}].value = 'sharedbook:{/literal}{$option.value}{literal}';
  {/literal}{elseif $option.type == 'privatebook'}{literal}
  item_options['{/literal}{$id}{literal}'][{/literal}{$option_id}{literal}].value = 'privatebook:{/literal}{$option.value}{literal}';
  {/literal}{/if}{literal}
  item_options['{/literal}{$id}{literal}'][{/literal}{$option_id}{literal}].text = '{/literal}{$option.name|escape:"javascript"} {$option.email|escape:"javascript"}{literal}';
 {/literal}{/foreach}{literal}
{/literal}{/foreach}{literal}
  var selected_category = form.elements['{/literal}{$CGID}{literal}'].value;
    RewriteItemOptionsWithoutSelectedAttribute( form.name, '{/literal}{$CID}{literal}', item_options[selected_category]);
  
  if ( form.elements['{/literal}{$CGID}{literal}'].options[0].value == 'search' ) {
      form.elements['{/literal}{$CGID}{literal}'].options[0] = null;
  }
  
  form.elements['{/literal}{$CID}{literal}'].focus();
}
function Search{/literal}{$CGID}{literal}( form, url )
{
    var selected_book = form.elements["{/literal}{$CGID}{literal}"].value.split(':');
    var book_id = (selected_book.length == 2) ? selected_book[1] : -1;

    var parameters = {
        {/literal}
        "keyword_{$CGID}" : form.elements["keyword_{$CGID}"].value,
        "target_form_name_{$CGID}": "{$form_name}",
        "target_category_select_name_{$CGID}": "{$CGID}",
        "target_item_select_name_{$CGID}": "{$CID}",
        "book_id_{$CGID}": book_id
        {literal}
    };
    {/literal}
    parameters["plugin_session_name_{$CGID}"] = "{$plugin_session_name}";
    parameters["plugin_data_name_{$CGID}"] = "{$plugin_data_name}";
    {literal}

    var target = "sub_{/literal}{$CGID}{literal}";
    searchByKeyword(target, url, parameters);
}
//-->
</script>
{/literal}
<p>
    <table border="0" cellspacing="0" class="std_form">
        <tr>
            <td valign="bottom" style="padding-left:0">
                <table border="0" cellspacing="0" cellpadding="0">
                    <tr>
                        <td style="padding-left:0; padding-bottom:0">
                            {if $order_by}
                                <a href="javascript:OrderTop('{$form_name}', '{$sUID}')">{grn_image image='order_top20.gif' alt=''}</a>
                                <br />
                                <br />
                                <a href="javascript:OrderUp('{$form_name}', '{$sUID}')">{grn_image image='order_up20.gif' alt=''}</a>
                                <br />
                                <br />
                                <a href="javascript:OrderDown('{$form_name}', '{$sUID}')">{grn_image image='order_down20.gif' alt=''}</a>
                                <br />
                                <br />
                                <a href="javascript:OrderBottom('{$form_name}', '{$sUID}')">{grn_image image='order_bottom20.gif' alt=''}</a>
                            {/if}
                        </td>
                        <td class="item_select" style="padding-bottom:0">
                            <div id='user_add'>
                                <select name="{$sUID}" size="13" multiple>
                                    {foreach from=$selected_address_users key=id item=item}
                                        <option value="{$item.type|escape}:{$item.value|escape}">{$item.name|escape} {$item.email|escape}</option>
                                    {/foreach}
                                    {if $os == 'mac'}
                                        <option value="">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</option>
                                    {else}
                                        <option value="">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</option>
                                    {/if}
                                </select>
                                <input type="hidden" name="selected_sUID" value="">
                            </div>
                        </td>
                    </tr>
                </table>
            </td>

            <td class="item_right_left">
                <input type="button" value="{cb_msg module='grn.grn' key='GRN_GRN-847' replace='true'}" onClick="AddMember('{$form_name}', '{$CID}', '{$sUID}');" />
                <br />
                <br />
                <input type="button" value="{cb_msg module='grn.grn' key='GRN_GRN-848' replace='true'}" onClick="RemoveMember('{$form_name}', '{$sUID}' )" />
            </td>

            <td>
                <div class="margin_bottom">
                    <a onclick="javascript:popupWin('{grn_pageurl page='address/popup_user_email_select' form_name='address/mygroup_change' select_name='sUID[]' params=$url_params}','html','','',0,0,1,1,0,1);" href="#">
                        {grn_image image="blank20.gif"}{cb_msg module='grn.grn' key='GRN_GRN-849' replace='true'}
                    </a>
                </div>

                <input type="text" name="keyword_{$CGID}" size=22 maxlength="45" value="" onKeyPress="if(event.keyCode == 13) Search{$CGID}( this.form, '{grn_pageurl page='address/card_add_search'}' ); return event.keyCode != 13;" />
                <input type="button" value="{cb_msg module='grn.grn' key='GRN_GRN-850' replace='true'}" onClick="Search{$CGID}( this.form, '{grn_pageurl page='address/card_add_search'}' );" />

                <!-- address book select -->
                <div class="margin_vert">
                    <select id="{$CGID}" name="{$CGID}" onChange="Change{$CGID}( this.form );">
                        {foreach from=$books_options item=option}
                            <option value="{$option.value}">{$option.name|escape}</option>
                        {/foreach}
                    </select>
                    <iframe id="sub_{$CGID}" name="sub_{$CGID}" frameborder="no" scrolling="no" style="position:absolute; width:0em; height:0em;" src="{$app_path}/grn/image/cybozu/spacer1.gif?{$build_date}"></iframe>
                </div>
                <!-- address book select -->

                <!-- item select -->
                <div class="margin_vert">
                    {if $os == 'mac'}
                        <select name="{$CID}" size="9" multiple>
                            {foreach from=$selected_item_options item=option}
                                <option value="{$option.type|escape}:{$option.value|escape}">{$option.name|escape} {$option.email|escape}</option>
                            {/foreach}
                            <option value="">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</option>
                        </select>
                    {else}
                        <select name="{$CID}" size="8" multiple>
                            {foreach from=$selected_item_options item=option}
                                <option value="{$option.type|escape}:{$option.value|escape}">{$option.name|escape} {$option.email|escape}</option>
                            {/foreach}
                            <option value="">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</option>
                        </select>
                    {/if}
                </div>
                <!-- item select -->

            </td>
        </tr>
        <tr>
            <td>
                {strip}
                    <div class="mTop10 mLeft20 pLeft5">
                        {capture name='grn_grn_GRN_GRN_851'}{cb_msg module='grn.grn' key='GRN_GRN-851' replace='true'}{/capture}
                        {grn_button id='grn_button_save' ui='main' spacing='normal' action='submit' caption=$smarty.capture.grn_grn_GRN_GRN_851
                        onclick="grn_onsubmit_common(document.forms['`$form_name`']); grn.component.button.util.submit(this);"}
                        {grn_button id='grn_button_cancel' action='cancel' page='address/mygroup_list' page_param_mgid=$mygroup_id}
                    </div>
                {/strip}
            </td>
            <td></td>
            <td></td>
        </tr>
    </table>
