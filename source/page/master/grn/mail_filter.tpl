<script language="JavaScript">
<!--
idNum = {$filter_set_num};
{literal}
function setSize(i)
{
    var my = i;
    var objName = my.getAttribute('name');
    var typeName = objName.replace(/object_/i,"type_")
    if(my.value == 'SZ')
    {
        var nodeMap = document.getElementsByTagName('select');
        for(i=0;i<nodeMap.length;i++)
        {
            if(i != 0)
            {
                var target = nodeMap[i].getAttributeNode('name');
                if(target.nodeValue == typeName)
                {
                    cfs(nodeMap[i],typeName);
                }
            }
        }
    }
    else
    {
        var cName = 'cfs_'+typeName;
        if(document.getElementById(cName))
        {
            var d = document.getElementById(cName);
            cdf(d,typeName);
        }
    }
}
{/literal}
//-->
</script>
{grn_load_javascript file="grn/html/wmf.js"}
<script language="Javascript" type="text/javascript">
<!--
__op_sb      = "{cb_msg module='grn.grn' key='GRN_GRN-1483' replace='true'}";
__op_fr      = "{cb_msg module='grn.grn' key='GRN_GRN-1484' replace='true'}";
__op_to      = "{cb_msg module='grn.grn' key='GRN_GRN-1485' replace='true'}";
__op_cc      = "{cb_msg module='grn.grn' key='GRN_GRN-1486' replace='true'}";
__op_hd      = "{cb_msg module='grn.grn' key='GRN_GRN-1487' replace='true'}";
__op_sz      = "{cb_msg module='grn.grn' key='GRN_GRN-1488' replace='true'}";
__op_co      = "{cb_msg module='grn.grn' key='GRN_GRN-1489' replace='true'}";
__op_nco     = "{cb_msg module='grn.grn' key='GRN_GRN-1490' replace='true'}";
__op_sa      = "{cb_msg module='grn.grn' key='GRN_GRN-1491' replace='true'}";
__op_nsa     = "{cb_msg module='grn.grn' key='GRN_GRN-1492' replace='true'}";
__op_be      = "{cb_msg module='grn.grn' key='GRN_GRN-1493' replace='true'}";
__op_ge      = "{cb_msg module='grn.grn' key='GRN_GRN-1494' replace='true'}";
__op_le      = "{cb_msg module='grn.grn' key='GRN_GRN-1495' replace='true'}";
__bt_del     = "{cb_msg module='grn.grn' key='GRN_GRN-1496' replace='true'}";
__bt_del_all = "{cb_msg module='grn.grn' key='GRN_GRN-1497' replace='true'}";
//-->
</script>
<div id="fbox">
{if $filter.condition}
 {foreach name=set from=$filter.condition item=condition}
<div id="fdiv{$smarty.foreach.set.iteration}">
<select name="object_{$smarty.foreach.set.iteration}" onchange="setSize(this)">
  {if $condition.object eq 'SB' || $condition.object eq 'FR' || $condition.object eq 'TO' || $condition.object eq 'CC' || $condition.object eq 'HD' || $condition.object eq 'SZ'}
 <option value="SB" {if $condition.object eq 'SB'}selected{/if}>{cb_msg module='grn.grn' key='GRN_GRN-1483' replace='true'}
 <option value="FR" {if $condition.object eq 'FR'}selected{/if}>{cb_msg module='grn.grn' key='GRN_GRN-1484' replace='true'}
 <option value="TO" {if $condition.object eq 'TO'}selected{/if}>{cb_msg module='grn.grn' key='GRN_GRN-1485' replace='true'}
 <option value="CC" {if $condition.object eq 'CC'}selected{/if}>{cb_msg module='grn.grn' key='GRN_GRN-1486' replace='true'}
 <option value="HD" {if $condition.object eq 'HD'}selected{/if}>{cb_msg module='grn.grn' key='GRN_GRN-1487' replace='true'}
 <option value="SZ" {if $condition.object eq 'SZ'}selected{/if}>{cb_msg module='grn.grn' key='GRN_GRN-1488' replace='true'}
  {/if}
</select>
  {if $condition.object eq 'SZ'}
<span id="cfs_type_{$smarty.foreach.set.iteration}"><select name="type_{$smarty.foreach.set.iteration}" class="filter_condition_width">
   {if $condition.type eq 'GE' || $condition.type eq 'LE'}
 <option value="GE" {if $condition.type eq 'GE'}selected{/if}>{cb_msg module='grn.grn' key='GRN_GRN-752' replace='true'}
 <option value="LE" {if $condition.type eq 'LE'}selected{/if}>{cb_msg module='grn.grn' key='GRN_GRN-754' replace='true'}
   {/if}
