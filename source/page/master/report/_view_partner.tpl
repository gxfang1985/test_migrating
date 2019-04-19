{cb_msg module='grn.report' key='GRN_RPRT-245' replace='true'}{$partners|@count}{cb_msg module='grn.report' key='GRN_RPRT-246' replace='true'}
 {foreach name="partner" from=$partners item=partner}
      <span class="user_grn"><span class="voice">{if ! $partner->isAccessible() || ! $partner->getBookId() || ! $partner->getAddressId() || !$address_available || !$address_available_for_external}<span>{grn_image image='person20.gif'}{$partner->getSubject()|escape}</span>{else}<a href="{grn_pageurl page='address/view' bid=$partner->getBookId() cid=$partner->getAddressId()}"{if $blank} target="_blank"{/if}>{grn_image image='person20.gif'}{$partner->getSubject()|escape}{if strlen($partner->getCompanyName()) > 0}({$partner->getCompanyName()|escape}){/if}</a>{/if}</span></span>
  {if $smarty.foreach.partner.iteration == 10 && $smarty.foreach.partner.total > 10}
      <span id="display_address_partner_close">
      {cb_msg module='grn.report' key='GRN_RPRT-247' replace='true'}
      <span class="nowrap-grn"><small>{cb_msg module='grn.report' key='GRN_RPRT-248' replace='true'}<a href="javascript:void(0);" onclick="display_on_off('display_address_partner_close:display_address_partner_open:display_member_swith_image_open:display_member_swith_image_close');">{cb_msg module='grn.report' key='display_partner' replace='true'}</a>{cb_msg module='grn.report' key='GRN_RPRT-250' replace='true'}</small></span>
      </span>
      <span id="display_address_partner_open" style="display:none">
  {/if}
 {/foreach}
 {if $partners|@count > 10}
      <span class="nowrap-grn"><small>{cb_msg module='grn.report' key='GRN_RPRT-251' replace='true'}<a href="javascript:void(0);" onclick="display_on_off('display_address_partner_close:display_address_partner_open:display_member_swith_image_open:display_member_swith_image_close');">{cb_msg module='grn.report' key='hide_partner' replace='true'}</a>{cb_msg module='grn.report' key='GRN_RPRT-253' replace='true'}</small></span>
      </span>
 {/if}
