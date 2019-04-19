<returns>
{foreach from=$star_for_view item=star}
  <star_data {grn_attr name="id" value=$star.id require=true}
         {grn_attr name="module_id" value=$star.module_id require=true}
         {grn_attr name="item" value=$star.unique_id require=true}
         {grn_attr name="subject" value=$star.subject require=true}
         {grn_attr name="version" value=$star.mtime} />
{/foreach}
</returns>