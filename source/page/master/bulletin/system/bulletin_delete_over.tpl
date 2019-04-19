{include file="grn/system_head.tpl"}
{include file="grn/system_header.tpl"}
{grn_title title=$page_title class=$page_info.parts[0]}
{if ! $articles.delete_numbers}
 <p>
{cb_msg module='grn.bulletin.system' key='GRN_BLLT_SYS-152' replace='true'}
</p>
 <p>
  <input type="button" value="{cb_msg module='grn.bulletin.system' key='GRN_BLLT_SYS-153' replace='true'}" onclick="history.back()">
 </p>
{else}
 {if $delete_continue}
<p>
{cb_msg module='grn.bulletin.system' key='GRN_BLLT_SYS-154' replace='true'}<br>
{cb_msg module='grn.bulletin.system' key='GRN_BLLT_SYS-155' replace='true'}
</p> 
 {/if}
{assign var="form_name" value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='bulletin/system/command_bulletin_delete_over'}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
<p>
{if $category}
{cb_msg module='grn.bulletin.system' key='GRN_BLLT_SYS-156' replace='true'}{grn_sentence caption=$category.name image='category20.gif' class='bold'}{cb_msg module='grn.bulletin.system' key='GRN_BLLT_SYS-157' replace='true'}
{else}
{cb_msg module='grn.bulletin.system' key='GRN_BLLT_SYS-158' replace='true'}{capture name='grn_bulletin_system_GRN_BLLT_SYS_159'}{cb_msg module='grn.bulletin.system' key='GRN_BLLT_SYS-159' replace='true'}{/capture}{grn_sentence caption=$smarty.capture.grn_bulletin_system_GRN_BLLT_SYS_159 image='category20.gif' class='bold'}{cb_msg module='grn.bulletin.system' key='GRN_BLLT_SYS-160' replace='true'}
{/if}
{cb_msg module='grn.bulletin.system' key='GRN_BLLT_SYS-161' replace='true'}{grn_sentence caption=$articles.delete_numbers class='bold'}{cb_msg module='grn.bulletin.system' key='GRN_BLLT_SYS-162' replace='true'}
  <div class="attention">{cb_msg module='grn.bulletin.system' key='GRN_BLLT_SYS-163' replace='true'}</div></p>
 <p>
  {capture name='grn_bulletin_system_GRN_BLLT_SYS_164'}{cb_msg module='grn.bulletin.system' key='GRN_BLLT_SYS-164' replace='true'}{/capture}{grn_button_submit class='margin' caption=$smarty.capture.grn_bulletin_system_GRN_BLLT_SYS_164}
  {capture name='grn_bulletin_system_GRN_BLLT_SYS_165'}{cb_msg module='grn.bulletin.system' key='GRN_BLLT_SYS-165' replace='true'}{/capture}{grn_button_cancel class='margin' caption=$smarty.capture.grn_bulletin_system_GRN_BLLT_SYS_165}
 </p>
<input type="hidden" name="cid" value="{$category_id}">
</form>
{/if}
{include file="grn/system_footer.tpl"}

