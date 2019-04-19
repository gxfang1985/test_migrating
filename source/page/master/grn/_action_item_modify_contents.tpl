{if $item.extended}
    {* add a prefix 'extended_' before a variable name *}
    {assign var='item_id' value="extended_$item_id"}
{/if}
{if $item_id == 'display_name'}
	{if $builtin_items.nickname}
        <table border="0" cellpadding="0" cellspacing="0">
        <tr>
        <td nowrap style="border: 0px;">
        {cb_msg module='grn' key='GRN_GRN-199' replace='true'}:
        </td>
        <td nowrap style="border: 0px;">
		{if $not_modify}
		  {$item.value|escape}({cb_language_name code=$builtin_items.display_name_language.value})
          {* バリデータを初期化するためのダミー  *}
          {grn_text name='dummy_field' value='dummy' style='display:none;'}
          {validate form=$form_name field='dummy_field' criteria='notEmpty' }
		{else}
          {grn_text name=$item_id size='50' maxlength='100' value=$item.value disable_return_key=true}
          {grn_select name="display_name_language" options=$languages_param}
          {capture name='grn_grn_GRN_GRN_1342'}{cb_msg module='grn.grn' key='GRN_GRN-1342' replace='true'}{/capture}
          {validate form=$form_name field=$item_id criteria='notEmpty' message=$item.display_name|cat:$smarty.capture.grn_grn_GRN_GRN_1342 transform='cb_trim' append='validation_errors'}
        {/if}
        </tr>
        <tr>
        <td nowrap style="border: 0px;">
        {cb_msg module='grn' key='GRN_GRN-200' replace='true'}:
        </td>
        <td nowrap style="border: 0px;" id="nickname">
		{if $not_modify}
		{$builtin_items.nickname.value}
		{else}
        {grn_text name="nickname" size='50' maxlength='100' value=$builtin_items.nickname.value disable_return_key=true}
	    {capture name='tmp'}{cb_msg module='grn.grn' key='GRN_GRN-IsAsciiBefore' replace='true'}{$builtin_items.nickname.display_name}{cb_msg module='grn.grn' key='GRN_GRN-IsAsciiAfter' replace='true'}{/capture}{validate form=$form_name field="nickname" criteria='grn_isAscii' message=$smarty.capture.tmp transform='cb_trim' append='validation_errors'}
        {/if}
        </td>
        </tr>
        </table>
    {else}
        {if $not_modify}
            {$item.value|escape}
        {else}
            {capture name='grn_grn_GRN_GRN_1342'}{cb_msg module='grn.grn' key='GRN_GRN-1342' replace='true'}{/capture}
            {grn_text name=$item_id size='50' maxlength='100' value=$item.value disable_return_key=true}
            {validate form=$form_name field=$item_id criteria='notEmpty' message=$item.display_name|cat:$smarty.capture.grn_grn_GRN_GRN_1342 transform='cb_trim' append='validation_errors'}
        {/if}
    {/if}
{elseif $item.type == 'locale'}
{if $not_modify}
{$item.value.localname}
{else}
{if $locales_param|@count == 1}{assign var='locales_disabled' value=true}{/if}
{grn_select name="locale" options=$locales_param disabled=$locales_disabled}
{/if}
{elseif $item.type == 'base'}
{if $not_modify}
{$item.value.local_name}
{else}
{if $bases_param|@count == 1}{assign var='bases_disabled' value=true}{/if}
{grn_select name="base" options=$bases_param disabled=$bases_disabled}
{/if}
{elseif $item.type == 'usergroups'}
    {* 所属する組織 *}
        {foreach from=$item.value key=group_id item=group}
            {$group.title|escape}&nbsp;({$group.path|escape})<br>
        {/foreach}
{elseif $item.type == 'primary_group'}
    {* 優先する組織 *}
        {if $not_modify}
            {foreach from=$item.value key=group_id item=group}
                {* ユーザー変更不可なので名前のみ表示する *}
                {$item.value.title|escape}&nbsp;({$group.path|escape})<br>
            {/foreach}
        {else}
            {foreach from=$item.value key=group_id item=group}
                {grn_select name="primary_group" options=$group.group_options}<br>
            {/foreach}
        {/if}
{elseif $item.type == 'attendee'}
    {* 在席情報 *}
        {if $item.value.value && $item.value.timestamp}
            {$item.value.value|escape}&nbsp;({grn_date_format date=$item.value.timestamp format="DateTimeCompact"})
        {else}
            {cb_msg module='grn.grn' key='GRN_GRN-1338' replace='true'}
        {/if}
{elseif $item.type == 'file'}
    {* ファイル *}
        {if $not_modify}
            {* ユーザー変更不可なのでファイル名のみ表示する *}
            {$item.value.name}
        {else}
            {if $necessary}
                {* 必須項目なので妥当性を検証する *}
                {capture name='grn_grn_GRN_GRN_1339'}{cb_msg module='grn.grn' key='GRN_GRN-1339' replace='true'}{/capture}
                {validate form=$form_name field="file:$item_id" criteria="grn_notFileEmptyWithCondition" message=$item.display_name|cat:$smarty.capture.grn_grn_GRN_GRN_1339 append="validation_errors"}
            {/if}
            {if $item.value}
                {* すでにファイルは登録されている *}
                {assign var='file' value=$item.value}
                {grn_filename dpage='grn/file_download' uid=$user_id fid=$file.oid name=$file.name mime=$file.mime}
                {if ! $necessary}
                    {* 必須項目でないので削除を表示する *}
                    {capture name='grn_grn_GRN_GRN_1340'}{cb_msg module='grn.grn' key='GRN_GRN-1340' replace='true'}{/capture}{grn_checkbox name="file_delete[$item_id]" id="file_delete[$item_id]" value=1 checked=$file.checked caption=$smarty.capture.grn_grn_GRN_GRN_1340}
                {/if}
