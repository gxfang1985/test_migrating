{php}
// for php5 strict
$use_vars = array('ajax_flag','enable_print','enable_print_week','enable_ical_export','search_form_name','selected_group_type','access','management','user_id');
foreach( $use_vars as $v )
    if( is_null($this->get_template_vars($v)) )
        $this->assign($v,NULL);
{/php}

{if $page_info.last == 'personal_month' && $ajax_flag}
{assign var=bd_func value='cy_um_bd(this);'}
{assign var=rd_func value='cy_um_rd(this);'}
{elseif $page_info.last == 'index' && $ajax_flag}
{assign var=bd_func value='cy_gw_bd(this);'}
{assign var=rd_func value='cy_gw_rd(this);'}
{/if}
{if $page_info.last == 'group_day'}
    {assign var='gday' value='on'}
    {assign var='gweek' value='off'}
    {assign var='pday' value='off'}
    {assign var='pweek' value='off'}
    {assign var='pmonth' value='off'}
    {assign var='pyear' value='off'}
{elseif $page_info.last == 'index'}
    {assign var='gday' value='off'}
    {assign var='gweek' value='on'}
    {assign var='pday' value='off'}
    {assign var='pweek' value='off'}
    {assign var='pmonth' value='off'}
    {assign var='pyear' value='off'}
{elseif $page_info.last == 'personal_day'}
    {assign var='gday' value='off'}
    {assign var='gweek' value='off'}
    {assign var='pday' value='on'}
    {assign var='pweek' value='off'}
    {assign var='pmonth' value='off'}
    {assign var='pyear' value='off'}
{elseif $page_info.last == 'personal_week'}
    {assign var='gday' value='off'}
    {assign var='gweek' value='off'}
    {assign var='pday' value='off'}
    {assign var='pweek' value='on'}
    {assign var='pmonth' value='off'}
    {assign var='pyear' value='off'}
{elseif $page_info.last == 'personal_month'}
    {assign var='gday' value='off'}
    {assign var='gweek' value='off'}
    {assign var='pday' value='off'}
    {assign var='pweek' value='off'}
    {assign var='pmonth' value='on'}
    {assign var='pyear' value='off'}
{elseif $page_info.last == 'personal_year'}
    {assign var='gday' value='off'}
    {assign var='gweek' value='off'}
    {assign var='pday' value='off'}
    {assign var='pweek' value='off'}
    {assign var='pmonth' value='off'}
    {assign var='pyear' value='on'}
{else}
    {assign var='gday' value='off'}
    {assign var='gweek' value='off'}
    {assign var='pday' value='off'}
    {assign var='pweek' value='off'}
    {assign var='pmonth' value='off'}
    {assign var='pyear' value='off'}
{/if}
{if $gid_is_empty}
    {assign var='group_id' value=''}
{/if}
<table class="global_navi_title" cellpadding="0" cellmargin="0" style="padding:0px;">
    <tbody>
        <tr>
            <td width="100%" valign="bottom" nowrap>
                <div class="global_naviAppTitle-grn">
                    {grn_image image="schedule20.gif"}{$app_name}
                </div>
                <div class="global_navi-viewChange-grn">
                    <ul>
                    {strip}<!-- using tag strip to delete all space between tag li-->
                        {if $gday == 'off'}
                            <li>
                                <a class="global_naviBackTab-viewChange-grn viewChangeLeft-grn"
                                   href="{grn_pageurl page='schedule/group_day' event=$event_id bdate=$bdate
                                        gid=$group_id search_text=$search_text p=$selected_group_type}"
                                   {if $ajax_flag}onclick="{$bd_func}"{/if}>
                        {else}
                            <li class="global_naviBack-viewChangeSelect-grn viewChangeLeftSelect-grn">
                                <span>
                        {/if}
                        {cb_msg module='grn.schedule' key='GRN_SCH-660' replace='true'}
                        {if $gday == 'off'}
                                </a>
                        {else}
                                </span>
                        {/if}
                            </li>
                        {if $gweek == 'off'}
                            <li>
                                <a class="global_naviBackTab-viewChange-grn"
                                   href="{grn_pageurl page='schedule/index' event=$event_id bdate=$bdate gid=$group_id
                                        search_text=$search_text p=$selected_group_type}"
                                   {if $ajax_flag}onclick="{$bd_func}"{/if}>
                        {else}
                            <li class="global_naviBack-viewChangeSelect-grn">
                                <span>
                        {/if}
                        {cb_msg module='grn.schedule' key='GRN_SCH-661' replace='true'}
                        {if $gweek == 'off'}
                            </a>
                        {else}
                            </span>
                        {/if}
                            </li>
                        {if $pday == 'off'}
                            <li>
                                <a class="global_naviBackTab-viewChange-grn"
                                   href="{grn_pageurl page='schedule/personal_day'
                                        event=$event_id bdate=$bdate gid=$group_id
                                        search_text=$search_text p=$selected_group_type}"
                                   {if $ajax_flag}onclick="{$bd_func}"{/if}>
                        {else}
                            <li class="global_naviBack-viewChangeSelect-grn">
                                <span>
                        {/if}
                        {cb_msg module='grn.schedule' key='GRN_SCH-662' replace='true'}
                        {if $pday == 'off'}
                                </a>
                        {else}
                                </span>
                        {/if}
                            </li>
                        {if $pweek == 'off'}
                            <li>
                                <a class="global_naviBackTab-viewChange-grn"
                                   href="{grn_pageurl page='schedule/personal_week'
                                        event=$event_id bdate=$bdate gid=$group_id
                                        search_text=$search_text p=$selected_group_type}"
                                   {if $ajax_flag}onclick="{$bd_func}"{/if}>
                        {else}
                            <li class="global_naviBack-viewChangeSelect-grn">
                                <span>
                        {/if}
                        {cb_msg module='grn.schedule' key='GRN_SCH-663' replace='true'}
                        {if $pweek == 'off'}
                                </a>
                        {else}
                                </span>
                        {/if}
                            </li>
                        {if $pmonth == 'off'}
                            <li>
                                <a class="global_naviBackTab-viewChange-grn"
                                   href="{grn_pageurl page='schedule/personal_month' event=$event_id bdate=$bdate
                                        gid=$group_id search_text=$search_text}"
                                   {if $ajax_flag}onclick="{$bd_func}"{/if}>
                        {else}
                            <li class="global_naviBack-viewChangeSelect-grn">
                                <span>
                        {/if}
                        {cb_msg module='grn.schedule' key='GRN_SCH-664' replace='true'}
                        {if $pmonth == 'off'}
                                </a>
                        {else}
                                </span>
                        {/if}
                            </li>
                        {if $pyear == 'off'}
                            <li>
                                <a class="global_naviBackTab-viewChange-grn viewChangeRight-grn"
                                   href="{grn_pageurl page='schedule/personal_year' event=$event_id bdate=$bdate
                                        gid=$group_id search_text=$search_text}"
                                   {if $ajax_flag}onclick="{$bd_func}"{/if}>
                        {else}
                            <li class="global_naviBack-viewChangeSelect-grn viewChangeRightSelect-grn">
                                <span>
                        {/if}
                        {cb_msg module='grn.schedule' key='GRN_SCH-665' replace='true'}
                        {if $pyear == 'off'}
                                </a>
                        {else}
                                </span>
                        {/if}
                            </li>
                    {/strip}
                    </ul>
                </div>
            </td>
            <td align="right" valign="bottom" nowrap>
            </td>
        </tr>
    </tbody>
</table>
