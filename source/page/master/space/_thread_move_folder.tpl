<script id="thead_move_folder_content_template" type="text/template">
    <div id="thead_move_folder_content">
        <p>
            {cb_msg module='grn.space' key='move_discussion-6' replace='true'}
            <br>
            {cb_msg module='grn.space' key='move_discussion-7' replace='true'}<span
                    class="bold thread_move_count"></span><br>
            {cb_msg module='grn.space' key='move_discussion-8' replace='true'}{grn_image image="inbox20.gif"}<span
                    class="bold destination_folder_name"></span><br>
        </p>
        <br>
        <div class="mTop20">
            {capture name='notify_move_folder'}{cb_msg module='grn.space' key='move_discussion-19' replace='true'}{/capture}
            {grn_checkbox name='notify_move_folder' id='notify_move_folder' value='to' checked=1 caption=$smarty.capture.notify_move_folder span_cover="1"}
        </div>
    </div>
</script>