{strip}
{capture name='grn_mail_GRN_MAIL_160'}{cb_msg module='grn.mail' key='GRN_MAIL-160' replace='true'}{/capture}
{capture name='grn_mail_GRN_MAIL_162'}{cb_msg module='grn.mail' key='GRN_MAIL-162' replace='true'}{/capture}
{capture name='grn_mail_GRN_MAIL_163'}{cb_msg module='grn.mail' key='GRN_MAIL-163' replace='true'}{/capture}
{capture name='grn_mail_GRN_MAIL_164'}{cb_msg module='grn.mail' key='GRN_MAIL-164' replace='true'}{/capture}
{capture name='grn_mail_GRN_MAIL_165'}{cb_msg module='grn.mail' key='GRN_MAIL-165' replace='true'}{/capture}
{capture name='grn_mail_GRN_MAIL_166'}{cb_msg module='grn.mail' key='GRN_MAIL-166' replace='true'}{/capture}
{capture name='grn_mail_GRN_MAIL_167'}{cb_msg module='grn.mail' key='GRN_MAIL-167' replace='true'}{/capture}
{capture name='grn_mail_GRN_MAIL_455'}{cb_msg module='grn.mail' key='GRN_MAIL-455' replace='true'}{/capture}
{capture name='grn_mail_GRN_MAIL_456'}{cb_msg module='grn.mail' key='GRN_MAIL-456' replace='true'}{/capture}
{if $sort == 'time'}
  {if $category.type == 4}
    {assign var='sort_message' value=$smarty.capture.grn_mail_GRN_MAIL_166}
  {elseif $sort_time == 'dctime'}{* draft create time *}
    {assign var='sort_message' value=$smarty.capture.grn_mail_GRN_MAIL_455}
  {elseif $sort_time == 'mtime'}
    {assign var='sort_message' value=$smarty.capture.grn_mail_GRN_MAIL_456}
  {elseif $sort_time == 'ctime'}
    {assign var='sort_message' value=$smarty.capture.grn_mail_GRN_MAIL_164}
  {elseif $sort_time == 'rtime'}
    {assign var='sort_message' value=$smarty.capture.grn_mail_GRN_MAIL_165}
  {else}
    {assign var='sort_message' value=$smarty.capture.grn_mail_GRN_MAIL_164}
  {/if}
{elseif $sort == 'name' || $sort == 'email'}
  {if $category.type == 3 || $category.type == 2}
    {assign var='sort_message' value=$smarty.capture.grn_mail_GRN_MAIL_163}
  {else}
    {assign var='sort_message' value=$smarty.capture.grn_mail_GRN_MAIL_162}
  {/if}
{elseif $sort == 'subject'}
  {assign var='sort_message' value=$smarty.capture.grn_mail_GRN_MAIL_160}
{elseif $sort == 'size'}
  {assign var='sort_message' value=$smarty.capture.grn_mail_GRN_MAIL_167}
{/if}
<script type="text/javascript">
var S = grn.page.mail.mail_list;
S.status_id = '{$status_id|escape:javascript}';
S.filter = '{$filter|escape:javascript}';
S.reverse = '{$reverse|escape:javascript}';
S.sort = '{$sort_col|escape:javascript}';
</script>
<span class="menu_item_dropdown_grn" id="sort_key">
  <a id="menu_dropdown_sort_target" title="{cb_msg module='grn.mail' key='GRN_MAIL-443' replace='true'}" href="javascript:void(0);" class="list_action_grn action_grn"><span class="vAlignMiddle-grn">{$sort_message}</span><span class="arrow_down_small_icon_grn"></span></a>
  <div class="mail-dropdownContents">
    <ul>
      {if $category.type == 3}{* DRAFT BOX *}
        <li><a href="javascript:void(0);" onclick="jQuery('#menu_dropdown_sort_target span:first').html(jQuery(this).text());S.sortAndFilterMailList('time', 'ctime');">{$smarty.capture.grn_mail_GRN_MAIL_455}</a></li>
        <li><a href="javascript:void(0);" onclick="jQuery('#menu_dropdown_sort_target span:first').html(jQuery(this).text());S.sortAndFilterMailList('time', 'rtime');">{$smarty.capture.grn_mail_GRN_MAIL_456}</a></li>
      {elseif $category.type == 4}{* GARBAGE BOX *}
        <li><a href="javascript:void(0);" onclick="jQuery('#menu_dropdown_sort_target span:first').html(jQuery(this).text());S.sortAndFilterMailList('time');">{$smarty.capture.grn_mail_GRN_MAIL_166}</a></li>
      {else}
        <li><a href="javascript:void(0);" onclick="jQuery('#menu_dropdown_sort_target span:first').html(jQuery(this).text());S.sortAndFilterMailList('time', 'rtime');">{$smarty.capture.grn_mail_GRN_MAIL_165}</a></li>
        <li><a href="javascript:void(0);" onclick="jQuery('#menu_dropdown_sort_target span:first').html(jQuery(this).text());S.sortAndFilterMailList('time', 'ctime');">{$smarty.capture.grn_mail_GRN_MAIL_164}</a></li>
      {/if}

      {if $category.type == 3 || $category.type == 2}{* DRAFT BOX or SENT BOX *}
        <li><a href="javascript:void(0);" onclick="jQuery('#menu_dropdown_sort_target span:first').html(jQuery(this).text());S.sortAndFilterMailList('name');">{$smarty.capture.grn_mail_GRN_MAIL_163}</a></li>
      {else}
        <li><a href="javascript:void(0);" onclick="jQuery('#menu_dropdown_sort_target span:first').html(jQuery(this).text());S.sortAndFilterMailList('name');">{$smarty.capture.grn_mail_GRN_MAIL_162}</a></li>
      {/if}

      <li><a href="javascript:void(0);" onclick="jQuery('#menu_dropdown_sort_target span:first').html(jQuery(this).text());S.sortAndFilterMailList('subject');">{$smarty.capture.grn_mail_GRN_MAIL_160}</a></li>
      <li><a href="javascript:void(0);" onclick="jQuery('#menu_dropdown_sort_target span:first').html(jQuery(this).text());S.sortAndFilterMailList('size');">{$smarty.capture.grn_mail_GRN_MAIL_167}</a></li>
    </ul>
  </div>
</span>
<span class="action_grn" id="sort_reverse">
  <a id="menu_sort_type" title="{cb_msg module='grn.mail' key='GRN_MAIL-457' replace='true'}" href="javascript:void(0);" onclick="S.reverse=(S.reverse == '1') ? '0' : '1'; jQuery('#sort_icon').toggleClass('sortdown_icon_grn sortup_icon_grn');S.sortAndFilterMailList();">
    <span id="sort_icon" class="{if $reverse}sortdown_icon_grn{else}sortup_icon_grn{/if}"></span>
  </a>
</span>
{/strip}