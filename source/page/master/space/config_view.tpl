{grn_load_javascript file="grn/html/page/space/application/join_leave.js"}
{include file='grn/window_simple_dialog.tpl'}
{grn_load_javascript file="grn/html/page/space/config_view.js"}
<script language="JavaScript" type="text/javascript">
  <!--
  grn.page.space.config_view.spid = "{$this->getSpaceId()}";
  //-->
</script>

{grn_space_show_expiration_date_warning space=$this_getSpace}

<div id="menu_part">
  {if $this->isOperationPrivilege()}
  <div id="smart_main_menu_part">
    {if $this_getSpace->isExpired()}
      <span class="menu_item"><nobr>
        {capture name='grn_space_view_space_35'}{cb_msg module='grn.space' key='view-space-35' replace='true'}{/capture}{grn_link page="space/config_expiration_date" spid=$this->getSpaceId() caption=$smarty.capture.grn_space_view_space_35 image='modify20.gif' element_id="space/config_expiration_date"}
      </nobr></span>
    {else}
      <span class="menu_item"><nobr>
        {capture name='grn_space_view_space_8'}{cb_msg module='grn.space' key='view-space-8' replace='true'}{/capture}{grn_link page="space/config_modify" spid=$this->getSpaceId() caption=$smarty.capture.grn_space_view_space_8 image='modify20.gif' element_id="space/config_modify"}
      </nobr></span>
      <span class="menu_item"><nobr>
        {capture name='grn_space_view_space_23'}{cb_msg module='grn.space' key='view-space-23' replace='true'}{/capture}{grn_link page="space/member_modify" spid=$this->getSpaceId() caption=$smarty.capture.grn_space_view_space_23 image='user20.gif' element_id="space/config_modify"}
      </nobr></span>
    {/if}
  {/if}
  {if !$this_getSpace->isExpired()}
    {if $this->isSpaceAllowJoinLeave()}
      {if !$this->isMember()}
        <span class="menu_item">
        <nobr>
          <a href="javascript:void(0);" onclick="grn.page.space.join_leave.checkShowDialog( {$this->getSpaceId()}, 'join');">
            {grn_image image='loginuser20.gif'}{cb_msg module='grn.space' key='view-space-29' replace='true'}
          </a>
        </nobr>
      </span>
      {elseif !$this->isUniqueSpaceMember() && !$this->isUniqueSpaceOperatorWithCurrentUser()}
        <span class="menu_item">
        <nobr>
          <a href="javascript:void(0);" onclick="grn.page.space.join_leave.checkShowDialog( {$this->getSpaceId()}, 'leave');">
            {grn_image image='out_schedule20.gif'}{cb_msg module='grn.space' key='view-space-28' replace='true'}
          </a>
        </nobr>
      </span>
      {/if}
    {elseif $this->isMember() && $this->isOperationPrivilege() && !$this->isUniqueSpaceMember() && !$this->isUniqueSpaceOperatorWithCurrentUser()}
      <span class="menu_item">
        <nobr>
          <a href="javascript:void(0);" onclick="grn.page.space.join_leave.checkShowDialog( {$this->getSpaceId()}, 'leave');">
            {grn_image image='out_schedule20.gif'}{cb_msg module='grn.space' key='view-space-28' replace='true'}
          </a>
        </nobr>
      </span>
    {/if}
    {if $canReuse}
      <span class="menu_item"><nobr>
        {capture name='grn_space_view_space_24'}{cb_msg module='grn.space' key='view-space-24' replace='true'}{/capture}{grn_link page="space/reuse" spid=$this->getSpaceId() caption=$smarty.capture.grn_space_view_space_24 image='reuse20.gif' element_id="space/config_modify"}
      </nobr></span>
    {/if}
  {/if}
  {if $this->isOperationPrivilege()}
    <span class="menu_item"><nobr>
      {capture name='grn_space_view_space_9'}{cb_msg module='grn.space' key='view-space-9' replace='true'}{/capture}{grn_link script="javascript:void(0);" caption=$smarty.capture.grn_space_view_space_9 image='delete20.gif' element_id="space_delete"}
    </nobr></span>
  </div>
  {/if}
