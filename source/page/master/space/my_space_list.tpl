<!-- space list -->
<table class="space-spaceList-grn">
  <tr>
    <td id="tree_part">
      <!-- tree part -->
      <div id="tree_view" class="tree_view">
        <div class="tree_item">
          {if $expiration_type}<span class="hilight"><span class="bold">{/if}
            {capture name='grn_space_my_space_1'}{cb_msg module='grn.space' key='my-space-1' replace='true'}{/capture}
            {grn_link page='space/index' caption=$smarty.capture.grn_space_my_space_1 expiration_type=1}
          {if $expiration_type}</span></span>{/if}
        </div>
        <div class="tree_item">
          {if !$expiration_type}<span class="hilight"><span class="bold">{/if}
            {capture name='grn_space_my_space_2'}{cb_msg module='grn.space' key='my-space-2' replace='true'}{/capture}
            {grn_link page='space/index' caption=$smarty.capture.grn_space_my_space_2 expiration_type=0}
          {if !$expiration_type}</span></span>{/if}
        </div>
      </div>
      <!-- end of tree part -->
    </td>

    <!-- view part start -->
    <td id="view_part">

      <!-- navi part start -->
      {capture name="navi_right"}{include file="grn/smart_data_count_310.tpl" start_num=$navi.start_count end_num=$navi.end_count all_num=$navi.count}{/capture}
      {include file="grn/smart_word_navi_310.tpl" navi=$navi.navi navi_right=$smarty.capture.navi_right}
      <!-- navi part end -->

      <!-- list part start -->
      <table class="list_column">
        <colgroup>
          <col width="5%">
          <col width="45%">
          <col width="20%">
          <col width="5%">
          <col width="25%">
        </colgroup>
        <tr>
          <th></th>
          <th>{cb_msg module='grn.space' key='my-space-list-1' replace='true'}</th>
          <th>{cb_msg module='grn.space' key='my-space-list-4' replace='true'}</th>
          <th>{cb_msg module='grn.space' key='my-space-list-2' replace='true'}&nbsp;&nbsp;</th>
          <th>
            {if $expiration_type}
                {cb_msg module='grn.space' key='my-space-list-3' replace='true'}
            {else}
                {cb_msg module='grn.space' key='my-space-list-5' replace='true'}
            {/if}
          </th>
        </tr>
        {foreach from=$this->getSpaceListArray() item=space name=spaceList}
        <tr class="{if $smarty.foreach.spaceList.index % 2 == 0}linetwo{else}lineone{/if}">
          <td>{if ! $space->isPublic()}<span class="icon-space-private-grn"></span>{/if}</td>
          <td>
            <a href="{grn_pageurl page=$space_detail_url spid=$space->getId()}">
              <span class="space-spaceList-spaceIDicon-grn">
                <img src="{$space->getDisplayIconPath()}" />
              </span>{$space->getSpaceName()|escape}
            </a>
          </td>
          <td><a href="{grn_pageurl page='space/list' cid=$space->getCategoryId()}">{$space->getCategoryName()|escape}</a></td>
          <td>{$space->countMembers()|escape}</td>
          <td>
            {if $expiration_type}
                {$space->getComponentModifyDisplayDatetime()|escape}
            {else}
                {grn_space_display_expiration_date space=$space dynamic_format=true}
            {/if}
          </td>
        </tr>
        {/foreach}

      </table>
      <!-- list part end -->
      <!-- navi part start -->
      <div class="list">
        <p class="item">
        <div class="navi">{include file="grn/word_navi.tpl" navi=$navi.navi}</div>
        </p>
      </div>
      <!-- navi part end -->
    </td>
    <!-- end of view part -->
  </tr>
</table>

<!-- endo of space list -->
