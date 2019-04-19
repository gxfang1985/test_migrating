{include file='schedule/system/_event_csv_columns.tpl'}
{capture name=sub_explanation}
{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-392' replace='true'}-MM-{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-393' replace='true'}/MM/{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-394' replace='true'}<br>
{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-395' replace='true'}:MM:{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-396' replace='true'}<br><br>
{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-397' replace='true'}
{/capture}
{include file='grn/std_import2.tpl' prev_page='schedule/system/import1' column_explanation=$smarty.capture.explanation sub_explanation=$smarty.capture.sub_explanation}
