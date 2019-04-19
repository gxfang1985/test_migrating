{strip}
<div class="content" style="width: 500px; display: block;">
  <div class="mTop10 mBottom15">
    {if $join_leave_space_page->getAction() === 'join'}
      {cb_msg module='grn.space' key='application-common-24' replace='true'}
    {else}
      {cb_msg module='grn.space' key='application-common-25' replace='true'}
    {/if}
  </div>
  <div class="mBottom20">
    {cb_msg module='grn.space' key='application-common-26' replace='true'}
    <span class="bold_grn break_word_grn">{$join_leave_space_page->getSpaceNameForView()|escape}</span>
  </div>
</div>
<div class="buttonArea-grn">
  <div>
    {capture name='grn_space_application_common_27'}{cb_msg module='grn.space' key='application-common-27' replace='true'}{/capture}
    {grn_button id='join_leave_submit' ui='normal' spacing='normal' auto_disable='true' caption=$smarty.capture.grn_space_application_common_27 onclick="grn.page.space.join_leave.submitDialog(this)"}
    {capture name='grn_space_application_common_28'}{cb_msg module='grn.space' key='application-common-28' replace='true'}{/capture}
    {grn_button id='join_leave_cancel' ui='normal' caption=$smarty.capture.grn_space_application_common_28 onclick="grn.page.space.join_leave.closeDialog()"}
  </div>
</div>
{/strip}