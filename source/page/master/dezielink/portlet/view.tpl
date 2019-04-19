<table class="top_title">{strip}
    <tbody>
    <tr>
        <td>
            <span class="portlet_title_grn">
                {$page_title|escape}
            </span>
        </td>
    </tr>
    </tbody>
</table>{/strip}

<div class="portal_frame portal_frame_dezie_grn">
<div id="dz_portlet_{$portlet_id}">
 <table class="list_column"><tr><td style="padding: 1em">{grn_image image="spinner.gif"}{cb_msg module='grn.dezielink.portlet' key='GRN_DZL_PO-1' replace='true'}</td></tr></table>
</div>

<script>
{literal}
function dz_get_portlet_content(dz_url, dz_lib_param, portlet_id)
{
jQuery.ajax(
    dz_url,
    {
        type: 'post',
        data: dz_lib_param,
        success: function(data, textStatus, request)
        {
            // X-Cybozu-{/literal}{cb_msg module='grn.dezielink.portlet' key='GRN_DZL_PO-2' replace='true'}{literal}
            var headers = request.getAllResponseHeaders();
            if(headers.match(new RegExp( /X-Cybozu-Error/i )))
            {
                // display error
                document.write( request.responseText );
                document.close();
                return false;
            }
            // update portlet content
            document.getElementById('dz_portlet_'+portlet_id).innerHTML = request.responseText;
        }
    });
}
{/literal}
{literal}
    jQuery(function (){
{/literal}
    dz_get_portlet_content(
      "{grn_pageurl page='dezielink/portlet/ajax_view'}",
      "plid={$portlet_id}&dz_params="+encodeURIComponent("{$dz_params|escape:javascript}"),
      {$portlet_id});
{literal}
  });
{/literal}
</script>
</div> <!--end of portal_frame -->
