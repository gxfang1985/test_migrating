{grn_load_javascript file="grn/html/select_date.js"}
{grn_load_javascript file="grn/html/report_select_date.js"}
{grn_load_javascript file="grn/html/reportmf.js"}
{grn_load_javascript file="grn/html/report.js"}
{grn_load_javascript file="grn/html/report-filter.js"}
{grn_load_css file="grn/html/report.css"}
{grn_load_css file="grn/html/msgbox.css"}
{if $page_info.parts[1] == 'system'}{assign var=is_system value=true}{/if}
{capture name="item_time"}
    {grn_select_time prefix="time_value_%NUM%_" form_name=$form_name necessary=true}
{/capture}
{literal}
<style type="text/css">
div.filter_item_odd
{
    background-color:{/literal}{if $personal}#E6E6FF{else}#fffe99{/if}{literal};
    border-top:1px solid #ccc;
    border-bottom:1px solid #ccc;
}
</style>

<script language="JavaScript" text="text/javascript">
<!--
var wday_name = new Array("{/literal}{cb_msg module='fw.date' key='WDayShort0'}{literal}", "{/literal}{cb_msg module='fw.date' key='WDayShort1'}{literal}", "{/literal}{cb_msg module='fw.date' key='WDayShort2'}{literal}", "{/literal}{cb_msg module='fw.date' key='WDayShort3'}{literal}", "{/literal}{cb_msg module='fw.date' key='WDayShort4'}{literal}", "{/literal}{cb_msg module='fw.date' key='WDayShort5'}{literal}", "{/literal}{cb_msg module='fw.date' key='WDayShort6'}{literal}");
var date_day_unit = '{/literal}{cb_msg module='fw.ui' key='date_day_unit'}{literal}';
var date_year_unit = '{/literal}{cb_msg module='fw.ui' key='date_year_unit'}{literal}';

__report_item_date = '{/literal}{$smarty.capture.date|escape:"javascript"}{literal}';
__report_item_time = '{/literal}{$smarty.capture.item_time|escape:"javascript"}{literal}';
plusImage = '{/literal}{$app_path}{literal}/grn/image/cybozu/plus.gif';
minusImage = '{/literal}{$app_path}{literal}/grn/image/cybozu/minus.gif'; 
__msg_item_select = {/literal}'{cb_msg module='grn.report' key='filter.item.select'}'{literal};
__msg_item_attachedfiles = {/literal}'{cb_msg module='grn.report' key='condition.item.file.attachedfiles' replace='true'}'{literal};

{/literal}
{if $is_system}
{literal}
var categoryListUrl = "{/literal}{grn_pageurl page='report/system/category_list'}{literal}";
var formListUrl = "{/literal}{grn_pageurl page='report/system/send_form_list'}{literal}";
var itemListUrl = "{/literal}{grn_pageurl page='report/system/item_list'}{literal}";
{/literal}
{else}
{literal}
var categoryListUrl = "{/literal}{grn_pageurl page='report/ajax/category_list'}{literal}";
var formListUrl = "{/literal}{grn_pageurl page='report/ajax/send_form_list'}{literal}";
var itemListUrl = "{/literal}{grn_pageurl page='report/ajax/item_list'}{literal}";
{/literal}
{/if}
{literal}
var csrf_ticket = "{/literal}{$csrf_ticket}{literal}";
var from = 'filter';
var userType = "{/literal}{$page_info.parts[1]}{literal}";

var allOption = new Array();
allOption[0] = {value:0,label:{/literal}'{cb_msg module='grn.report' key='condition.type.0'}'{literal}};
allOption[1] = {value:1,label:{/literal}'{cb_msg module='grn.report' key='condition.type.1'}'{literal}};

var textOption = new Array();
textOption[0] = {value:0,label:{/literal}'{cb_msg module='grn.report' key='condition.type.0'}'{literal}};
textOption[1] = {value:1,label:{/literal}'{cb_msg module='grn.report' key='condition.type.1'}'{literal}};
textOption[2] = {value:2,label:{/literal}'{cb_msg module='grn.report' key='condition.type.2'}'{literal}};
textOption[3] = {value:3,label:{/literal}'{cb_msg module='grn.report' key='condition.type.3'}'{literal}};
textOption[4] = {value:4,label:{/literal}'{cb_msg module='grn.report' key='condition.type.4'}'{literal}};
textOption[5] = {value:5,label:{/literal}'{cb_msg module='grn.report' key='condition.type.5'}'{literal}};

