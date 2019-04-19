{* this template is included from set_**.tpl *}
 <form name="{$form_name}_type" id="data_type_change_form" method="post"
       action="{grn_pageurl page=$page_prefix|cat:$page_info.last}" enctype="multipart/form-data">
     <input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
     {if $display != 'add' && $display != 'modify'}
         <input type="hidden" name="cid" value="{$category_id}">
         <input type="hidden" name="fid" value="{$form_id}">
         {else}
         <input type="hidden" name="rid" value="{$report_id}">
     {/if}
     <input type="hidden" name="iid" value="{$item.iid}">
     <input type="hidden" name="display" value="{$display}">
     <input type="hidden" name="data_type" value="">
</form>
<script>
     {literal}
     jQuery(document).ready(function(){
         var data_type_class = "{/literal}{$data_type_class}{literal}";
         jQuery("." + data_type_class).change(function(){
             var form = jQuery("#data_type_change_form");
             jQuery("input[name='data_type']").val(this.value);
             form.submit();
         });
     });
     {/literal}
 </script>