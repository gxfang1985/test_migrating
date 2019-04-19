{capture name='explanation'}
  <div><span class="bold">1.</span>&nbsp;{cb_msg module='grn.kunai.system' key='GRN_KUNAI_SY-1' replace='true'}</div>
  <div><span class="bold">2.</span>&nbsp;{cb_msg module='grn.kunai.system' key='GRN_KUNAI_SY-12' replace='true'}</div>
  {foreach key=key item=app from=$available_apps}
    <div><span class="bold">{$key+3}.</span>
    {if $app eq 'schedule'}{cb_msg module='grn.kunai.system' key='GRN_KUNAI_SY-2' replace='true'}
    {elseif $app eq 'message'}{cb_msg module='grn.kunai.system' key='GRN_KUNAI_SY-3' replace='true'}
    {elseif $app eq 'workflow'}{cb_msg module='grn.kunai.system' key='GRN_KUNAI_SY-4' replace='true'}
    {elseif $app eq 'mail'}{cb_msg module='grn.kunai.system' key='GRN_KUNAI_SY-5' replace='true'}
    {elseif $app eq 'address'}{cb_msg module='grn.kunai.system' key='GRN_KUNAI_SY-6' replace='true'}
    {elseif $app eq 'space'}{cb_msg module='grn.kunai.system' key='GRN_KUNAI_SY-32' replace='true'}
    {elseif $app eq 'bulletin'}{cb_msg module='grn.kunai.system' key='GRN_KUNAI_SY-33' replace='true'}
    {elseif $app eq 'report'}{cb_msg module='grn.kunai.system' key='GRN_KUNAI_SY-34' replace='true'}
    {/if}
    </div>
  {/foreach}
{/capture}
