{include file='grn/head.tpl'}
{include file='grn/header.tpl'}

{grn_title title=$page_title class=$page_info.parts[0]}
{include file='grn/show_validation_errors.tpl'}
{assign var="form_name" value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='message/command_'|cat:$page_info.last}" enctype="multipart/form-data"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
    <p class="explanation">
        {cb_msg module='grn.message' key='GRN_MSG-273' replace='true'}<br>
        {cb_msg module='grn.message' key='GRN_MSG-275' replace='true'}<br>
        {cb_msg module='grn.message' key='GRN_MSG-276' replace='true'}
    <p>
        {include file='grn/indispensable.tpl'}
    <table class="std_form">
        <tr valign="top">
            <th>{capture name='grn_message_GRN_MSG_277'}{cb_msg module='grn.message' key='GRN_MSG-277' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_message_GRN_MSG_277 necessary=true}</th>
            <td>
                {capture name='grn_message_GRN_MSG_278'}{cb_msg module='grn.message' key='GRN_MSG-278' replace='true'}{/capture}{validate form=$form_name field='sUID' criteria='notEmpty' message=$smarty.capture.grn_message_GRN_MSG_278 append='validation_errors'}
                {grn_member_add name='sUID' app_id='message' form_name=$form_name selected_users=$addressee_users include_org=true  access_plugin=$plugin add_org_with_users=true operator_add_name='sUID_o'}
            </td>
        </tr>
        <tr valign="top">
            <th>{capture name='grn_message_GRN_MSG_398'}{cb_msg module='grn.message' key='GRN_MSG-398' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_message_GRN_MSG_398 necessary=true}</th>
            <td>
                {if $operator_open}
                    {capture name='grn_message_GRN_MSG_399'}{cb_msg module='grn.message' key='GRN_MSG-399' replace='true'}{/capture}{grn_radio name="operator-set" id="operator-set1" value="0" caption=$smarty.capture.grn_message_GRN_MSG_399 checked=0 onclick='display_off(\'operator_select\')'}{capture name='grn_message_GRN_MSG_400'}{cb_msg module='grn.message' key='GRN_MSG-400' replace='true'}{/capture}{grn_radio name="operator-set" id="operator-set2" value="1" caption=$smarty.capture.grn_message_GRN_MSG_400 checked=1 onclick='display_on(\'operator_select\')'}
                {else}
                    {capture name='grn_message_GRN_MSG_401'}{cb_msg module='grn.message' key='GRN_MSG-401' replace='true'}{/capture}{grn_radio name="operator-set" id="operator-set1" value="0" caption=$smarty.capture.grn_message_GRN_MSG_401 checked=1 onclick='display_off(\'operator_select\')'}{capture name='grn_message_GRN_MSG_402'}{cb_msg module='grn.message' key='GRN_MSG-402' replace='true'}{/capture}{grn_radio name="operator-set" id="operator-set2" value="1" caption=$smarty.capture.grn_message_GRN_MSG_402 checked=0 onclick='display_on(\'operator_select\')'}
                {/if}
            </td>
        </tr>
        <tr valign="top" id="operator_select"{if ! $operator_open} style="display:none;"{/if}>
            <th>{cb_msg module='grn.message' key='GRN_MSG-403' replace='true'}</th>
            <td>{grn_operator_add name='sUID_o'
                form_name=$form_name operators_list_id='sUID_o' operators_candidate_list_id='operators_candidate_list'
                member_add_names='sUID' selected_operators=$operation_users candidate_operators=$addressee_users_filter app_id='message'}</td>
        </tr>
        </tr>
        <tr>
            <td></td>
            <td>
                <div class="mTop10">
                    {strip}
                        {capture name='grn_message_GRN_MSG_279'}{cb_msg module='grn.message' key='GRN_MSG-279' replace='true'}{/capture}
                        {capture name='message_button_save_onclick'}
                            grn_onsubmit_common(); grn.component.button.util.submit(this);
                        {/capture}
                        {grn_button ui="main" spacing="normal" action="submit" caption=$smarty.capture.grn_message_GRN_MSG_279 onclick=$smarty.capture.message_button_save_onclick id="message_button_save"}

                        {grn_button action="cancel" page="message/view" page_param_cid=$category_id page_param_rid=$relation_id page_param_mid=$message_id id="message_button_cancel"}
                    {/strip}
                </div>
            </td>
        </tr>
    </table>
    <input type="hidden" name="cid" value="{$category_id}">
    <input type="hidden" name="rid" value="{$relation_id}">
    <input type="hidden" name="mid" value="{$message_id}">
    <input type='hidden' name='fn' value="{$form_name}">
</form>
{literal}
    <script>
        <!--
        function grn_onsubmit_common() {
            grn.component.member_add.prepareSubmit(["sUID", "sUID_o"]);
        }
        //-->
    </script>
{/literal}

{include file='grn/footer.tpl'}
