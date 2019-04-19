<!-- space list -->
<table class="space-spaceList-grn">
  <tr>
    <td id="tree_part">
      <!-- tree part -->
      <div id="tree_view" class="tree_view">
      {include file='grn/org_tree_26.tpl' folder_tree=$category_tree}
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
          <col width="55%">
          <col width="10%">
          <col width="30%">
        </colgroup>
        <tr>
          <th></th>
          <th>{cb_msg module='grn.space' key='my-space-list-1' replace='true'}</th>
          <th>{cb_msg module='grn.space' key='my-space-list-2' replace='true'}&nbsp;&nbsp;</th>
          <th>{cb_msg module='grn.space' key='my-space-list-3' replace='true'}</th>
        </tr>
        {foreach from=$this->getSpaceListArray() item=space name=spaceList}
        <tr class="{if $smarty.foreach.spaceList.index % 2 == 0}linetwo{else}lineone{/if}">
          <td>{if ! $space->isPublic()}<span class="icon-space-private-grn"></span>{/if}</td>
          <td>
            <a href="{grn_pageurl page='space/top' spid=$space->getId()}">
              <span class="space-spaceList-spaceIDicon-grn">
                <img src="{$space->getDisplayIconPath()|escape}" />
              </span>{$space->getSpaceName()|escape}
            </a>
          </td>
          <td>{$space->countMembers()|escape}</td>
          <td>{$space->getComponentModifyDisplayDatetime()|escape}</td>
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

{$treeJson|grn_noescape}