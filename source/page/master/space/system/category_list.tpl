{include file="grn/system_head.tpl"}
{include file="grn/system_header.tpl"}
{grn_load_javascript file="grn/html/page/space/system/category_list.js"}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var="form_name" value=$smarty.template|basename}

<div id="main_menu_part">
<span class="menu_item">{capture name='grn_space_system_GRN_SPACE_SY_1'}{cb_msg module='grn.space.system' key='GRN_SPACE_SY-1' replace='true'}{/capture}{grn_link page='space/system/category_add' caption=$smarty.capture.grn_space_system_GRN_SPACE_SY_1 image='category20.gif' cid=$cid filter_id=$filter_id}</span>
<span class="menu_item">{capture name='grn_space_system_GRN_SPACE_SY_2'}{cb_msg module='grn.space.system' key='GRN_SPACE_SY-2' replace='true'}{/capture}{grn_link page='space/system/category_view' caption=$smarty.capture.grn_space_system_GRN_SPACE_SY_2 image='detail20.gif' cid=$cid filter_id=$filter_id}</span>
{if $category_childcount }
<span class="menu_item">{capture name='grn_space_system_GRN_SPACE_SY_3'}{cb_msg module='grn.space.system' key='GRN_SPACE_SY-3' replace='true'}{/capture}{grn_link page='space/system/category_order' caption=$smarty.capture.grn_space_system_GRN_SPACE_SY_3 image='order20.gif' cid=$cid filter_id=$filter_id}</span>
{else}
<span class="menu_item">{capture name='grn_space_system_GRN_SPACE_SY_6'}{cb_msg module='grn.space.system' key='GRN_SPACE_SY-6' replace='true'}{/capture}{grn_link page='space/system/category_order' caption=$smarty.capture.grn_space_system_GRN_SPACE_SY_6 image='order20.gif' cid=$cid disabled=1 filter_id=$filter_id}</span>
{/if}
<div id="rare_menu_part_under">
  <span class="menu_item">{capture name='grn_space_system_GRN_SPACE_SY_56'}{cb_msg module='grn.space.system' key='GRN_SPACE_SY-56' replace='true'}{/capture}{grn_link page='space/system/delete_expired_space' caption=$smarty.capture.grn_space_system_GRN_SPACE_SY_56 image='delete20.gif'  cid=$cid filter_id=$filter_id}</span>
  <span class="menu_item">{capture name='grn_space_system_GRN_SPACE_SY_55'}{cb_msg module='grn.space.system' key='GRN_SPACE_SY-55' replace='true'}{/capture}{grn_link page='space/system/delete_public_space' caption=$smarty.capture.grn_space_system_GRN_SPACE_SY_55 image='delete20.gif'  cid=$cid filter_id=$filter_id}</span>
