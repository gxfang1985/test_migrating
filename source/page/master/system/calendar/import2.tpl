{include file='system/calendar/_csv_columns.tpl'}
{capture name=sub_explanation}
{cb_msg module='grn.system.calendar' key='GRN_SY_CA-28' replace='true'}-MM-{cb_msg module='grn.system.calendar' key='GRN_SY_CA-29' replace='true'}/MM/{cb_msg module='grn.system.calendar' key='GRN_SY_CA-30' replace='true'}<br>
{cb_msg module='grn.system.calendar' key='GRN_SY_CA-31' replace='true'}(YYYY){cb_msg module='grn.system.calendar' key='GRN_SY_CA-32' replace='true'}<strong>{grn_date_format date=null format="DateFull_Y"}</strong>{cb_msg module='grn.system.calendar' key='GRN_SY_CA-33' replace='true'}<br>
{cb_msg module='grn.system.calendar' key='GRN_SY_CA-34' replace='true'}<strong>1</strong>{cb_msg module='grn.system.calendar' key='GRN_SY_CA-35' replace='true'}<strong>3</strong>{cb_msg module='grn.system.calendar' key='GRN_SY_CA-101' replace='true'}<strong>5</strong>{cb_msg module='grn.system.calendar' key='GRN_SY_CA-36' replace='true'}<br><br>
{cb_msg module='grn.system.calendar' key='GRN_SY_CA-37' replace='true'} 
{/capture}

{capture name=cancel_button}
{grn_button_cancel class="margin" page="system/calendar/systemcalendar_list" scid=$scid bdate=$bdate}
{/capture}
{capture name=prev_button}
{capture name='grn_system_calendar_GRN_SY_CA_38'}{cb_msg module='grn.system.calendar' key='GRN_SY_CA-38' replace='true'}{/capture}{grn_button_cancel class="margin" page='system/calendar/import1' charset=$charset skip=$skip scid=$scid bdate=$bdate caption=$smarty.capture.grn_system_calendar_GRN_SY_CA_38}
{/capture}
{include file='grn/std_import2.tpl' config_id='system' prev_button=$smarty.capture.prev_button cancel_button=$smarty.capture.cancel_button post_page='system/calendar/command_import2' column_explanation=$smarty.capture.explanation sub_explanation=$smarty.capture.sub_explanation}
