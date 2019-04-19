{strip}
<div class="content" style="width: 850px; min-height: 30px; max-height: 480px; display: block;">
    <div style="max-height: 420px; overflow-y: auto;" class="list_column_base_bottomline_grn mTop5">
        {include file="space/_space_list_item_dialog.tpl"}
    </div>
    {include file="space/smart_word_navi.tpl" navi=$navi.navi start_num=$navi.start_count end_num=$navi.end_count custom_class="mTop5 js_navi_space_dialog"}
</div>
<div class="buttonArea-grn">
    <div class="buttonarea_sub_base_grn">
        {capture name='notify_move_space'}{cb_msg module='grn.space' key='move_discussion-11' replace='true'}{/capture}
        {grn_checkbox name='notify_move_space' id='notify_move_space' value='to' checked=1 caption=$smarty.capture.notify_move_space span_cover="1"}
    </div>
    <div class="mTop10 mBottom20">
        {capture name='grn_space_move_discussion_16'}{cb_msg module='grn.space' key='move_discussion-16' replace='true'}{/capture}
        {grn_button class='js_btn_move' ui='main' auto_disable=true caption=$smarty.capture.grn_space_move_discussion_16 spacing='normal'}
        {capture name='grn_space_move_discussion_17'}{cb_msg module='grn.space' key='move_discussion-17' replace='true'}{/capture}
        {grn_button class='js_btn_cancel' caption=$smarty.capture.grn_space_move_discussion_17}
    </div>
</div>
{/strip}