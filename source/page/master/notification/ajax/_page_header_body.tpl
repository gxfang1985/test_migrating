{foreach from=$data item=notify}
    <li class="cloudHeader-grnNotification-item-grn">
        <div class="cloudHeader-grnNotification-itemTitle-grn">
            <span class="cloudHeader-grnNotification-itemDate-grn">{grn_date_format date = $notify.timestamp}</span>
            {if strlen($notify.subject) > 35}
                {assign var=subject value=$notify.subject|mb_strimwidth:0:30|cat:"..."}
            {else}
                {assign var=subject value=$notify.subject}
            {/if}
            {if $notify.module_id == "grn.message"}
                {grn_link image=$notify.subject_icon alt=$notify.subject_icon_alt page='message/view' cid=$notify.org_data.cid rid=$notify.org_data.rid mid=$notify.org_data.mid nid=$notify.id caption=$subject}
            {elseif $notify.module_id == "grn.bulletin"}
                {grn_link image=$notify.subject_icon alt=$notify.subject_icon_alt page='bulletin/view' aid=$notify.unique_id nid=$notify.id caption=$subject}
            {elseif $notify.module_id == "grn.schedule"}
                {if $notify.action_id == "requested"}
                    {grn_link image=$notify.subject_icon alt=$notify.subject_icon_alt page='schedule/operation/facility_approve' event=$notify.org_data.event faid=$notify.org_data.faid nid=$notify.id caption=$subject}
                {else}
                    {grn_link image=$notify.subject_icon alt=$notify.subject_icon_alt page='schedule/view' uid=$uid event=$notify.org_data.event bdate=$notify.org_data.bdate nid=$notify.id caption=$subject}
                {/if}
            {elseif $notify.module_id == "grn.cabinet"}
                {grn_link image=$notify.subject_icon alt=$notify.subject_icon_alt page='cabinet/view' fid=$notify.unique_id nid=$notify.id caption=$subject}
            {elseif $notify.module_id == "grn.phonemessage"}
                {grn_link image=$notify.subject_icon alt=$notify.subject_icon_alt page='phonemessage/history' uid=$notify.org_data.uid nid=$notify.id caption=$subject}
            {elseif $notify.module_id == "grn.mail"}
                {grn_link image=$notify.subject_icon alt=$notify.subject_icon_alt page='mail/view' mid=$notify.unique_id nid=$notify.id caption=$subject}
            {elseif $notify.module_id == "grn.report"}
                {grn_link image=$notify.subject_icon alt=$notify.subject_icon_alt page='report/view' rid=$notify.org_data.rid nid=$notify.id caption=$subject}
            {elseif $notify.module_id == "grn.workflow"}
                {grn_link image=$notify.subject_icon alt=$notify.subject_icon_alt page='workflow/handle' fid=$notify.org_data.fid pid=$notify.org_data.pid nid=$notify.org_data.nid caption=$subject}
            {elseif $notify.module_id == "grn.space"}
                {if $notify.sub_module_id == "grn.discussion"}
                    {if isset( $notify.org_data.comment )}
                        {grn_link image=$notify.subject_icon alt=$notify.subject_icon_alt page='space/top' spid=$notify.space_id caption=$subject nid=$notify.id tid=$notify.unique_id fragment='tid='|cat:$notify.unique_id|cat:'&cmid='|cat:$notify.org_data.comment}
                    {else}
                        {grn_link image=$notify.subject_icon alt=$notify.subject_icon_alt page='space/top' spid=$notify.space_id caption=$subject nid=$notify.id tid=$notify.unique_id fragment='tid='|cat:$notify.unique_id}
                    {/if}
                {elseif $notify.sub_module_id == "grn.todo"}
                    {if isset( $notify.org_data.comment )}
                        {grn_link image=$notify.subject_icon alt=$notify.subject_icon_alt page='space/application/todo/view' spid=$notify.space_id tdid=$notify.unique_id cmid=$notify.org_data.comment caption=$subject nid=$notify.id}
                    {else}
                        {grn_link image=$notify.subject_icon alt=$notify.subject_icon_alt page='space/application/todo/view' spid=$notify.space_id tdid=$notify.unique_id caption=$subject nid=$notify.id}
                    {/if}
                {else}
                    {grn_link image=$notify.subject_icon alt=$notify.subject_icon_alt page=$notify.space_page_url spid=$notify.space_id caption=$subject nid=$notify.id}
                {/if}
            {elseif $notify.subject_icon|strlen > 0}
                {if $notify.url_direct}
                    {grn_link image=$notify.subject_icon alt=$notify.subject_icon_alt image_direct=$notify.image_direct page=$notify.url_direct page_direct=true caption=$subject}
                {else}
                    {grn_link image=$notify.subject_icon alt=$notify.subject_icon_alt image_direct=$notify.image_direct page='notification/notify_redirect' nid=$notify.id ct=s caption=$subject}
                {/if}
            {else}
                {if $notify.url_direct}
                    {grn_link image='notify_unknown32.gif' page=$notify.url_direct page_direct=true caption=$subject}
                {else}
                    {grn_link image='notify_unknown32.gif' page='notification/notify_redirect' nid=$notify.id ct=s caption=$subject}
                {/if}
            {/if}
        </div>
        <div class="cloudHeader-grnNotification-itemInfo-grn">
            <div class="cloudHeader-grnNotification-userName-grn">
                {if $notify.module_id == "grn.mail"}
                    {grn_mail_name type='' name_format='name' name=$notify.sender_name email=$mail.email truncated=$characters.name mid=$notify.unique_id aid=1 cid=2}
                {elseif $notify.module_id|substr:0:2 == "x."}
                    {grn_mail_name type='' name_format='name' name=$notify.sender_name truncated=$characters.name}
                {elseif $notify.module_id == 'grn.bulletin' && $notify.sender_id == -2}
                    {grn_sender_name name=$notify.sender_name truncated=$characters.name no_image=true}
                {else}
                    {grn_user_name uid=$notify.sender_id name=$notify.sender_name users_info=$users_info app_id=$notify.module_id|substr:4}
                {/if}
            </div>
            {if is_null($notify.space_id) == false && $notify.space_id != 0 && $available_space}
                <div class="cloudHeader-grnNotification-spaceName-grn">
                    {if $notify.space_icon_url}
                        <a href='{cb_pageurl page= $notify.space_page_url spid=$notify.space_id}'>
                            <img src="{$notify.space_icon_url}" alt="">{$notify.space_name}
                        </a>
                    {else}
                        {$notify.space_name}
                    {/if}
                </div>
            {/if}
            <div class="clear_both"></div>
        </div>

        <div class="cloudHeader-grnNotification-itemBody-grn">
            {grn_format body=$notify.abstract flag_notification_header=true}
        </div>
    </li>
{/foreach}