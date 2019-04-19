{include file="cbpapi/header.tpl"}
<workflow:{$action}Response>
     <returns>
        {foreach from=$list_data item=form}
            <category 
                {grn_attr name="id_category" value=$form.CategoryID require=true}
                {grn_attr name="name_category" value=$form.CategoryName require=true}
            >
               <manage_request_form 
                    {grn_attr name="id_request_form" value=$form.form_id require=true}
                    {grn_attr name="name_request_form" value=$form.form_name require=true}
               >
               <manage_item_detail
                        {grn_attr name="pid" value=$form.pid require=true}
                        {grn_attr name="number" value=$form.petition_number require=true}
                        {grn_attr name="priority" value=$form.priority require=true}
                        {grn_attr name="subject" value=$form.name require=true}
                        {if $form.status == GRN_WORKFLOW_STATUS_UNPROCESSING || 
                            $form.status == GRN_WORKFLOW_STATUS_IN_PROCESS ||
                            $form.status == GRN_WORKFLOW_STATUS_REMAND}
                            {capture name='grn_workflow_system_status'}{cb_msg module='grn.workflow' key='view_status_0' replace='true'}{/capture}
                        {elseif $form.status == GRN_WORKFLOW_STATUS_ACCEPTANCE}
                            {capture name='grn_workflow_system_status'}{cb_msg module='grn.workflow' key='view_status_1' replace='true'}{/capture}
                        {elseif $form.status == GRN_WORKFLOW_STATUS_REJECTION}
                            {capture name='grn_workflow_system_status'}{cb_msg module='grn.workflow' key='view_status_2' replace='true'}{/capture}
                        {elseif $form.status == GRN_WORKFLOW_STATUS_IN_PROCESS_CANCEL}
                            {capture name='grn_workflow_system_status'}{cb_msg module='grn.workflow' key='view_status_3' replace='true'}{/capture}
                        {elseif $form.status == GRN_WORKFLOW_STATUS_FINISHED}
                            {capture name='grn_workflow_system_status'}{cb_msg module='grn.workflow' key='view_status_4' replace='true'}{/capture}
                        {elseif $form.status == GRN_WORKFLOW_STATUS_TEMPORARY ||
                                $form.status == GRN_WORKFLOW_STATUS_UNPROCESSING_CANCEL }
                            {capture name='grn_workflow_system_status'}{cb_msg module='grn.workflow' key='view_status_5' replace='true'}{/capture}
                        {/if}
                        {grn_attr name="status" value=$smarty.capture.grn_workflow_system_status require=true}
                        {grn_attr name="applicant" value=$form.user require=true}
                        {if $form.status == GRN_WORKFLOW_STATUS_REJECTION}
                            {grn_attr name="last_approver" value=$form.transactor_id require=true}
                        {elseif $form.status != GRN_WORKFLOW_STATUS_TEMPORARY}
                            {foreach from=$form.transactor item=user}
                                {grn_attr name="last_approver" value=$user._id require=true}
                            {foreachelse}
                                {capture name='grn_workflow_system_last_approver'}{cb_msg module='grn.workflow.system' key='w_circulars' replace='true'}{/capture}
                                {grn_attr name="last_approver" value=$smarty.capture.grn_workflow_system_last_approver require=true}
                            {/foreach}
                        {/if}
                        {grn_attr name="request_date" value=$form.ctime require=true}
                    >
                    </manage_item_detail>
           </manage_request_form>
            </category>
        {/foreach}
    </returns>
</workflow:{$action}Response>
{include file="cbpapi/footer.tpl"}