</div>

<table class="view_table margin_top" width="80%" style="table-layout:fixed;">
  <colgroup>
    <col width="20%">
    <col width="80%">
  </colgroup>
  <tbody>
    <tr>
      <th nowrap>{cb_msg module='grn.space' key='view-space-12' replace='true'}</th>
      <td>{$this_getSpace->getSpaceName()|escape}</td>
    </tr>
    <tr>
      <th nowrap>{cb_msg module='grn.space' key='view-space-13' replace='true'}</th>
      <td>{$this_getCategory->getCategoryName()|escape}</td>
    </tr>
    <tr>
      <th nowrap>{cb_msg module='grn.space' key='view-space-14' replace='true'}</th>
      <td><img src="{$this_getSpace->getDisplayIconPath()|escape}"></td>
    </tr>
    <tr>
      {capture name='header_members'}
        {cb_msg module='grn.space' key='view-space-members-prefix' replace='true'}{$count_space_members}{cb_msg module='grn.space' key='view-space-members-suffix' replace='true'}
      {/capture}
      {include file='space/_member_display.tpl' header=$smarty.capture.header_members
                                                id='members'
                                                user_collection=$this->getSpaceUserCollection()
                                                append_script_file=true}
    </tr>
    <tr>
      {capture name='header_admins'}
        {cb_msg module='grn.space' key='view-space-admins-prefix' replace='true'}{$count_space_admins}{cb_msg module='grn.space' key='view-space-admins-suffix' replace='true'}
      {/capture}
      {include file='space/_member_display.tpl' header=$smarty.capture.header_admins
                                                id='admins'
                                                user_collection=$this->getSpaceOperatorCollection()
                                                append_script_file=false}
    </tr>
    <tr>
      <th nowrap>{cb_msg module='grn.space' key='view-space-33' replace='true'}</th>
      <td>
          {if $this_getSpace->getIsUnlimitedExpirationDate()}
              {cb_msg module='grn.space' key='view-space-34' replace='true'}
          {else}
              {grn_space_display_expiration_date space=$this_getSpace}
          {/if}
      </td>
    </tr>
    <tr>
      <th>{cb_msg module='grn.space' key='view-space-30' replace='true'}</th>
      <td>{if $this->isSpaceAllowJoinLeave()}{cb_msg module='grn.space' key='view-space-31' replace='true'}{else}{cb_msg module='grn.space' key='view-space-32' replace='true'}{/if}</td>
    </tr>
    <tr>
      <th nowrap>{cb_msg module='grn.space' key='view-space-15' replace='true'}</th>
      <td>{if $this_getSpace->isPublic()}{cb_msg module='grn.space' key='view-space-16' replace='true'}{else}{cb_msg module='grn.space' key='view-space-17' replace='true'}{/if}</td>
    </tr>
    <tr>
      <th nowrap>{cb_msg module='grn.space' key='view-space-19' replace='true'}</th>
      <td>{$this->getFileUsageMB()|escape}MB</td>
    </tr>
  </tbody>
</table>

<table class="view_table margin_top" width="80%" style="margin-top:20px; table-layout:fixed;">
  <colgroup>
    <col width="20%">
    <col width="80%">
  </colgroup>
  <tbody>
    <tr>
      <th nowrap>{cb_msg module='grn.space' key='view-space-10' replace='true'}</th>
      <td>{grn_space_user_link user=$this_getSpace->getCreator()} {$this_getSpace->getCreateDisplayDatetime()|escape}</td>
    </tr>
    <tr>
      <th nowrap>{cb_msg module='grn.space' key='view-space-11' replace='true'}</th>
      <td>{grn_space_user_link user=$this_getSpace->getModifier()} {$this_getSpace->getModifyDisplayDatetime()|escape}</td>
    </tr>
  </tbody>
</table>