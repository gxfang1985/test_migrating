{capture name='explanation'}
    <div><span class="bold">1.</span>&nbsp;{cb_msg module='grn.system.application' key='GRN_SY_AP-32' replace='true'}</div>
    <div><span class="bold">2.</span>&nbsp;{cb_msg module='grn.system.application' key='GRN_SY_AP-33' replace='true'}</div>
    {foreach key=key item=app from=$available_apps}
        <div><span class="bold">{$key+3}.</span>
            {$app}
        </div>
    {/foreach}
{/capture}
