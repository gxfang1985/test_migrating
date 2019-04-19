{grn_load_javascript file="grn/html/display_options.js"}
{grn_load_css file="grn/html/display_options.css"}
<script type="text/javascript" language="javascript">
<!--
{literal}
GRN_DisplayOptions['options'] = GRN_DisplayOptionFactory.create();

GRN_DisplayOptions['options'].setPage('options');
GRN_DisplayOptions['options'].setCSRFTicket('options');
GRN_DisplayOptions['options'].setListID('options');
GRN_DisplayOptions['options'].setPLID('options');
jQuery(document).ready(function(){
    GRN_DisplayOptions['options'].init();
});
{/literal}
//-->
</script>

<span class="display_options">
    <span><a id="display_options_switchoptions" href="javascript:void(0);">{grn_image image='image-common/menu20.png'}{cb_msg module='grn.schedule' key='display_options' replace='true'}<span id="display_options_down_allowoptions">{grn_image class="menu_arrow_grn" image='arrow_down_single_gray.gif'}</span><span id="display_options_up_allowoptions" style="display:none;">{grn_image class="menu_arrow_grn" image='arrow_up_single_gray.gif'}</span></a></span>
    <span id="display_options_dialogoptions" class="display_options_dialog" style="display:none;">
      <ul>
        {if $mail_automation_available}
        {strip}
            <li class="display_options_dialog_ch">
                <a href="{grn_pageurl page="mail/personal/automation" accountId=$category.aid}">
                    {grn_image image="mail20_f.gif"}
                    {cb_msg module='grn.mail' key='GRN_MAIL-469' replace='true'}
                </a>
            </li>
        {/strip}
        {/if}
        {if ! $only_one_layout}
          <li class="display_options_dialog_ch">
            <form name="change_pane" id="change_pane" method="post" action="{grn_pageurl page='mail/command_change_pane'}">
              <input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
              <input type="hidden" name="pane" value="3">
              <input type="hidden" name="aid" value="{$category.aid}">
            </form>
            <a href="javascript:void(0);" onclick="javascript:jQuery('#change_pane').submit()">
              {grn_image image="image-common/3paine20.png"}{cb_msg module='grn.mail' key='GRN_MAIL-429' replace='true'}
            </a>
          </li>
        {/if}
        {if $category.type neq '3'}
            <li><div class="border_partition_pulldown_grn"></div></li>
            <li class="display_options_dialog_ch">
              <a id="lnk_delete_multi_files" href="javascript:void(0);" style="display: none">
                  {grn_image image="delete20.gif"}{cb_msg module='grn.mail' key='GRN_MAIL-475' replace='true'}
              </a>
              <span class="nowrap-grn" id="lnk_delete_multi_files_disable">
                  <span>
                      {grn_image image="delete20.gif"}{cb_msg module='grn.mail' key='GRN_MAIL-475' replace='true'}
                  </span>
              </span>
            </li>
            <li><div class="border_partition_pulldown_grn"></div></li>
        {/if}
        <li class="display_options_dialog_ch">{capture name='grn_mail_GRN_MAIL_148'}{cb_msg module='grn.mail' key='GRN_MAIL-148' replace='true'}{/capture}{grn_link page='mail/delete_all' caption=$smarty.capture.grn_mail_GRN_MAIL_148 image='delete20.gif' script='javascript:void(0);' id="lnk_delete_all"}
        </li>
      </ul>
    </span>
    <iframe id="iframe-breadcrumboptions" class="iframe-breadcrumb" style="display:none;" src=""></iframe>
</span>



