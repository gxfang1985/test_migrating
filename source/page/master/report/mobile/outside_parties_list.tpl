{foreach from=$partners item=partner}
  <li data-icon="false" class="mobile-list-outside-parties-grn">
    {if ! $partner->isAccessible() || ! $partner->getBookId() || ! $partner->getAddressId() || !$address_available || !$address_available_for_external}
      <span class="mobile-list-outside-parties-text-grn">{$partner->getSubject()|escape}</span>
    {else}
      <a href="{grn_pageurl page='address/view' bid=$partner->getBookId() cid=$partner->getAddressId()}" target="_blank">
        <span class="mobile-list-outside-parties-link-grn">{$partner->getSubject()|escape}{if strlen($partner->getCompanyName()) > 0}({$partner->getCompanyName()|escape}){/if}</span>
      </a>
      <span class="mobile-array-list-grn mobile-array-member-grn"></span>
    {/if}
  </li>
{/foreach}