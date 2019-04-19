{include file='schedule/system/_event_csv_columns.tpl'}
{capture name=sub_explanation}
{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-325' replace='true'}-MM-{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-326' replace='true'}/MM/{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-327' replace='true'}<br>
{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-328' replace='true'}:MM:{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-329' replace='true'}<br><br>
{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-330' replace='true'}
{/capture}
{include file='grn/std_import1.tpl' column_explanation=$smarty.capture.explanation sub_explanation=$smarty.capture.sub_explanation}
