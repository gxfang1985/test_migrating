{include file="cellular/header.tpl"}
{strip}

{grn_cellular_appname app_id="bulletin"}<br>
{cb_msg module='grn.bulletin.cellular' key="title_look2"}<br>
<hr>

{if $bbsdata.can_follow && $category_auth.follow }
    {grn_cellular_link page="$pagepath/follow" aid="$aid" accesskey="1" caption_module='grn.bulletin.cellular' caption_key="link_follow"}<br>
{/if}
{grn_cellular_pictogram key="memo"}{$title|escape}<br>
<hr>

{grn_cellular_pictogram key="clock"}
{cb_date_format format='DateTimeShort_YMD_HM' date=`$followdata.ctime`}<br>
{$followdata.id}{cb_msg module='grn.bulletin.cellular' key='GRN_BLLT_CELL-6' replace='true'}{grn_cellular_pictogram key="person"}
{$followdata.creator_name|escape}<br>

{grn_cellular_pictogram key="follow"}
{grn_cellular_string_split string=$followdata.data page_paraname="pg"}
<br>

{if count($followdata.attach_files)}
    <br>
    [{grn_cellular_pictogram key="clip"}{cb_msg module='grn.bulletin.cellular' key="txt_attach_file"}]<br>
{/if}

{if $fid_p || $fid_n}
    <br>
    {if $fid_p}
        {grn_cellular_link page="$pagepath/look2" fid=$fid_p aid=$aid caption_module='grn.cellular.common' caption_key="link_back"}
        &nbsp;
    {/if}
    {if $fid_n}
        {grn_cellular_link page="$pagepath/look2" fid=$fid_n aid=$aid caption_module='grn.cellular.common' caption_key="link_next"}
    {/if}
{/if}

<hr>

{grn_cellular_link page="$pagepath/look1" aid=$aid caption_module='grn.bulletin.cellular' caption_key="link_look1"}<br>

{grn_cellular_link page="$pagepath/list" cid=$cid accesskey="3" caption_module='grn.bulletin.cellular' caption_key="list"}<br>
{grn_cellular_link page="$pagepath/search" accesskey="4" caption_module='grn.bulletin.cellular' caption_key="search"}<br>
{/strip}
{include file="cellular/footer.tpl"}
