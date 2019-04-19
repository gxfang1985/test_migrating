{strip}
<table class="list_column list_column_grn list_column_style2_grn" id="space_list">
    <tr>
        <th nowrap="" width="5px"></th>
        <th nowrap="" width="5px"></th>
        <th style="width:440px;">{cb_msg module='grn.space' key='move_discussion-13' replace='true'}</th>
        <th style="width:260px;">{cb_msg module='grn.space' key='move_discussion-14' replace='true'}</th>
        <th>{cb_msg module='grn.space' key='move_discussion-15' replace='true'}</th>
    </tr>
    {if count($this->getSpaceListArray()) > 0}
    {foreach from=$this->getSpaceListArray() item=space name=spaceList}
        <tr class="{if $smarty.foreach.spaceList.index % 2 == 0}linetwo{else}lineone{/if}">
            <td>
                <input value="{$space->getId()}" id="radio_{$space->getId()}" name="space_list_radio" type="radio">
            </td>
            <td>
                {if ! $space->isPublic()}<span class="icon-space-private-grn"></span>{/if}
            </td>
            <td>
                <label onmouseout="this.style.color=''" onmouseover="this.style.color='#ff0000'" for="radio_{$space->getId()}" style="">{$space->getSpaceName()|escape}</label>
                {assign var='spid' value=$space->getId()}
                {if count($folderList.$spid) }
                    <div style="display: none;" class="js_folder_select js_space_folder{$space->getId()} mTop5 mBottom3"><span class="label_grn mRight5">{cb_msg module='grn.space' key='move_discussion-18' replace='true'}</span>
                        <select name="select_folder_{$space->getId()}" id="select_folder_{$space->getId()}" class="mLeft5">
                            {foreach from=$folderList.$spid item=folder}
                                <option value="{$folder->getId()}">{$folder->getFolderName()|escape}</option>
                            {/foreach}
                            <option selected="selected" value="-1">{cb_msg module='grn.space' key='move_discussion-21' replace='true'}</option>
                        </select>
                    </div>
                {/if}
            </td>
            <td>{$space->getCategoryName()|escape}</td>
            <td>{$space->countMembers()|escape}</td>
        </tr>
    {/foreach}
    {/if}
</table>
{if count($this->getSpaceListArray()) == 0}
<div id="empty_space_list" class="list_message_grn">
    <div class="list_message_balloon_grn">
        <span class="bold_grn">{cb_msg module='grn.space' key='move_discussion-20' replace='true'}</span>
    </div>
    <div class="balloon_arrow_down_grn"></div>
    <div class="list_message_icon_grn">
        <span class="message_middle_icon_size_grn space_message_middle_icon_grn"></span>
    </div>
</div>
{/if}
{/strip}