{if ! $data_theme}{assign var='data_theme' value='c'}{/if}
{grn_load_css file="fw/jquery_mobile/datebox/jqm-datebox-1.4.5.min.css"}
{grn_load_javascript file="grn/html/component/checkbox_mobile.js"}
{grn_load_javascript file="grn/html/page/space/mobile/todo/todo_date.js"}
{grn_load_javascript file="fw/jquery_mobile/datebox/jqm-datebox-1.4.5.core.min.js"}
{grn_load_javascript file="fw/jquery_mobile/datebox/jqm-datebox-1.4.5.mode.calbox.min.js"}
{if $html_tag_lang eq 'zh'}
{grn_load_javascript file="fw/jquery_mobile/datebox/jquery.mobile.datebox.i8n.CHN-S.js"}
{elseif $html_tag_lang eq 'zh-tw'}
{grn_load_javascript file="fw/jquery_mobile/datebox/jquery.mobile.datebox.i18n.zh-TW.utf8.js"}
{elseif $html_tag_lang eq 'ja'}
{grn_load_javascript file="fw/jquery_mobile/datebox/jquery.mobile.datebox.i8n.jp.js"}
{else}
{grn_load_javascript file="fw/jquery_mobile/datebox/jquery.mobile.datebox.i8n.en-US.js"}
{/if}
{literal}
<script language="JavaScript" text="text/javascript">
(function()
{
    var G = grn.page.space.mobile.todo.todo_date;
    var CK = grn.component.checkbox_mobile;
    $(document).on("pagecreate", function (e) {
        if (!$(e.target).is("#_select"))
        {{/literal}
            $('#start, #end').parent().hide();
            {if $modify_form}
                {if ! $start_date}
                    G.hideStartDate($('#date_button'));
                    {if ! $end_date}
                        CK.check('#date_nolimit', true);
                        G.disableDate("end", true);
                        G.setDefaultDate('end');
                    {else}
                    {literal}$('#end_linkmodelink').bind('click', {str: "end"}, G.openDatebox);{/literal}
                    {/if}
                {else}
                    CK.check('#date_nolimit', false);
                    $('#end_date_nolimit').hide();
                    {literal}$('#start_linkmodelink').bind('click', {str: "start"}, G.openDatebox);{/literal}
                    {literal}$('#end_linkmodelink').bind('click', {str: "end"}, G.openDatebox);{/literal}
                    G.showStartDate($('#date_button'));
                {/if}
            {else}
                CK.check('#date_nolimit', false);
                $('#end_date_nolimit').hide();
                G.hideStartDate($('#date_button'));
                G.setDefaultDate('end');
                {literal}$('#end_linkmodelink').bind('click', {str: "end"}, G.openDatebox);{/literal}
            {/if}
        {literal}
        }
    });
{/literal}
    G.SHOW_END_DATE = '{cb_msg module='grn.space.todo' key='GRN_SP_TOD-66' replace='true'}';
    G.HIDE_END_DATE = '{cb_msg module='grn.space.todo' key='GRN_SP_TOD-67' replace='true'}';
{literal}
})();
</script>
{/literal}
<div class="mobile-div-title-grn">
  <span for="textarea" class="mobile-label-grn">{cb_msg module='grn.space.todo' key='GRN_SP_TOD-3' replace='true'}</span>
  <div id="start_date">
    <input name="start" id="start" type="text" value="{$start_date}" data-role="datebox"
      data-options='{ldelim}"mode": "calbox","theme": "{$data_theme}", "noButton": true, "disableManualInput":true, "calTodayButton": true, "pickPageTodayButtonTheme": "b", "useDialogForceTrue": true, "useDialogForceFalse": false, "dateFormat": "YYYY/mm/dd"{if $is_ios}, "closeCallback": "grn.page.space.mobile.todo.todo_date.top()"{/if}{rdelim}'/>
    <span class="mobile-contentSubButton-grn">
      <a href="javascript:void(0);" id="start_linkmodelink" data-role="button" class="mobile-btn-calender-grn mobile-btn-2calender-grn">
        <span class="mobile-icon-calender-grn"></span>
        <span id="start_set" class="mobile-font-normal-grn mLeft5">{grn_mobile_date_format date=$start_date}</span>&nbsp;
      </a>
    </span>
  </div>
  <div id="end_date">
    <span class="mobile-sign-calender-grn">～</span>
    <span class="mobile-contentSubButton-grn">
      <input name="end" id="end" type="text" value="{$end_date}" data-role="datebox" 
        data-options='{ldelim}"mode": "calbox","theme": "{$data_theme}", "noButton": true, "disableManualInput":true, "calTodayButton": true, "pickPageTodayButtonTheme": "b", "useDialogForceTrue": true, "useDialogForceFalse": false, "dateFormat": "YYYY/mm/dd"{if $is_ios}, "closeCallback": "grn.page.space.mobile.todo.todo_date.top()"{/if}{rdelim}'/>
      <a href="javascript:void(0);" id="end_linkmodelink" data-role="button" class="mobile-btn-calender-grn mobile-btn-2calender-grn">
        <span class="mobile-icon-calender-grn"></span>
        <span id="end_set" class="mobile-font-normal-grn mLeft5">{grn_mobile_date_format date=$end_date}</span>&nbsp;
      </a>
    </span>
  </div>
</div>
<div class="mobile-div-assigner-grn mobile-div-title-grn">
  <span class="mobile-contentSubButton-grn"><a id="date_button" href="javascript:void(0);" data-role="button"  data-theme="{$data_theme}" class="mobile-btn-assigner-grn"> {cb_msg module='grn.space.todo' key='GRN_SP_TOD-67' replace='true'} </a></span>
  <span id="end_date_nolimit" class="mobile-check-noTerm-grn">
    {assign var='checkbox_id' value=$form_name|cat:'_'|cat:'date'}
    <label for="{$checkbox_id}">
      <a id="date_nolimit" href="javascript:void(0);" class="mobile-checkboxOff-todo-grn"></a>
      <input name="nolimit" id="{$checkbox_id}" type="checkbox" data-role="none" class="mobile-input-grn"/>
    </label>
    <span>{cb_msg module='grn.space.todo' key='GRN_SP_TOD-78' replace='true'}</span>
  </span>
</div>