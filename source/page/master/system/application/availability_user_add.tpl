{include file='grn/system_head.tpl'}
{include file='grn/system_header.tpl'}
{grn_load_javascript file="fw/jquery/jquery-3.2.1.min.js"}
{grn_title title=$page_title class=$page_info.parts[0]}
<script language="JavaScript" type="text/javascript">
    jQuery.noConflict();
</script>
{literal}
<script type="text/javascript">
    <!--
    (function($){
        $(document).ready(function(){
            //page load, default assgin checked
            var value = '';
            var ob = null;
            $('input[type=checkbox]').prop('checked',true);
            $.each($('input[type=checkbox]'), function(id,va){
                ob = $(this);
                if(id!=0){
                    value += "," + ob.val();
                }else{
                    value += ob.val();
                }

            });

        });
    })(jQuery);
    //-->
</script>
{/literal}
{grn_load_javascript file="grn/html/page/system/application/change_allow_application.js"}
<div class="explanation">
{cb_msg module='grn.system.application' key='GRN_SY_AP-64' replace='true'}
<br>
{cb_msg module='grn.system.application' key='GRN_SY_AP-65' replace='true'}
</div>
<p>

{include file='grn/org_user_role_select.tpl' allow_external_setting=$can_use_external_access can_select_role=1 form_name=$smarty.template|basename post_page='system/application/command_availability_user_add' cancel_page='system/application/availability_user_list' json_page='system/org_json'}

{include file="grn/system_footer.tpl"}
