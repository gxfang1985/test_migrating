<script language="JavaScript">
<!--
idNum = {$filter_set_num};
//-->
</script>
{grn_load_javascript file="grn/html/mf.js"}
<script>
<!--

__op_sb      = "{cb_msg module='grn.grn' key='GRN_GRN-1471' replace='true'}";
__op_fr      = "{cb_msg module='grn.grn' key='GRN_GRN-1472' replace='true'}";
__op_to      = "{cb_msg module='grn.grn' key='GRN_GRN-1473' replace='true'}";
__op_co      = "{cb_msg module='grn.grn' key='GRN_GRN-1474' replace='true'}";
__op_nco     = "{cb_msg module='grn.grn' key='GRN_GRN-1475' replace='true'}";
__op_sa      = "{cb_msg module='grn.grn' key='GRN_GRN-1476' replace='true'}";
__op_nsa     = "{cb_msg module='grn.grn' key='GRN_GRN-1477' replace='true'}";
__op_be      = "{cb_msg module='grn.grn' key='GRN_GRN-1478' replace='true'}";
__op_ge      = "{cb_msg module='grn.grn' key='GRN_GRN-1479' replace='true'}";
__op_le      = "{cb_msg module='grn.grn' key='GRN_GRN-1480' replace='true'}";
__bt_del     = "{cb_msg module='grn.grn' key='GRN_GRN-1481' replace='true'}";
__bt_del_all = "{cb_msg module='grn.grn' key='GRN_GRN-1482' replace='true'}";

//-->
</script>
<div id="fbox">
{if $filter.condition}
 {foreach name=set from=$filter.condition item=condition}
<div id="fdiv{$smarty.foreach.set.iteration}">
<select name="object_{$smarty.foreach.set.iteration}">
 {if $condition.object == 1}
 <option value="1" selected>{cb_msg module='grn.grn' key='GRN_GRN-1204' replace='true'}
 <option value="2">{cb_msg module='grn.grn' key='GRN_GRN-1205' replace='true'}
 <option value="3">{cb_msg module='grn.grn' key='GRN_GRN-1206' replace='true'}
 {elseif $condition.object == 2}
 <option value="1">{cb_msg module='grn.grn' key='GRN_GRN-1207' replace='true'}
 <option value="2" selected>{cb_msg module='grn.grn' key='GRN_GRN-1208' replace='true'}
 <option value="3">{cb_msg module='grn.grn' key='GRN_GRN-1209' replace='true'}
 {elseif $condition.object == 3}
 <option value="1">{cb_msg module='grn.grn' key='GRN_GRN-1210' replace='true'}
 <option value="2">{cb_msg module='grn.grn' key='GRN_GRN-1211' replace='true'}
 <option value="3" selected>{cb_msg module='grn.grn' key='GRN_GRN-1212' replace='true'}
 {/if}
</select><select name="type_{$smarty.foreach.set.iteration}">
 <option value="1"{if $condition.type == 1} selected{/if}>{cb_msg module='grn.grn' key='GRN_GRN-1213' replace='true'}
 <option value="2"{if $condition.type == 2} selected{/if}>{cb_msg module='grn.grn' key='GRN_GRN-1214' replace='true'}
 <option value="3"{if $condition.type == 3} selected{/if}>{cb_msg module='grn.grn' key='GRN_GRN-1215' replace='true'}
 <option value="4"{if $condition.type == 4} selected{/if}>{cb_msg module='grn.grn' key='GRN_GRN-1216' replace='true'}
 <option value="5"{if $condition.type == 5} selected{/if}>{cb_msg module='grn.grn' key='GRN_GRN-1217' replace='true'}
</select>&nbsp;<input type="text" name="text_{$smarty.foreach.set.iteration}" size="40" value="{$condition.value|escape}">
  {if $filter_set_num == 1}
<input type="button" value="{cb_msg module='grn.grn' key='GRN_GRN-1218' replace='true'}" onClick="javascript:odf('fdiv{$smarty.foreach.set.iteration}')" style="display:none;"></div>
  {else}
<input type="button" value="{cb_msg module='grn.grn' key='GRN_GRN-1219' replace='true'}" onClick="javascript:odf('fdiv{$smarty.foreach.set.iteration}')" style="display:;"></div>
  {/if}
 {/foreach}
{else}
<div id="fdiv1">
<select name="object_1"><option value="1">{cb_msg module='grn.grn' key='GRN_GRN-1220' replace='true'}<option value="2">{cb_msg module='grn.grn' key='GRN_GRN-1221' replace='true'}<option value="3">{cb_msg module='grn.grn' key='GRN_GRN-1222' replace='true'}</select><select name="type_1"><option value="1">{cb_msg module='grn.grn' key='GRN_GRN-1507' replace='true'}<option value="2">{cb_msg module='grn.grn' key='GRN_GRN-1508' replace='true'}<option value="3">{cb_msg module='grn.grn' key='GRN_GRN-1509' replace='true'}<option value="4">{cb_msg module='grn.grn' key='GRN_GRN-1510' replace='true'}<option value="5">{cb_msg module='grn.grn' key='GRN_GRN-1511' replace='true'}</select>&nbsp;<input type="text" name="text_1" size="40">&nbsp;<input type="button" value="{cb_msg module='grn.grn' key='GRN_GRN-1228' replace='true'}" onClick="javascript:odf('fdiv1')" style="display:none;"></div>
{/if}
</div>
<div class="br">&nbsp;</div>
<input type="button" name="file0" value="{cb_msg module='grn.grn' key='GRN_GRN-804' replace='true'}" onclick="return add();">
<span id="fdel">
{if $filter_set_num != 1}
<span id="delete_all"><input type="button" value="{cb_msg module='grn.grn' key='GRN_GRN-1230' replace='true'}" onclick="return adf();" style="display:;"></span>
{/if}
</span>
