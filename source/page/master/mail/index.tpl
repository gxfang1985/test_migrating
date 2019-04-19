{include file='grn/head.tpl'}
{include file='grn/header_no_siteposition.tpl'}

{include file='mail/_title_search.tpl'}

<div class="mainarea">
<div class="mainarea-mail">
{if $no_setting neq '0'}
    {grn_title title=$app_name class=$page_info.parts[0]}
    {include file='mail/_no_setting.tpl'}
{else}
    {assign var='form_name' value=$smarty.template|basename}
    {grn_load_javascript file="grn/html/wm.js"}
    {grn_load_javascript file="grn/html/folder_select.js"}

    {* second line start *}
    <div class="mail_account">
        {if $account_deleted}
            <!----><div class="br">&nbsp;</div>

            <form name="receive" method="post" action="{grn_pageurl page='mail/command_index'}">
                <input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
                <input type="hidden" name="aid" value="{$category.aid}">
                <input type="hidden" name="cid" value="{$category.cid}">
                <input type="hidden" name="sid" value="{$status_id}">
                <input type="hidden" name="cmd" id="cmd">
                {grn_delete title=$account_delete_info.title page=$account_delete_info.page no_confirm=$account_delete_info.no_confirm data=$account_delete_info.data handler=$account_delete_info.handler}
                <div>
                    {cb_msg module='grn.mail' key='GRN_MAIL-115' replace='true'}<span class="bold">{cb_msg module='grn.mail' key='GRN_MAIL-116' replace='true'}</span>{cb_msg module='grn.mail' key='GRN_MAIL-117' replace='true'}<br>
                    {cb_msg module='grn.mail' key='GRN_MAIL-118' replace='true'}{$app_name|escape}{cb_msg module='grn.mail' key='GRN_MAIL-119' replace='true'} {capture name='grn_mail_GRN_MAIL_120'}{cb_msg module='grn.mail' key='GRN_MAIL-120' replace='true'}{/capture}{grn_button_submit name='delete_account' caption=$smarty.capture.grn_mail_GRN_MAIL_120 id="btn_account_delete" class="buttonStandard-grn" onclick="return false;"} {cb_msg module='grn.mail' key='GRN_MAIL-121' replace='true'}<br>
                </div>
            </form>

            <!----><div class="br">&nbsp;</div>
        {else}
            {if $size_error or $remaining or $notify_count or $size_over}
                <!----><div class="br">&nbsp;</div>
                <div class="notes">
            {/if}
            {if $size_error}
                <p>
                    {cb_msg module='grn.mail' key='GRN_MAIL-122' replace='true'}{$app_name|escape}{cb_msg module='grn.mail' key='GRN_MAIL-123' replace='true'}<br>
                    <ul>
                        <li>{capture name='grn_mail_GRN_MAIL_124'}{cb_msg module='grn.mail' key='GRN_MAIL-124' replace='true'}{/capture}{capture name='grn_mail_GRN_MAIL_125'}{cb_msg module='grn.mail' key='GRN_MAIL-125' replace='true'}{/capture}{grn_link image='view20.gif' page='mail/cannot_receive' caption=$smarty.capture.grn_mail_GRN_MAIL_124|cat:$app_name|cat:$smarty.capture.grn_mail_GRN_MAIL_125 aid=$category.aid cid=$category.cid}
                    </ul>
                </p>
            {/if}
            {if $remaining}
                <p>{cb_msg module='grn.mail' key='GRN_MAIL-126' replace='true'}{$app_name|escape}{cb_msg module='grn.mail' key='GRN_MAIL-127' replace='true'}<span class="bold">{cb_msg module='grn.mail' key='GRN_MAIL-128' replace='true'}{cb_msg module='grn.mail' key='GRN_MAIL-425' replace='true'}{cb_msg module='grn.mail' key='GRN_MAIL-129' replace='true'}</span>{cb_msg module='grn.mail' key='GRN_MAIL-130' replace='true'}</p>
            {/if}
            {if $notify_count}
                <p>{cb_msg module='grn.mail' key='GRN_MAIL-131' replace='true'}<span class="bold">{cb_msg module='grn.mail' key='GRN_MAIL-132' replace='true'}{$notify_count|escape}{cb_msg module='grn.mail' key='GRN_MAIL-133' replace='true'}</span>{cb_msg module='grn.mail' key='GRN_MAIL-134' replace='true'}</p>
            {/if}
            {if $size_over}
                <p>
                    {cb_msg module='grn.mail' key='GRMSG_MAIL_1' app_name=$app_name|escape mailbox_size=$mailbox_size|escape}<br>
                    {cb_msg module='grn.mail' key='GRMSG_MAIL_2' app_name=$app_name|escape mailbox_size=$mailbox_size|escape}({cb_msg module='grn.mail' key='GRMSG_MAIL_3' app_name=$app_name|escape}<span class="bold">{grn_format_filesize size=$mail_size unit='MB'}</span>)
                </p>
            {/if}
            {if $size_error or $remaining or $notify_count or $size_over}
                </div>
                <!----><div class="br">&nbsp;</div>
            {/if}
        {/if}
    </div><!--end of mail_account-->
    {* second line end *}

    <!--menubar-->
    <div id="menu_part">
        {include file="mail/_receive_button.tpl"}
        <div id="smart_main_menu_part">
            {if ! $account_deleted and ! $disable_mail}
                <span class="menu_item">{capture name='grn_mail_GRN_MAIL_403'}{cb_msg module='grn.mail' key='GRN_MAIL-403' replace='true'}{$app_name|grn_noescape}{cb_msg module='grn.mail' key='GRN_MAIL-404' replace='true'}{/capture}{grn_link page='mail/send' caption=$smarty.capture.grn_mail_GRN_MAIL_403 image='mail20.gif' aid=$category.aid cid=$category.cid sid=$status_id disabled=$cannot_send}</span>
            {/if}
                <span class="menu_item">
                {include file='mail/_display_folder_option.tpl'}
            </span>
            <span class="menu_item">
                {include file='mail/_display_options.tpl'}
            </span>
        </div>
        {grn_delete title=$delete_info_all.title page=$delete_info_all.page no_confirm=$delete_info_all.no_confirm data=$delete_info_all.data handler=$delete_info_all.handler}
        <div id="smart_rare_menu_part">
            {if !($use_fts && ($category.type eq '3' || $category.type eq '4'))}
                {include file='mail/_search_box.tpl'}
            {/if}
        </div>
        <div class="clear_both_0px"></div>
    </div>
    <input type="hidden" name="aid" value="{$category.aid}">
    <input type="hidden" name="cid" value="{$category.cid}">
    <input type="hidden" name="sid" value="{$status_id}">
    {grn_delete title=$delete_info_multi.title page=$delete_info_multi.page no_confirm=$delete_info_multi.no_confirm data=$delete_info_multi.data handler=$delete_info_multi.handler multi_target=$delete_info_multi.multi_target form_target=$delete_info_multi.form_target}
    {grn_delete title=$delete_info_multi.title page=$delete_info_multi.page no_confirm=$delete_info_multi.no_confirm data=$delete_info_multi.data handler='btn_delete' multi_target=$delete_info_multi.multi_target form_target=$delete_info_multi.form_target}
    {grn_delete title=$delete_info_multi_files.title page=$delete_info_multi_files.page data=$delete_info_multi_files.data handler=$delete_info_multi_files.handler multi_target=$delete_info_multi_files.multi_target form_target=$delete_info_multi_files.form_target attachment_search=true}
    <!--menubar_end-->

    <table class="maincontents_list">
        <tbody>
            <tr>
                <td class="maincontents_list_td">
                    <table style="width:100%;">
                        <tbody>
                            <tr valign="top">
                                <td id="tree_part">
                                    <!--tree_structure-->
                                    {include file='grn/org_tree_26.tpl'}
                                    <!--tree_structure_end-->
                                </td>
                                <td id="view_part" width="90%">
                                    <div id="moving_box" style="display:none;">
                                        <span id="moving_notice" style="color:#ff0000;"></span>
                                        <a href="javascript:void(0);" onclick="GRN_ListView_Util.UndoDrapDrop('mail_list');">{cb_msg module='grn.mail' key='GRN_MAIL-411' replace='true'}</a>
                                    </div>
                                    <div class="margin_vert">
                                        {include file='grn/memo.tpl' category_memo=$category.memo}
                                    </div>
    
                                    {if $category.type eq '4'}
                                        <div class="smart_sub_title_right" style="float:none;text-align:right;">{cb_msg module='grn.mail' key='GRN_MAIL-152' replace='true'}&nbsp;<span class="bold">{$savedays}</span>&nbsp;{cb_msg module='grn.mail' key='GRN_MAIL-153' replace='true'}</div>
                                    {/if}
                                    <form name="{$form_name}" id="{$form_name}" method="post" action="{grn_pageurl page='mail/command_index'}">
                                        <input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
                                        {capture name="navi_right"}{include file="grn/smart_data_count_310.tpl" start_num=$navi_info.start_count end_num=$navi_info.end_count all_num=$navi_info.count}{/capture}
                                        {include file="grn/smart_word_navi_mail.tpl" navi=$navi_info.navi navi_right=$smarty.capture.navi_right mail_flag =true}
    
                                        <div class="list_menu">
                                            <nobr>
                                                <span class="mail-listCheckButton-grn">{include file="grn/checkall.tpl" elem_name="ids[]" enable_shift_click=true mail_flag=true}</span>
                                                <span class="mail-listButtonDisable-grn"><a id="btn_delete_multi1" href="javascript:void(0);" onclick="submit_form('delete');">{cb_msg module='grn.mail' key='GRN_MAIL-157' replace='true'}</a></span>
                                                {capture name='grn_message_GRN_MAIL_406'}{cb_msg module='grn.mail' key='GRN_MAIL-406' replace='true'}{/capture}
                                                <span class="mail-listButtonDisable-grn">{include file='mail/_change_folder_index.tpl' no_account=1 checkon=1 moveon=1 hide_root_folder=1 hide_garbage_folder=1 show_another_account=$show_another_account c_name='dcid' c_id='dcid1' ids='ids[]' mv_disabled='true' exception_value="-1" exception_item=$smarty.capture.grn_message_GRN_MAIL_406 mv_id='move1' default_selected='true' button_select='true' onchange="onChangeFolderSelect(this, 'dcid2', ['move1', 'move2']);"}</span>
                                                <span class="mail-listButtonDisable-grn">{include file='mail/_change_status_index.tpl' csid="csid1" options=$change_status_infos}</span>
                                            </nobr>
                                        </div>
                                        {if $use_star}
                                            {include file="star/star_init.tpl" list_id="mail_list"}
                                        {/if}
                                        <table class="list_column" id="mail_list" name="list_item">
                                            <colgroup>
                                                <col width="1%">
                                                {if $use_star && $category.type neq '4'}<col width="1%">{/if}
                                                <col width="1%">
                                                <col width="30%">
                                                {if $status_infos}<col width="12%">{/if}
                                                <col width="25%">
                                                <col width="20%">
                                                {if $status_infos}
                                                    <col width="8%">
                                                {else}
                                                    <col width="20%">
                                                {/if}
                                            </colgroup>
                                            <tr>
                                                <th nowrap></th>
                                                {if $use_star && $category.type neq '4'}<th nowrap></th>{/if}
                                                <th nowrap></th>
                                                <th nowrap>
                                                    {capture name='grn_mail_GRN_MAIL_160'}{cb_msg module='grn.mail' key='GRN_MAIL-160' replace='true'}{/capture}{grn_title_sort title=$smarty.capture.grn_mail_GRN_MAIL_160 page=$page_info.all aid=$category.aid cid=$category.cid sid=$status_id sort=$sort.subject.id reverse=$sort.subject.reverse filter=$switch_params.filter disable=$sort.subject.disable}
                                                </th>
                                                <th nowrap>
                                                    {include file='mail/_selection_status.tpl' stid='stid' options=$status_infos unread_filter="true"}
                                                </th>
                                                {if ($category.type neq '2') and $category.type neq '3'} {* 送信箱/下書き以外 *}
                                                    <th nowrap>
                                                        {capture name='grn_mail_GRN_MAIL_162'}{cb_msg module='grn.mail' key='GRN_MAIL-162' replace='true'}{/capture}{grn_title_sort title=$smarty.capture.grn_mail_GRN_MAIL_162 page=$page_info.all aid=$category.aid cid=$category.cid sid=$status_id sort=$sort.name.id reverse=$sort.name.reverse filter=$switch_params.filter disable=$sort.name.disable}
                                                    </th>
                                                {else}{* 送信箱/下書き *}
                                                    <th nowrap>
                                                        {capture name='grn_mail_GRN_MAIL_163'}{cb_msg module='grn.mail' key='GRN_MAIL-163' replace='true'}{/capture}{grn_title_sort title=$smarty.capture.grn_mail_GRN_MAIL_163 page=$page_info.all aid=$category.aid cid=$category.cid sid=$status_id sort=$sort.name.id reverse=$sort.name.reverse filter=$switch_params.filter disable=$sort.name.disable}
                                                    </th>
                                                {/if}
    
                                                <th nowrap>
                                                    {if $category.type neq '4'}{* ごみ箱以外 *}
                                                        {if $button_params.sort_time neq 'ctime'}
                                                            {capture name='grn_mail_GRN_MAIL_164'}{cb_msg module='grn.mail' key='GRN_MAIL-164' replace='true'}{/capture}{grn_title_sort_switch class="buttonStandard-grn" title=$smarty.capture.grn_mail_GRN_MAIL_164 page=$page_info.all reverse=$sort.time.reverse disable=$sort.time.disable button_params=$button_params sort_params=$switch_params flag_mail=true}
                                                        {else}
                                                            {capture name='grn_mail_GRN_MAIL_165'}{cb_msg module='grn.mail' key='GRN_MAIL-165' replace='true'}{/capture}{grn_title_sort_switch  class="buttonStandard-grn" title=$smarty.capture.grn_mail_GRN_MAIL_165 page=$page_info.all reverse=$sort.time.reverse disable=$sort.time.disable button_params=$button_params sort_params=$switch_params flag_mail=true}
                                                        {/if}
                                                    {else}
                                                        {capture name='grn_mail_GRN_MAIL_166'}{cb_msg module='grn.mail' key='GRN_MAIL-166' replace='true'}{/capture}{grn_title_sort  class="buttonStandard-grn" title=$smarty.capture.grn_mail_GRN_MAIL_166 page=$page_info.all aid=$category.aid cid=$category.cid sid=$status_id sort=$sort.time.id reverse=$sort.time.reverse disable=$sort.time.disable filter=$switch_params.filter flag_mail=true}
                                                    {/if}
                                                </th>
                                                <th nowrap>
                                                    {capture name='grn_mail_GRN_MAIL_167'}{cb_msg module='grn.mail' key='GRN_MAIL-167' replace='true'}{/capture}{grn_title_sort title=$smarty.capture.grn_mail_GRN_MAIL_167 page=$page_info.all aid=$category.aid cid=$category.cid sid=$status_id sort=$sort.size.id reverse=$sort.size.reverse filter=$switch_params.filter disable=$sort.size.disable}
                                                </th>
                                            </tr>
                                            {foreach from=$mails item=mail key=rid name="mail_loop"}
                                                {include file="mail/_index.tpl" no_status=$no_status}
                                                {if $smarty.foreach.mail_loop.last}
                                                <tr></tr>
                                                {/if}
                                            {/foreach}
                                        </table>
                                        <div class="list_menu">
                                            <nobr>
                                                <span class="mail-listCheckButton-grn">{include file="grn/checkall.tpl" elem_name="ids[]" enable_shift_click=true mail_flag=true}</span>
                                                <span class="mail-listButtonDisable-grn"><a id="btn_delete_multi2" href="javascript:void(0);" onclick="submit_form('delete');">{cb_msg module='grn.mail' key='GRN_MAIL-168' replace='true'}</a></span>
                                                <span class="mail-listButtonDisable-grn">{include file='mail/_change_folder_index.tpl' no_account=1 checkon=1 moveon=1 hide_root_folder=1 hide_garbage_folder=1 show_another_account=$show_another_account c_name='dcid2' c_id='dcid2' ids='ids[]' mv_disabled='true' exception_value="-1" exception_item=$smarty.capture.grn_message_GRN_MAIL_406 mv_id='move2' default_selected='true' button_select='true' onchange="onChangeFolderSelect(this, 'dcid1', ['move1', 'move2']);"}</span>
                                                <span class="mail-listButtonDisable-grn">{include file='mail/_change_status_index.tpl' csid="csid2" options=$change_status_infos}</span>
                                            </nobr>
                                        </div>
                                        <div class="navi">
                                            <nobr>
                                            {capture name="navi_right_down"}{include file="grn/smart_data_count_310.tpl" start_num=$navi_info.start_count end_num=$navi_info.end_count all_num=$navi_info.count position='_down'}{/capture}
                                                {include file="grn/smart_word_navi_mail.tpl" bottom=1 navi=$navi_info.navi navi_right=$smarty.capture.navi_right_down mail_flag =true}
                                            </nobr>
                                        </div>
                       
                                        <!----->
                                        <input type="hidden" name="cmd" id="cmd_index" value="index">
                                        <input type="hidden" name="cs_value" id="cs_value_index" value="index">
                                        <input type="hidden" name="move_value" id="move_value_index" value="index">
                                        <input type="hidden" name="aid" value="{$category.aid}">
                                        <input type="hidden" name="cid" value="{$category.cid}">
                                        <input type="hidden" name="ctype" value="{$category.type}">
                                        <input type="hidden" name="sid" value="{$status_id}">
                                        <span style="display:none">{capture name='grn_mail_GRN_MAIL_157'}{cb_msg module='grn.mail' key='GRN_MAIL-157' replace='true'}{/capture}{grn_button_submit caption=$smarty.capture.grn_mail_GRN_MAIL_157 id="btn_delete" onclick="return false;" }</span>
                                    </form>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </td>
            </tr>
        </tbody>
    </table>
    <!--end of maincontents_list-->
{/if}

