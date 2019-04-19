{include file="grn/head.tpl"}
{include file="grn/header_no_siteposition.tpl"}

{include file='bulletin/_title_search.tpl' wt='1'} 

<div class="mainarea">
{assign var="form_name" value=$smarty.template|basename}
{grn_delete title=$delete_multi.title page=$delete_multi.page handler=$delete_multi.handler data=$delete_multi.data multi_target=$delete_multi.multi_target form_target=$delete_multi.form_target}
<!--menubar-->
<div id="menu_part">
  <div id="smart_main_menu_part">
    <span class="menu_item">{capture name='grn_bulletin_GRN_BLLT_316'}{cb_msg module='grn.bulletin' key='GRN_BLLT-316' replace='true'}{/capture}{grn_link page='bulletin/send' caption=$smarty.capture.grn_bulletin_GRN_BLLT_316 image='write20.gif' disabled=1}</span>
    <span class="menu_item">{capture name='grn_bulletin_GRN_BLLT_317'}{cb_msg module='grn.bulletin' key='GRN_BLLT-317' replace='true'}{/capture}{grn_link page='bulletin/subscribe' caption=$smarty.capture.grn_bulletin_GRN_BLLT_317 image='subscribe20.png' disabled=1}</span>
  </div>

<div id="smart_rare_menu_part">

{if ! $no_search}
 {capture name='grn_bulletin_GRN_BLLT_542'}{cb_msg module='grn.bulletin' key='GRN_BLLT-542' replace='true'}{/capture}
 {if $wt=='1'}
  {grn_simple_search caption=$app_name|cat:$smarty.capture.grn_bulletin_GRN_BLLT_542 name='text' action="bulletin/wait_search" page="bulletin/wait_search"}
 {elseif $df=='1'}
  {grn_simple_search caption=$app_name|cat:$smarty.capture.grn_bulletin_GRN_BLLT_542 name='text' action="bulletin/draft_search" page="bulletin/draft_search" cid='' df='1'}
 {else}
  {grn_simple_search caption=$app_name|cat:$smarty.capture.grn_bulletin_GRN_BLLT_542 name='text' action="bulletin/search" page="bulletin/search" cid=$category.cid scid=$category.cid}
  {/if}
{/if}
</div>
</div>

<table class="maincontents_list"><tbody><tr><td class="maincontents_list_td">
<form name="{$form_name}" method="post" action="{grn_pageurl page='bulletin/wait_delete_multi'}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
<table style="width:100%">
 <tr valign="top">
  <td id="tree_part">

