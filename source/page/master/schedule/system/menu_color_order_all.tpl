{include file="grn/system_head.tpl"}
{include file="grn/system_header.tpl"}
{grn_load_javascript file="fw/jquery/jquery-3.2.1.min.js"}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var="form_name" value=$smarty.template|basename}
{literal}
<script type="text/javascript">
<!--
/*htvs
This is a logic repare data before submit to server,
this is fixbug grn2-8064 because in the case text is xss, the plugin "change_order " builder option element of select is wrong, then this is good logic
*/
jQuery.noConflict();
(function($){
    $(document).ready(function(){
        $.each($("select option"), function(key, value){
            var ob = $(this);
            ob.val($.trim(ob.text()) + ob.val());
        })
    });
})(jQuery);
//-->
</script>
{/literal}
<form name="{$form_name}" method="post" action="{grn_pageurl page='schedule/system/command_menu_color_order_all'}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
{include file="schedule/_menu_color_order.tpl" form_name=$form_name}
</form>
{include file="grn/system_footer.tpl"}
