{foreach from=$fac_info_list item=info}
  <li data-icon="false" class="mobile-list-member-grn">
     <a href="{grn_pageurl page='schedule/facility_info' faid=$info._id}" target="_blank">
        {grn_image image="image-mobile/facilityPlofile.png" height="40" width="40" class="mobile-image-member-grn"}
         <!--GTM-1684-->
         {if $info.facilityApprovalStatus}
             <div class="mobile-list-member-name-grn">{$info.col_name|escape}</div>
             <div class="mobile-label-small-grn">{$info.facilityApprovalStatus}</div>
         {else}
             <div class="mobile-list-member-name-grn" style="margin-top: 10px;">{$info.col_name|escape}</div>
         {/if}
         <span class="mobile-array-list-grn mobile-array-member-grn"></span>
         <!--End GTM-1684-->
    </a>
  </li>
{/foreach}
