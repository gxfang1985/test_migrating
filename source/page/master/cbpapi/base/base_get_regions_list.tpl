{include file="cbpapi/header.tpl"}

    <base:{$action}Response>
      <returns xmlns:b="http://schemas.cybozu.co.jp/base/2008">
{foreach from=$region_options item=region_option}
        <region name="{$region_option.value}" >
        {foreach from=$region_option.timezone key=key item=city}
            <b:city name="{$city.city}" timezone="{$city.time}" />
        {/foreach}
        </region>
{/foreach}
      </returns>
    </base:{$action}Response>
{include file="cbpapi/footer.tpl"}