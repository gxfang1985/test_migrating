<table class="space-spaceList-grn">
  <tr>
    <!-- tree part -->
    <td id="tree_part">
      <div id="tree_view" class="tree_view">
        {include file='grn/org_tree_26.tpl' folder_tree=$category_tree}
      </div>
    </td>
    <!-- end of tree part -->

    <td id="view_part">
      <!-- view part -->

      <div class="space-spaceListIconView-grn">

        <div class="space-spaceListIconView-title-grn">{cb_msg module='grn.space' key='root-space-list-1' replace='true'}</div>

        {foreach from=$this->getUpdatedSpaceCollectionArray() item=space}
        <a class="space-spaceListIconView-space-grn" href="{grn_pageurl page='space/top' spid=$space->getId()}">
          <span class="space-spaceListIconView-spaceIDicon-grn">
          <img src="{$space->getDisplayIconPath()|escape}" />
          </span>
          <span class="space-spaceListIconView-spaceName-grn">{$space->getSpaceName()|escape}</span>
        </a>
        {/foreach}

        <div class="clear_both"></div>

        <div class="space-spaceListIconView-more-grn">
          <a class="space-spaceListIconView-moreLink-grn" href="{grn_pageurl page='space/updated_list'}">{cb_msg module='grn.space' key='root-space-list-2' replace='true'}</a>
        </div>
      </div>

      <div class="space-spaceListIconView-partition-grn"></div>

      <div class="space-spaceListIconView-grn">

        <div class="space-spaceListIconView-title-grn">{cb_msg module='grn.space' key='root-space-list-3' replace='true'}</div>

        {foreach from=$this->getNewSpaceCollectionArray() item=space}
        <a class="space-spaceListIconView-space-grn" href="{grn_pageurl page='space/top' spid=$space->getId()}">
          <span class="space-spaceListIconView-spaceIDicon-grn">
          <img src="{$space->getDisplayIconPath()|escape}" />
          </span>
          <span class="space-spaceListIconView-spaceName-grn">{$space->getSpaceName()|escape}</span>
        </a>
        {/foreach}


        <div class="clear_both"></div>

        <div class="space-spaceListIconView-more-grn">
          <a class="space-spaceListIconView-moreLink-grn" href="{grn_pageurl page='space/new_list'}">{cb_msg module='grn.space' key='root-space-list-4' replace='true'}</a>
        </div>
        
      </div></td>

  </tr>

</table>



<!-- endo of space list -->
