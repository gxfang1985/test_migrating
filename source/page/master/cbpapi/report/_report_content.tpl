{capture name="grn_report_subject"}{$report.form_name}（ {$report.name} ）{/capture}
<report id="{$report.id}" {grn_attr name="subject" value=$smarty.capture.grn_report_subject}
    is_draft="{if $report.draft}true{else}false{/if}">
    <items xmlns="http://schemas.cybozu.co.jp/report/2008">
        {foreach from=$report.items item=item}
            {if $item.type == 2}
                <blank_item />
            {else}
                {if $item.data_type == 'grn.report.file' }
                    <files_item {grn_attr name="name" value=$item.display_name require=true}
                                {if $item.settings.inline == 1}inline="true"{else}inline="false"{/if}>
                        {if is_array($item.files) && count($item.files) > 0 }
                            {foreach from=$item.files item=file}
                                <file file_id="{$file.ifid}" {grn_attr name="name" value=$file.name require=true}
                                        {grn_attr name="size" value=$file.size}
                                        {grn_attr name="mime_type" value=$file.mime} />
                            {/foreach}
                        {/if}
                    </files_item>
                {else}
                    <item 
                        {grn_attr name=name  value=$item.display_name require=true}
                        {if $item.data_type == 'grn.report.date'}
                            {grn_attr name=value value=$item.view_str}
                        {else}
                            {grn_attr name=value value=$item.view_str|regex_replace:'/^\s+|\s+$/':'' require=true}
                        {/if}
                        {if $item.option_string_type == 1 && strlen($item.option_string) > 0}
                            {grn_attr name="front" value=$item.option_string require=false}
                        {/if}

                        {if $item.option_string_type == 0 && strlen($item.option_string) > 0}
                            {grn_attr name="back" value=$item.option_string require=false}
                        {/if}
                     />
                {/if}
            {/if}
        {/foreach}
    </items>
    <members xmlns="http://schemas.cybozu.co.jp/report/2008">
        {foreach from=$report.members item=user}
            <user id="{$user.id}" {grn_attr name="name" value=$user.name} />
        {/foreach}
    </members>
    <notifyusers xmlns="http://schemas.cybozu.co.jp/report/2008">
        {foreach from=$report.notifyusers item=user}
            <user id="{$user.id}" {grn_attr name="name" value=$user.name} />
        {/foreach}
    </notifyusers>
    <maintainers xmlns="http://schemas.cybozu.co.jp/report/2008">
        {foreach from=$report.operators item=operator}
            <user id="{$operator.id}" {grn_attr name="name" value=$operator.name} />
        {/foreach}
    </maintainers>

    <creator  {grn_attr name="user_id" value=$report.creator }  {grn_attr name="name" value=$report.creator_name require=true}  date="{$report.creator_date}" />
    <modifier {grn_attr name="user_id" value=$report.modifier } {grn_attr name="name" value=$report.modifier_name require=true} date="{$report.modifier_date}" />
</report>