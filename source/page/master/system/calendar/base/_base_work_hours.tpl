    {foreach from=$base.work_hours_list item=work_hours}
    <div>{grn_date_format date=$work_hours.start format='TimeLong_HM'}{cb_msg module='grn.system.i18n.base' key='from_to' replace='true'}{grn_date_format date=$work_hours.end format='TimeLong_HM'}</div>
    {/foreach}
