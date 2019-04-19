{foreach from=$form_list item=f}
       {if $f.type == 1}
        <hr />
       {else}
           {if $from == 'filter'}
               <a href="javascript:;" id="form_link_{$f.id}" class="form_link" onclick="onFormSelect({$f.id});" >{$f.name}</a> 
           {else}
            {if $eid}
                {grn_link page='report/send_form' cid=$category_id fid=$f.id eid=$eid date=$date caption=$f.name}
            {else}
                {grn_link page='report/send_form' cid=$category_id fid=$f.id caption=$f.name}
            {/if}
        {/if}
        <br />
       {/if}
{/foreach}
