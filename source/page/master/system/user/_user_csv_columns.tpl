{capture name='explanation'}
{foreach from=$columns key=counter item=column name=column_num}
   <div class="{if $column->isNew()}new-column{/if}" {if $old && $column->isNew()}style="display:none;"{/if}><span class="bold column-number">{$smarty.foreach.column_num.iteration}.</span>&nbsp;{$column->getName()|escape}</div>
{/foreach}
{/capture}
