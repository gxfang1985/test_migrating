{literal}
<script language="javascript" type="text/javascript">
<!--

//-->
</script>
{/literal}
<div class="tab_menu">
 <div class="tab">
{if $select == 1}
  <span class="tab_left_on"></span><span class="tab_on"><a name="#">{grn_image image='user20.gif'}{cb_msg module='grn.grn' key='GRN_GRN-61' replace='true'}</a></span><span class="tab_right_on"></span>
 </div>
 <div class="tab">
  <span class="tab_left_off"></span><span class="tab_off"><a href="{cb_pageurl page=$page_info.all select=0}">{grn_image image='organize20.gif'}{cb_msg module='grn.grn' key='GRN_GRN-62' replace='true'}</a></span><span class="tab_right_off"></span>
 </div>
 <div class="tab">
  <span class="tab_left_off"></span><span class="tab_off"><a href="{cb_pageurl page=$page_info.all select=2}">{grn_image image='role20.gif'}{cb_msg module='grn.grn' key='GRN_GRN-63' replace='true'}</a></span><span class="tab_right_off"></span>
 </div>
{elseif $select == 2}
  <span class="tab_left_off"></span><span class="tab_off"><a href="{cb_pageurl page=$page_info.all select=1}">{grn_image image='user20.gif'}{cb_msg module='grn.grn' key='GRN_GRN-64' replace='true'}</a></span><span class="tab_right_off"></span>
 </div>
 <div class="tab">
  <span class="tab_left_off"></span><span class="tab_off"><a href="{cb_pageurl page=$page_info.all select=0}">{grn_image image='organize20.gif'}{cb_msg module='grn.grn' key='GRN_GRN-65' replace='true'}</a></span><span class="tab_right_off"></span>
 </div>
 <div class="tab">
  <span class="tab_left_on"></span><span class="tab_on"><a name="#">{grn_image image='role20.gif'}{cb_msg module='grn.grn' key='GRN_GRN-66' replace='true'}</a></span><span class="tab_right_on"></span>
 </div>
{else}
  <span class="tab_left_off"></span><span class="tab_off"><a href="{cb_pageurl page=$page_info.all select=1}">{grn_image image='user20.gif'}{cb_msg module='grn.grn' key='GRN_GRN-67' replace='true'}</a></span><span class="tab_right_off"></span>
 </div>
 <div class="tab">
  <span class="tab_left_on"></span><span class="tab_on"><a name="#">{grn_image image='organize20.gif'}{cb_msg module='grn.grn' key='GRN_GRN-68' replace='true'}</a></span><span class="tab_right_on"></span>
 </div>
 <div class="tab">
  <span class="tab_left_off"></span><span class="tab_off"><a href="{cb_pageurl page=$page_info.all select=2}">{grn_image image='role20.gif'}{cb_msg module='grn.grn' key='GRN_GRN-69' replace='true'}</a></span><span class="tab_right_off"></span>
 </div>
{/if}
 <div class="float_right">
  <input type="text" size="20" maxlength="45">&nbsp;<input type="submit" value="&nbsp;{cb_msg module='grn.grn' key='GRN_GRN-70' replace='true'}&nbsp;">
 </div>
</div>
<div class="tab_menu_end">&nbsp;</div>
<table class="select_parts">
 <tr>
  <td nowrap>
{if $select == 1}
   <select size=12 multiple>
    <option>{cb_msg module='grn.grn' key='GRN_GRN-71' replace='true'}(000000)</option>
   </select><br>
   <div class="list">
    <div class="item">
     <div class="contents_navi">{include file="grn/word_navi.tpl"}</div>
    </div>
   </div>
{elseif $select == 2}
   <select size=12 multiple>
    <option>{cb_msg module='grn.grn' key='GRN_GRN-72' replace='true'}</option>
   </select><br>
   <div class="list">
    <div class="item">
     <div class="contents_navi">{include file="grn/word_navi.tpl"}</div>
    </div>
   </div>
{else}
<div id="tree_structure">
 <div class="items">
  <div class="parent">
<hr>
  <div><a href="#">{grn_image image='folder20_fo.gif'}{cb_msg module='grn.grn' key='GRN_GRN-73' replace='true'}</a>&nbsp;</div>
   <div class="child">
   <div id="focus"><a name="#">{grn_image image='folder20_fo.gif'}{cb_msg module='grn.grn' key='GRN_GRN-74' replace='true'}</a>&nbsp;</div>
     <div class="child">
       <div><a href="#">{grn_image image='folder20.gif'}PG</a>&nbsp;</div>
     </div>
       <div><a href="#">{grn_image image='folder20.gif'}{cb_msg module='grn.grn' key='GRN_GRN-75' replace='true'}*</a>&nbsp;</div>
         <div><a href="#">{grn_image image='folder20_f.gif'}{cb_msg module='grn.grn' key='GRN_GRN-76' replace='true'}</a>&nbsp;</div>
      </div>
  </div>
 </div>
 <!-----><div class="br">&nbsp;</div>
</div>
{/if}
   <input class="line" type="button" value="{cb_msg module='grn.grn' key='GRN_GRN-77' replace='true'}"><br>
   <select size=2>
    <option>{cb_msg module='grn.grn' key='GRN_GRN-78' replace='true'}(000000)</option>
   </select>
  </td>
{if $select}
  <td nowrap>
   <select name="yomi_organization_change">
    <option value=0 selected>{cb_msg module='grn.grn' key='GRN_GRN-79' replace='true'}</option>
    <option value=1>{cb_msg module='grn.grn' key='GRN_GRN-80' replace='true'}</option>
   </select>
<div id="tree_structure">
 <div class="items">
  <div class="parent">
{if $category.cid != $category.root_category.cid}
   {grn_structure_link page=$page caption=$category.root_category.title class='folder20_f' cid=$category.root_category.cid}
{/if}
<hr>
{if $category.parent_category.cid != $category.root_category.cid}
  {grn_structure_link page=$page caption=$category.parent_category.title class='folder20_fo' subscribe=$category.parent_category.subscribe cid=$category.parent_category.cid}
   <div class="child">
{elseif $category.parent_category}
   <div class="child">
{/if}
{if $category.child_categories}
   {grn_structure_link page=$page caption=$category.title class='folder20_fo' subscribe=$category.subscribe focus=TURE}
     <div class="child">
 {foreach from=$category.child_categories item=child_category}
      {grn_structure_link page=$page caption=$child_category.title class='folder20' subscribe=$child_category.subscribe cid=$child_category.cid}
 {/foreach}
    </div>
{else}
   {grn_structure_link page=$page caption=$category.title class='folder20' subscribe=$category.subscribe focus=TURE}
{/if}
{if $category.categories}
 {foreach from=$category.categories item=categories}
  {if $categories.child}
    {grn_structure_link page=$page caption=$categories.title class='folder20_f' subscribe=$categories.subscribe cid=$categories.cid}
  {else}
    {grn_structure_link page=$page caption=$categories.title class='folder20' subscribe=$categories.subscribe cid=$categories.cid}
  {/if}
 {/foreach}
{/if}
{if $category.parent_category.cid != $category.root_category.cid}
   </div>
{elseif $category.parent_category}
   </div>
{/if}
  </div>
 </div>
 <!-----><div class="br">&nbsp;</div>
</div>
  </td>
{/if}
 </tr>
</table>
