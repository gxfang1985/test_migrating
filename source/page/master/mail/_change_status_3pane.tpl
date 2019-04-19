{strip}
<span class="menu_item menu_item_dropdown_grn" id="menu_item_change_status">
  <span class="menu_item_disable_grn"><span class="icon_label_grn">{cb_msg module="grn.mail" key="GRN_MAIL-440" replace="true"}</span><span class="arrow_down_small_icon_grn"></span></span>
  <div class="mail-dropdownContents">
    <ul>
        <li><a class="mail-statusNormal-grn" href="javascript:void(0);" onclick="grn.page.mail.mail_3pane.unread()">{cb_msg module="grn.mail" key="GRN_MAIL-465" replace="true"}</a></li>
        <li><a class="mail-statusNormal-grn" href="javascript:void(0);" onclick="grn.page.mail.mail_3pane.read()">{cb_msg module="grn.mail" key="GRN_MAIL-464" replace="true"}</a></li>
      {if $status_infos}
        <li><div class="border_partition_pulldown_grn"></div></li>
      {/if}
      {foreach from=$status_infos item=status}
        <li><a {if $status.class}class="{$status.class}"{else}style="color:#{$status.color}"{/if} href="javascript:void(0);" onclick="grn.page.mail.mail_3pane.changeStatus('{$status.value}', '{$status.class}', '{$status.color}', '{$status.label}')">{$status.label}</a></li>
      {/foreach}
    </ul>
  </div>
</span>
{/strip}