{include file='grn/system_head.tpl'}
{include file='grn/system_header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}

<div id="main_menu_part">
<span class="menu_item">{capture name='grn_system_logging_GRN_SY_LO_1'}{cb_msg module='grn.system.logging' key='GRN_SY_LO-1' replace='true'}{/capture}{grn_link page='system/logging/log_delete' caption=$smarty.capture.grn_system_logging_GRN_SY_LO_1 image='delete20.gif' lid=$log.id priority=$priority category=$category}</span>
</div>

<p>
<table class="view_table">
 <tr>
  <th nowrap>{cb_msg module='grn.system.logging' key='GRN_SY_LO-2' replace='true'}</th>
  <td>{$log.date->format()|escape}</td>
 </tr>
 <tr>
  <th nowrap>{cb_msg module='grn.system.logging' key='GRN_SY_LO-3' replace='true'}</th>
  <td>{$log.category_msg|escape}</div>
 </tr>
 <tr>
  <th nowrap>{cb_msg module='grn.system.logging' key='GRN_SY_LO-4' replace='true'}</div>
  <td>{$log.priority_msg|escape}</div>
 </tr>
 <tr>
  <th nowrap>{cb_msg module='grn.system.logging' key='GRN_SY_LO-5' replace='true'}</div>
  <td>{$log.msg|escape}</div>
 </tr>
 <tr>
  <th nowrap>{cb_msg module='grn.system.logging' key='GRN_SY_LO-6' replace='true'}</div>
  <td>{$log.user|escape}</div>
 </tr>
 <tr>
  <th nowrap>{cb_msg module='grn.system.logging' key='GRN_SY_LO-7' replace='true'}</div>
  <td>{$log.account|escape}</div>
 </tr>
 <tr>
  <th nowrap>{cb_msg module='grn.system.logging' key='GRN_SY_LO-8' replace='true'}</div>
  <td>{$log.host|escape}</div>
 </tr>
 <tr>
  <th nowrap>{cb_msg module='grn.system.logging' key='GRN_SY_LO-9' replace='true'}</div>
  <td>{$log.ip|escape}</div>
 </tr>
</table>

{include file='grn/system_footer.tpl'}
