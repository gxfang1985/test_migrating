{if $no_tree}
    <div id="menu_part">
        <div id="smart_main_menu_part">
            <span class="menu_item">{capture name='grn_bulletin_GRN_BLLT_3'}{cb_msg module='grn.bulletin' key='GRN_BLLT-3' replace='true'}{/capture}{grn_link page=$page_prefix|cat:'/bulletin_delete_wait' caption=$smarty.capture.grn_bulletin_GRN_BLLT_3 image='delete20.gif' cid=$category_id}</span>
            <span class="menu_item">{capture name='grn_bulletin_GRN_BLLT_4'}{cb_msg module='grn.bulletin' key='GRN_BLLT-4' replace='true'}{/capture}{grn_link page=$page_prefix|cat:'/bulletin_delete_over'  caption=$smarty.capture.grn_bulletin_GRN_BLLT_4 image='delete20.gif' cid=$category_id}</span>
            <span class="menu_item">{capture name='grn_bulletin_GRN_BLLT_5'}{cb_msg module='grn.bulletin' key='GRN_BLLT-5' replace='true'}{/capture}{grn_link page=$page_prefix|cat:'/bulletin_delete_term1' caption=$smarty.capture.grn_bulletin_GRN_BLLT_5       image='delete20.gif' cid=$category_id}</span>
            <span class="menu_item">
            {include file='bulletin/operation/_display_options.tpl'}
            </span>
        </div>
        <div id="smart_rare_menu_part">
            {if ! $no_search}
                {if ! $search_action}{assign var='search_action' value=$page_prefix|cat:"/bulletin_search"}{/if}
                {if ! $search_page}{assign var='search_page' value=$search_action}{/if}
                {capture name='grn_bulletin_GRN_BLLT_201'}{cb_msg module='grn.bulletin' key='GRN_BLLT-201' replace='true'}{/capture}{grn_simple_search caption=$app_name|cat:$smarty.capture.grn_bulletin_GRN_BLLT_201 name='text' action=$search_action page=$search_page cid=$category.cid scid=$category.cid}
            {/if}
        </div>
    </div>
{else}
    <!--menubar-->
    <div id="main_menu_part">
        <span class="menu_item">{capture name='grn_bulletin_GRN_BLLT_3'}{cb_msg module='grn.bulletin' key='GRN_BLLT-3' replace='true'}{/capture}{grn_link page=$page_prefix|cat:'/bulletin_delete_wait' caption=$smarty.capture.grn_bulletin_GRN_BLLT_3 image='delete20.gif' cid=$category_id}</span>
        <span class="menu_item">{capture name='grn_bulletin_GRN_BLLT_4'}{cb_msg module='grn.bulletin' key='GRN_BLLT-4' replace='true'}{/capture}{grn_link page=$page_prefix|cat:'/bulletin_delete_over'  caption=$smarty.capture.grn_bulletin_GRN_BLLT_4 image='delete20.gif' cid=$category_id}</span>
        <span class="menu_item">{capture name='grn_bulletin_GRN_BLLT_5'}{cb_msg module='grn.bulletin' key='GRN_BLLT-5' replace='true'}{/capture}{grn_link page=$page_prefix|cat:'/bulletin_delete_term1' caption=$smarty.capture.grn_bulletin_GRN_BLLT_5 image='delete20.gif' cid=$category_id}</span>
        <span class="menu_item">
            {include file='bulletin/_article_display_options.tpl' category_id=$category_id article_id=''}
        </span>
        <div id="rare_menu_part_under">
            <span class="menu_item">{capture name='grn_bulletin_GRN_BLLT_6'}{cb_msg module='grn.bulletin' key='GRN_BLLT-6' replace='true'}{/capture}{grn_link page=$page_prefix|cat:'/bulletin_delete_all'   caption=$smarty.capture.grn_bulletin_GRN_BLLT_6   image='delete20.gif' cid=$category_id}</span>
        </div>
    </div>
    {include file="bulletin/_category_path.tpl" search_action=$page_prefix|cat:"/bulletin_search"}
{/if}
<table width="100%">
<tr valign="top">

{if ! $no_tree}

<td id="tree_part">
{*include file="bulletin/_category_structure.tpl" no_extra=1 params=$params*}
{include file='grn/org_tree_26.tpl'}
</td>

{if $category_id}
<td id="view_part" width="90%">
<div class="bold">{$category.name|escape}</div>
 {include file='grn/memo.tpl' category_memo=$category.memo}
{/if}

{else}
<td id="view_part">
{/if}