var numOption = new Array();
numOption[0] = {value:6,label:{/literal}'{cb_msg module='grn.report' key='condition.type.6'}'{literal}};
numOption[1] = {value:7,label:{/literal}'{cb_msg module='grn.report' key='condition.type.7'}'{literal}};
numOption[2] = {value:8,label:{/literal}'{cb_msg module='grn.report' key='condition.type.8'}'{literal}};
numOption[3] = {value:9,label:{/literal}'{cb_msg module='grn.report' key='condition.type.9'}'{literal}};

var dateOption = new Array();
dateOption[0] = {value:2,label:{/literal}'{cb_msg module='grn.report' key='condition.type.date.2'}'{literal}};
dateOption[1] = {value:3,label:{/literal}'{cb_msg module='grn.report' key='condition.type.date.3'}'{literal}};
dateOption[2] = {value:7,label:{/literal}'{cb_msg module='grn.report' key='condition.type.date.7'}'{literal}};
dateOption[3] = {value:9,label:{/literal}'{cb_msg module='grn.report' key='condition.type.date.9'}'{literal}};

var timeOption = new Array();
timeOption[0] = {value:2,label:{/literal}'{cb_msg module='grn.report' key='condition.type.date.2'}'{literal}};
timeOption[1] = {value:3,label:{/literal}'{cb_msg module='grn.report' key='condition.type.date.3'}'{literal}};
timeOption[2] = {value:7,label:{/literal}'{cb_msg module='grn.report' key='condition.type.date.7'}'{literal}};
timeOption[3] = {value:9,label:{/literal}'{cb_msg module='grn.report' key='condition.type.date.9'}'{literal}};

var checkboxOption = new Array();
checkboxOption[0] = {value:0,label:{/literal}'{cb_msg module='grn.report' key='condition.type.2'}'{literal}};

//validate messages
__validate_msg_no_item      = {/literal}'{cb_msg module='grn.report' key='validate.no.item'}'{literal};
__validate_msg_not_a_number = {/literal}'{cb_msg module='grn.report' key='validate.not.a.number'}'{literal};
__validate_msg_empty_string = {/literal}'{cb_msg module='grn.report' key='validate.empty.string'}'{literal};
__validate_msg_select_form  = {/literal}'{cb_msg module='grn.report' key='select.form2' replace='true'}'{literal};
__validate_msg_no_title     = {/literal}'{cb_msg module='grn.report.system' key='GRN_RPRT_SY-546' replace='true'}'{literal};

function getForm(count)
{
    //最後の絞り込みがevenだったら今回はodd, oddだったらeven.
    var item = jQuery('div.filter_item').last();
    var classname = item.hasClass('filter_item_even') ? 'filter_item_odd' : 'filter_item_even';
    
    return '{/literal}                                                                                                             \
        <div id="filter_item_'+count+'" class="filter_item '+classname+'" >                                                             \
            <input type="hidden" name="item_id[]"   id="item_id_'+count+'" />                                                       \
            <input type="hidden" name="item_index[]" id="item_index_'+count+'" value="' + count + '" />                             \
            <input type="hidden" name="item_type[]" id="item_type_'+count+'" />                                                     \
            <input type="hidden" name="item_name[]" id="item_name_'+count+'" />                                                     \
            <input type="hidden" name="type_item[]" id="type_item_'+count+'" />                                                     \
            <table style="width:100%;">                                                                                             \
                <tr>                                                                                                                \
                    <td>                                                                                                            \
                        <table>                                                                                                     \
                            <tr>                                                                                                    \
                                <td style="width:140px;">                                                                           \
                                    <select name="type[]" class="target_select" id="type_'+count+'" onchange="onChangeType(this)" style="width:130px;">                        \
                                        {foreach from=$type_info item=item}\
                                        {if $item.item_list}\
                                        {foreach from=$item.item_list item=item_detail key=item_id}\
                                        <option value="{$item_id|escape}" datatype="{$item_detail.data_type|escape}" {if $item_detail.data_type == 'grn.report.time'}interval="{$item_detail.settings.unit}" {/if}>{$item_detail.display_name|escape}</option>                                                            \
                                                            {/foreach}    \
                                                            {else}     \
                                                            <option value="{$item.value}">{$item.label}</option>                                    \
                                                {/if}
                                        {/foreach}                                                                                  \
                                    </select>                                                                                       \
                                </td>                                                                                               \
                                <td nowrap>                                                                                                \
                                    <select name="condition[]" id="condition_'+count+'" style="width:170px;">                       \
                                        {foreach from=$condition_info item=item}                                                    \
                                            <option value="{$item.value}">{$item.label}</option>                                    \
                                        {/foreach}                                                                                  \
                                    </select>                                                                                       \
                                </td>                                                                                               \
                                <td nowrap>                                                                                                \
                                    {grn_text class="condition_value" id="value_'+count+'" name="value[]" necessary=1 size="30" disable_return_key=true}    \
                                </td>                                                                                               \
                                <td nowrap>                                                                                                \
                                    <span id="error_message_'+count+'" style="font-weight:bold; color:red;"></span>                    \
                                </td>                                                                                               \
                            <tr>                                                                                                    \
                        </table>                                                                                                    \
                    </td>                                                                                                           \
                    <td>                                                                                                            \
                        <input type="button" style="float:right;" onclick="removeFilterItem('+count+')" value="{cb_msg module='grn.report' key='filter.item.remove'}"/>\
                    </td>                                                                                                           \
                </tr>                                                                                                               \
            </table>                                                                                                                \
        </div>{literal}';
}