{include file='grn/org_tree_26.tpl'}

  </td>
  <td id="view_part" width="90%">

   <!--view-->
   {capture name="navi_right"}{include file="grn/smart_data_count_310.tpl" start_num=$navi.start_count end_num=$navi.end_count all_num=$navi.count}{/capture}
   {include file="grn/smart_word_navi_310.tpl" navi=$navi.navi navi_right=$smarty.capture.navi_right}

   <div class="list_menu">
   <span class="list_menu_item">{include file='grn/checkall.tpl' elem_name="eid[]"}</span>  
   <span class="list_menu_item">{capture name='grn_bulletin_GRN_BLLT_321'}{cb_msg module='grn.bulletin' key='GRN_BLLT-321' replace='true'}{/capture}{grn_button_submit id="btn_delete_multi1" caption=$smarty.capture.grn_bulletin_GRN_BLLT_321 onclick="return false;"}</span>  
   </div>

   {if $use_star}
   {include file="star/star_init.tpl" list_id="bulletin_list"}
   <table class="list_column" width="100%" id="bulletin_list">
    <colgroup>
     <col width="1%">
     <col width="1%">
     <col width="40%">
     <col width="30%">
     <col width="30%">
    </colgroup>
    <tr>
     <th nowrap>&nbsp;</th>
     <th nowrap>&nbsp;</th>
   {else}
   <table class="list_column" width="100%">
    <colgroup>
     <col width="1%">
     <col width="40%">
     <col width="30%">
     <col width="30%">
    </colgroup>
    <tr>
     <th nowrap>&nbsp;</th>
   {/if}
     {if $sort == 'suu'}
     <th nowrap>{capture name='grn_bulletin_GRN_BLLT_322'}{cb_msg module='grn.bulletin' key='GRN_BLLT-322' replace='true'}{/capture}{grn_title_sort title=$smarty.capture.grn_bulletin_GRN_BLLT_322   page=$page_info.all sort='sud' sp=0 reverse=1}</th>
     {else}
      {if $sort == 'sud'}
     <th nowrap>{capture name='grn_bulletin_GRN_BLLT_323'}{cb_msg module='grn.bulletin' key='GRN_BLLT-323' replace='true'}{/capture}{grn_title_sort title=$smarty.capture.grn_bulletin_GRN_BLLT_323   page=$page_info.all sort='suu' sp=0}</th>
      {else}
     <th nowrap>{capture name='grn_bulletin_GRN_BLLT_324'}{cb_msg module='grn.bulletin' key='GRN_BLLT-324' replace='true'}{/capture}{grn_title_sort title=$smarty.capture.grn_bulletin_GRN_BLLT_324   page=$page_info.all sort='sud' sp=0 disable=1}</th>
      {/if}
     {/if}         
     {if $sort == 'cyu'}
     <th nowrap>{capture name='grn_bulletin_GRN_BLLT_325'}{cb_msg module='grn.bulletin' key='GRN_BLLT-325' replace='true'}{/capture}{grn_title_sort title=$smarty.capture.grn_bulletin_GRN_BLLT_325 page=$page_info.all sort='cyd' sp=0 reverse=1}</th>
     {else}
      {if $sort == 'cyd'}
     <th nowrap>{capture name='grn_bulletin_GRN_BLLT_326'}{cb_msg module='grn.bulletin' key='GRN_BLLT-326' replace='true'}{/capture}{grn_title_sort title=$smarty.capture.grn_bulletin_GRN_BLLT_326 page=$page_info.all sort='cyu' sp=0}</th>
      {else}
     <th nowrap>{capture name='grn_bulletin_GRN_BLLT_327'}{cb_msg module='grn.bulletin' key='GRN_BLLT-327' replace='true'}{/capture}{grn_title_sort title=$smarty.capture.grn_bulletin_GRN_BLLT_327 page=$page_info.all sort='cyd' sp=0 disable=1}</th>
      {/if}
     {/if}
     {if $sort == 'stu'}
     <th nowrap>{capture name='grn_bulletin_GRN_BLLT_328'}{cb_msg module='grn.bulletin' key='GRN_BLLT-328' replace='true'}{/capture}{grn_title_sort title=$smarty.capture.grn_bulletin_GRN_BLLT_328 page=$page_info.all sort='std' sp=0 reverse=1}</th>
     {else}
      {if $sort == 'std'}
     <th nowrap>{capture name='grn_bulletin_GRN_BLLT_329'}{cb_msg module='grn.bulletin' key='GRN_BLLT-329' replace='true'}{/capture}{grn_title_sort title=$smarty.capture.grn_bulletin_GRN_BLLT_329 page=$page_info.all sort='stu' sp=0}</th>
      {else}
     <th nowrap>{capture name='grn_bulletin_GRN_BLLT_330'}{cb_msg module='grn.bulletin' key='GRN_BLLT-330' replace='true'}{/capture}{grn_title_sort title=$smarty.capture.grn_bulletin_GRN_BLLT_330 page=$page_info.all sort='std' sp=0 disable=1}</th>
      {/if}
     {/if}
    </tr>
{foreach from=$articles item=article name="article_roop"}
    <tr valign="top" class="{if $smarty.foreach.article_roop.iteration % 2 == 0}lineone{else}linetwo{/if}">
     <td nowrap><input type=checkbox name="eid[]" value="{$article.aid}"></td>
     {if $use_star}<td nowrap>{grn_star_icon module="grn.bulletin" star_infos=$star_infos unique_id=$article.aid aid=$article.aid type="wait"}</td>{/if}
     <td nowrap>
 {if $article.file_attached}
  {grn_link page='bulletin/wait_view' caption=$article.title image='bulletin_clip30x20.gif' aid=$article.aid truncated_caption=$config.subject_width}
 {else}
  {grn_link page='bulletin/wait_view' caption=$article.title image='bulletin20.gif'         aid=$article.aid truncated_caption=$config.subject_width}
 {/if}
     </td>
 {if $article.cid === "deleted"}
      <td nowrap>{cb_msg module='grn.bulletin' key='GRN_BLLT-331' replace='true'}</td>
 {elseif strlen($article.category_name) < 1}
      <td nowrap>{cb_msg module='grn.bulletin' key='GRN_BLLT-332' replace='true'}</td>
 {else}
      <td>{$article.category_name|cb_mb_truncate:$config.truncate_width|escape:"html"}</td>
 {/if}
     <td nowrap>{grn_date_format date=$article.stime format='DateShort_MDW'}{if $article.start_is_datetime}&nbsp;{grn_date_format date=$article.stime format='TimeShort_HM'}{/if}</td>
    </tr>
{/foreach}
   </table>
   <div class="list_menu">
   <span class="list_menu_item">{include file='grn/checkall.tpl' elem_name="eid[]"}</span>  
   <span class="list_menu_item">{capture name='grn_bulletin_GRN_BLLT_333'}{cb_msg module='grn.bulletin' key='GRN_BLLT-333' replace='true'}{/capture}{grn_button_submit id="btn_delete_multi2" caption=$smarty.capture.grn_bulletin_GRN_BLLT_333 onclick="return false;"}</span>  
   </div>
   <div class="navi"><nobr>{include file="grn/word_navi.tpl" navi=$navi.navi}</nobr></div>
  </td>
 </tr>
</table>

</form>
</td></tr></tbody></table><!--end of maincontents_list-->

{include file="grn/footer.tpl"}
