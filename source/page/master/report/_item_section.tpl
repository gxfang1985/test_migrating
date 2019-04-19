  {foreach from=$item_list item=item_line}
    {if $item_line.type == 2}
      <tr valign="top">
        <td rowspan="1" colspan="1" align="left" width=""><div class="wf_empty_row"></div></td>
      </tr>
    {else}
      {if $item_line.list_index == 0 && $event}
      <tr valign="top">
        <th rowspan="1" align="left" width="20%" nowrap>{cb_msg module='grn.report' key='GRN_RPRT-312' replace='true'}</th>
        <td>
          <a href="{grn_pageurl page='schedule/view' event=$event_id bdate=$event_date}">{$event->getTitle()}</a><br />
        </td>
      </tr>
      {/if}
      <tr valign="top">
       {if $item_line.description}
        <th rowspan="2" align="left" width="20%" nowrap>
       {else}
        <th rowspan="1" align="left" width="20%" nowrap>
       {/if}
         {grn_show_input_title title=$item_line.display_name necessary=$item_line.required}
       {assign var="current_display_name" value=$item_line.display_name}
        </th>
       {if $send_form}
        {if $item_line.list_index == 0 && $event_item}
        {grn_report_include_item category_id=$category_id form_id=$form_id iid=$item_line.iid item=$event_item display="input"}
        {else}
        {grn_report_include_item category_id=$category_id form_id=$form_id iid=$item_line.iid item=$item_line display="input"}
        {/if}
       {else}
        {grn_report_include_item report_id=$report_id iid=$item_line.iid item=$item_line display="input"}
       {/if}
      </tr>
      {if $item_line.description}
      <tr>
        <td>
         {if $item_line.description_type != 1}
          {if $item_line.description_editor == 1}
          <div class="adjust_link">{$item_line.description|grn_noescape}</div>
          {else}
           {grn_format body=$item_line.description}
          {/if}
         {elseif $modify}
          <div class="adjust_link"><small>{capture name='grn_report_GRN_RPRT_314'}{cb_msg module='grn.report' key='GRN_RPRT-314' replace='true'}{/capture}{grn_link image='popup14.gif' page='report/send_description_common' caption=$smarty.capture.grn_report_GRN_RPRT_314 target='_blank' category_id=$category_id form_id=$form_id item_id=$item_line.item mode=$mode}</small></div>
         {else}
          <div class="adjust_link"><small>{capture name='grn_report_GRN_RPRT_314'}{cb_msg module='grn.report' key='GRN_RPRT-314' replace='true'}{/capture}{grn_link image='popup14.gif' page='report/send_description_common' caption=$smarty.capture.grn_report_GRN_RPRT_314 target='_blank' category_id=$category_id form_id=$form_id item_id=$item_line.iid mode=$mode}</small></div>
         {/if}
        </td>
      </tr>
      {/if}
      {if $item_line.type == 1}
      <tr valign="top">
        <th rowspan="1" align="left" width="20%" nowrap>{cb_msg module='grn.report' key='GRN_RPRT-315' replace='true'}</th>
       {if $creator_is_login}
        <td nowrap>{grn_user_name uid=$login.id name=$login.name}</td>
       {else}
        <td nowrap>{grn_user_name uid=$report.creator name=$report.creator_name}</td>
       {/if}
      </tr>
       {if $form.enable_member}
      <tr valign="top">
        <th rowspan="1" align="left" width="20%" nowrap>{cb_msg module='grn.report' key='GRN_RPRT-316' replace='true'}<span class="attention">*</span></th>
        <td>
          <small>{cb_msg module='grn.report' key='member.attention' replace='true'}</small>
          {assign var="action_form" value=$form_name|escape:"html"}{grn_member_add name="member_sUID" operator_add_name="sUID_o" form_name=$form_name sUID='member_sUID' CID='member_CID' selected_users=$members app_id='report' access_plugin=$plugin}
        </td>
      </tr>
       {/if}
       {if $form.enable_partner}
      <tr valign="top" id="report_partner_row">
        <th id="report_partner_header" rowspan="1" align="left" width="20%" nowrap>{cb_msg module='grn.report' key='outside_parties' replace='true'}</th>
        <td>
          {grn_report_add_partner form_name=$form_name sUID='partner_sUID[]' CGID='partner_CGID' path_mode=$path_mode path_mode_get_address=$path_mode_get_address  CID='partner_CID[]' partners=$partners access_plugin=$plugin function_name='partner_popupUserList'}
        </td>
      </tr>
       {/if}
      {/if}
    {/if}
  {/foreach}
      <tr valign="top">
        <th rowspan="1" align="left" width="20%" nowrap>{cb_msg module='grn.report' key='GRN_RPRT-358' replace='true'}</th>
        <td>
          <input id="radio.public"  type="radio" name="private" value="0" {if !$private}checked{/if} /><label onmouseout="this.style.color=''" onmouseover="this.style.color='#ff0000'" for="radio.public" style="">{cb_msg module='grn.report' key='publicity.public' replace='true'}</label>
          <input id="radio.private" type="radio" name="private" value="1" {if  $private}checked{/if} /><label onmouseout="this.style.color=''" onmouseover="this.style.color='#ff0000'" for="radio.private" style="">{if $form.enable_member}{cb_msg module='grn.report' key='publicity.private' replace='true'}{else}{cb_msg module='grn.report' key='disable_member_notify' replace='true'}{/if}</label>
        </td>
      </tr>
      <tr valign="top">
        <th rowspan="1" align="left" width="20%" nowrap>{if $form.enable_member}{cb_msg module='grn.report' key='GRN_RPRT-86' replace='true'}{else}{cb_msg module='grn.report' key='GRN_RPRT-317' replace='true'}{/if}</th>
        <td>
          <small>{if $form.enable_member}{cb_msg module='grn.report' key='notification.attention' replace='true'}{else}{cb_msg module='grn.report' key='disable_member_notification.attention' replace='true'}{/if}</small>
            {php}
                $this->assign('search_box_options',array('is_use'       => TRUE,
                                                         'id_searchbox' => 'notification_keyword_user'));
            {/php}
          {grn_member_add name="notification_sUID" search_box_options=$search_box_options operator_add_name="sUID_o" form_name=$form_name sUID='notification_sUID' CID='notification_CID' selected_users=$notification app_id='report' access_plugin=$plugin}
        </td>
      </tr>
      <tr>
       {if $operator_open}
        <th id="allow_operator">{capture name='grn_report_allow_operator'}{cb_msg module='grn.report' key='allow_operator' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_report_allow_operator necessary=true}</th><td>{capture name='grn_report_only_creator'}{cb_msg module='grn.report' key='only_creator' replace='true'}{/capture}{grn_radio name="operator-set" id="operator-set1" value="0" caption=$smarty.capture.grn_report_only_creator checked=0 onclick='display_off(\'operator_select\')'}{capture name='grn_report_set_operator'}{cb_msg module='grn.report' key='set_operator' replace='true'}{/capture}{grn_radio name="operator-set" id="operator-set2" value="1" checked=1 caption=$smarty.capture.grn_report_set_operator onclick='display_on(\'operator_select\')'}</td>
       {else}
        <th id="allow_operator">{capture name='grn_report_allow_operator'}{cb_msg module='grn.report' key='allow_operator' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_report_allow_operator necessary=true}</th><td>{capture name='grn_report_only_creator'}{cb_msg module='grn.report' key='only_creator' replace='true'}{/capture}{grn_radio name="operator-set" id="operator-set1" value="0" caption=$smarty.capture.grn_report_only_creator checked=1 onclick='display_off(\'operator_select\')'}{capture name='grn_report_set_operator'}{cb_msg module='grn.report' key='set_operator' replace='true'}{/capture}{grn_radio name="operator-set" id="operator-set2" value="1" checked=0 caption=$smarty.capture.grn_report_set_operator onclick='display_on(\'operator_select\')'}</td>
       {/if}
      </tr>
      <tr valign="top" id="operator_select"{if ! $operator_open} style="display:none;"{/if}>
        <th id="report_operators">{cb_msg module='grn.report' key='allow_user' replace='true'}</th>
        <td>{grn_operator_add name="sUID_o" form_name=$form_name operators_list_id="sUID_o" operators_candidate_list_id="operators_candidate_list" member_add_names="member_sUID:notification_sUID" app_id="report" sUID_out_data=$operators selected_operators=$operators candidate_operators=$candidate_operators}</td>
      </tr>
