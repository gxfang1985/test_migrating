<card {grn_attr name="book_id" value=$card.book_id require=true} {grn_attr name="id" value=$card.cid require=true}
 {grn_attr name="version" value=$card.version require=true} xmlns:card="http://schemas.cybozu.co.jp/address/2008">
  <card:creator {grn_attr name="user_id" value=$card.creator} {grn_attr name="name" value=$card.creator_name require=true} 
  {grn_attr name="date" value=$card.ctime require=true} />
  
  <card:modifier {grn_attr name="user_id" value=$card.modifier} {grn_attr name="name" value=$card.modifier_name require=true}
  {grn_attr name="date" value=$card.mtime require=true} />
  
  <card:subject>{grn_papi_text_format value=$card.subject}</card:subject>
  
  {if $card.builtin_items.personal_name.use && ( 0 < strlen( $card.family_name ) || 0 < strlen( $card.given_name ) ) }
    <card:personal_name>
        <card:part>{grn_papi_text_format value=$card.family_name}</card:part>
        <card:part>{grn_papi_text_format value=$card.given_name}</card:part>
    </card:personal_name>
  {/if}
  
  {if $card.builtin_items.personal_sort_key.use && ( 0 < strlen( $card.family_sort_key ) || 0 < strlen( $card.given_sort_key ) )}
    <card:personal_reading>
        <card:part>{grn_papi_text_format value=$card.family_sort_key}</card:part>
        <card:part>{grn_papi_text_format value=$card.given_sort_key}</card:part>
    </card:personal_reading>
  {/if}
  
  {if $card.builtin_items.company_name.use && 0 < strlen( $card.company_name )}
  <card:company_name>{grn_papi_text_format value=$card.company_name}</card:company_name>
  {/if}
  
  {if $card.builtin_items.company_sort_key.use && 0 < strlen( $card.company_sort_key )}
  <card:company_reading>{grn_papi_text_format value=$card.company_sort_key}</card:company_reading>
  {/if}
  
  {if $card.builtin_items.section_name.use && 0 < strlen( $card.section_name )}
  <card:section>{grn_papi_text_format value=$card.section_name}</card:section>
  {/if}
  
  {if $card.builtin_items.zip_code.use && 0 < strlen( $card.zip_code )}
  <card:zip_code>{grn_papi_text_format value=$card.zip_code}</card:zip_code>
  {/if}
  
  {if $card.builtin_items.physical_address.use && 0 < strlen( $card.physical_address )}
  <card:physical_address>{grn_papi_text_format value=$card.physical_address}</card:physical_address>
  {/if}
  
  {if $card.builtin_items.map.use && 0 < strlen( $card.map )}
  <card:map>{grn_papi_text_format value=$card.map}</card:map>
  {/if}
  
  {if $card.builtin_items.route.use && ( 0 < strlen( $card.route ) || 0 < strlen( $card.route_time ) || 0 < strlen( $card.route_fare ) )}
  <card:route>
    {if 0 < strlen( $card.route )}
    <card:path>{grn_papi_text_format value=$card.route}</card:path>
    {/if}
    {if 0 < strlen( $card.route_time )}
    <card:time>{grn_papi_text_format value=$card.route_time}</card:time>
    {/if}
    {if 0 < strlen( $card.route_fare )}
    <card:fare>{grn_papi_text_format value=$card.route_fare}</card:fare>
    {/if}
  </card:route>
  {/if}
  
  {if $card.builtin_items.company_telephone_number.use && 0 < strlen( $card.company_telephone_number )}
  <card:company_tel>{grn_papi_text_format value=$card.company_telephone_number}</card:company_tel>
  {/if}
  
  {if $card.builtin_items.facsimile_number.use && 0 < strlen( $card.facsimile_number )}
  <card:company_fax>{grn_papi_text_format value=$card.facsimile_number}</card:company_fax>
  {/if}
  
  {if $card.builtin_items.url.use && 0 < strlen( $card.url )}
  <card:url>{grn_papi_text_format value=$card.url}</card:url>
  {/if}
  
  {if $card.builtin_items.post_name.use && 0 < strlen( $card.post_name )}
  <card:post>{grn_papi_text_format value=$card.post_name}</card:post>
  {/if}
  
  {if $card.builtin_items.personal_telephone_number.use && 0 < strlen( $card.personal_telephone_number )}
  <card:personal_tel>{grn_papi_text_format value=$card.personal_telephone_number}</card:personal_tel>
  {/if}
  
  {if $card.builtin_items.email_address.use && 0 < strlen( $card.email_address )}
  <card:email>{grn_papi_text_format value=$card.email_address}</card:email>
  {/if}
  
  {if $card.builtin_items.image.use && count($card.image) > 0 }
  <card:image {grn_attr name="name" value=$card.image.name require=true} {grn_attr name="file_id" value=$card.image.oid require=true} {grn_attr name="size" value=$card.image.size}  
  {grn_attr name="mime_type" value=$card.image.mime}/>
  {/if}
  
  {if $card.builtin_items.description.use && 0 < strlen( $card.description )}
  <card:description>{grn_papi_text_format value=$card.description}</card:description>
  {/if}
  
  {if is_array($card.extended_items)&& count($card.extended_items) > 0 }
  <card:custom>
  {foreach from=$card.extended_items key=item_id item=item}
    {if $item.use}
          {if $item.type == GRN_ADDRESS_ITEM_URL}
            {* URL *}
            <card:url image="false" {grn_attr name="field_code" value=$item.id require=true}>{grn_papi_text_format value=$card.$item_id}</card:url>
          {elseif $item.type == GRN_ADDRESS_ITEM_IMAGE_URL}
            {* 画像URL *}
            <card:url image="true" {grn_attr name="field_code" value=$item.id require=true}>{grn_papi_text_format value=$card.$item_id}</card:url>
          {elseif $item.type == GRN_ADDRESS_ITEM_EMAIL_ADDRESS}
            {* E-Mailアドレス *}        
            <card:email {grn_attr name="field_code" value=$item.id require=true}>{grn_papi_text_format value=$card.$item_id}</card:email>   
          {elseif $item.type == GRN_ADDRESS_ITEM_FILE}
            {* ファイル *} 
            <card:file {grn_attr name="field_code" value=$item.id require=true} {grn_attr name="name" value=$card.$item_id.name require=true} 
                                                            {grn_attr name="file_id" value=$card.$item_id.oid require=true} 
                                                            {grn_attr name="size" value=$card.$item_id.size} 
                                                            {grn_attr name="mime_type" value=$card.$item_id.mime}/>
          {elseif $item.type == GRN_ADDRESS_ITEM_IP_PHONE}
            {* IP電話 *}
            <card:ipphone {grn_attr name="field_code" value=$item.id require=true}>{grn_papi_text_format value=$card.$item_id}</card:ipphone>
          {elseif $item.type == GRN_ADDRESS_ITEM_MULTIPLE_STRING}
            {* 複数行文字列 *}
            <card:text {grn_attr name="field_code" value=$item.id require=true}>{grn_papi_text_format value=$card.$item_id}</card:text>
         {else}
            {* 1行文字列 *}
            <card:string {grn_attr name="field_code" value=$item.id require=true}>{grn_papi_text_format value=$card.$item_id}</card:string>
         {/if}
    {/if}
  {/foreach}
  </card:custom>
  {/if}
  
</card>
