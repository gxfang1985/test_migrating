{foreach from=$books item=book}
    <book {grn_attr name="key" value=$book.bkey require=true}
                {grn_attr name="book_id" value=$book.book_id require=true}
                {grn_attr name="name" value=$book.bname require=true}
                {grn_attr name="type" value=$book.type require=true}
                {grn_attr name="version" value=$book.version require=true}
                xmlns:book="http://schemas.cybozu.co.jp/address/2008"
    >
    <book:form key="dummy" version="999999">
    {foreach from=$book.builtin_items key=item_key item=builtin_item}
    {if $item_key == "personal_sort_key"}
        {assign var="item_key" value="personal_reading"}
    {elseif $item_key == "company_sort_key"}
        {assign var="item_key" value="company_reading"}
    {elseif $item_key == "section_name"}
        {assign var="item_key" value="section"}
    {elseif $item_key == "company_telephone_number"}
        {assign var="item_key" value="company_tel"}
    {elseif $item_key == "facsimile_number"}
        {assign var="item_key" value="company_fax"}
    {elseif $item_key == "post_name"}
        {assign var="item_key" value="post"}
    {elseif $item_key == "personal_telephone_number"}
        {assign var="item_key" value="personal_tel"}
    {elseif $item_key == "email_address"}
        {assign var="item_key" value="email"}
    {/if}
    <book:{$item_key} {grn_attr name="name" value=$builtin_item.display_name require=true}
                            {grn_attr name="field_code" value=$builtin_item.id require=true}
                            {if $builtin_item.use == "1"}
                                {grn_attr name="using" value="true"}
                            {else}
                                {grn_attr name="using" value="false"}
                            {/if}
                            {if $builtin_item.display == "1"}
                                {grn_attr name="listing" value="true"}
                            {else}
                                {grn_attr name="listing" value="false"}
                            {/if}
                            {if $builtin_item.necessary == "1"}
                                {grn_attr name="necessary" value="true"}
                            {else}
                                {grn_attr name="necessary" value="false"}
                            {/if}
                            {if $builtin_item.not_modify == "1"}
                                {grn_attr name="allow_modification" value="false"}
                            {else}
                                {grn_attr name="allow_modification" value="true"}
                            {/if}
                            {grn_attr name="sso_id" value=$builtin_item.sso} 
    />
    {/foreach}
    {if $book.extended_items}
    <book:custom>
    {foreach from=$book.extended_items item=ext_item}
        {if $ext_item.type == GRN_ADDRESS_ITEM_URL}
            {assign var="tag_name" value="url"}
            {assign var="is_image" value="false"}
        {elseif $ext_item.type == GRN_ADDRESS_ITEM_IMAGE_URL}
            {assign var="tag_name" value="url"}
            {assign var="is_image" value="true"}
        {elseif $ext_item.type == GRN_ADDRESS_ITEM_FILE}
            {assign var="tag_name" value="file"}
        {elseif $ext_item.type == GRN_ADDRESS_ITEM_EMAIL_ADDRESS}
            {assign var="tag_name" value="email"}
        {elseif $ext_item.type == GRN_ADDRESS_ITEM_IP_PHONE}
            {assign var="tag_name" value="ipphone"}
        {elseif $ext_item.type == GRN_ADDRESS_ITEM_ATTENDEE}
            {assign var="tag_name" value="menu"}
        {elseif $ext_item.type == GRN_ADDRESS_ITEM_MULTIPLE_STRING}
            {assign var="tag_name" value="text"}
        {else}
            {assign var="tag_name" value="string"}
        {/if}
      <book:{$tag_name} {grn_attr name="name" value=$ext_item.display_name require=true}
                                {grn_attr name="field_code" value=$ext_item.id require=true}
                                {if $ext_item.use == "1"}
                                    {grn_attr name="using" value="true"}
                                {else}
                                    {grn_attr name="using" value="false"}
                                {/if}
                                {if $ext_item.display == "1"}
                                    {grn_attr name="listing" value="true"}
                                {else}
                                    {grn_attr name="listing" value="false"}
                                {/if}
                                {if $ext_item.necessary == "1"}
                                    {grn_attr name="necessary" value="true"}
                                {else}
                                    {grn_attr name="necessary" value="false"}
                                {/if}
                                {if $ext_item.not_modify == "1"}
                                    {grn_attr name="allow_modification" value="false"}
                                {else}
                                    {grn_attr name="allow_modification" value="true"}
                                {/if}
                                {grn_attr name="sso_id" value=$ext_item.sso} 
                                {if $tag_name eq "url"}
                                {grn_attr name="image" value=$is_image require=true}
                                {/if}
      />
    {/foreach}
    </book:custom>
    {/if}
    </book:form>
    <book:cards>
        {foreach from=$book.cards item=card}
        <book:card {grn_attr name="id" value=$card require=true} />
        {/foreach}
    </book:cards>
    </book>
{/foreach}