{literal}
<script language="JavaScript" type="text/javascript">
<!--
function add_menu_submit(t)
{
    f = document.forms["{/literal}{$form_name}{literal}"];
    f.target = '_self';
    var tab_item = f.elements['tab'];
    var page_name = f.elements['page_name'];
    page_name.value = t;
    f.action = '{/literal}{grn_pageurl page='schedule/mobile/command_change_page'}{literal}';
    if (t == 'normal')
    {
        if( tab_item )
        {
            tab_item.value = '{/literal}{$page_info.last|escape}{literal}';
        }
    }
    else if (t == 'banner')
    {
        if( tab_item )
        {
            tab_item.value = '{/literal}{$page_info.last|escape}{literal}';
        }
    }
    else if (t == 'repeat')
    {
        if( tab_item )
        {
            tab_item.value = '{/literal}{$page_info.last|escape}{literal}';
        }
    }

    var form = $(f);

    $('input').each(function(){
        if($(this).closest('form').attr('id') != form.attr('id'))
        {
            $(this).appendTo(form)
        }
    });

    $('select').each(function(){
        if($(this).closest('form').attr('id') != form.attr('id'))
        {
            $(this).appendTo(form)
        }
    });

    $('textarea').each(function(){
        if($(this).closest('form').attr('id') != form.attr('id'))
        {
            $(this).appendTo(form)
        }
    });

    // fix GRB-16207
    var file = $('input[type=file]');
    if(file.length > 0)
    {
        var checked = $('input[name=attached_file]').prop('checked');
        if(typeof checked == 'undefined')
        {
            file.remove();
        }
    }

    f.submit();
}

//-->
</script>
{/literal}
<input type="hidden" name="tab" value="">
<input type="hidden" name="page_name" value="">
<input type="hidden" name="bdate" value="{$bdate|escape}">
<input type="hidden" name="uid" value="{$user_id|escape}">
<input type="hidden" name="gid" value="{$group_id|escape}">
<input type="hidden" name="referer_key" value="{$referer_key|escape}">
{if $page_info.last == 'add'}
    {assign var='normal' value='on'}
    {assign var='repeat' value='off'}
    {assign var='banner' value='off'}
{elseif $page_info.last == 'repeat_add'}
    {assign var='normal' value='off'}
    {assign var='repeat' value='on'}
    {assign var='banner' value='off'}
{else}
    {assign var='normal' value='off'}
    {assign var='repeat' value='off'}
    {assign var='banner' value='on'}
{/if}
<div class="mobile_schedulelist_menu_grn mobile-div-title-grn">
    {strip}
    <div class="ui-grid-b">
        <div class="ui-block-a">
            {if $normal == 'off'}
                <a href="javascript:add_menu_submit('normal')">
            {else}
                <span class="mobile_schedulelist_menuhover_grn">
            {/if}
            {cb_msg module='grn.schedule.mobile' key='GRN_SCH_MOBILE-13' replace='true'}
            {if $normal == 'off'}
                </a>
            {else}
                </span>
            {/if}
        </div>
        <div class="ui-block-b">
            {if $banner == 'off'}
                <a href="javascript:add_menu_submit('banner')">
            {else}
                <span class="mobile_schedulelist_menuhover_grn">
            {/if}
            {cb_msg module='grn.schedule.mobile' key='GRN_SCH_MOBILE-14' replace='true'}
            {if $banner == 'off'}
                </a>
            {else}
                </span>
            {/if}
        </div>
        <div class="ui-block-c">
            {if $repeat == 'off'}
                <a {if $before_delete} id="tab-repeat-schedule" href="javascript:void(0);" {else} href="javascript:add_menu_submit('repeat')" {/if}>
            {else}
                <span class="mobile_schedulelist_menuhover_grn">
            {/if}
            {cb_msg module='grn.schedule.mobile' key='GRN_SCH_MOBILE-15' replace='true'}
            {if $repeat == 'off'}
                </a>
            {else}
                </span>
            {/if}
        </div>
    </div>
    {/strip}
</div>
