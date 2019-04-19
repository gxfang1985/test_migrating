<div id="view">
 <p>{cb_msg module='grn.mail' key='GRN_MAIL-323' replace='true'}</p>
 <ul>
{if $no_setting eq '1' || $no_setting eq '3'}
  <li>{capture name='grn_mail_GRN_MAIL_324'}{cb_msg module='grn.mail' key='GRN_MAIL-324' replace='true'}{/capture}{grn_link caption=$smarty.capture.grn_mail_GRN_MAIL_324 disabled=TRUE}
{/if}
{if $no_setting eq '2' || $no_setting eq '3'}
  <li><span class="bold">{grn_user_name uid=$login.id nolink=1}</span>&nbsp;&nbsp;{cb_msg module='grn.mail' key='GRN_MAIL-325' replace='true'}
{/if}
 </ul>
 <p>{cb_msg module='grn.mail' key='GRMSG_MAIL_4' app_name=$app_name}</p>
<div class="explanation">{cb_msg module='grn.mail' key='GRMSG_MAIL_5' app_name=$app_name}</div>
</div>
<script type="text/javascript" language="javascript">
<!--
{literal}
jQuery(document).ready(function(){
    if ( jQuery( ".move_top_base_grn").length > 0 )
    {
        jQuery( ".move_top_base_grn").remove();
    }
});
{/literal}
//-->
</script>