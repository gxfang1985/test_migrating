{include file='schedule/personal/_event_csv_columns.tpl'}
{capture name=sub_explanation}
{cb_msg module='grn.schedule.personal' key='GRN_SCH_PE-29' replace='true'}-MM-{cb_msg module='grn.schedule.personal' key='GRN_SCH_PE-30' replace='true'}/MM/{cb_msg module='grn.schedule.personal' key='GRN_SCH_PE-31' replace='true'}<br>
{cb_msg module='grn.schedule.personal' key='GRN_SCH_PE-32' replace='true'}:MM:{cb_msg module='grn.schedule.personal' key='GRN_SCH_PE-33' replace='true'}<br><br>
{cb_msg module='grn.schedule.personal' key='GRN_SCH_PE-34' replace='true'}
{/capture}
{include file='grn/std_import2.tpl' prev_page='schedule/personal/import1' column_explanation=$smarty.capture.explanation sub_explanation=$smarty.capture.sub_explanation}
