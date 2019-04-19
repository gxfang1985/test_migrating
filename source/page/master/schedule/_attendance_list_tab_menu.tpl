{if $bid eq "attendees"}
<div class="tab">
  <span class="tab_left_on"></span>
  <span class="tab_on" >
    <span class="tab_text_noimage">{cb_msg module='grn.schedule' key='GRN_SCH-1033' replace='true'}</span>
  </span>
  <span class="tab_right_on"></span>
</div>
<div class="tab">
  <span class="tab_left_off"></span>
  <span class="tab_off" >
    <span class="tab_text_noimage"><a href="{grn_pageurl page="schedule/attendance_registrant_list" referer_key=$referer_key}">{cb_msg module='grn.schedule' key='GRN_SCH-1034' replace='true'}</a></span>
  </span>
  <span class="tab_right_off" ></span>
</div>
{elseif $bid eq "registrant"}
<div class="tab">
  <span class="tab_left_off"></span>
  <span class="tab_off" >
    <span class="tab_text_noimage"><a href="{grn_pageurl page="schedule/attendance_list" referer_key=$referer_key}">{cb_msg module='grn.schedule' key='GRN_SCH-1033' replace='true'}</a></span>
  </span>
  <span class="tab_right_off" ></span>
</div>
<div class="tab">
  <span class="tab_left_on"></span>
  <span class="tab_on" >
    <span class="tab_text_noimage">{cb_msg module='grn.schedule' key='GRN_SCH-1034' replace='true'}</span>
  </span>
  <span class="tab_right_on" ></span>
</div>
{/if}
<div class="tab_menu_end">&nbsp;</div>
<div class="clear_both_0px"></div>
