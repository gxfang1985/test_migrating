{include file="cbpapi/header.tpl"}

<address:{$action}Response>
    {if $use_personal_book }
        {assign var="use_personal" value="true"}
    {else}
        {assign var="use_personal" value="false"}
    {/if}
    {if $use_shared_book }
        {assign var="use_shared" value="true"}
    {else}
        {assign var="use_shared" value="false"}
    {/if}
    <returns {grn_attr name="attendee_menu" value=$items require=true}
                  {grn_attr name="use_personal_book" value=$use_personal require=true}
                  {grn_attr name="use_shared_book" value=$use_shared require=true} />
</address:{$action}Response>

{include file="cbpapi/footer.tpl"}