</select></span>&nbsp;<input type="text" name="text_{$smarty.foreach.set.iteration}" size="40" value="{$condition.value|escape}">
  {else}
<select name="type_{$smarty.foreach.set.iteration}" class="filter_condition_width">
   {if $condition.type eq 'CO' || $condition.type eq 'NCO' || $condition.type eq 'SA' || $condition.type eq 'NSA' || $condition.type eq 'BE'}
 <option value="CO"  {if $condition.type eq 'CO'}selected{/if}>{cb_msg module='grn.grn' key='GRN_GRN-1489' replace='true'}
 <option value="NCO" {if $condition.type eq 'NCO'}selected{/if}>{cb_msg module='grn.grn' key='GRN_GRN-1490' replace='true'}
 <option value="SA"  {if $condition.type eq 'SA'}selected{/if}>{cb_msg module='grn.grn' key='GRN_GRN-1491' replace='true'}
 <option value="NSA" {if $condition.type eq 'NSA'}selected{/if}>{cb_msg module='grn.grn' key='GRN_GRN-1492' replace='true'}
 <option value="BE"  {if $condition.type eq 'BE'}selected{/if}>{cb_msg module='grn.grn' key='GRN_GRN-1493' replace='true'}
   {elseif $condition.type eq 'GE' || $condition.type eq 'LE'}
 <option value="GE" {if $condition.type eq 'GE'}selected{/if}>{cb_msg module='grn.grn' key='GRN_GRN-780' replace='true'}(KB){cb_msg module='grn.grn' key='GRN_GRN-781' replace='true'}
 <option value="LE" {if $condition.type eq 'LE'}selected{/if}>{cb_msg module='grn.grn' key='GRN_GRN-782' replace='true'}(KB){cb_msg module='grn.grn' key='GRN_GRN-783' replace='true'}
   {/if}
</select>&nbsp;<input type="text" name="text_{$smarty.foreach.set.iteration}" size="40" value="{$condition.value|escape}">
  {/if}
  {if $filter_set_num == 1}
<input type="button" value="{cb_msg module='grn.grn' key='GRN_GRN-793' replace='true'}" onClick="javascript:odf('fdiv{$smarty.foreach.set.iteration}')" style="display:none;"></div>
  {else}
<input type="button" value="{cb_msg module='grn.grn' key='GRN_GRN-794' replace='true'}" onClick="javascript:odf('fdiv{$smarty.foreach.set.iteration}')" style="display:;"></div>
  {/if}
 {/foreach}
{else}
<div id="fdiv1">
<select name="object_1" onchange="setSize(this)"><option value="SB">{cb_msg module='grn.grn' key='GRN_GRN-1483' replace='true'}<option value="FR">{cb_msg module='grn.grn' key='GRN_GRN-1484' replace='true'}<option value="TO">{cb_msg module='grn.grn' key='GRN_GRN-1485' replace='true'}<option value="CC">{cb_msg module='grn.grn' key='GRN_GRN-1486' replace='true'}<option value="HD">{cb_msg module='grn.grn' key='GRN_GRN-1487' replace='true'}<option value="SZ">{cb_msg module='grn.grn' key='GRN_GRN-1488' replace='true'}</select>&nbsp;<select name="type_1" class='filter_condition_width'><option value="CO">{cb_msg module='grn.grn' key='GRN_GRN-1507' replace='true'}<option value="NCO">{cb_msg module='grn.grn' key='GRN_GRN-1508' replace='true'}<option value="SA">{cb_msg module='grn.grn' key='GRN_GRN-1509' replace='true'}<option value="NSA">{cb_msg module='grn.grn' key='GRN_GRN-1510' replace='true'}<option value="BE">{cb_msg module='grn.grn' key='GRN_GRN-1511' replace='true'}</select>&nbsp;<input type="text" name="text_1" size="40">&nbsp;<input type="button" value="{cb_msg module='grn.grn' key='GRN_GRN-803' replace='true'}" onClick="javascript:odf('fdiv1')" style="display:none;"></div>
{/if}
</div>
<div class="br">&nbsp;</div>
<input type="button" name="file0" value="{cb_msg module='grn.grn' key='GRN_GRN-804' replace='true'}" onclick="return add();">
<span id="fdel">
{if $filter_set_num != 1}
<span id="delete_all"><input type="button" value="{cb_msg module='grn.grn' key='GRN_GRN-805' replace='true'}" onclick="return adf();" style="display:;"></span>
{/if}
</span>
