{literal}
<script language="JavaScript" type="text/javascript">
<!--
function PrepareSubmit( form )
{
    var form = document.forms[form.name];
    var src = form.elements['export_item'].options;
    var selected_export_base = form.elements['selected_export_base'];
    var selected_export_item = form.elements['selected_export_item'];
    selected_export_base.value = '';
    selected_export_item.value = '';
    var bdelim = '';
    var idelim = '';
    for( i = 0 ; i < src.length ; i ++ )
    {
        var co = src[i];
        if( ! co.value ) continue;

        var co_value = co.value;
        if ( co_value.length > 0 && isFinite( co_value ) )
        {
            selected_export_item.value += idelim + co_value;
            idelim = ':';
        }
        else
        {
            selected_export_base.value += bdelim + co_value;
            bdelim = ':';
        }
    }
}
//-->
</script>
 {/literal}
<table border="0" cellspacing="0">
 <tr>
  <td style="padding-left:0">
   <table border="0" cellspacing="0" cellpadding="0">
    <tr>
     <td class="item_select" style="padding-bottom:0">
      <div>{cb_msg module='grn.workflow.system' key='GRN_WKF_SYS-97' replace='true'}</div>
<!-- export item -->
      <div>
       <select id="export_item" name="export_item" size="13" multiple>
        <option value="no">{cb_msg module='grn.workflow.system' key='petition_csv_no' replace='true'}</option>
        <option value="creator">{cb_msg module='grn.workflow.system' key='petition_csv_creator' replace='true'}</option>
        <option value="creator_login_name">{cb_msg module='grn.workflow.system' key='petition_csv_creator_login_name' replace='true'}</option>
        <option value="creat_date">{cb_msg module='grn.workflow.system' key='petition_csv_creat_date' replace='true'}</option>
        <option value="form_name">{cb_msg module='grn.workflow.system' key='petition_csv_form_name' replace='true'}</option>
        <option value="status">{cb_msg module='grn.workflow.system' key='petition_csv_status' replace='true'}</option>
    {foreach from=$item_list item=item_line}
        <option value="{$item_line.iid}">{$item_line.display_name|escape}</option>
    {/foreach}
        {if $os == 'mac' }
        <option value="">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</option>
        {else}
        <option value="">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</option>
        {/if}
       </select>
<input type="hidden" name="selected_export_base" value="">
<input type="hidden" name="selected_export_item" value="">
      </div>
<!-- export item -->
     </td>
    </tr>
   </table>
  </td>
  <td class="item_right_left">
   <input id="btn_add" type="button" value="{cb_msg module='grn.system.i18n' key='GRN_SY_I18N-4' replace='true'}" onClick="MoveOption(this.form , 'select_item', 'export_item', '{$item_index}');"><br><br>
   <input id="btn_rmv" type="button" value="{cb_msg module='grn.system.i18n' key='GRN_SY_I18N-5' replace='true'}" onClick="MoveOption(this.form, 'export_item', 'select_item', '{$item_index}')">
  </td>
  <td>
   <div>{cb_msg module='grn.workflow.system' key='GRN_WKF_SYS-98' replace='true'}</div>
<!-- select item -->
   <div>
   <select id="select_item" name="select_item" size=13 multiple>
    <option value="path_step">{cb_msg module='grn.workflow.system' key='petition_csv_pathstep' replace='true'}</option>
    {if $os == 'mac' }
    <option value="">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</option>
    {else}
    <option value="">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</option>
    {/if}
   </select>
   </div>
<!-- select item -->
  </td>
 </tr>
</table>