<div class="margin_vert">
<form name="list_item" method="get" action="{grn_pageurl page=$page_info.all}">
<input type="hidden" name="cid" value="{$category_id}">
<select name="list_item" onchange="this.form.submit()">
<option value="all"{if ! $list_item || $list_item == "all"} selected{/if}>{cb_msg module='grn.bulletin' key='GRN_BLLT-7' replace='true'}
<option value="before"{if $list_item == "before"} selected{/if}>{cb_msg module='grn.bulletin' key='GRN_BLLT-8' replace='true'}
<option value="published"{if $list_item == "published"} selected{/if}>{cb_msg module='grn.bulletin' key='GRN_BLLT-9' replace='true'}
<option value="expired"{if $list_item == "expired"} selected{/if}>{cb_msg module='grn.bulletin' key='GRN_BLLT-10' replace='true'}
</select> {cb_msg module='grn.bulletin' key='GRN_BLLT-11' replace='true'} <input type="button" value="{cb_msg module='grn.bulletin' key='GRN_BLLT-12' replace='true'}" onclick="this.form.submit();">&nbsp;
<span class="sub_title">{include file="grn/smart_data_count_310.tpl" start_num=$navi.start_count end_num=$navi.end_count all_num=$navi.count}</span>
</form>
</div>

{assign var="form_name" value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page=$page_info.all}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
<input type="hidden" name="cid" value="{$category_id}">

<table class="list_column">
 <colgroup>
  <col width="1%">
  <col width="25%">
  <col width="25%">
  <col width="15%">
  <col width="20%">
  <col width="15%">
 </colgroup>
 <tr>
  <th nowrap>{include file="grn/checkall.tpl" form_name=$form_name elem_name="eid[]"}</th>
  {if $sort == 'suu'}    
    <th nowrap>{capture name='grn_bulletin_GRN_BLLT_16'}{cb_msg module='grn.bulletin' key='GRN_BLLT-16' replace='true'}{/capture}{grn_title_sort title=$smarty.capture.grn_bulletin_GRN_BLLT_16   page=$page_info.all cid=$category_id list_item=$list_item sort='sud' sp=0 reverse=1}</th>
  {else}
    {if $sort == 'sud'}
        <th nowrap>{capture name='grn_bulletin_GRN_BLLT_17'}{cb_msg module='grn.bulletin' key='GRN_BLLT-17' replace='true'}{/capture}{grn_title_sort title=$smarty.capture.grn_bulletin_GRN_BLLT_17   page=$page_info.all cid=$category_id list_item=$list_item sort='suu' sp=0}</th>
    {else}
        <th nowrap>{capture name='grn_bulletin_GRN_BLLT_18'}{cb_msg module='grn.bulletin' key='GRN_BLLT-18' replace='true'}{/capture}{grn_title_sort title=$smarty.capture.grn_bulletin_GRN_BLLT_18   page=$page_info.all cid=$category_id list_item=$list_item sort='sud' sp=0 disable=1}</th>
    {/if}
  {/if} 
  <th nowrap>{cb_msg module='grn.bulletin' key='GRN_BLLT-19' replace='true'}</th>
  <th nowrap>{cb_msg module='grn.bulletin' key='GRN_BLLT-20' replace='true'}</th>
  {if $sort == 'guu'}
  <th nowrap>{capture name='grn_bulletin_GRN_BLLT_21'}{cb_msg module='grn.bulletin' key='GRN_BLLT-21' replace='true'}{/capture}{grn_title_sort title=$smarty.capture.grn_bulletin_GRN_BLLT_21   page=$page_info.all cid=$category_id list_item=$list_item sort='gud' sp=0 reverse=1}</th>
  {else}
   {if $sort == 'gud'}
  <th nowrap>{capture name='grn_bulletin_GRN_BLLT_22'}{cb_msg module='grn.bulletin' key='GRN_BLLT-22' replace='true'}{/capture}{grn_title_sort title=$smarty.capture.grn_bulletin_GRN_BLLT_22   page=$page_info.all cid=$category_id list_item=$list_item sort='guu' sp=0}</th>
   {else}
  <th nowrap>{capture name='grn_bulletin_GRN_BLLT_23'}{cb_msg module='grn.bulletin' key='GRN_BLLT-23' replace='true'}{/capture}{grn_title_sort title=$smarty.capture.grn_bulletin_GRN_BLLT_23   page=$page_info.all cid=$category_id list_item=$list_item sort='gud' sp=0 disable=1}</th>
   {/if}
  {/if}
  {if $sort == 'ntu'}
  <th nowrap>{capture name='grn_bulletin_GRN_BLLT_24'}{cb_msg module='grn.bulletin' key='GRN_BLLT-24' replace='true'}{/capture}{grn_title_sort title=$smarty.capture.grn_bulletin_GRN_BLLT_24 page=$page_info.all cid=$category_id list_item=$list_item sort='ntd' sp=0 reverse=1}</th>
  {else}
   {if $sort == 'ntd'}
  <th nowrap>{capture name='grn_bulletin_GRN_BLLT_25'}{cb_msg module='grn.bulletin' key='GRN_BLLT-25' replace='true'}{/capture}{grn_title_sort title=$smarty.capture.grn_bulletin_GRN_BLLT_25 page=$page_info.all cid=$category_id list_item=$list_item sort='ntu' sp=0}</th>
   {else}
  <th nowrap>{capture name='grn_bulletin_GRN_BLLT_26'}{cb_msg module='grn.bulletin' key='GRN_BLLT-26' replace='true'}{/capture}{grn_title_sort title=$smarty.capture.grn_bulletin_GRN_BLLT_26 page=$page_info.all cid=$category_id list_item=$list_item sort='ntd' sp=0 disable=1}</th>
   {/if}
  {/if}
 </tr>
{foreach from=$articles item=article name="article_roop"}
 <tr valign="top" class="{if $smarty.foreach.article_roop.iteration % 2 == 0}lineone{else}linetwo{/if}">
  <td><input type=checkbox name="eid[]" value="{$article.aid}"></td>
  <td>
 {if ! $no_tree}
  {include file='bulletin/_article_subject.tpl' view_page=$page_prefix|cat:'/bulletin_view' no_read_status=1}
 {else}
  {include file='bulletin/_article_subject.tpl' view_page=$page_prefix|cat:'/bulletin_view'}
 {/if}
  </td>
  <td>{$article.data|cb_mb_truncate:$config.truncate_width|escape:"html"}</td>
{*
  <td>{if $article.cid}{$article.category_name|cb_mb_truncate:$config.truncate_width|escape:"html"}{else}{cb_msg module='grn.bulletin' key='GRN_BLLT-27' replace='true'}{/if}</td>
*}
  <td>{if ! $article.published}{cb_msg module='grn.bulletin' key='GRN_BLLT-28' replace='true'}{elseif $article.expired}{cb_msg module='grn.bulletin' key='GRN_BLLT-29' replace='true'}{else}{cb_msg module='grn.bulletin' key='GRN_BLLT-30' replace='true'}{/if}</td>
  <td>
      {if $article.manually_enter_sender != null}
          {grn_sender_name name=$article.manually_enter_sender truncated=$config.name_width no_image=true}
      {else}
          {if $article.group_name}{$article.group_name|escape} ({/if}{grn_user_name uid=$article.creator_uid name=$article.creator_name truncated=$config.name_width users_info=$users_info}{if $article.group_name} ){/if}
      {/if}
  </td>
  <td>{grn_date_format date=$article.ntime format="DateTimeCompact"}</td>
 </tr>
{/foreach}
</table>
  <div class="contents_navi">{include file="grn/word_navi.tpl" navi=$navi.navi}</div>

