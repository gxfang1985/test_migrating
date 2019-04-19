{* 
 * @param portlets the array of portlets
 * @param all_portlets the all portlets
 *}

<script language="javascript" type="text/javascript">
<!--
function grn_select_portlet_group( group_select, portlet_select )
{$smarty.ldelim}
 var len = portlet_select.length;
 for( i = 0 ; i < len - 1 ; i ++ ) {$smarty.ldelim} portlet_select[0] = null; {$smarty.rdelim}
 switch( group_select.value )
 {$smarty.ldelim}
{foreach from=$portlet_group key=plgid item=group}
 case "{$plgid}":
  {foreach from=$portlets.$plgid key=pid item=portlet}
   grn_add_option( portlet_select, "{$pid}", "{$portlet.title|escape}" );
  {/foreach}
  break;
{/foreach}
 default:
  {foreach from=$all_portlets key=pid item=portlet}
   grn_add_option( portlet_select, "{$pid}", "{$portlet.title|escape}" );
  {/foreach}
  break;
 {$smarty.rdelim}
{$smarty.rdelim}
-->
</script>
