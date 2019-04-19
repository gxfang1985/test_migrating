<div id="tree_structure">
 <div class="items">
{foreach from=$users item=user}
  <div class="parent">
 {if $uid == $user.uid}
  {if $accounts[$user.uid]}
   {capture name='grn_mail_system_GRN_MAIL_SY_89'}{cb_msg module='grn.mail.system' key='GRN_MAIL_SY-89' replace='true'}{/capture}{capture name='grn_mail_system_GRN_MAIL_SY_90'}{cb_msg module='grn.mail.system' key='GRN_MAIL_SY-90' replace='true'}{/capture}{grn_structure_link class='user20' caption=$user.name|cat:$smarty.capture.grn_mail_system_GRN_MAIL_SY_89|cat:$user.account|cat:$smarty.capture.grn_mail_system_GRN_MAIL_SY_90|cat:'*' page=$page_info.all focus=TRUE uid=$user.uid}
  {else}
   {capture name='grn_mail_system_GRN_MAIL_SY_91'}{cb_msg module='grn.mail.system' key='GRN_MAIL_SY-91' replace='true'}{/capture}{capture name='grn_mail_system_GRN_MAIL_SY_92'}{cb_msg module='grn.mail.system' key='GRN_MAIL_SY-92' replace='true'}{/capture}{grn_structure_link class='user20' caption=$user.name|cat:$smarty.capture.grn_mail_system_GRN_MAIL_SY_91|cat:$user.account|cat:$smarty.capture.grn_mail_system_GRN_MAIL_SY_92 page=$page_info.all focus=TRUE uid=$user.uid}
  {/if}
 {else}
  {if $accounts[$user.uid]}
   {capture name='grn_mail_system_GRN_MAIL_SY_93'}{cb_msg module='grn.mail.system' key='GRN_MAIL_SY-93' replace='true'}{/capture}{capture name='grn_mail_system_GRN_MAIL_SY_94'}{cb_msg module='grn.mail.system' key='GRN_MAIL_SY-94' replace='true'}{/capture}{grn_structure_link class='user20' caption=$user.name|cat:' $smarty.capture.grn_mail_system_GRN_MAIL_SY_93|cat:$user.account|cat:$smarty.capture.grn_mail_system_GRN_MAIL_SY_94*' page=$page_info.all uid=$user.uid}
  {else}
   {capture name='grn_mail_system_GRN_MAIL_SY_95'}{cb_msg module='grn.mail.system' key='GRN_MAIL_SY-95' replace='true'}{/capture}{capture name='grn_mail_system_GRN_MAIL_SY_96'}{cb_msg module='grn.mail.system' key='GRN_MAIL_SY-96' replace='true'}{/capture}{grn_structure_link class='user20' caption=$user.name|cat:$smarty.capture.grn_mail_system_GRN_MAIL_SY_95|cat:$user.account|cat:$smarty.capture.grn_mail_system_GRN_MAIL_SY_96 page=$page_info.all uid=$user.uid}
  {/if}
 {/if}
  </div>
{/foreach}
 </div>
 <!-----><div class="br">&nbsp;</div>
</div>
