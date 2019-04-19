{*********************************************************
 Need assigns
  @ para:           $spid      Space ID
                    $tid       Thread ID
**********************************************************}
<script language="JavaScript" type="text/javascript">
    <!--
    var dialog_unique_key = "_" +{$spid} +"_" + {$tid}
    var dialog_name = "notification_user_list_dialog" + dialog_unique_key;
    var dialog = grn.component.member_list_dialog.get_dialog(dialog_name);

    jQuery(function () {ldelim}
        jQuery("#follower_list_link").on("click", function () {ldelim}
            {* Close thread menu. *}
            grn.page.space.discussion.index.clickThreadMenu();
            dialog.showDialog("follower_list_link" + dialog_unique_key);
        {rdelim});
    {rdelim});
    //-->
</script>

{capture name='grn_space_GRN_SP_DISC_52'}{cb_msg module='grn.space.discussion' key='GRN_SP_DISC-52' replace='true'}{/capture}
{grn_link id="follower_list_link" script="javascript:void(0);" caption=$smarty.capture.grn_space_GRN_SP_DISC_52 class="icon-follow-grn"}