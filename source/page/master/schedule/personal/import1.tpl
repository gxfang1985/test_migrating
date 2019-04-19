{include file='schedule/personal/_event_csv_columns.tpl'}
{capture name=sub_explanation}
{cb_msg module='grn.schedule.personal' key='GRN_SCH_PE-50' replace='true'}-MM-{cb_msg module='grn.schedule.personal' key='GRN_SCH_PE-51' replace='true'}/MM/{cb_msg module='grn.schedule.personal' key='GRN_SCH_PE-52' replace='true'}<br>
{cb_msg module='grn.schedule.personal' key='GRN_SCH_PE-53' replace='true'}:MM:{cb_msg module='grn.schedule.personal' key='GRN_SCH_PE-54' replace='true'}<br><br>
{cb_msg module='grn.schedule.personal' key='GRN_SCH_PE-55' replace='true'}
{/capture}
{include file='grn/std_import1.tpl' column_explanation=$smarty.capture.explanation sub_explanation=$smarty.capture.sub_explanation}
