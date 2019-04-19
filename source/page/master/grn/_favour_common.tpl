{include file='grn/error_handler.tpl'}
{grn_load_javascript file="grn/html/component/favour.js"}
{grn_load_javascript file="fw/yui/build/dragdrop/dragdrop-min.js"}
{literal}
<script type="text/javascript">
<!--
var favour = grn.component.favour;
favour.favour_url = {/literal}'{grn_pageurl page="favour/ajax/command_favour"}'{literal};
favour.spinner = '<img src="' + {/literal}'{$app_path}/grn/image/cybozu/spinner.gif?{$build_date}'{literal} + '" />';
favour.get_favourer_list_url = {/literal}'{grn_pageurl page="favour/ajax/get_favourer_list"}'{literal};
//-->
</script>
{/literal}
<div>
  <div class="subWindowBase-grn" id="favourer_dialog" style="display:none;">
      <table class="subWindowTable-grn">
          <tr id="favourer_dialog_header">
              <td class="subWindowTitleLeft-grn"><div class="subWindowTitleText-grn">{cb_msg module='grn.favour' key='GRN_FAV-4' replace='true'}{grn_favour_app_name}{cb_msg module='grn.favour' key='GRN_FAV-7' replace='true'}</div></td>
              <td class="subWindowTitleRight-grn"><div class="subWindowClose-grn" title="{cb_msg module='grn.grn' key='GRN_GRN-44' replace='true'}" onclick="javascript:favour.closeFavourerDialog();"></div></td>
          </tr>
          <tr>
              <td colspan="2">
                  <div class="subWindowContent-grn favour-favourerListContent-grn" id="favourer_list">
                  </div>
              </td>
          </tr>
      </table>
  </div>
  <div style="height: 15px;"></div>
</div>
