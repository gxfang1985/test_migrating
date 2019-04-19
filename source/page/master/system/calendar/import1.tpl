{assign var="form_name" value=$smarty.template|basename}
{include file='system/calendar/_csv_columns.tpl'}
{capture name=sub_explanation}
{cb_msg module='grn.system.calendar' key='GRN_SY_CA-55' replace='true'}-MM-{cb_msg module='grn.system.calendar' key='GRN_SY_CA-56' replace='true'}/MM/{cb_msg module='grn.system.calendar' key='GRN_SY_CA-57' replace='true'}<br>
{cb_msg module='grn.system.calendar' key='GRN_SY_CA-58' replace='true'}(YYYY){cb_msg module='grn.system.calendar' key='GRN_SY_CA-59' replace='true'}<strong>{grn_date_format date=null format="DateFull_Y"}</strong>{cb_msg module='grn.system.calendar' key='GRN_SY_CA-60' replace='true'}<br>
{cb_msg module='grn.system.calendar' key='GRN_SY_CA-61' replace='true'}<strong>1</strong>{cb_msg module='grn.system.calendar' key='GRN_SY_CA-62' replace='true'}<strong>3</strong>{cb_msg module='grn.system.calendar' key='GRN_SY_CA-101' replace='true'}<strong>5</strong>{cb_msg module='grn.system.calendar' key='GRN_SY_CA-63' replace='true'}<br><br>
{cb_msg module='grn.system.calendar' key='GRN_SY_CA-64' replace='true'} 
{/capture}
{capture name=cancel_button}
{grn_button_cancel class="margin" page="system/calendar/systemcalendar_list" bdate=$bdate}
{/capture}
{include file='grn/std_import1.tpl' config_id='system' cancel_button=$smarty.capture.cancel_button post_page='system/calendar/command_import1' column_explanation=$smarty.capture.explanation sub_explanation=$smarty.capture.sub_explanation}
