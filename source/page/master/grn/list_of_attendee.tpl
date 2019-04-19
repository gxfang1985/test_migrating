{$message_start_of_attendee}{$num_of_attendee}{$message_end_of_attendee}
{foreach name='addressee' from=$addressees item=addressee}
     {if isset($addressee.uid) && isset($addressee.name)}
         {capture assign="uid" }{$addressee.uid}{/capture}
         {capture assign="name"}{$addressee.name}{/capture}
     {elseif isset($addressee.id) && isset($addressee.display_name)}
         {capture assign="uid" }{$addressee.id}{/capture}
         {capture assign="name"}{$addressee.display_name}{/capture}
     {/if} 
     <span class="user_grn">{grn_user_name uid=$uid name=$name users_info=$users_info}</span>
 {if $smarty.foreach.addressee.iteration == 10 && $smarty.foreach.addressee.total > 10}
     <span id="{$id_when_list_of_attendee_closed}">
     {$message_when_attendee_is_so_many}
     <span class="nowrap-grn"><small>{$message_of_display_on}<a href="{$execute_open_list_of_attendee_javascript}">{$display_all_of_attendee}</a>{$display_all_of_attendee_end}</small></span>
     </span>
     <span id="{$id_when_list_of_attendee_open}" style="display:none">
 {/if}
{/foreach}
{if $num_of_attendee > 10}
     <span class="nowrap-grn"><small>{$message_of_display_off}<a href="{$execute_close_list_of_attendee_javascript}">{$message_of_display_hide}</a>{$message_of_display_hide_end}</small></span>
     </span>
{/if}

