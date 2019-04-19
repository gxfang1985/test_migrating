{assign var="form_name" value=$smarty.template|basename}
{include file='personal/calendar/_csv_columns.tpl'}
{capture name=sub_explanation}
{cb_msg module='grn.personal.calendar' key='GRN_PRS_CA-41' replace='true'}<br>
{cb_msg module='grn.personal.calendar' key='GRN_PRS_CA-44' replace='true'}<strong>{grn_date_format date=null format="DateFull_Y"}</strong>{cb_msg module='grn.personal.calendar' key='GRN_PRS_CA-46' replace='true'}<br>
{cb_msg module='grn.personal.calendar' key='GRN_PRS_CA-47' replace='true'}<strong>2</strong>{cb_msg module='grn.personal.calendar' key='GRN_PRS_CA-48' replace='true'}<strong>4</strong>{cb_msg module='grn.personal.calendar' key='GRN_PRS_CA-49' replace='true'}<br><br>
{cb_msg module='grn.personal.calendar' key='GRN_PRS_CA-50' replace='true'}
{/capture}
{capture name=cancel_button}
{grn_button_cancel class="margin" page="personal/calendar/calendar_view" bdate=$bdate}
{/capture}
{include file='grn/std_import1.tpl' config_id='personal' cancel_button=$smarty.capture.cancel_button post_page='personal/calendar/command_import1' column_explanation=$smarty.capture.explanation sub_explanation=$smarty.capture.sub_explanation}
