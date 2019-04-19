{assign var="is_print_page" value=true}
{include file="grn/head.tpl"}

  <body class="print_body_grn">
    <div id="div_print_setting">
      <table class="table_plain_grn print_action_base_grn">
        <tbody>
          <tr>
            <td nowrap="">
              <table border="0" cellspacing="0" cellpadding="4" width="100%">
                <tbody>
                  <tr>
                    <td nowrap="">
                      <font size="+1">{cb_msg module="grn.memo" key="PRINT_SETTING" replace="true"}</font>
                      <font size="-1">{cb_msg module="grn.memo" key="THIS_AREA_WILL_NOT_BE_PRINTED" replace="true"}</font>
                    </td>
                  </tr>
                </tbody>
              </table>
              <br />
              <table class="formTable">
                <colgroup>
                  <col nowrap>
                  <col nowrap>
                </colgroup>
                <tbody>
                  <tr>
                    <td align="right">{cb_msg module="grn.memo" key="FONT_SIZE" replace="true"}</td>
                    <td>
                      <select onchange="setFontSize(this.value)" id="FontSize">
                        <option value="8pt">8pt</option>
                        <option value="9pt">9pt</option>
                        <option value="10pt">10pt</option>
                        <option value="11pt">11pt</option>
                        <option value="12pt" selected="">12pt</option>
                        <option value="13pt">13pt</option>
                        <option value="14pt">14pt</option>
                        <option value="15pt">15pt</option>
                        <option value="16pt">16pt</option>
                        <option value="17pt">17pt</option>
                        <option value="18pt">18pt</option>
                        <option value="19pt">19pt</option>
                        <option value="20pt">20pt</option>
                      </select>
                      &nbsp;
                    </td>
                  </tr>
                  <tr>
                    <td align="right">{cb_msg module="grn.memo" key="LOCALE_SETTING" replace="true"}</td>
                    <td>
                      <select onchange="setLocale(this.value)" id="Locale">
                        <option value="user">{cb_msg module="grn.memo" key="USER_SETTING" replace="true"}</option>
                        <option value="system">{cb_msg module="grn.memo" key="SYSTEM_SETTING" replace="true"}</option>
                      </select>
                      &nbsp;
                    </td>
                  </tr>
                  <tr>
                    <td align="right"></td>
                    <td>
                      {strip}
                        <div class="mTop10 mBottom5">
                          {capture name='grn_memo_print'}{cb_msg module="grn.memo" key="PRINT" replace="true"}{/capture}
                          {grn_button ui="main" spacing="normal" action="submit" caption=$smarty.capture.grn_memo_print id="print_button_save" onclick="doPrint();return false;" auto_disable=false}

                          {capture name='grn_memo_back'}{cb_msg module="grn.memo" key="BACK" replace="true"}{/capture}
                          {grn_button action="cancel" caption=$smarty.capture.grn_memo_back id="print_button_cancel" page="memo/view" page_param_iid=$item_id}
                        </div>
                      {/strip}
                    </td>
                  </tr>
                </tbody>
              </table>
            </td>
          </tr>
        </tbody>
      </table>      
    </div>
    <div id="view">
      <table border="0" cellspacing="10" cellpadding="0" style="font-size:100%;">
        <tr valign="top" align="left">
          <th colspan="2">{grn_msg_switch module='grn.memo' key='Subject'}</th>
          <td>{$content.title|escape}</td>
        </tr>
        <tr valign="top" align="left">
          <th colspan="2">{grn_msg_switch module='grn.memo' key='Created'}</th>
          <td>{grn_date_format_switch date=$content.ctime format='DateTimeMiddle_YMDW_HM'}</td>
        </tr>
        <tr valign="top" align="left">
          <th colspan="2">{grn_msg_switch module='grn.memo' key='Updated'}</th>
          <td>{grn_date_format_switch date=$content.mtime format='DateTimeMiddle_YMDW_HM'}</td>
        </tr>
      </table>
      <hr noshade> 
      {grn_format body=$content.data}
      <br>
      {foreach from=$content.files item=file}
      <br>
      {grn_attach_file_link fid=$file.id dpage="memo/attached_file_download" vpage="memo/attached_file_view" name=$file.name mime=$file.mime did=$folder_id iid=$item_id inline=$inline disabled=true hash=$file.hash}
      {/foreach}
    </div>
