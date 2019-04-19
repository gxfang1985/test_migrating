{include file='system/calendar/_csv_columns.tpl'}
{capture name=sub_explanation}
{cb_msg module='grn.personal.calendar' key='GRN_PRS_CA-60' replace='true'}<br>
{cb_msg module='grn.personal.calendar' key='GRN_PRS_CA-63' replace='true'}<strong>{grn_date_format date=null format="DateFull_Y"}</strong>{cb_msg module='grn.personal.calendar' key='GRN_PRS_CA-65' replace='true'}<br>
{cb_msg module='grn.personal.calendar' key='GRN_PRS_CA-66' replace='true'}<strong>2</strong>{cb_msg module='grn.personal.calendar' key='GRN_PRS_CA-67' replace='true'}<strong>4</strong>{cb_msg module='grn.personal.calendar' key='GRN_PRS_CA-68' replace='true'}<br><br>
{cb_msg module='grn.personal.calendar' key='GRN_PRS_CA-69' replace='true'} 
{/capture}
{capture name=cancel_button}
{grn_button_cancel class="margin" page="personal/calendar/calendar_view" bdate=$bdate}
{/capture}
{capture name=prev_button}
{capture name='grn_personal_calendar_GRN_PRS_CA_70'}{cb_msg module='grn.personal.calendar' key='GRN_PRS_CA-70' replace='true'}{/capture}{grn_button_cancel class="margin" page='personal/calendar/import1' charset=$charset skip=$skip bdate=$bdate caption=$smarty.capture.grn_personal_calendar_GRN_PRS_CA_70}
{/capture}
{include file='grn/std_import2.tpl' config_id='personal' prev_button=$smarty.capture.prev_button cancel_button=$smarty.capture.cancel_button post_page='personal/calendar/command_import2' column_explanation=$smarty.capture.explanation sub_explanation=$smarty.capture.sub_explanation}
