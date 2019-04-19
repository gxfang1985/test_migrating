<div class="navi mTop3 mBottom3">
  <div class="list_paging_grn inline_block_grn">
{if $navi.previous_page_start_position eq -1}
    <span class="action_disable_grn" id="top_page_off">
      <span title="{cb_msg module='grn.grn' key='GRN_GRN-886' replace='true'}" class="arrow_first_button_grn"></span>
    </span>
{else}
    <span class="" id="top_page_on">
      <a href="{grn_pageurl page=$page_info.all sp=0 params=$navi.params}" title="{cb_msg module='grn.grn' key='GRN_GRN-886' replace='true'}" class="action_grn" >
        <span class="arrow_first_button_grn"></span>
      </a>
    </span>
{/if}
{if $navi.previous_page_start_position eq -1}
    <span class="action_disable_grn" id="prev_page_off">
      <span title="{cb_msg module='grn.grn' key='GRN_GRN-888' replace='true'}{$navi.number_on_page}{cb_msg module='grn.grn' key='GRN_GRN-889' replace='true'}" class="arrow_left_button_grn"></span>
    </span>
{else}
    <span class="" style="" id="prev_page_on">
      <a href="{grn_pageurl page=$page_info.all sp=$navi.previous_page_start_position params=$navi.params}" title="{cb_msg module='grn.grn' key='GRN_GRN-888' replace='true'}{$navi.number_on_page}{cb_msg module='grn.grn' key='GRN_GRN-889' replace='true'}" class="action_grn" >
          <span class="arrow_left_button_grn"></span>
      </a>
    </span>
{/if}
{if $navi.next_page_start_position eq -1}
    <span class="action_disable_grn" id="next_page_off" style="">
      <span title="{cb_msg module='grn.grn' key='GRN_GRN-892' replace='true'}{$navi.number_on_page}{cb_msg module='grn.grn' key='GRN_GRN-891' replace='true'}" class="arrow_right_button_grn"></span>
    </span>
{else}
    <span class="" style="" id="next_page_on">
      <a href="{grn_pageurl page=$page_info.all sp=$navi.next_page_start_position params=$navi.params}" title="{cb_msg module='grn.grn' key='GRN_GRN-892' replace='true'}{$navi.number_on_page}{cb_msg module='grn.grn' key='GRN_GRN-891' replace='true'}" class="action_grn" >
          <span class="arrow_right_button_grn"></span>
      </a>
    </span>
{/if}
    <span class="sub_title numberList vAlignMiddle-grn mLeft10">
      <span id="start_num">{$start_num}</span>-<span id="end_num">{$end_num}</span>
    </span>
  </div>
</div>