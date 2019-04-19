{strip}
<div class="cloudHeader-service-grn">
    <div class="cloudHeader-service-inner-grn">
        <ul>
            {if $slash_available.office}
                <li class="cloudHeader-service-office-grn">
                    <a href="/o/" title="{cb_msg module='grn' key='HEADER_LINK_OFFICE' replace='true'}"
                       aria-label="{cb_msg module='grn' key='HEADER_LINK_OFFICE' replace='true'}"></a>
                </li>
            {/if}
            {if $slash_available.kintone}
                <li class="cloudHeader-service-kintone-grn">
                    <a href="/k/" title="{cb_msg module='grn' key='HEADER_LINK_KINTONE' replace='true'}"
                       aria-label="{cb_msg module='grn' key='HEADER_LINK_KINTONE' replace='true'}"></a>
                </li>
            {/if}
            {if $slash_available.mailwise}
                <li class="cloudHeader-service-mailwise-grn">
                    <a href="/m/" title="{cb_msg module='grn' key='HEADER_LINK_MW' replace='true'}"
                       aria-label="{cb_msg module='grn' key='HEADER_LINK_MW' replace='true'}"></a>
                </li>
            {/if}
        </ul>
    </div>
</div>
{/strip}