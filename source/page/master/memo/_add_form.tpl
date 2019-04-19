{include file="grn/show_validation_errors.tpl"}
{include file='grn/indispensable.tpl'}
 <p>
 <table class="std_form">
  <!--category_items-->
  <tr>
   <th>{capture name='grn_memo_GRN_MEM_24'}{cb_msg module='grn.memo' key='GRN_MEM-24' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_memo_GRN_MEM_24 necessary=1}</th>
   <td>{capture name='grn_memo_GRN_MEM_25'}{cb_msg module='grn.memo' key='GRN_MEM-25' replace='true'}{/capture}{validate form=$form_name field="title" criteria="notEmpty" message=$smarty.capture.grn_memo_GRN_MEM_25 append="validation_errors"}{grn_text necessary=true name="title" value=$title size="50" disable_return_key=true}</td>
  </tr>
  <tr>
   <th>{capture name='grn_memo_GRN_MEM_26'}{cb_msg module='grn.memo' key='GRN_MEM-26' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_memo_GRN_MEM_26}</th>
   <td><select name="pdid">
        <option value="">{cb_msg module="grn.memo" key="lastest_folder_name"}</option>
       {foreach from=$folder_menu key=id item=title}
        <option value="{$id|escape}"{if $pdid == $id} selected{/if}>{$title|escape}</option>
       {/foreach}</select></td>
  </tr>
  <tr valign="top">
   <th>{capture name='grn_memo_GRN_MEM_27'}{cb_msg module='grn.memo' key='GRN_MEM-27' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_memo_GRN_MEM_27}</th>
   <td>{grn_textarea name="memo" rows="9" value=$memo}</td>
  </tr>

<div id="one_parts">
 <!--action--->
 <div id="action">
  <!----->
   <div class="list">
    <p class="item">
     <div class="title">
      <div class="word">{capture name='grn_memo_GRN_MEM_28'}{cb_msg module='grn.memo' key='GRN_MEM-28' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_memo_GRN_MEM_28 necessary=TRUE}</div>
     </div>
     <div class="contents">
      <div class="word">{capture name='grn_memo_GRN_MEM_29'}{cb_msg module='grn.memo' key='GRN_MEM-29' replace='true'}{/capture}{validate form=$form_name field="title" criteria="notEmpty" message=$smarty.capture.grn_memo_GRN_MEM_29 append="validation_errors"}{grn_text name="title" size="30" value=$title}</div>
     </div>
    </p>
    <p class="item">
     <div class="title">
      <div class="word">{capture name='grn_memo_GRN_MEM_30'}{cb_msg module='grn.memo' key='GRN_MEM-30' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_memo_GRN_MEM_30}</div>
     </div>
     <div class="contents">
      <div class="word">
       <select name="pdid">
        <option value="">---
      {foreach from=$folder_menu key=id item=folder_title}
        <option value="{$id|escape}"{if $id == $pdid} selected{/if}>{$folder_title|escape}
      {/foreach}
       </select>
      </div>
     </div>
    </p>
    <p class="item">
     <div class="title">
      <div class="word">{capture name='grn_memo_GRN_MEM_31'}{cb_msg module='grn.memo' key='GRN_MEM-31' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_memo_GRN_MEM_31}</div>
     </div>
     <div class="contents">
      <div class="word">
       {capture name='grn_memo_GRN_MEM_32'}{cb_msg module='grn.memo' key='GRN_MEM-32' replace='true'}{/capture}{grn_radio name="format" id="0" value="0" caption=$smarty.capture.grn_memo_GRN_MEM_32 checked=TRUE}{capture name='grn_memo_GRN_MEM_33'}{cb_msg module='grn.memo' key='GRN_MEM-33' replace='true'}{/capture}{grn_radio name="format" id="1" value="1" caption=$smarty.capture.grn_memo_GRN_MEM_33}
       {grn_textarea name="data" value=$data rows="15"}
      </div>
     </div>
    </p>
    <p class="item">
     <div class="title">
      <div class="word">{capture name='grn_memo_GRN_MEM_34'}{cb_msg module='grn.memo' key='GRN_MEM-34' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_memo_GRN_MEM_34}</div>
     </div>
     <div class="contents">
      <div class="word">{include file="grn/attach_file.tpl" attached_files=$attached_files}</div>
     </div>
    </p>
    </p>
{*
    <p class="item">
     <div class="title">
      <div class="word">{capture name='grn_memo_GRN_MEM_35'}{cb_msg module='grn.memo' key='GRN_MEM-35' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_memo_GRN_MEM_35}</div>
     </div>
     <div class="contents">
      <div class="word">
       <select name="max_version">
 {foreach from=$version.options item=value}
  {if $max_version == $value }
   {assign var="selected" value="selected"}
  {else}
   {assign var="selected" value=""}
  {/if}
  {if $value == 0}
        <option value="0" {$selected}>{cb_msg module='grn.memo' key='GRN_MEM-36' replace='true'}
  {elseif $value == -1}
        <option value="-1" {$selected}>{cb_msg module='grn.memo' key='GRN_MEM-37' replace='true'}
  {else}
        <option value="{$value}" {$selected}>{$value}
  {/if}
 {/foreach}
       </select>&nbsp;{cb_msg module='grn.memo' key='GRN_MEM-38' replace='true'}</div>
     </div>
    </p>
*}
    <p class="item">
     <div class="contents_button">
      <div class="word">
       {capture name='grn_memo_GRN_MEM_39'}{cb_msg module='grn.memo' key='GRN_MEM-39' replace='true'}{/capture}{grn_button_submit class='margin' caption=$smarty.capture.grn_memo_GRN_MEM_39}
       {grn_button_cancel page="memo/index" did=$folder_id}
      </div>
     </div>
    </p>
   </div>
  <!----->
 </div>
 <!--action_end--->
</div>
<input type="hidden" name="did" value="{$folder_id}">
</form>
{include file="grn/footer.tpl"}
