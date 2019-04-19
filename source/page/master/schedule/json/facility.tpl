{php}
$facility = $this->get_template_vars( 'facility' );
$sort = $this->get_template_vars( 'sort' );
if( is_array($facility) && $sort === TRUE )
{
    ksort( $facility );
    $this->assign( 'facility', $facility );
}

$this->assign( 'facility_length', count( $facility ) );
{/php}
[
{assign var='next_facility_count' value=1}
{foreach from=$facility item='data'}
{ldelim}
"id":"{$data._id|escape:javascript}","name":"{$data.col_name|escape:javascript}","code":"{$data.col_foreign_key|escape:javascript}","repeat":"{$data.checkrepeat|escape:javascript}","approval":"{$data.approval_facility|escape:javascript}"
,"ancestors":[
{php}
$data = $this->get_template_vars( 'data' );
$this->assign( 'ancestors_length', count( $data['ancestors'] ) );
{/php}
{assign var='next_ancestors_count' value=1}
{foreach from=$data.ancestors item='ancestor'}
{ldelim}
"id":"{$ancestor._id|escape:javascript}","name":"{$ancestor.col_name|escape:javascript}","code":"{$ancestor.col_foreign_key|escape:javascript}"
{rdelim} {if $next_ancestors_count < $ancestors_length } , {/if} {assign var='next_ancestors_count' value=`$next_ancestors_count+1`}
{/foreach}
]
{rdelim}
 {if $next_facility_count  < $facility_length } , {/if} {assign var='next_facility_count' value=`$next_facility_count+1`}
{/foreach}
]