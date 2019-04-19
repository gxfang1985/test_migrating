<input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
<table class="std_form">
 <tr>
  <th nowrap>{cb_msg module='grn.system.user' key='GRN_SY_US-496' replace='true'}</th>
  <td>{grn_charset name="charset" bom='TURE'}</td>
 </tr>
 <tr>
  <th nowrap>{cb_msg module='grn.system.user' key='GRN_SY_US-497' replace='true'}</th>
  <td>
   {capture name='grn_system_user_GRN_SY_US_498'}{cb_msg module='grn.system.user' key='GRN_SY_US-498' replace='true'}{/capture}{grn_radio name="title" id="yes" value="1" caption=$smarty.capture.grn_system_user_GRN_SY_US_498 checked=false}&nbsp;{capture name='grn_system_user_GRN_SY_US_499'}{cb_msg module='grn.system.user' key='GRN_SY_US-499' replace='true'}{/capture}{grn_radio name="title" id="no" value="0" caption=$smarty.capture.grn_system_user_GRN_SY_US_499 checked=true}
  </td>
 </tr>
 {if $enable_old_format}
 <tr>
   <th nowrap>{cb_msg module='grn.system.user' key='GRN_SY_US-696' replace='true'}</th>
   <td>
     {capture name='grn_system_user_GRN_SY_US_697'}{cb_msg module='grn.system.user' key='GRN_SY_US-697' replace='true'}{/capture}
     {grn_checkbox name="old" id="old" value="1" caption=$smarty.capture.grn_system_user_GRN_SY_US_697 checked=$old}<br />
     {cb_msg module='grn.system.user' key='GRN_SY_US-698' replace='true'}
     <script>{literal}
         jQuery(function () {
             var old_elm = jQuery("#old");
             old_elm.on("click", function () {
                 if (old_elm.is(":checked")) {
                     jQuery(".new-column").hide();
                 }
                 else {
                     jQuery(".new-column").show();
                 }

                 jQuery(".column-number").each(function (idx, columnNumberElement) {
                     function _filter(a, f) {
                         var ret = [];
                         for (var i = 0; i < a.length; i++) {
                             if (f(a[i]))
                                 ret[ret.length] = a[i];
                         }
                         return ret;
                     }

                     columnNumberElement.innerHTML = (_filter(jQuery(columnNumberElement.parentNode).prevAll(), function (e) {
                         return jQuery(e).is(":visible");
                     }).length + 1).toString() + ".";
                 })
             });
         });
     </script>{/literal}
   </td>
 {/if}
 <tr>
  <td></td>
  <td>
       {capture name='grn_system_user_GRN_SY_US_500'}{cb_msg module='grn.system.user' key='GRN_SY_US-500' replace='true'}{/capture}{grn_button_submit class="margin" caption=$smarty.capture.grn_system_user_GRN_SY_US_500}
       {grn_button_cancel class="margin"}
  </td>
 </tr>
</table>
