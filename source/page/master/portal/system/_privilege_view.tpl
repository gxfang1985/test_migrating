 <div id="view">
  <!----->
   <div class="list">
    <p class="item">
     <div class="title">
      <div class="word">{cb_msg module='grn.portal.system' key='GRN_POT_SY-86' replace='true'}</div>
     </div>
     <div class="contents">
      <div class="word">
 {if $privilege_info.target == 'users'}
       <div class="voice">{grn_user_name uid=$privilege_info.id name=$privilege_info.name}</div>
 {elseif $privilege_info.target == 'roles'}
       <div class="voice">{$privilege_info.name|escape:"html"}</div>
 {else}
       <div class="voice">{$privilege_info.name|escape:"html"}({$privilege_info.foreign_key|escape:"html"})</div>
 {/if}
      </div>
     </div>
    </p>
    <div class="br_list"><hr></div>
    <p class="item">
     <div class="title">
      <div class="word">{cb_msg module='grn.portal.system' key='GRN_POT_SY-87' replace='true'}</div>
     </div>
     <div class="contents">
      <div class="word">
{if $portal_list}
 {foreach from=$portal_list key=id item=portal}
       {grn_link class='portal20' caption=$portal.title page='portal/system/privilege_list' pid=$id}<br>
 {/foreach}
{else}
       {cb_msg module='grn.portal.system' key='GRN_POT_SY-88' replace='true'}
{/if}
      </div>
     </div>
    </p>
    <p class="item">
     <div class="title">
      <div class="word">{cb_msg module='grn.portal.system' key='GRN_POT_SY-89' replace='true'}</div>
     </div>
     <div class="contents">
      <div class="word">
{if $portlet_group_list}
 {foreach from=$portlet_group_list key=id item=portlet_group}
       {grn_link class='folder20' caption=$portlet_group.title page='portal/system/privilege_portlet_group_list' pgid=$id}<br>
 {/foreach}
{else}
       {cb_msg module='grn.portal.system' key='GRN_POT_SY-90' replace='true'}
{/if}
      </div>
    </p>
   </div>
  <!----->
 </div>
