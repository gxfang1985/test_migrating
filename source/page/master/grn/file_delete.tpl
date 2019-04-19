<input type="hidden" name="fid" value="{$file.id}">
{if strlen($file.title) > 0}
 <p>{cb_msg module='grn.grn' key='GRN_GRN-725' replace='true'}{grn_sentence caption=$file.title image='file20.gif' class='bold'}&nbsp;{cb_msg module='grn.lang' key='file_delete_open_bracket' replace='true'}{$file.filename|escape:"html"}{cb_msg module='grn.grn' key='GRN_GRN-726' replace='true'}
{else}
 <p>{cb_msg module='grn.grn' key='GRN_GRN-727' replace='true'}{grn_sentence caption='('|cat:$file.filename|cat:')' image='file20.gif' class='bold'}{cb_msg module='grn.grn' key='GRN_GRN-728' replace='true'}
{/if}{cb_msg module='grn.grn' key='GRN_GRN-729' replace='true'}
{if $form_name == 'bulletin/file_delete'}
<div class="attention">{cb_msg module='grn.grn' key='GRN_GRN-730' replace='true'}</div>
{/if}
 </p>
{if !$no_button}
 {strip}
  <div class="mTop15 mBottom15">
   {capture name='grn_grn_GRN_GRN_731'}{cb_msg module='grn.grn' key='GRN_GRN-731' replace='true'}{/capture}
   {capture name='grn_grn_GRN_GRN_732'}{cb_msg module='grn.grn' key='GRN_GRN-732' replace='true'}{/capture}
   {grn_button action="submit" spacing="normal" caption=$smarty.capture.grn_grn_GRN_GRN_731}
   {grn_button action="cancel" caption=$smarty.capture.grn_grn_GRN_GRN_732 onclick="history.back()"}
  </div>
 {/strip}
{/if}
