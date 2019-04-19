{include file="grn/head.tpl"}
{include file="grn/header.tpl"}
{capture name='grn_link_GRN_LNK_41'}{cb_msg module='grn.link' key='GRN_LNK-41' replace='true'}{/capture}{grn_title title=$smarty.capture.grn_link_GRN_LNK_41 class='message'}
{assign var='form_name' value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='link/search'}">
 <p>
 <table class="std_form">
  <tr>
   <th>{cb_msg module='grn.link' key='GRN_LNK-42' replace='true'}</th>
   <td>
    {grn_text necessary=true name='search_text' value=$search_text size='50'}
    <input type="submit" name="Search" value="{cb_msg module='grn.link' key='GRN_LNK-43' replace='true'}"><br>
   </td>
  </tr>
  <tr>
   <th>{cb_msg module='grn.link' key='GRN_LNK-44' replace='true'}</th>
   <td>
      {if $category.cid}
        {if 'all' == $target_category}
          {grn_radio name="target_category" id="select" value="select" caption=$category.title}{cb_msg module='grn.link' key='GRN_LNK-45' replace='true'}{capture name='grn_link_GRN_LNK_46'}{cb_msg module='grn.link' key='GRN_LNK-46' replace='true'}{/capture}{grn_radio name="target_category" id="all" value="all" caption=$smarty.capture.grn_link_GRN_LNK_46 checked=TRUE}
    {else}
      {grn_radio name="target_category" id="select" value="select" caption=$category.title checked=TRUE}{cb_msg module='grn.link' key='GRN_LNK-47' replace='true'}{capture name='grn_link_GRN_LNK_48'}{cb_msg module='grn.link' key='GRN_LNK-48' replace='true'}{/capture}{grn_radio name="target_category" id="all" value="all" caption=$smarty.capture.grn_link_GRN_LNK_48}
    {/if}
      {else}
        {cb_msg module='grn.link' key='GRN_LNK-49' replace='true'}
    <input type="hidden" name="target_category" value="all">
      {/if}
   </td>
  </tr>
  <tr>
   <th>{cb_msg module='grn.link' key='GRN_LNK-50' replace='true'}</th>
   <td>{capture name='grn_link_GRN_LNK_51'}{cb_msg module='grn.link' key='GRN_LNK-51' replace='true'}{/capture}{grn_checkbox name='search_keys[]' id='sub' value='sub' checked=$search_keys.sub caption=$smarty.capture.grn_link_GRN_LNK_51}</td>
  </tr>
  <tr>
   <th>{cb_msg module='grn.link' key='GRN_LNK-52' replace='true'}</th>
   <td>
    <select name="search_term">
     <option value="1"{if 1 == $search_term} selected{/if}>{cb_msg module='grn.link' key='GRN_LNK-53' replace='true'}
     <option value="3"{if 3 == $search_term} selected{/if}>{cb_msg module='grn.link' key='GRN_LNK-55' replace='true'}
     <option value="6"{if 6 == $search_term} selected{/if}>{cb_msg module='grn.link' key='GRN_LNK-57' replace='true'}
     <option value="12"{if 12 == $search_term} selected{/if}>{cb_msg module='grn.link' key='GRN_LNK-59' replace='true'}
     <option value="-1"{if -1 == $search_term} selected{/if}>{cb_msg module='grn.link' key='GRN_LNK-61' replace='true'}
    </select>
   </td>
  </tr>
  <tr valign="top">
   <th>{cb_msg module='grn.link' key='GRN_LNK-62' replace='true'}</th>
   <td>
    {capture name='grn_link_GRN_LNK_63'}{cb_msg module='grn.link' key='GRN_LNK-63' replace='true'}{/capture}{grn_checkbox name='search_keys[]' id='category' value='category' checked=$search_keys.category caption=$smarty.capture.grn_link_GRN_LNK_63}<br>
    {capture name='grn_link_GRN_LNK_64'}{cb_msg module='grn.link' key='GRN_LNK-64' replace='true'}{/capture}{grn_checkbox name='search_keys[]' id='title' value='title' checked=$search_keys.title caption=$smarty.capture.grn_link_GRN_LNK_64}
    {grn_checkbox name='search_keys[]' id='url' value='url' checked=$search_keys.url caption='URL'}
   </td>
  </tr>
  <tr>
   <td></td>
   <td>
    <div class="mTop10">
     {capture name='grn_link_GRN_LNK_65'}{cb_msg module='grn.link' key='GRN_LNK-65' replace='true'}{/capture}
     {grn_button ui="main" action="submit" caption=$smarty.capture.grn_link_GRN_LNK_65 id="link_button_save"}
    </div>
   </td>
  </tr>
 </table>

 <p>
 <div class="sub_title">{cb_msg module='grn.link' key='GRN_LNK-66' replace='true'} {include file="grn/smart_data_count_310.tpl" start_num=$personal_category_navi.start_count end_num=$personal_category_navi.end_count all_num=$personal_category_navi.count}</div>
 <div class="navi"><nobr>{include file='grn/word_navi.tpl' navi=$personal_category_navi.navi}</nobr></div>
 <table class="list_column">
  <colgroup>
   <col width="60%">
   <col width="40%">
  </colgroup>
  <tr>
   <th nowrap>{cb_msg module='grn.link' key='GRN_LNK-69' replace='true'}</th>
   <th nowrap>{cb_msg module='grn.link' key='GRN_LNK-70' replace='true'}</th>
  </tr>
{foreach from=$search.search_personal_category item=search_personal_category}
  <tr>
   <td nowrap>{grn_link caption=$search_personal_category.title image='category20.gif' page='link/index' cid=$search_personal_category.cid}</td>
   <td nowrap>
 {if $search_personal_category.cid != 1}
    {grn_image image='category20.gif'}{grn_link caption=$personal_root.title page='link/index'  type='personal'} &gt; 
 {/if}
 {foreach from=$search_personal_category.path item=path}
    {grn_link caption=$path.title page='link/index' cid=$path.cid  type='personal'} &gt; 
 {/foreach}
    {$search_personal_category.title|escape:"html"}
   </td>
  </tr>
{/foreach}
 </table>
 <div class="navi"><nobr>{include file='grn/word_navi.tpl' navi=$personal_category_navi.navi}</nobr></div>

 <p>
 <div class="sub_title">{cb_msg module='grn.link' key='GRN_LNK-72' replace='true'} {include file="grn/smart_data_count_310.tpl" start_num=$personal_link_navi.start_count end_num=$personal_link_navi.end_count all_num=$personal_link_navi.count}</div>
 <div class="navi"><nobr>{include file='grn/word_navi.tpl' navi=$personal_link_navi.navi}</nobr></div>
 <table class="list_column">
  <colgroup>
   <col width="25%">
   <col width="35%">
   <col width="40%">
  </colgroup>
  <tr>
   <th nowrap>{cb_msg module='grn.link' key='GRN_LNK-75' replace='true'}</th>
   <th nowrap>URL</th>
   <th nowrap>{cb_msg module='grn.link' key='GRN_LNK-76' replace='true'}</th>
  </tr>
{foreach from=$search.search_personal_link item=search_personal_link}
  <tr>
   <td nowrap>{grn_link_raw caption=$search_personal_link.title image='linklist20.gif' page=$search_personal_link.url no_script=true}</td>
   <td nowrap>{grn_link_raw caption=$search_personal_link.url page=$search_personal_link.url target='_blank' no_script=true}</td>
   <td nowrap>
    {grn_image image='category20.gif'}{grn_link caption=$personal_root.title page='link/index' type='personal'}
 {foreach from=$search_personal_link.path item=path}
     &gt; {grn_link caption=$path.title page='link/index' cid=$path.cid type='personal'}
 {/foreach}
     {if $search_personal_link.cid > 1}
     &gt; {grn_link caption=$search_personal_link.category page='link/index' cid=$search_personal_link.cid type='personal'}
     {/if}
   </td>
  </tr>
{/foreach}
 </table>
 <div class="navi"><nobr>{include file='grn/word_navi.tpl' navi=$personal_link_navi.navi}</nobr></div>

 <p>
 <div class="sub_title">{cb_msg module='grn.link' key='GRN_LNK-78' replace='true'} {include file="grn/smart_data_count_310.tpl" start_num=$system_category_navi.start_count end_num=$system_category_navi.end_count all_num=$system_category_navi.count}</div>
 <div class="navi"><nobr>{include file='grn/word_navi.tpl' navi=$system_category_navi.navi}</nobr></div>
 <table class="list_column">
  <colgroup>
   <col width="60%">
   <col width="40%">
  </colgroup>
  <tr>
   <th nowrap>{cb_msg module='grn.link' key='GRN_LNK-81' replace='true'}</th>
   <th nowrap>{cb_msg module='grn.link' key='GRN_LNK-82' replace='true'}</th>
  </tr>
{foreach from=$search.search_system_category item=search_system_category}
  <tr>
   <td nowrap>{grn_link caption=$search_system_category.title image='category20.gif' page='link/index' cid=$search_system_category.cid type='share'}</td>
   <td nowrap>
 {if $search_system_category.cid != 1}
    {grn_image image='category20.gif'}{grn_link caption=$system_root.title page='link/index'} &gt; 
 {/if}
 {foreach from=$search_system_category.path item=path}
    {grn_link caption=$path.title page='link/index' cid=$path.cid type='share'} &gt; 
 {/foreach}
    {$search_system_category.title|escape:"html"}
   </td>
  </tr>
{/foreach}
 </table>
 <div class="navi"><nobr>{include file='grn/word_navi.tpl' navi=$system_category_navi.navi}</nobr></div>

 <p>
 <div class="sub_title">{cb_msg module='grn.link' key='GRN_LNK-84' replace='true'} {include file="grn/smart_data_count_310.tpl" start_num=$system_link_navi.start_count end_num=$system_link_navi.end_count all_num=$system_link_navi.count}</div>
 <div class="navi"><nobr>{include file='grn/word_navi.tpl' navi=$system_link_navi.navi}</nobr></div>
 <table class="list_column">
  <colgroup>
   <col width="25%">
   <col width="35%">
   <col width="40%">
  </colgroup>
  <tr>
   <th nowrap>{cb_msg module='grn.link' key='GRN_LNK-87' replace='true'}</th>
   <th nowrap>URL</th>
   <th nowrap>{cb_msg module='grn.link' key='GRN_LNK-88' replace='true'}</th>
  </tr>
{foreach from=$search.search_system_link item=search_system_link}
  <tr>
  {if $item.sid > 0}
    <td nowrap>{grn_sso_link caption=$search_system_link.title sso_id=$search_system_link.sid app_id="link" id_list=$search_system_link.sso_param redirect_url=$search_system_link.url}</td>
    <td nowrap>{grn_sso_link caption=$search_system_link.url sso_id=$search_system_link.sid app_id="link" id_list=$search_system_link.sso_param redirect_url=$search_system_link.url target='_blank'}</td>
  {else}
    <td nowrap>{grn_link_raw caption=$search_system_link.title image='linklist20.gif' page=$search_system_link.url no_script=true}</td>
    <td nowrap>{grn_link_raw caption=$search_system_link.url page=$search_system_link.url target='_blank' no_script=true}</td>
  {/if}
   <td nowrap>
    {grn_image image='category20.gif'}{grn_link caption=$system_root.title page='link/index' }
 {foreach from=$search_system_link.path item=path}
     &gt; {grn_link caption=$path.title page='link/index' cid=$path.cid type='share'}
 {/foreach}
     {if $search_system_link.cid > 1}
     &gt; {grn_link caption=$search_system_link.category page='link/index' cid=$search_system_link.cid type='share'}
     {/if}
   </td>
  </tr>
{/foreach}
 </table>
 <div class="navi"><nobr>{include file='grn/word_navi.tpl' navi=$system_link_navi.navi}</nobr></div>

 <input type="hidden" name="optional_search" value="1">
 <input type="hidden" name="cid" value="{$category.cid}">
 <input type="hidden" name="type" value="{$type|escape}">
</form>

{include file='grn/footer.tpl'}