function grn_onsubmit_common(f)
{
    {/literal}{if ! $disable_prepare_submit}{literal}
    PrepareSubmit('{/literal}{$form_name}{literal}', 'sUID[]');
    var elements = f.elements;
    for( var i = 0 ; i < elements.length ; i ++ )
    {
        if ( elements[i].name && elements[i].name == "sUID[]")
        {
            var options = elements[i].options;
            if( options )
            {
                for( var j = 0 ; j < options.length ; j ++ )
                {
                    options[j].selected = options[j].value ? true : false; 
                }
            }
        }
    }
    {/literal}{/if}{literal}
}
//-->
</script>
{/literal}
{include file='report/_initial_minute.tpl'}
<iframe id="background_iframe" src="">
</iframe>

<script type="text/javascript" src="{$app_path}/fw/yui/build/yahoo/yahoo-min.js?{$build_date}" ></script>
<script type="text/javascript" src="{$app_path}/fw/yui/build/treeview/treeview.js?{$build_date}" ></script>
     <div id="categoryFormListWindow" class="msgbox" style="display:none;height:50%;">
        <div class="title" style="padding-left:0px;">
            <a style="line-height:0;position: absolute; right: 5px;top:5px;text-decoration:none;" onclick="closeFormSelectWindow();" href="javascript:;">{grn_image image='close20.gif'}</a>
            &nbsp;&nbsp;&nbsp;{cb_msg module='grn.report.schedule' key='GRN_RPRT_SCH-13' replace='true'}
        </div>
        <div class="content" style="height:90%;position:relative;padding:10px 0px 10px 0px;">
                <table style="margin-left:auto;margin-right:auto;height:90%;width:90%;border:1px solid #B0B0B0;">
                    <tr valign="top">
                        <td style="width:50%;height:100%">
                            <div id="tree_part" style="overflow:auto;padding:0px;height:100%;width:100%">
                                {include file='grn/org_tree_26.tpl'}
                            </div>
                        </td>
                        {* window.onload では、ツリーの初期化前に onSelectCategory が実行されてしまうため初期化イベントの設定後に設定 *}
                        {literal}
                        <script language="javascript">
                        <!--
                            YAHOO.util.Event.onDOMReady(function()
                            {
                                {/literal}{if !$diableSelectCategory}{literal}
                                    onSelectCategory(1);
                                {/literal}{/if}{literal}
                                jQuery(window).resize(function(){
                                    var body = document.body;
                                    with(document.getElementById('background_iframe').style)
                                    {
                                        width  = Math.max(body.clientWidth,  body.scrollWidth) + 'px';
                                        height = Math.max(body.clientHeight, body.scrollHeight) + 'px';
                                    }
                                    if (grn.browser.msie)
                                    {
                                        var ifr_doc = document.getElementById('background_iframe').contentWindow.document;
                                        var popup_bg = ifr_doc.body.childNodes[0];
                                        if( popup_bg ){
                                            with (popup_bg.style) {
                                                width   = Math.max(body.clientWidth,  body.scrollWidth) + 'px';
                                                height  = Math.max(body.clientHeight, body.scrollHeight) + 'px';
                                            }
                                        }
                                    }
                                });
                            });
                        //-->
                        </script>
                        {/literal}
                        <td style="width:100%;height:100%">
                            <div id="view_part" style="overflow:auto;height:100%;width: 100%">
                            <img border="0" align="top" id="reportLoadingImage" src="{$app_path}/grn/image/cybozu/spinner.gif?{$build_date}"/>
                            </div>
                        </td>
                    </tr>
                </table>

        </div>
     </div>
