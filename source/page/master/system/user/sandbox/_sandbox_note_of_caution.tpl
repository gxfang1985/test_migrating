{**
 * Options...
 * string  $prefix_script_name : system/user or system/user/sandbox
 * array   $sandbox_view : view of the sandbox info
 * boolean $is_admin : whether the system available user
 * boolean $is_sandbox_page : whether the sandbox page
 **}

{if $is_sandbox_page}

    {** sandbox page **}
    {if $sandbox_view.is_apply_result_exists}
        {if ! $sandbox_view.apply_result.result}
            {** &&date&&、事前設定の反映に失敗しました。 **}
            <div class="attention_area_grn mTop10">
                <div class="icon_attention_grn">
                    <span>{$sandbox_view.apply_result.failed_message}</span>
                </div>
            </div>
        {/if}
    {/if}

{else}

    {** not sandbox page **}
    {if $is_admin && $sandbox_view.is_apply_result_exists}
        {if $sandbox_view.apply_result.result}
            <form method="post" action="{grn_pageurl page="$prefix_script_name/command_org_list"}" id="system_confirm_form">
                <input type="hidden" name="csrf_ticket" value="{$csrf_ticket}"/>
                <input type="hidden" name="confirm_result" value="1">
                {** 事前設定が運用環境に反映されました。 **}
                {strip}
                <div class="info_area_grn info_area_inline_grn mTop10">
                    <div class="icon_information_grn inline_block_grn v-allign-middle">
                        <span>{cb_msg module='grn.system.user.sandbox' key='GRN_SY_SANDBOX-ORG-LIST-14' replace='true'}</span>
                    </div>
                    <a href="javascript:jQuery('#system_confirm_form').submit();" title="{cb_msg module='grn.system.user.sandbox' key='GRN_SY_SANDBOX-ORG-LIST-15' replace='true'}">
                        <span class="icon-close-sub-grn v-allign-middle mLeft15"></span>
                    </a>
                </div>
                {/strip}
            </form>
        {else}
            {** &&date&&、事前設定の反映に失敗しました。 **}
            <div class="attention_area_grn mTop10">
                <div class="icon_attention_grn">
                    <span>{$sandbox_view.apply_result.failed_message}</span>
                </div>
            </div>
        {/if}

    {else}

        {if $sandbox_view.status eq 'INITIAL'}

        {elseif $sandbox_view.status eq 'CREATE'}
            {** 事前設定を準備中です。しばらくしてからページを再読み込みしてください。 **}
            {strip}
            <div class="info_area_grn mBottom15 mTop15">
                <div class="icon_information_grn">
                    <span>
                        <span class="bold_grn">{cb_msg module='grn.system.user.sandbox' key='GRN_SY_SANDBOX-INDEX-5' replace='true'}</span>
                        <br />
                        {cb_msg module='grn.system.user.sandbox' key='GRN_SY_SANDBOX-INDEX-16' replace='true'}
                    </span>
                </div>
            </div>
            {/strip}

        {elseif $sandbox_view.status eq 'EXIST' && $sandbox_view.is_preset_event_exists}
            {if $is_admin}
                {** 2014/05/26（木）0:00に事前設定が運用環境に反映されます。**}
                {strip}
                <div class="attention_area_grn mTop10">
                    <div class="icon_attention_grn">
                        <span>{$sandbox_view.preset_event.message_prefix}</span>
                        <a href="{grn_pageurl page='system/user/sandbox/index'}" title="{$sandbox_view.preset_event.message_link}">
                            <span>{$sandbox_view.preset_event.message_link}</span>
                        </a>
                        <span>{$sandbox_view.preset_event.message_postfix}</span>
                    </div>
                </div>
                {/strip}
            {else}
                {** 2014/05/26（木）0:00に事前設定が運用環境に反映されます。**}
                {strip}
                <div class="attention_area_grn mTop10">
                    <div class="icon_attention_grn">
                        <span>
                            {$sandbox_view.preset_event.message_prefix}
                            {$sandbox_view.preset_event.message_link}
                            {$sandbox_view.preset_event.message_postfix}
                        </span>
                    </div>
                </div>
                {/strip}
            {/if}

        {elseif $sandbox_view.status eq 'EXIST'}
            {if $is_admin}
                {** 運用環境に未反映の事前設定があるため、組織を追加、変更、および削除できません。**}
                {strip}
                <div class="attention_area_grn mTop10">
                    <div class="icon_attention_grn">
                        <span>{cb_msg module='grn.system.user.sandbox' key='GRN_SY_SANDBOX-ORG-LIST-16' replace='true'}</span>
                        <a href="{grn_pageurl page='system/user/sandbox/index'}" title="{cb_msg module='grn.system.user.sandbox' key='GRN_SY_SANDBOX-ORG-LIST-17' replace='true'}">
                            <span>{cb_msg module='grn.system.user.sandbox' key='GRN_SY_SANDBOX-ORG-LIST-17' replace='true'}</span>
                        </a>
                        <span>{cb_msg module='grn.system.user.sandbox' key='GRN_SY_SANDBOX-ORG-LIST-18' replace='true'}</span>
                    </div>
                </div>
                {/strip}
            {else}
                {** 運用環境に未反映の事前設定があるため、組織を追加、変更、および削除できません。**}
                {strip}
                <div class="attention_area_grn mTop10">
                    <div class="icon_attention_grn">
                        <span>
                            {cb_msg module='grn.system.user.sandbox' key='GRN_SY_SANDBOX-ORG-LIST-16' replace='true'}
                            {cb_msg module='grn.system.user.sandbox' key='GRN_SY_SANDBOX-ORG-LIST-17' replace='true'}
                            {cb_msg module='grn.system.user.sandbox' key='GRN_SY_SANDBOX-ORG-LIST-18' replace='true'}
                        </span>
                    </div>
                </div>
                {/strip}
            {/if}

        {elseif $sandbox_view.status eq 'DISCARD'}
            {** 事前設定を削除中です。しばらくしてからページを再読み込みしてください。 **}
            {strip}
            <div class="info_area_grn mBottom15 mTop15">
                <div class="icon_information_grn">
                    <span>
                        <span class="bold_grn">{cb_msg module='grn.system.user.sandbox' key='GRN_SY_SANDBOX-INDEX-13' replace='true'}</span>
                        <br />
                        {cb_msg module='grn.system.user.sandbox' key='GRN_SY_SANDBOX-INDEX-16' replace='true'}
                    </span>
                </div>
            </div>
            {/strip}

        {elseif $sandbox_view.status eq 'APPLY'}
            {** 事前設定を運用中の環境に反映中です。しばらくしてからページを再読み込みしてください。 **}
            {strip}
            <div class="info_area_grn mBottom15 mTop15">
                <div class="icon_information_grn">
                    <span>
                        <span class="bold_grn">{cb_msg module='grn.system.user.sandbox' key='GRN_SY_SANDBOX-INDEX-14' replace='true'}</span>
                        <br />
                        {cb_msg module='grn.system.user.sandbox' key='GRN_SY_SANDBOX-INDEX-16' replace='true'}
                    </span>
                </div>
            </div>
            {/strip}

        {/if}
    {/if}

{/if}
