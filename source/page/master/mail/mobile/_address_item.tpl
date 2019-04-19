{if ! $data_theme}{assign var='data_theme' value='c'}{/if}
{foreach from=$address_list item=address}
  <li data-icon="false" data-theme="{$data_theme}">
    <div class="mobile_contents_detail_grn">{grn_mail_name name=$address}</div>
  </li>
{/foreach}