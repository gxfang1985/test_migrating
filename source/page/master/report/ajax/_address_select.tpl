<!--menubar-->
<div id="menu_part">
    <div id="smart_rare_menu_part" style="white-space:nowrap;" >
        <input type="text" id="st" name="st" size="20" maxlength="45" value="{$search_text}" onKeyPress="{literal}if(13 == event.keyCode){GRN_ReportAddress.searchAddresses();}{/literal}">&nbsp;
        <input class="small" type="button" id="address_search" name="address_search" value="&nbsp;{cb_msg module='grn.report' key='GRN_RPRT-365' replace='true'}&nbsp;" onclick="GRN_ReportAddress.searchAddresses();">&nbsp;
        {if $search}
        <input class="small" type="button" id="clear_address_search" name="clear_address_search" value="&nbsp;{cb_msg module='grn.report' key='GRN_RPRT-366' replace='true'}&nbsp;" onclick="GRN_ReportAddress.clearSearchAddresses();">
        {/if}
        <input type="hidden" id="st_hidden" name="st_hidden" value="{$search_text}"/>
    </div>
</div>
<!--menubar_end-->
  <div>
    <!-- reading name index -->
    <div class="sub_explanation">&nbsp;{cb_msg module='grn.address' key='GRN_ADDR-253' replace='true'}</div>
    <table id="reading_name_index" border="0" class="margin_bottom" {if ! $personal_sort_key_use}style="visibility:hidden;"{/if}>
      <tr>
        <td>
          <span>[<a href="javascript:void(0);" onclick="GRN_ReportAddress.updateAddressList(GRN_ReportAddress.getSelectedBookId(), 0, -1);">{cb_msg module='grn.report' key='all' replace='true'}</a>]</span>
        </td>
        <td><div id="char_container">&nbsp;</div></td>
      </tr>
      <tr>
        <td></td>
        <td><div id="subchar_container">&nbsp;</div></td>
      </tr>
    </table>

    <!-- reading name index end -->
  </div>
  <input type="hidden" id="selected_char" value="{$selected_char}" />
  <table>
    <tr valign="top">
      <td>
        <div id='selected_partners'>
         {if $init}
          {cb_msg module='grn.report' key='outside_parties' replace='true'}<br />
          <select name="s_uid_to[]" size="15" multiple>
            <option value="">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</option>
          </select>
         {/if}
        </div>
      </td>
      <td valign="middle">
        <input id="address_add" class="row" type="button" name="to_add" value="{cb_msg module='grn.report' key='candidate' replace='true'}" onClick="if( ! grn_is_selected( this.form,'c_uid[]' ) ) return false; GRN_ReportAddress.addSelectedAddresses();"><br><input id="address_remove" class="row" type="button" name="to_delete" value="{cb_msg module='grn.report' key='remove' replace='true'}" onClick="if( ! grn_is_selected( this.form,'s_uid_to[]' ) ) return false; GRN_ReportPartner.removeSelectedOptions('s_uid_to[]');">
      </td>
      <td id="view_part">
        <div id="address_contents_navi" class="contents_navi">
        {include file="report/ajax/word_navi.tpl" navi=$view_set.navi callback_func="GRN_ReportAddress.paging"}
        </div>
<iframe id="spinner-loading-cid" src="{$app_path}/grn/html/space.html?{$build_date}" frameborder="no" style="width:16px; height:16px; position:absolute; margin:3px 0px 0px 3px; display: none"></iframe>
        <select id="c_uid" name="c_uid[]" size="15" multiple>
         {foreach from=$cards item=card}
          {if $card.company_name}
          <option value="{$card._id}">{$card.subject|escape}({$card.company_name|escape})</option>
          {else}
          <option value="{$card._id}">{$card.subject|escape}</option>
          {/if}
         {/foreach}
          <option value="">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</option>
        </select><br />
      </td>
    </tr>
    <tr>
      <td colspan="3">
        <input id="address_apply" type=button value="{cb_msg module='grn.address' key='GRN_ADDR-167' replace='true'}" onClick="GRN_ReportAddress.addAddressesToForm();" />
        <input id="address_cancel" type="button" value="{cb_msg module='grn.address' key='GRN_ADDR-168' replace='true'}" onClick="GRN_ReportAddress.closeAddressDialog();" />
      </td>
    </tr>
  </table>