<input type="hidden" name="file_exist[{$item_id}]" value="1"><br>
            {/if}
            {grn_file name=$item_id size='50' necessary=$necessary}
        {/if}
{else}
    {if $not_modify}
        {* ユーザー変更不可 *}
            {if $item.value}
                {* すでに値が登録されている *}
                {if $item.type == 'multiple_string'}
                    {* 複数行文字列 *}
                    {$item.value|escape|nl2br}&nbsp;
                {else}
                    {* 1行文字列、URL、画像URL、E-mailアドレス、IP電話 *}
                    {$item.value|escape}&nbsp;
                {/if}
            {else}
                {* 何も登録されていない *}
&nbsp;
            {/if}
    {else}
        {assign var='empty' value=true}
        {if $necessary}
            {assign var='empty' value=false}
        {/if}

        {if $item.type == 'image_url'}
            {* 画像URL *}
            {capture name='grn_grn_GRN_GRN_1341'}{cb_msg module='grn.grn' key='GRN_GRN-1341' replace='true'}{/capture}{validate form=$form_name field=$item_id criteria='grn_isURL' message=$item.display_name|cat:$smarty.capture.grn_grn_GRN_GRN_1341 transform='cb_trim' append='validation_errors' empty=$empty}
        {elseif $necessary}
            {capture name='grn_grn_GRN_GRN_1342'}{cb_msg module='grn.grn' key='GRN_GRN-1342' replace='true'}{/capture}{validate form=$form_name field=$item_id criteria='notEmpty' message=$item.display_name|cat:$smarty.capture.grn_grn_GRN_GRN_1342 transform='cb_trim' append='validation_errors'}
        {/if}

        {if $item.type == 'multiple_string'}
            {* 複数行文字列 *}
            {grn_textarea name=$item_id rows='5' value=$item.value}
        {elseif $item.type == 'url' || $item.type == 'image_url'}
            {* URL、画像URL *}
            {grn_text name=$item_id size='50' maxlength='255' value=$item.value disable_return_key=true}
        {elseif $item.type == 'password'}
            {* パスワード *}
            {if $item.value}{assign var='purpose' value='modify'}{else}{assign var='purpose' value='init'}{/if}
            {grn_password name=$item_id purpose=$purpose size='50' value=$item.value disable_return_key=true}
        {else}
            {* 1行文字列、E-mailアドレス、IP電話 *}
            {grn_text name=$item_id size='50' maxlength='100' value=$item.value disable_return_key=true}
        {/if}
    {/if}
{/if}

