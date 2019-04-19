{if $portlet.settings.font_size == "large"}
    {assign var="font_size" value='font-size:140%;'}
{elseif $portlet.settings.font_size == "normal"}
    {assign var="font_size" value=''}
{elseif $portlet.settings.font_size == "small"}
    {assign var="font_size" value='font-size:70%;'}
{/if}
<script type="text/javascript">
    {literal}
    function submitMemoForm(element, type) {
        jQuery(element).parents('form').append(jQuery('<input>').attr('name', type).attr('type', 'hidden')).submit();
    }
    {/literal}
</script>

<table class="top_title">{strip}
    <tbody>
    <tr>
        <td>
            <span class="portlet_title_grn">
                <a href="{grn_pageurl page='memo/index'}">{$page_title}</a>
            </span>
        </td>
    </tr>
    </tbody>
</table>{/strip}

<div class="portal_frame portal_frame_memo_grn">
    <form name="memo" method="post" action="{grn_pageurl page='memo/portlet/command_view'}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
        <input type="hidden" name="pid" value="{$portlet.pid}">
        <input type="hidden" name="ppid" value="{$portlet.ppid}">
        <input type="hidden" name="plid" value="{$portlet.plid}">
        <input type="hidden" name="iid" value="{$memo.iid}">
        <input type="hidden" name="did" value="{$portlet.settings.did}">
        <table class="list_column" width="100%">{strip}
            <tr valign="top">
                <th colspan=2>
                    {if $memo.title}{$memo.title|escape}{else}{cb_msg module='grn.memo.portlet' key='GRN_MEM_PO-1' replace='true'}{/if}
                </th>
            </tr>
            <tr>
                <td colspan=2>
                    <textarea class="textarea_grn" name="memo" rows="{$portlet.settings.rows}" style="width:98%">{"\n"}{$memo.data}</textarea>
                </td>
            </tr>
            <tr>
                <td>
                    <div class="mBottom5">
                        <span class="aButtonStandard-grn mRight10">
                            <a href="javascript:void(0)" onclick="submitMemoForm(this, 'clear');return false;">
                                <span>{cb_msg module='grn.memo.portlet' key='GRN_MEM_PO-2' replace='true'}</span>
                            </a>
                        </span>
                        <span class="aButtonStandard-grn">
                            <a href="javascript:void(0)" onclick="submitMemoForm(this, 'restore');return false;">
                                <span>{cb_msg module='grn.memo.portlet' key='GRN_MEM_PO-3' replace='true'}</span>
                            </a>
                        </span>
                    </div>
                </td>
                <td align="right">
                    {capture name='grn_memo_portlet_GRN_MEM_PO_4'}{cb_msg module='grn.memo.portlet' key='GRN_MEM_PO-4' replace='true'}{/capture}
                    {grn_link page='memo/index' caption=$smarty.capture.grn_memo_portlet_GRN_MEM_PO_4 image='folder20.gif' did=$portlet.settings.did}
                </td>
            </tr>
        </table>{/strip}
    </form>
</div> <!--end of portal_frame -->

