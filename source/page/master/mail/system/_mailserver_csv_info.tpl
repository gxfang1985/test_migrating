{capture name=sub_explanation}
    {cb_msg module='grn.mail.system' key='GRN_MAIL_SY-398' replace='true'}<br>
    {if $smarty.const.ON_FOREST===1}
        {cb_msg module='grn.mail.system' key='GRN_MAIL_SY-514' replace='true'}<br>
    {/if}
{/capture}