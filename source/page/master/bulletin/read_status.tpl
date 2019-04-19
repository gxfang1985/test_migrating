{include file='grn/head.tpl'}
{include file='grn/header.tpl'}

{grn_title title=$page_title class=$page_info.parts[0]}
<div class="sub_title">{$sub_title}</div>
{capture name="navi_right"}{include file="grn/smart_data_count_310.tpl" start_num=$navi_info.start_count end_num=$navi_info.end_count all_num=$navi_info.count}{/capture}
  {include file="grn/smart_word_navi_310.tpl" navi=$navi_info.navi navi_right=$smarty.capture.navi_right}

<table class="list_column">
 <colgroup>
  <col width="5%">
  <col width="15%">

 </colgroup>
 <tr>
  <th nowrap>
    {cb_msg module='grn.message' key='GRN_MSG-333' replace='true'}
  </th>
  <th nowrap>
  {cb_msg module='grn.message' key='GRN_MSG-334' replace='true'}
  </th>
{foreach from=$user_info item=info}
 <tr>

    <td nowrap>

    {grn_user_name uid = $info.uid name = $info.name users_info = $users_info}

    </td>

  <td nowrap>
      {if $info.vtime}
        {grn_date_format date=$info.vtime format='DateTimeMiddle_YMDW_HM'}
      {elseif $info.no_receive}
        -
      {/if}
  </td>

 </tr>
{/foreach}
</table>
<div class="navi"><nobr>{include file="grn/word_navi.tpl" navi=$navi_info.navi}</nobr></div>

<p>
{include file='grn/footer.tpl'}
