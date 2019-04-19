<input type="hidden" name="fid" value="{$file.id}">
{cb_msg module='grn.cabinet' key='GRN_CAB-35' replace='true'}<br>
{if strlen($file.title) > 0}
 <p>{grn_sentence caption=$file.title image='file20.gif' class='bold'}&nbsp;({$file.filename|escape:"html"}{cb_msg module='grn.cabinet' key='GRN_CAB-36' replace='true'}
{else}
 <p>{grn_sentence caption='('|cat:$file.filename|cat:')' image='file20.gif' class='bold'}
{/if}
 </p>
 <p>
  {capture name='grn_cabinet_GRN_CAB_37'}{cb_msg module='grn.cabinet' key='GRN_CAB-37' replace='true'}{/capture}{grn_button_submit class='margin' caption=$smarty.capture.grn_cabinet_GRN_CAB_37}
  {capture name='grn_cabinet_GRN_CAB_38'}{cb_msg module='grn.cabinet' key='GRN_CAB-38' replace='true'}{/capture}{grn_button_cancel class="margin" caption=$smarty.capture.grn_cabinet_GRN_CAB_38}
 </p>
