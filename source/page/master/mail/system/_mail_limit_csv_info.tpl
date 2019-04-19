{capture name=sub_explanation}
{cb_msg module='grn.mail.system' key='GRN_MAIL_SY-398' replace='true'}<br>
{if $smarty.const.ON_FOREST!==1}
    {cb_msg module='grn.mail.system' key='GRN_MAIL_SY-526' replace='true'}<br>
    {cb_msg module='grn.mail.system' key='GRN_MAIL_SY-524' replace='true'}<br>
    {cb_msg module='grn.mail.system' key='GRN_MAIL_SY-525' replace='true'}
{else}
    {cb_msg module='grn.mail.system' key='GRN_MAIL_SY-527' replace='true'}<br>
    {cb_msg module='grn.mail.system' key='GRN_MAIL_SY-523' replace='true'}<br>
    {cb_msg module='grn.mail.system' key='GRN_MAIL_SY-528' replace='true'}
{/if}
{/capture}