{*** DRAG N' DROP ***}
{if $no_setting eq '0'}
    {include file='grn/dragdrop_list2tree.tpl'}
    {grn_load_javascript file="grn/html/component/mail/DropDown.js"}
    {grn_load_javascript file="grn/html/mail.js"}
    {literal}
    <script language="javascript">
    <!--
    YAHOO.util.Event.onDOMReady(function(){

        var GRN_DDList2Tree_Mail = function(){
            GRN_DDList2Tree_Mail.superclass.constructor.apply(this, arguments);
        };
        YAHOO.extend(GRN_DDList2Tree_Mail, GRN_DDList2Tree);

        var options = { list_id:'mail_list',
                        item_name:'ids[]',
                        csrf_ticket:'{/literal}{$csrf_ticket}{literal}',
                        async_url: '{/literal}{grn_pageurl page="mail/command_move_ajax"}',
                        source:{ldelim}name:'cid',value:{$category.cid}{rdelim},
                        target_oid_key: 'dcid',
                        drag_msg: {ldelim}singular: '{cb_msg module='grn.mail' key='GRN_MAIL-408' replace='true'}', plural: '{cb_msg module='grn.mail' key='GRN_MAIL-409' replace='true'}'{rdelim},
                        moving_notice:'{cb_msg module='grn.mail' key='GRN_MAIL-410' replace='true'}'{literal}
                      };
        GRN_ListView_Util.InitDragDrop(GRN_DDList2Tree_Mail, options);
        
        GRN_MoveEmail_Util.init();
    });
    -->
    </script>
    {/literal}
{/if}
{*** END: DRAG N' DROP ***}
{grn_load_javascript file="grn/html/page/mail/mail.js"}
<script type="text/javascript">
    var __thisPage = grn.page.mail.mail;
</script>
{if $no_setting eq '0'}
<script language="javascript">
   __thisPage.IMG_PATH = '{$app_path}/grn/image/cybozu/';
   __thisPage.ajax_mail_preview_url = '{grn_pageurl page="mail/ajax_mail_preview"}';
   var csrf_ticket = '{$csrf_ticket}';
   __thisPage.csrf_ticket = csrf_ticket;
   __thisPage.selected_node = '{$folder_tree.selected_oid}';
   var form_name = '{$form_name}';
   var source_name = 'cid';
   var source_value = '{$category.cid}';
   var target_oid_key = 'dcid';
   var url_ajax_move_email = '{grn_pageurl page="mail/command_move_ajax"}';
   var moving_notice_content = '{cb_msg module='grn.mail' key='GRN_MAIL-410' replace='true'}';
  var locale = '{$html_tag_lang}';
{literal}
//<!--
    function grn_is_checked_mail(form, target_name)
    {
        if(! grn_is_checked( form, target_name ))
        {
            jQuery("#dcid2").attr("selectedIndex", 0);
            jQuery('#dcid1').attr("selectedIndex", 0);
            jQuery('#csid').attr("selectedIndex", 0);
            jQuery('#csid2').attr("selectedIndex", 0);
            return false;
        }
        return true;
    }
    
    function show_balloon(target)
    {
        var balloon = jQuery("#mail-amountDetaiDaialog-grn");
        var narrow_mail = jQuery("#narrow_top_mail");
        var switchOffset = cumulativeOffset(target),
                left = switchOffset[0] + 20,
                top = switchOffset[1] + 16;
        balloon.css({top: top + 'px', left: left - balloon.width() + 'px'});
        narrow_mail.css({left: balloon.width() - 25 + 'px'});
        balloon.toggle();
    }
    
    function show_another_tab_icon(elm)
    {
        elm.attr("class", "new_tab_icon_show");
    }
    
    function hide_another_tab_icon(elm)
    {
        elm.attr("class", "new_tab_icon_hide");
    }

   jQuery(document).click(function (event) {
       var target = event.target;
       var capacity_infomation = jQuery("#mail-CapacityInfomation-grn");
       var capacity_bar_base = jQuery("#mail-CapacityBarBase-grn");

       var not_click = !capacity_infomation.is(target) && !capacity_bar_base.is(target);

       if (not_click) {
           var balloon = jQuery("#mail-amountDetaiDaialog-grn");
           if (balloon.length > 0 && balloon.is(":visible")) {
               balloon.hide();
           }
       }
   });

    function setPositionBalloon()
    {
        var balloon = jQuery("#mail-amountDetaiDaialog-grn");
        var narrow_mail = jQuery("#narrow_top_mail");
        if (balloon.is(":visible")) {
            var target = jQuery("#mail-CapacityInfomation-grn");
            var switchOffset = target.offset(),
                    left = switchOffset.left + 22,
                    top = switchOffset.top + 16;
            balloon.css({top: top + 'px', left: left - balloon.width() + 'px'});
            if(!grn.browser.msie)
            {
                narrow_mail.css({left: balloon.width() - 25 + 'px'});
            }
        }
    }

    jQuery(window).resize(function(){
        setTimeout('setPositionBalloon()',0);
    });

function show_popup_delete(data,mid,aid,cid)
{
    var tmp_div = jQuery("<div id='tmpdiv'></div>");
    var tmp_div_text = tmp_div.text(data);
    var escape_html =  tmp_div_text.html();
    {/literal}
    {if $category.type eq '4' or $use_garbagebox eq '0'}
        data = "<p>" + "{cb_msg module='grn.mail' key='GRN_MAIL-212' replace='true'}" + "</br><span class='bold'> <span class='mail20'>" + escape_html + "</span></span>" + "</p>";
    {else}
        data = "<p>" + "{cb_msg module='grn.mail' key='GRN_MAIL-211' replace='true'}" + "<br><span class='bold' ><span class='mail20'>" + escape_html + "</span></span>" + "</p>";
    {/if}
    {literal}
    GRN_MsgBox.show(data, 
                    {/literal}'{cb_msg module="grn.mail" key="GRN_MAIL-421" replace="true"}'{literal},                    GRN_MsgBoxButtons.yesno,
                                { ui       : {},
                                  caption : {yes: {/literal}"{cb_msg module='grn.common' key='yes'}",
                                             no: "{cb_msg module='grn.common' key='no'}"{literal}},
                                  callback : function(result, form){
                                      if(result == GRN_MsgBoxResult.yes){
                                        delete_mail();
                                      }
                                  }
                                }
  );
  
  function delete_mail()
  {
      document.body.style.cursor = "progress";
      jQuery('input[name="aid"]').val(aid);
      jQuery('input[name="mid"]').val(mid);
      jQuery('input[name="cid"]').val(cid);
      document.forms['mail/delete'].submit();
  }
}

   jQuery(document).ready(function () {
       var delete_multi_files_enable = jQuery("#lnk_delete_multi_files");
       var delete_multi_files_disable = jQuery("#lnk_delete_multi_files_disable");
       if (!grn_is_checked(document.forms[form_name], "ids[]")) {
           delete_multi_files_enable.hide();
           delete_multi_files_disable.show();
       }
       else {
           delete_multi_files_disable.hide();
           delete_multi_files_enable.show();
       }
   });
//-->
{/literal}
</script>
{/if}
</div>
</div>
{*** END PREVIEW EMAIL ***}

<form name="mail/delete" method="post" action="{grn_pageurl page='mail/command_delete'}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
<input type="hidden" name="aid" id="aid" value="{$mail.aid}">
<input type="hidden" name="cid" id="cid" value="{$mail.cid}">
<input type="hidden" name="mid" id="mid" value="{$mail.mid}">
</form>
{include file="grn/footer.tpl"}