</div>
</div>
<form name="{$form_name}" method="post" action="{grn_pageurl page='space/system/command_category_list'}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
    <input type="hidden" name="cid" value="{$this->getCategoryId()|escape}" />
    <input type="hidden" name="cmd" value="" />
    <table class="space-spaceList-grn" style= "width:100%;">
      <tr>
      <td id="tree_part" valign="top">
          {include file='grn/org_tree_26.tpl' folder_tree=$category_tree} 
      </td>
      <td id="view_part" valign="top">
        <div class="margin_bottom">
          <div>
          <span class="bold">{$category_name|escape}</span>
          <span>{capture name='grn_space_system_GRN_SPACE_SY_10'}{cb_msg module='grn.space.system' key='GRN_SPACE_SY-10' replace='true'}{/capture}{grn_link image='detail20.gif' page='space/system/category_view' cid=$cid filter_id=$filter_id caption=$smarty.capture.grn_space_system_GRN_SPACE_SY_10}</span>&nbsp;&nbsp;
          <span>{cb_msg module='grn.space.system' key='space_disk_size' replace='true'}{grn_format_filesize size=$category_Usage precision="2" round='ceil'}</span>
          </div>
          {if 0 < $category.memo|count_characters:true}
           {include file='grn/memo.tpl' category_memo=$category.memo}
          {/if}
        </div>
        <div id="menu_part" class="js_filter_container" >
          {strip}
          <span class="menu_item">
            <select name="filter" class="js_filter_value">
              <option value="0" {if $filter_id == "0"} selected{/if}>{cb_msg module='grn.space.system' key='GRN_SPACE_SY-48' replace='true'}
              <option value="1" {if $filter_id == "1"} selected{/if}>{cb_msg module='grn.space.system' key='GRN_SPACE_SY-49' replace='true'}
              <option value="2" {if $filter_id == "2"} selected{/if}>{cb_msg module='grn.space.system' key='GRN_SPACE_SY-50' replace='true'}
            </select>
          </span>
          <span class="menu_item">
              {capture name='grn_space_system_GRN_SPACE_SY_51'}
                  {cb_msg module='grn.space.system' key='GRN_SPACE_SY-51' replace='true'}
              {/capture}
              {grn_button_submit class='js_filter_command' onclick="return false;" caption=$smarty.capture.grn_space_system_GRN_SPACE_SY_51}

          </span>
          <span class="sub_title menu_item">
              {include file="grn/smart_data_count_310.tpl" start_num=$navi.start_count end_num=$navi.end_count all_num=$navi.count}
          </span>
            {/strip}
        </div>
        <div class="list_menu">
         <span class="list_menu_item">{include file="grn/checkall.tpl" form_name=$form_name elem_name="spid[]"}</span>
          {capture name='grn_space_system_GRN_SPACE_SY_15'}{cb_msg module='grn.space.system' key='GRN_SPACE_SY-15' replace='true'}{/capture}{grn_button_submit id='btn_delete_multi1' caption=$smarty.capture.grn_space_system_GRN_SPACE_SY_15 onclick="if(!grn_is_checked(this.form,'spid[]')) return false; cmd.value='delete';"}
          {capture name='grn_space_system_GRN_SPACE_SY_13'}{cb_msg module='grn.space.system' key='GRN_SPACE_SY-13' replace='true'}{/capture}{grn_button_submit caption=$smarty.capture.grn_space_system_GRN_SPACE_SY_13 onclick="if(!grn_is_checked(this.form,'spid[]')) return false; cmd.value='move';"}
        </div>
          <!-- list part start -->
          <table class="list_column">
            <colgroup>
              <col width="2%">
              <col width="2%">
              <col width="40%">
              <col width="6%">
              <col width="18%">
              <col width="5%">
              <col width="18%">
              <col width="8%">
            </colgroup>

            <tr>
              <th></th>
              <th>{grn_image image="private20.gif" }</th>
              <th>{cb_msg module='grn.space.system' key='space_name' replace='true'}</th>
              <th>{cb_msg module='grn.space.system' key='space_expiration_status' replace='true'}</th>
              <th>{cb_msg module='grn.space.system' key='space_member_expiration_date' replace='true'}</th>
              <th>{cb_msg module='grn.space.system' key='space_member' replace='true'}</th>

              {if $sort == 'mtu'}
                <th>{cb_msg module='grn.space.system' key='updated_time' replace='true'}{grn_title_sort title=$smarty.capture.grn_space_system_updated_time page=$page_info.all cid=$cid sort='mtd' sp=0 filter_id=$filter_id reverse=1}</th>
              {else}
                {if $sort == 'mtd'}
                  <th>{cb_msg module='grn.space.system' key='updated_time' replace='true'}{grn_title_sort title=$smarty.capture.grn_space_system_updated_time page=$page_info.all cid=$cid sort='mtu' sp=0 filter_id=$filter_id }</th>
                {else}
                  <th>{cb_msg module='grn.space.system' key='updated_time' replace='true'}{grn_title_sort title=$smarty.capture.grn_space_system_updated_time page=$page_info.all cid=$cid sort='mtd' sp=0 filter_id=$filter_id disable=1}</th>
                {/if}
              {/if}

              {if $sort == 'fsu'}
                <th>{cb_msg module='grn.space.system' key='size' replace='true'}{grn_title_sort title=$smarty.capture.grn_space_system_size page=$page_info.all cid=$cid sort='fsd' sp=0 filter_id=$filter_id reverse=1}</th>
              {else}
                {if $sort == 'fsd'}
                  <th>{cb_msg module='grn.space.system' key='size' replace='true'}{grn_title_sort title=$smarty.capture.grn_space_system_size page=$page_info.all cid=$cid sort='fsu' sp=0 filter_id=$filter_id}</th>
                {else}
                  <th>{cb_msg module='grn.space.system' key='size' replace='true'}{grn_title_sort title=$smarty.capture.grn_space_system_size page=$page_info.all cid=$cid sort='fsd' sp=0 filter_id=$filter_id disable=1}</th>
                {/if}
              {/if}
            </tr>

            {foreach from=$space_collection item=space }
              <tr>
                <td><input type="checkbox" name="spid[]" value="{$space->getId()|escape}"></td>
                <td>
                  {if !$space->isPublic()}{grn_image image="private20.gif" }{/if}
                </td>
                <td>
                    {if $space->isExpired()}
                      <a href="{grn_pageurl page='space/config_view' spid=$space->getId()}"
                         target="_blank">{$space->getSpaceName()|escape}</a>
                    {else}
                      <a href="{grn_pageurl page='space/top' spid=$space->getId()}"
                         target="_blank">{$space->getSpaceName()|escape}</a>
                    {/if}
                </td>
                <td class="nowrap_grn">
                    {if $space->isExpired()}
                        {cb_msg module='grn.space.system' key='GRN_SPACE_SY-53' replace='true'}
                    {else}
                        {cb_msg module='grn.space.system' key='GRN_SPACE_SY-52' replace='true'}
                    {/if}
                </td>
                <td>
                    {if $space->getIsUnlimitedExpirationDate()}
                        {cb_msg module='grn.space.system' key='GRN_SPACE_SY-57' replace='true'}
                    {else}
                        {grn_space_display_expiration_date space=$space}
                    {/if}
                </td>
                <td>
                  {$space->countMembers()}
                </td>
                <td>
                  {$space->getComponentModifyDisplayDatetime()|escape}
                </td>
                <td>
                  {grn_format_filesize size=$space->getFileUsage() precision="2" round='ceil'}
                </td>
              </tr>
            {/foreach}
          </table>
        <div class="list_menu">
         <span class="list_menu_item">{include file="grn/checkall.tpl" form_name=$form_name elem_name="spid[]"}</span>
          {capture name='grn_space_system_GRN_SPACE_SY_15'}{cb_msg module='grn.space.system' key='GRN_SPACE_SY-15' replace='true'}{/capture}{grn_button_submit id='btn_delete_multi1' caption=$smarty.capture.grn_space_system_GRN_SPACE_SY_15 onclick="if(!grn_is_checked(this.form,'spid[]')) return false;  cmd.value='delete';"}
          {capture name='grn_space_system_GRN_SPACE_SY_13'}{cb_msg module='grn.space.system' key='GRN_SPACE_SY-13' replace='true'}{/capture}{grn_button_submit caption=$smarty.capture.grn_space_system_GRN_SPACE_SY_13 onclick="if(!grn_is_checked(this.form,'spid[]')) return false; cmd.value='move';"}
        </div>
        <!-- list part end -->
        <div class="contents_navi"><nobr>
         {include file="grn/word_navi.tpl" navi=$navi.navi}</nobr>
        </div>
      </td>
      </tr>
    </table>
</form>
{include file="grn/system_footer.tpl"}
