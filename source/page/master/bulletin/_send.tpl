 <p>
{include file='grn/_ajax_submit_check_error.tpl'}
{include file='grn/indispensable.tpl'}
 <table class="std_form">
  <!--bulitin_items-->
  <tr>
   <th>{cb_msg module='grn.bulletin' key='GRN_BLLT-481' replace='true'}</th>
   <td>
        {if $enable_manually_enter_sender}
            {capture name='grn_bulletin_GRN_BLLT_640'}{cb_msg module='grn.bulletin' key='GRN_BLLT-640' replace='true'}{/capture}{grn_radio name='sender_set' id='sender_set_creator' value=0 caption=$smarty.capture.grn_bulletin_GRN_BLLT_640 checked=$is_sender_type_creator}
        {/if}
        {grn_user_name name=$creator_name uid=$creator_uid}
        <span>{capture name='grn_bulletin_GRN_BLLT_482'}{cb_msg module='grn.bulletin' key='GRN_BLLT-482' replace='true'}{/capture}{grn_checkbox name='choose_group' id='choose_group' caption=$smarty.capture.grn_bulletin_GRN_BLLT_482 value='1' checked=$choose_group_checked disabled=$choose_group_disbaled onclick='selectGroup(this);'}</span>
        <span>{grn_select name='select_group' options=$group_options disabled=$select_group_disabled}</span>
        {if $enable_manually_enter_sender}
            <div class="mTop7">
                {capture name='grn_bulletin_GRN_BLLT_641'}{cb_msg module='grn.bulletin' key='GRN_BLLT-641' replace='true'}{/capture}{grn_radio name='sender_set' id='sender_set_custom' value=1 caption=$smarty.capture.grn_bulletin_GRN_BLLT_641 checked=$is_sender_type_custom}<span class="attention">*</span>
                {capture name='grn_bulletin_GRN_BLLT_642'}{cb_msg module='grn.bulletin' key='GRN_BLLT-642' replace='true'}{/capture}
                {validate form=$form_name field="manually_sender" criteria="grn_bulletin_senderNotEmpty" message=$smarty.capture.grn_bulletin_GRN_BLLT_642 append="validation_errors"}{grn_text name="manually_sender" id='manually_sender' value=$manually_sender_data size="50" disable_return_key=true}
            </div>
        {/if}
   </td>
  </tr>
  <tr>
   <th>{capture name='grn_bulletin_GRN_BLLT_483'}{cb_msg module='grn.bulletin' key='GRN_BLLT-483' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_bulletin_GRN_BLLT_483 necessary=1}</th>
   <td>{capture name='grn_bulletin_GRN_BLLT_484'}{cb_msg module='grn.bulletin' key='GRN_BLLT-484' replace='true'}{/capture}{validate form=$form_name field="title" criteria="notEmpty" message=$smarty.capture.grn_bulletin_GRN_BLLT_484 transform="cb_trim" append="validation_errors"}{grn_text necessary=true name="title" value=$title size="50" disable_return_key=true}</td>
  </tr>
  <tr>
   <th>{capture name='grn_bulletin_GRN_BLLT_485'}{cb_msg module='grn.bulletin' key='GRN_BLLT-485' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_bulletin_GRN_BLLT_485}</th>
   <td>{grn_sentence caption=$category_name image='category20.gif'}</td>
  </tr>
  <tr valign="top">
   <th>{cb_msg module='grn.bulletin' key='GRN_BLLT-486' replace='true'}</th>
   <td>
       <script language="JavaScript" type="text/javascript"><!--{literal}

        function selectGroup(checkgroup)
        {
            var group = document.getElementById("select_group");
            if(checkgroup.checked && !checkgroup.disabled)
            {
                group.disabled = false;
            }
            else
            {
                group.disabled = true;
            }
        }
        jQuery(document).ready(function(){
            selectGroup(document.getElementById("choose_group"));
        });
      {/literal} --></script>
      {capture name='grn_bulletin_GRN_BLLT_639'}{cb_msg module='grn.bulletin' key='GRN_BLLT-639' replace='true'}{/capture}
      {if !$published}
        {if $enable_term || $set_limit}
          <div class="mBottom3">
            <span class="radiobutton_base_grn">{capture name='grn_bulletin_GRN_BLLT_487'}{cb_msg module='grn.bulletin' key='GRN_BLLT-487' replace='true'}{/capture}{grn_radio name='enable_term' id='term_off' value=0 caption=$smarty.capture.grn_bulletin_GRN_BLLT_487}</span>
          </div>
          <div class="mBottom3">
            <span class="radiobutton_base_grn">{grn_radio name='enable_term' id='term_on'  value=1 checked=1 caption=$smarty.capture.grn_bulletin_GRN_BLLT_639}</span>
          </div>
        {else}
          <div class="mBottom3">
            <span class="radiobutton_base_grn">{capture name='grn_bulletin_GRN_BLLT_488'}{cb_msg module='grn.bulletin' key='GRN_BLLT-488' replace='true'}{/capture}{grn_radio name='enable_term' id='term_off' value=0 checked=1 caption=$smarty.capture.grn_bulletin_GRN_BLLT_488}</span>
          </div>
          <div class="mBottom3">
            <span class="radiobutton_base_grn">{grn_radio name='enable_term' id='term_on'  value=1 caption=$smarty.capture.grn_bulletin_GRN_BLLT_639}</span>
          </div>
        {/if}
        {capture name='grn_bulletin_GRN_BLLT_491'}{cb_msg module='grn.bulletin' key='GRN_BLLT-491' replace='true'}{/capture}{validate form=$form_name field="sterm_" field2="" enable="enable_term" criteria="grn_isDateOnOrAfter" message=$smarty.capture.grn_bulletin_GRN_BLLT_491 append="validation_errors"}
        {capture name='grn_bulletin_GRN_BLLT_492'}{cb_msg module='grn.bulletin' key='GRN_BLLT-492' replace='true'}{/capture}{validate form=$form_name field="eterm_" field2="" enable="enable_term" criteria="grn_isDateOnOrAfter" message=$smarty.capture.grn_bulletin_GRN_BLLT_492 append="validation_errors"}
        {capture name='grn_bulletin_GRN_BLLT_493'}{cb_msg module='grn.bulletin' key='GRN_BLLT-493' replace='true'}{/capture}{validate form=$form_name field="sterm_" field2="eterm_" enable="enable_term" criteria="grn_isValidTerm" message=$smarty.capture.grn_bulletin_GRN_BLLT_493 append="validation_errors"}
        <div class="mBottom7 mLeft15">
          {grn_select_date prefix="sterm_" form_name=$form_name necessary=false show_wday=true date=$stime support_calendar_disable_ui=true}{grn_select_time prefix='sterm_' minute_interval=$minute_interval time=$start_time}{cb_msg module='grn.bulletin' key='GRN_BLLT-494' replace='true'}
        </div>
        <div class="mLeft15">
          {grn_select_date prefix="eterm_" form_name=$form_name necessary=false show_wday=true date=$etime support_calendar_disable_ui=true}{grn_select_time prefix='eterm_' minute_interval=$minute_interval time=$end_time}
        </div>
        <input type="hidden" name="sterm_">
        <input type="hidden" name="eterm_">
      {else}
        {if $enable_term || $set_limit}
          <div class="mBottom3">
            <span class="radiobutton_base_grn">{capture name='grn_bulletin_GRN_BLLT_487'}{cb_msg module='grn.bulletin' key='GRN_BLLT-487' replace='true'}{/capture}{grn_radio name='enable_term' id='term_off' value=0 caption=$smarty.capture.grn_bulletin_GRN_BLLT_487}</span>
          </div>
          <div class="mBottom3">
            <span class="radiobutton_base_grn">{grn_radio name='enable_term' id='term_on'  value=1 checked=1 caption=$smarty.capture.grn_bulletin_GRN_BLLT_639}</span>
          </div>
        {else}
          <div class="mBottom3">
            <span class="radiobutton_base_grn">{capture name='grn_bulletin_GRN_BLLT_488'}{cb_msg module='grn.bulletin' key='GRN_BLLT-488' replace='true'}{/capture}{grn_radio name='enable_term' id='term_off' value=0 checked=1 caption=$smarty.capture.grn_bulletin_GRN_BLLT_488}</span>
          </div>
          <div class="mBottom3">
            <span class="radiobutton_base_grn">{grn_radio name='enable_term' id='term_on'  value=1 caption=$smarty.capture.grn_bulletin_GRN_BLLT_639}</span>
          </div>
        {/if}
          {capture name='grn_bulletin_GRN_BLLT_489'}{cb_msg module='grn.bulletin' key='GRN_BLLT-489' replace='true'}{/capture}{validate form=$form_name field="eterm_" field2="" enable="enable_term" criteria="grn_isDateOnOrAfter" message=$smarty.capture.grn_bulletin_GRN_BLLT_489 append="validation_errors"}
          {if $stime}
            <input type="hidden" name="sterm_year" value="{$stime->year}">
            <input type="hidden" name="sterm_month" value="{$stime->month}">
            <input type="hidden" name="sterm_day" value="{$stime->day}">
            {if $start_time}
              <input type="hidden" name="sterm_hour" value="{$stime->hour}"/>
              <input type="hidden" name="sterm_minute" value="{$stime->minute}"/>
            {else}
              <input type="hidden" name="sterm_hour" value=""/>
              <input type="hidden" name="sterm_minute" value=""/>
            {/if}
          {else}
            <input type="hidden" name="sterm_year" value="">
            <input type="hidden" name="sterm_month" value="">
            <input type="hidden" name="sterm_day" value="">
            <input type="hidden" name="sterm_hour" value=""/>
            <input type="hidden" name="sterm_minute" value=""/>
          {/if}
          <div class="mBottom7 mLeft15">
            {if $start_time}
              {grn_date_format date=$stime format="DateTimeFull_YMDW_HM"}
            {else}
              {grn_date_format date=$stime format="DateFull_YMDW"}
            {/if}
            {cb_msg module='grn.bulletin' key='GRN_BLLT-490' replace='true'}
          </div>
          <div class="mLeft15">
            {grn_select_date prefix="eterm_" form_name=$form_name necessary=false show_wday=true date=$etime support_calendar_disable_ui=true}{grn_select_time prefix='eterm_' minute_interval=$minute_interval time=$end_time}
          </div>
          <input type="hidden" name="sterm_">
          <input type="hidden" name="eterm_">
      {/if}
        <input type="hidden" name="published" value="{$published}">
   </td>
  </tr>
  <tr valign="top">
   <th>{cb_msg module='grn.bulletin' key='GRN_BLLT-495' replace='true'}</th>
   <td>
      {include file="grn/richeditor.tpl" html=$html text=$data cols=$config.area_width rows=$config.area_height enable=$config.enable_htmleditor class="form_textarea_grn"}
   </td>
  </tr>
  <tr>
   <th>{cb_msg module='grn.bulletin' key='GRN_BLLT-496' replace='true'}</th>
   <td>
      {include file="grn/attach_file.tpl" attached_files=$attach_files}
   </td>
  </tr>
  {if $enable_acknowledgement}
    <tr valign="top">
  {else}
    <tr valign="top" style="display:none">
  {/if} 
  <th>{cb_msg module='grn.bulletin' key='GRN_BLLT-605' replace='true'}</th>
  <td>
   {capture name='grn_bulltetin_GRN_MSG_606'}
    {cb_msg module='grn.bulletin' key='GRN_BLLT-606' replace='true'}
   {/capture}
   {grn_checkbox name="enable_acknowledgement" id="enable_acknowledgement" value="1" caption=$smarty.capture.grn_bulltetin_GRN_MSG_606 checked=$acknowledgement}
  </td>
 </tr>

  <tr>
   <th>{cb_msg module='grn' key='grn.comment.permission.conf.item' replace='true'}</th>
   <td>
       {if $can_follow}
        {capture name='grn_bulletin_GRN_BLLT_498'}{cb_msg module='grn' key='grn.comment.permission.conf.add' replace='true'}{/capture}{grn_checkbox name="can_follow" id="0" value="1" checked=1 caption=$smarty.capture.grn_bulletin_GRN_BLLT_498}
       {else}
        {capture name='grn_bulletin_GRN_BLLT_499'}{cb_msg module='grn' key='grn.comment.permission.conf.add' replace='true'}{/capture}{grn_checkbox name="can_follow" id="0" value="1" caption=$smarty.capture.grn_bulletin_GRN_BLLT_499}
       {/if}
    </td>
  </tr>
  <tr>
    <th>{cb_msg module='grn.bulletin' key='GRN_BLLT-643' replace='true'}</th>
    <td>
      {capture name='grn_bulletin_GRN_BLLT_644'}{cb_msg module='grn.bulletin' key='GRN_BLLT-644' replace='true'}{/capture}{grn_radio name='operator_set' id='operator_set_sender' value=0 caption=$smarty.capture.grn_bulletin_GRN_BLLT_644 checked=$is_maintainer_type_sender}
      {capture name='grn_bulletin_GRN_BLLT_645'}{cb_msg module='grn.bulletin' key='GRN_BLLT-645' replace='true'}{/capture}{grn_radio name='operator_set' id='operator_set_other' value=1 caption=$smarty.capture.grn_bulletin_GRN_BLLT_645 checked=$is_maintainer_type_other}
    </td>
  </tr>
  <tr id="other_operator_area" style="{if $is_maintainer_type_sender}display:none;{/if}">
    <th>{cb_msg module='grn.bulletin' key='GRN_BLLT-646' replace='true'}</th>
    <td>
      <small>{cb_msg module='grn.bulletin' key='GRN_BLLT-647' replace='true'}</small>
      {grn_member_add name='bulletin_maintainer' app_id='bulletin' form_name=$form_name sUID='sUID' CGID='CGID' CID='CID' selected_users=$maintainers access_plugin=$plugin}
    </td>
  </tr>
  {if $notify_check}
      <input type="hidden" name="notifyFlag" value="">
      <tr>
          <td></td>
          <td>
              {capture name='grn_bulletin_GRN_BLLT_653'}{cb_msg module='grn.bulletin' key='GRN_BLLT-653' replace='true'}{/capture}
              <div class="mTop10">{grn_checkbox name='notifyFlag' id='notifyFlag' value='1' checked=1 caption=$smarty.capture.grn_bulletin_GRN_BLLT_653}</div>
          </td>
      </tr>
  {/if}
  <tr>
   <td></td>
   <td>{strip}
           <div class="mTop10">
               {if ! $modify_form}
                   {capture name="onbulletinpost"}
                       grn.page.bulletin._send.bulletin_submit('send', '{$form_name}', '{grn_pageurl page=$submit_page}', this);
                   {/capture}
                   {capture name="onbulletinsave"}
                       grn.page.bulletin._send.bulletin_submit('save', '{$form_name}', '{grn_pageurl page=$submit_page}', this);
                   {/capture}
                   {capture name="grn_bulletin_GRN_BLLT_500"}{cb_msg module='grn.bulletin' key='GRN_BLLT-500' replace='true'}{/capture}
                   {capture name="grn_bulletin_GRN_BLLT_501"}{cb_msg module='grn.bulletin' key='GRN_BLLT-501' replace='true'}{/capture}
                   {grn_button id="bulletin_button_post" ui="main" spacing="loose" caption=$smarty.capture.grn_bulletin_GRN_BLLT_500 onclick=$smarty.capture.onbulletinpost}
                   {grn_button id="bulletin_button_save" spacing="tight" class="button_submit_grn" caption=$smarty.capture.grn_bulletin_GRN_BLLT_501 onclick=$smarty.capture.onbulletinsave}
               {else}
                   {capture name="grn_bulletin_GRN_BLLT_502"}{cb_msg module='grn.bulletin' key='GRN_BLLT-502' replace='true'}{/capture}
                   {capture name="onbulletinmodify"}
                       grn.page.bulletin._send.bulletin_submit('save', '{$form_name}', '{grn_pageurl page=$submit_page}', this);
                   {/capture}
                   {grn_button id="bulletin_button_modify" ui="main" spacing="normal" caption=$smarty.capture.grn_bulletin_GRN_BLLT_502 onclick=$smarty.capture.onbulletinmodify}
               {/if}
               {grn_button action="cancel" page=$cancel_page page_param_cid=$category_id page_param_aid=$article_id}
           </div>
       {/strip}
   </td>
  </tr>
 </table>
 <input type="hidden" name="cid" value="{$category_id}">
 <input type="hidden" name="aid" value="{$article_id}">
 <input type="hidden" name="tmp_key" value="{$tmp_key}">
 <input type="hidden" name="save" value="">
 <input type="hidden" name="send" value="">
{grn_load_javascript file="grn/html/page/bulletin/_send.js"}