{include file="cbpapi/header.tpl"}

    <base:{$action}Response>
      <returns>
{foreach from=$users item=user}        
        <user key="{$user.attributes.key}" version="{$user.attributes.version}"
            {grn_attr name="order" value=$user.attributes.order}
            {if $user.builtin_items.foreign_key.use && $user.builtin_items.foreign_key.show}
                {grn_attr name="login_name" value=$user.attributes.login_name}
            {/if}
            {if $user.builtin_items.display_name.use && $user.builtin_items.display_name.show}
                {grn_attr name="name" value=$user.attributes.name}
            {/if}
            {grn_attr name="status" value=$user.attributes.status}
            {if $user.builtin_items.sort_key.use && $user.builtin_items.sort_key.show}
                {grn_attr name="reading" value=$user.attributes.reading}
            {/if}
            {if $user.builtin_items.url.use && $user.builtin_items.url.show}
                {grn_attr name="url" value=$user.attributes.url}
            {/if}
            {if $user.builtin_items.email_address.use && $user.builtin_items.email_address.show}
                {grn_attr name="email" value=$user.attributes.email}
            {/if}
            {if $user.builtin_items.telephone_number.use && $user.builtin_items.telephone_number.show}
                {grn_attr name="phone" value=$user.attributes.phone}
            {/if}
            {grn_attr name="birth_date" value=$user.attributes.birth_date}
            
            {if $user.builtin_items.description.use && $user.builtin_items.description.show}
                {grn_attr name="description" value=$user.attributes.description}
            {/if}
            {if $user.builtin_items.post.use && $user.builtin_items.post.show}
                {grn_attr name="title" value=$user.attributes.title}
            {/if}
            {if $user.builtin_items.primary_group.use && $user.builtin_items.primary_group.show}
                {grn_attr name="primary_organization" value=$user.attributes.primary_organization}
            {/if}
            >
            
            {if isset($user.photo) }
                {if $user.builtin_items.image.use && $user.builtin_items.image.show}
                    <photo file_id="{$user.photo.id}" version="{$user.photo.version}" {grn_attr name="name" value=$user.photo.name require=true}
                    {grn_attr name="size" value=$user.photo.size}
                    {grn_attr name="mime_type" value=$user.photo.mime_type} xmlns="http://schemas.cybozu.co.jp/base/2008" >
                    </photo>
                {/if}
            {/if}
            
            {if isset($user.groups)}
                {if $user.builtin_items.usergroups.use && $user.builtin_items.usergroups.show}
                    {foreach from=$user.groups item=group}
                      <organization id="{$group}" xmlns="http://schemas.cybozu.co.jp/base/2008" />
                    {/foreach}
                {/if}
            {/if}
            
        </user>
{/foreach}
      </returns>
    </base:{$action}Response>
    
{include file="cbpapi/footer.tpl"}