{literal}
<script language="JavaScript" text="text/javascript"><!--
function on_move( f, ename )
{
    if( ! grn_is_checked( f, ename ) ) return false;
    f.action = {/literal}"{grn_pageurl page=$page_prefix|cat:'/bulletin_move_multi'}"{literal};
    return true;
}
//--></script>
{/literal}
{cb_msg module='grn.bulletin' key='GRN_BLLT-31' replace='true'}{capture name='grn_bulletin_GRN_BLLT_32'}{cb_msg module='grn.bulletin' key='GRN_BLLT-32' replace='true'}{/capture}{grn_button_submit caption=$smarty.capture.grn_bulletin_GRN_BLLT_32 onclick="if(!on_move(this.form,'eid[]')) return false; "}&nbsp;

{literal}
<script language="JavaScript" text="text/javascript"><!--
function on_delete( f, ename )
{
    if( ! grn_is_checked( f, ename ) ) return false;
    f.action = {/literal}"{grn_pageurl page=$page_prefix|cat:'/bulletin_delete_multi'}"{literal};
    return true;
}
//--></script>
{/literal}
{cb_msg module='grn.bulletin' key='GRN_BLLT-33' replace='true'}{capture name='grn_bulletin_GRN_BLLT_34'}{cb_msg module='grn.bulletin' key='GRN_BLLT-34' replace='true'}{/capture}{grn_button_submit caption=$smarty.capture.grn_bulletin_GRN_BLLT_34 onclick="if(!on_delete(this.form,'eid[]')) return false; "}

</form>

</p>
</td>
</tr>
</table>
