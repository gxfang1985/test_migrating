{include file="grn/head.tpl"}
{include file="grn/header_no_siteposition.tpl"}

{assign var='form_name' value=$smarty.template|basename}
{capture name='address_search'}{cb_plain_msg module='grn/address' key='address_search_button' params=$resources}{/capture}
{include file="address/_title_search.tpl"}

<div class="mainarea mainarea_address_grn">
    <div class="tab_portal">
        <div class="tab_menu">
            <table class="tab" border="0" cellspacing="0" cellpadding="0">
                <tr height="24" style="cursor:default" nowrap>
                    <td class="tab_left_off"></td>
                    <td class="tab_off" style="font-size:11pt" nowrap>
                        <a href="{grn_pageurl page='address/mygroup_list'}">{grn_image image='myaddressgroup20.gif'}{cb_msg module='grn.address' key='GRN_ADDR-56' replace='true'}</a>
                    </td>
                    <td class="tab_right_off" nowrap></td>
                </tr>
            </table>
            <table class="tab" border="0" cellspacing="0" cellpadding="0">
                <tr height="24" style="cursor:default" nowrap>
                    <td class="tab_left_off"></td>
                    <td class="tab_off" style="font-size:11pt" nowrap>
                        <a href="{grn_pageurl page='address/user_list'}">{grn_image image='user20.gif'}{cb_msg module='grn.address' key='GRN_ADDR-57' replace='true'}</a>
                    </td>
                    <td class="tab_right_off" nowrap></td>
                </tr>
            </table>
            {if $access.private_address}
                <table class="tab" border="0" cellspacing="0" cellpadding="0">
                    <tr height="24" style="cursor:default" nowrap>
                        {if $book_id > 0}
                            <td class="tab_left_off"></td>
                            <td class="tab_off" style="font-size:11pt" nowrap>
                                <a id="personal_address_book" href="{grn_pageurl page='address/index' bid=-1}">{grn_image image='person20.gif'}{cb_msg module='grn.address' key="private" application_name=$resources.application_name}</a>
                            </td>
                            <td class="tab_right_off" nowrap></td>
                        {else}
                            <td class="tab_left_on"></td>
                            <td class="tab_on" style="font-size:11pt" nowrap id="personal_address_book">
                                {grn_image image='person20.gif'} {cb_msg module='grn.address' key="private" application_name=$resources.application_name}
                            </td>
                            <td class="tab_right_on" nowrap></td>
                        {/if}
                    </tr>
                </table>
            {/if}
            {if $access.shared_address}
                {foreach from=$books item=book}
                    <table class="tab" border="0" cellspacing="0" cellpadding="0">
                        <tr height="24" style="cursor:default" nowrap>
                            {if $book.oid == $book_id}
                                <td class="tab_left_on"></td>
                                <td class="tab_on" style="font-size:11pt" nowrap>
                                    {grn_image image='person20.gif'}{$book.display_name|escape}
                                </td>
                                <td class="tab_right_on" nowrap></td>
                            {else}
                                <td class="tab_left_off"></td>
                                <td class="tab_off" style="font-size:11pt" nowrap>
                                    <a href="{grn_pageurl page='address/index' bid=$book.oid}">{grn_image image='person20.gif'}{$book.display_name|escape}</a>
                                </td>
                                <td class="tab_right_off" nowrap></td>
                            {/if}
                        </tr>
                    </table>
                {/foreach}
            {/if}
        </div>
        <div class="tab_menu_end"></div>
    </div><!--end of tab_portal-->

    <!--menubar-->
    <div id="menu_part">
        {if $access.add || $access.operation}
        <div id="smart_main_menu_part">
                {if $access.add}
                <span class="menu_item">
                    {capture name='grn_address_GRN_ADDR_51'}{cb_msg module='grn.address' key='GRN_ADDR-51' replace='true'}{/capture}
                    {grn_link page='address/add' caption=$smarty.capture.grn_address_GRN_ADDR_51 image='modify20.gif' bid=$book_id element_id="address_add"}
                </span>
                {/if}
            <span class="menu_item">
                {include file='address/_display_options.tpl'}
            </span>
        </div>
        {/if}
        <div id="smart_rare_menu_part" style="white-space:nowrap;" >
            {if $page_info.last == 'index'}
                {grn_simple_search caption=$smarty.capture.address_search name='st' action='address/search' page='address/search' bid=$book_id}
            {elseif $page_info.last == 'user_list'}
                {capture name='grn_address_GRN_ADDR_192'}{cb_msg module='grn.address' key='GRN_ADDR-192' replace='true'}{/capture}
                {grn_simple_search caption=$smarty.capture.grn_address_GRN_ADDR_192 name='st' action='address/user_search' page='address/user_search'}
            {/if}
        </div>
    </div>
    <!--menubar_end-->

    <form name="{$form_name}" method="post" action="{grn_pageurl page='address/delete_multi'}">
        <input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
        <table class="maincontents_list">
            <tbody>
                <tr>
                    <td class="maincontents_list_td">
                        {if $builtin_items.personal_sort_key.use}
                            <!-- readind name index -->
                            <div class="sub_explanation">&nbsp;{cb_msg module='grn.address' key='GRN_ADDR-253' replace='true'}</div>
                            <table border="0" class="address_filter_grn">
                                <tr>
                                    <td>
                                        <span>[<a href="{grn_pageurl page='address/index' bid=$book_id}">{cb_msg module='grn.address' key='GRN_ADDR-60' replace='true'}</a>]</span>
                                    </td>
                                    <td>
                                        <div id="char_container">&nbsp;</div>
                                    </td>
                                </tr>
                                <tr>
                                    <td></td>
                                    <td><div id="subchar_container">&nbsp;</div></td>
                                </tr>
                            </table>

                            {include file='address/_char_map.tpl'}

                            <script language="javascript">
                                url = "{grn_pageurl page='address/index' bid=$book_id cidx=''}";

                                nameIndex = new CharMap('char_container', 'subchar_container', ''+url+'');
                                nameIndex.writeMasterIndex();

                                {if $selected_char}
                                    CharMap.showSubIndex( '{$selected_char}', 'subchar_container', ''+url+'');
                                {/if}
                            </script>
                            <!-- reading name index end -->
                        {/if}
                        {include file='address/_list.tpl'}
                        <input type="hidden" name="bid" value="{$book_id}">
                    </td>
                </tr>
            </tbody>
        </table><!--end of maincontents_list-->
    </form>

{include file="grn/footer.tpl"}
