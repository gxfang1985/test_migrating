{if $item.type == GRN_ADDRESS_ITEM_FILE}
    {* ファイル *}
    {capture name='front'}
        {if $not_modify}
            {$value.name}
        {else}
            {if $necessary}
                {if $item_id == 'image'}{capture name='grn_address_GRN_ADDR_111'}{cb_msg module='grn.address' key='GRN_ADDR-111' replace='true'}{/capture}{assign var='message' value=$smarty.capture.grn_address_GRN_ADDR_111}{else}{assign var='message' value=$item.display_name}{/if}
                {capture name='grn_address_GRN_ADDR_113'}{cb_msg module='grn.address' key='GRN_ADDR-113' replace='true'}{/capture}{validate form=$form_name field="file:$item_id" criteria="grn_notFileEmptyWithCondition" message=$message|cat:$smarty.capture.grn_address_GRN_ADDR_113 append="validation_errors"}
            {/if}
            {if 0 < strlen( (string)$value )}
                {grn_filename dpage='address/file_download' bid=$book_id cid=$card_id fid=$value.oid name=$value.name mime=$value.mime}
                {if ! $necessary}
                    {capture name='grn_address_GRN_ADDR_114'}{cb_msg module='grn.address' key='GRN_ADDR-114' replace='true'}{/capture}{grn_checkbox name="file_delete[$item_id]" id="file_delete[$item_id]" value=1 caption=$smarty.capture.grn_address_GRN_ADDR_114}
                {/if}
<input type="hidden" name="file_exist[{$item_id}]" value="1"><br>
            {/if}
            {grn_file name=$item_id size='50' necessary=$necessary}
        {/if}
    {/capture}
{else}
    {if $not_modify}
        {capture name='front'}
            {if 0 < strlen( $value )}
                {if $item_id == 'map'}
                    {* 地図 *}
<img id="map_image" name="map_image" align="absmiddle" src="{$value}">
                {elseif $item_id == 'route'}
                    {if 0 < strlen( $card.route ) || 0 < strlen( $card.route_time ) || 0 < strlen( $card.route_fare )}
                        {$card.route}<br>{$card.route_time}&nbsp;{cb_msg module='grn.address' key='GRN_ADDR-115' replace='true'}<br>{$card.route_fare}&nbsp;{cb_msg module='grn.address' key='GRN_ADDR-116' replace='true'}
                    {/if}
                {elseif $item.type == GRN_ADDRESS_ITEM_MULTIPLE_STRING}
                    {* 複数行文字列 *}&nbsp;
                    {$value|escape|nl2br}
                {else}
                    {* 1行文字列、URL、画像URL、E-mailアドレス、IP電話 *}
                    {$value|escape}&nbsp;
                {/if}
            {else}
&nbsp;
            {/if}
        {/capture}
    {else}
        {assign var='empty' value=true}
        {if $necessary}
            {assign var='empty' value=false}
        {/if}

        {if $item.type == GRN_ADDRESS_ITEM_URL || $item.type == GRN_ADDRESS_ITEM_IMAGE_URL}
            {* URL、画像URL *}
            {capture name='grn_address_GRN_ADDR_117'}{cb_msg module='grn.address' key='GRN_ADDR-117' replace='true'}{/capture}{validate form=$form_name field=$item_id criteria='grn_isURL' message=$item.display_name|cat:$smarty.capture.grn_address_GRN_ADDR_117 transform='cb_trim' append='validation_errors' empty=$empty}
        {elseif $necessary}
            {* 複数行文字列、1行文字列 *}
            {capture name='grn_address_GRN_ADDR_118'}{cb_msg module='grn.address' key='GRN_ADDR-118' replace='true'}{/capture}{validate form=$form_name field=$item_id criteria='notEmpty' message=$item.display_name|cat:$smarty.capture.grn_address_GRN_ADDR_118 transform='cb_trim' append='validation_errors'}
        {/if}

        {if $item_id == 'subject'}
            {* 標題 *}
            {capture name='front'}{grn_text name=$item_id size='50' value=$value disable_return_key=true onchange="complete_subject( this.form, true );"}{/capture}
        {elseif $item_id == 'company_name'}
            {* 会社名 *}
            {capture name='front'}{grn_text name=$item_id size='50' value=$value disable_return_key=true onchange="complete_subject( this.form );"}{/capture}
        {elseif $item_id == 'map'}
            {* 地図 *}
            {capture name='front'}
            {if ! $is_cbwebsrv || 0 == strlen( $value )}
                {grn_image image='map20.gif' name='map_image' id='map_image'}
            {else}
<img id="map_image" name="map_image" align="absmiddle" src="{$value}">
            {/if}
            {/capture}
            {capture name='rear'}{capture name='grn_address_GRN_ADDR_120'}{cb_msg module='grn.address' key='GRN_ADDR-120' replace='true'}{/capture}{capture name='grn_address_GRN_ADDR_121'}{cb_msg module='grn.address' key='GRN_ADDR-121' replace='true'}{/capture}{grn_cbwebsrv_map_clear caption=$smarty.capture.grn_address_GRN_ADDR_121 form_name=$form_name map_tid="map" map_img_tid="map_image"}{/capture}
        {elseif $item_id == 'route'}
            {* 路線 *}
            {capture name='front'}
<table class="dataList">
 <tr>
  <th nowrap align="left">{cb_msg module='grn.address' key='GRN_ADDR-122' replace='true'}</th>
  <td>{grn_text name="route" value=$card.route size='35' disable_return_key='true'}</td>
 </tr>
 <tr>
  <th nowrap align="left">{cb_msg module='grn.address' key='GRN_ADDR-123' replace='true'}</th>
  <td>{grn_text name="route_time" value=$card.route_time size='8' disable_return_key=true}&nbsp;{cb_msg module='grn.address' key='GRN_ADDR-124' replace='true'}</td>
 </tr>
 <tr>
  <th nowrap align="left">{cb_msg module='grn.address' key='GRN_ADDR-125' replace='true'}</th>
  <td>{grn_text name="route_fare" value=$card.route_fare size='8' disable_return_key=true}&nbsp;{cb_msg module='grn.address' key='GRN_ADDR-126' replace='true'}</td>
 </tr>
</table>
            {/capture}
            {capture name='rear'}{capture name='grn_address_GRN_ADDR_127'}{cb_msg module='grn.address' key='GRN_ADDR-127' replace='true'}{/capture}{grn_cbwebsrv_route caption=$smarty.capture.grn_address_GRN_ADDR_127}{/capture}
        {elseif $item_id == 'zip_code'}
            {* 郵便番号 *}
            {capture name='front'}{grn_text name=$item_id size='10' value=$value disable_return_key=true}{/capture}
        {elseif $item.type == GRN_ADDRESS_ITEM_MULTIPLE_STRING}
            {* 複数行文字列 *}
            {capture name='front'}{grn_textarea name=$item_id rows='5' value=$value}{/capture}
        {else}
            {* 1行文字列、URL、画像URL、E-mailアドレス、IP電話 *}
            {assign var='maxlength' value=null}
            {if $item_id == 'physical_address'}
                {assign var='maxlength' value=4096}
            {elseif $item.type == GRN_ADDRESS_ITEM_URL || $item.type == GRN_ADDRESS_ITEM_IMAGE_URL}
                {assign var='maxlength' value=255}
            {/if}
            {capture name='front'}{grn_text name=$item_id size='50' maxlength=$maxlength value=$value disable_return_key=true}{/capture}
        {/if}
    {/if}
{/if}
