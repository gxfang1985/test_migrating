{literal}
<script language="JavaScript" type="text/javascript">
<!--
function PrepareSubmit( form )
{
    var form = document.forms[form.name];
    var src = form.elements['export_item_selected'].options;
    var export_selected_list = form.elements['export_selected_list'];
    var export_item_selected_list = form.elements['export_item_selected_list'];
    export_selected_list.value = '';
    export_item_selected_list.value = '';
    var gdelim = '';
    var udelim = '';
    for( i = 0 ; i < src.length ; i ++ )
    {
        var co = src[i];
        if( ! co.value ) continue;
        
        var co_value = co.value;
        if ( co_value.length > 0 && isFinite( co_value ) )
        {
            export_item_selected_list.value += udelim + co_value;
            udelim = ',';
        }
        else
        {
            export_selected_list.value += gdelim + co_value;
            gdelim = ',';
        }
    }
}

//-->
</script>
 {/literal}

 <tr>
  <th nowrap>
    {cb_msg module='grn.report' key='exported_header' replace='true'}
  </th>
  <td>
   <table>
    <tr>
     <td style="padding-top:0">
        {cb_msg module='grn.report' key='exported_fields' replace='true'}
     </td>
    </tr>
    <tr>
     <td class="item_select" style="padding-bottom:0">
       <select name="export_item_selected" size="13" multiple id="selectbox_selected_export_item" >
        <option value="{$item_first.iid}">{$item_first.display_name|escape}</option>
        <option value="creator">{cb_msg module='grn.report' key='GRN_RPRT-82' replace='true'}</option>
        <option value="ctime">{cb_msg module='grn.report' key='ctime' replace='true'}</option>
        <option value="enable_member">{cb_msg module='grn.report' key='GRN_RPRT-90' replace='true'}</option>
        <option value="enable_partner">{cb_msg module='grn.report' key='outside_parties' replace='true'}</option>
        {foreach from=$item_list item=item_line name=item_list}
            {if !$smarty.foreach.item_list.first}
                <option value="{$item_line.iid}">{$item_line.display_name|escape}</option>
            {/if}
        {/foreach}
        {if $os == 'mac' }
        <option value="">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</option>
        {else}
        <option value="">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</option>
        {/if}
       </select>
<input type="hidden" name="export_selected_list" value="">
<input type="hidden" name="export_item_selected_list" value="">
<input type="hidden" name="export_item_first" value="{$item_first.iid}">
     </td>
    </tr>
   </table>
  </td>
  <td class="item_right_left">
    <input id="btn_add" type="button" value="{cb_msg module='grn.grn' key='GRN_GRN-808' replace='true'}" onClick="MoveOption(this.form , 'export_item', 'export_item_selected', '{$item_index}');"><br><br>
    <input id="btn_rmv" type="button" value="{cb_msg module='grn.grn' key='GRN_GRN-809' replace='true'}" onClick="MoveOption(this.form, 'export_item_selected', 'export_item', '{$item_index}')">
  </td>
  <td>
   <table border="0" cellspacing="0" cellpadding="0">
    <tr>
     <td>
        {cb_msg module='grn.report' key='selecting_fields' replace='true'}
     </td>
     </tr>
    <tr>
    <td>
   <select id="select_export_item" name="export_item" size='13' multiple>
    <option value="enable_follow">{cb_msg module='grn' key='grn.comment' replace='true'}</option>
    {if $os == 'mac' }
    <option value="">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</option>
    {else}
    <option value="">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</option>
    {/if}
   </select>
   </td>
   </tr>
  </table>
 </td>
</tr>

<input type="hidden" name="cid" value="{$cid|escape}">
<input type="hidden" name="fid" value="{$fid|escape}">
<input type="hidden" name="tmp_key" value="{$tmp_key|escape}">
