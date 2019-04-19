<script type="text/javascript">
    {literal}
    function submitAddressSearchForm(element, url) {
        var form = jQuery(element).parents('form');
        if (form.find('select').prop('value') == '') {
            form.attr('action', url);
        }
        form.submit();
    }
    {/literal}
</script>

<table class="top_title">{strip}
    <tbody>
    <tr>
        <td>
            <span class="portlet_title_grn">
            {if !$book_id}
                <a href="{grn_pageurl page='address/user_search'}">{$page_title|escape}</a>
            {else}
                <a href="{grn_pageurl page='address/search' bid=$book_id}">{$page_title|escape}</a>
            {/if}
            </span>
        </td>
    </tr>
    </tbody>
</table>{/strip}

<div class="portal_frame portal_frame_address_search_grn">
{if $access.private_address || $access.shared_address}
    <form name="address_search" method="post" action="{grn_pageurl page='address/search'}">
        <table class="list_column" width="100%">{strip}
            <colgroup>
                <col width="5%">
                <col width="95%">
            </colgroup>
            <tr>
                <td nowrap>
                    <div class="sub_title">{cb_msg module='grn.address.portlet' key='GRN_ADDR_PTLT-1' replace='true'}</div>
                </td>
                <td nowrap>
                    {grn_select name='bid' options=$book_options onchange='this.form.st.focus()'}
                </td>
            </tr>
            <tr>
                <td nowrap>
                    <div class="sub_title">{cb_msg module='grn.address.portlet' key='GRN_ADDR_PTLT-2' replace='true'}</div>
                </td>
                <td nowrap>
                    {capture name='user_search'}{grn_pageurl page='address/user_search'}{/capture}
                    {assign var='pageurl' value=$smarty.capture.user_search}
                    <div class="mBottom3">
                        <input name="st" class="input_text_grn mRight3" onKeyPress="if(event.keyCode == 13){literal}{{/literal}submitAddressSearchForm(this, '{$pageurl}');return false;{literal}}{/literal}">
                        <span class="aButtonStandard-grn">
                            <a href="javascript:void(0)" onclick="submitAddressSearchForm(this, '{$pageurl}');return false;">
                                <span>{cb_msg module='grn.address.portlet' key='GRN_ADDR_PTLT-3' replace='true'}</span>
                            </a>
                        </span>
                    </div>
                </td>
            </tr>
        </table>{/strip}
    </form>
{/if}
</div> <!--end of portal_frame -->
