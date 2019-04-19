{foreach from=$space_user_list item=space_user}
    <li {if $space_user.id === $user_id}class="hilight"{/if}>
        {if $space_user.id == $login_id}
            {assign var='image' value='loginuser20.gif'}
        {elseif $space_user.id == 0}
            {assign var='image' value=''}
        {elseif $space_user.inactive_user == true}
            {assign var='image' value='invaliduser20.gif'}
        {elseif $space_user.using_space != true}
            {assign var='image' value='invalid_app_user20.png'}
        {else}
            {assign var='image' value='user20.gif'}
        {/if}
        {grn_link page='space/application/todo/index' image=$image br=true caption=$space_user.name spid=$space_id tid=$thread_id uid=$space_user.id search_text=$search_text search_bits=$search_bits}
        <span class="space-todoLeft-number-grn">{cb_msg module='grn.space.todo' key='GRN_SP_TOD-45' replace='true'}{$space_user.incomplete_count.count}{cb_msg module='grn.space.todo' key='GRN_SP_TOD-60' replace='true'}</span>
        <div class="space-todoStatusBarBase-grn">
            <div class="space-todoStatusBarSideLate-grn" style="width:{$space_user.incomplete_count.late/$max_count_user_incomplete_todo*188}px"></div>
            <div class="space-todoStatusBarSideToday-grn" style="width:{$space_user.incomplete_count.today/$max_count_user_incomplete_todo*188}px"></div>
            <div class="space-todoStatusBarSideInTerm-grn" style="width:{$space_user.incomplete_count.inTerm/$max_count_user_incomplete_todo*188}px"></div>
            <div class="space-todoStatusBarSideNoTerm-grn" style="width:{$space_user.incomplete_count.noTerm/$max_count_user_incomplete_todo*188}px"></div>
        </div>
    </li>
{/foreach}