{grn_load_javascript file="grn/html/component/validator.js"}
{grn_load_javascript file="grn/html/page/space/discussion/_send.js"}
{literal}
<script language="JavaScript" text="text/javascript">
(function()
{
    var G = grn.page.space.discussion._send;
    G.ERRMSG_TITLE_IS_REQUIRED = '{/literal}{cb_msg module='grn.space.discussion' key='GRN_SP_DISC-2' replace='true'}{literal}';
})();
</script>
{/literal}
 <p>
{include file="grn/show_validation_errors.tpl"}
<div id="FieldToShowErrorMessage"></div>
{include file='grn/indispensable.tpl'}
 <table class="std_form">
  <!--thread_items-->
  <tr>
   <th>{capture name='grn_space_GRN_SP_DISC_1'}{cb_msg module='grn.space.discussion' key='GRN_SP_DISC-1' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_space_GRN_SP_DISC_1 necessary=1} </th>
   <td>{capture name='grn_space_GRN_SP_DISC_2'}{cb_msg module='grn.space.discussion' key='GRN_SP_DISC-2' replace='true'}{/capture}{grn_text necessary=true name="title" id="title" value=$title size="50" disable_return_key=true}</td>
  </tr>
     {if $is_display_folder}
         <tr>
         <th>{cb_msg module='grn.space.discussion' key='GRN_SP_DISC-58' replace='true'}</th>
         <td>
             <select name="did" id="did">
                <option value="-1" >-----</option>
                 {foreach from=$folder_list item=folder}
                     <option value="{$folder->getId()}"
                             {if $folder->getId() == $folder_id}selected{/if}>{$folder->getFolderName()|escape}</option>
                 {/foreach}
             </select>
         </td>
         </tr>
     {/if}
  <tr valign="top">
   <th>{cb_msg module='grn.space.discussion' key='GRN_SP_DISC-3' replace='true'}</th>
   <td>
  {assign var="ed_name" value="thread_data"}
  {assign var="ed_switch_name" value="thread_editor"}
  {include file="grn/richeditor.tpl" html=$html text=$data cols=$config.area_width rows=$config.area_height enable=1 name=$ed_name switch_name=$ed_switch_name class="form_textarea_grn"}
   </td>
  </tr>
  <tr>
   <th>{cb_msg module='grn.space.discussion' key='GRN_SP_DISC-4' replace='true'}</th>
   <td>
      {include file="grn/attach_file.tpl" attached_files=$attach_files}
   </td>
  </tr>
  {if $modify_form}
  <tr>
      <td></td>
      <td>
          {capture name='grn_space_GRN_SP_DISC_60'}{cb_msg module='grn.space.discussion' key='GRN_SP_DISC-60' replace='true'}{/capture}
          <div class="mTop10">{grn_checkbox name='notifyFlag' id='notifyFlag' value='1' checked=1 caption=$smarty.capture.grn_space_GRN_SP_DISC_60}</div>
      </td>
  </tr>
  {/if}
  <tr>
   <td></td>
   <td>
       <div class="mTop10">
           {if ! $modify_form}
           {strip}
               {capture name="grn_space_discussion_GRN_SP_DISC_5"}{cb_msg module='grn.space.discussion' key='GRN_SP_DISC-5' replace='true'}{/capture}
               {grn_button id='buttonSubmit' ui='main' auto_disable=true caption=$smarty.capture.grn_space_discussion_GRN_SP_DISC_5 spacing='normal'}
               {grn_button action='cancel'}
           {/strip}
           {else}
           {strip}
               {capture name="grn_space_discussion_GRN_SP_DISC_6"}{cb_msg module='grn.space.discussion' key='GRN_SP_DISC-6' replace='true'}{/capture}
               {grn_button id='buttonSubmit' ui='main' auto_disable=true caption=$smarty.capture.grn_space_discussion_GRN_SP_DISC_6 spacing='normal'}
               {grn_button action='cancel' page=$cancel_page page_param_spid=$space_id fragment=$fragment}
           {/strip}
           {/if}
       </div>
   </td>
  </tr>
 </table>
 <input type="hidden" name="spid" value="{$space_id}">
 <input type="hidden" name="tid" value="{$thread_id}">
 <input type="hidden" name="tmp_key" value="{$tmp_key}">
<script type="text/javascript">
    grn.page.space.discussion._send.init("buttonSubmit", '{$form_name}');
</script>
 