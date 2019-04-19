<table width="100%" cellspacing="0" cellpadding="4" class="{$year_navi_class}">
 <tr>
  <td class="v-allign-middle" align="left" nowrap width="40%">{grn_user_name uid=$login.id nolink=TURE noimage=TURE}{cb_msg module='grn.schedule' key='GRN_SCH-666' replace='true'}</td>
  <td class="v-allign-middle" align="center" nowrap width="20%"><b>{grn_date_format date=$bdate format="DateFull_Y"}</td>
  <td class="v-allign-middle" align="right" nowrap width="40%">
    <div class="moveButtonBlock-grn">
    {strip}
        <span class="moveButtonBase-grn" title="{cb_msg module='grn.schedule' key='GRN_SCH-668' replace='true'}">
            <a href="{grn_pageurl page=$page_info.all bdate=$bdate_prevyear uid=$schedule.user_id search_text=$search_text}">
                <span class="moveButtonArrowLeft-grn"></span>
            </a>
        </span>
        <span class="moveButtonBase-grn" title="">
            <a href="{grn_pageurl page=$page_info.all uid=$schedule.user_id search_text=$search_text}">
                {cb_msg module='grn.schedule' key='GRN_SCH-669' replace='true'}
            </a>
        </span>
        <span class="moveButtonBase-grn" title="{cb_msg module='grn.schedule' key='GRN_SCH-670' replace='true'}">
            <a href="{grn_pageurl page=$page_info.all bdate=$bdate_nextyear uid=$schedule.user_id search_text=$search_text}">
                <span class="moveButtonArrowRight-grn"></span>
            </a>
        </span>
    {/strip}
    </div>
  </td>
 </tr>
</table>
