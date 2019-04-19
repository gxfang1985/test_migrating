{**
 * Parameters:
 * [and_or]          select entity
 * [inputs]          conditions of filter
 * [filter_modify]   whether the current page is modifying filter or not
 *}
<div style="margin-bottom:5px;">
    <select name="and_or">
        {foreach from=$and_or_info item=item name=and_or}
            {if $smarty.foreach.and_or.index == $and_or || $item.selected}
                <option value="{$item.value}" selected="selected">{$item.label}</option>
            {else}
                <option value="{$item.value}">{$item.label}</option>
            {/if}
        {/foreach}
    </select><br />
</div>
<div id="filter_items">
    {if $inputs}
        {foreach from=$inputs item=input name=input}
                {assign var='index' value=$smarty.foreach.input.index}
                {if $index % 2 == 0}
                    {assign var='classname' value='filter_item_even'}
                {else}
                    {assign var='classname' value='filter_item_odd'}
                {/if}

                <div class="filter_item {$classname}" id="filter_item_{$index}">
                    <table style="width:100%;">
                          <tr>
                              <td>
                                  <table>
                                      <tr>
                                          <td>
                                              <select name="type[]" id="type_{$index}" class="target_select" style="width:170px;" onchange="onChangeType(this)">
                                                {foreach from=$type_info item=item}
                                                    {if $item.item_list}
                                                        {foreach from=$item.item_list item=item_detail key=item_id}
                                                            {if $input.type == 4 && $item_id == $input.item_id}
                                                                <option value="{$item_id}_itemid" datatype="{$item_detail.data_type|escape}" {if $item_detail.data_type == 'grn.report.time'}interval="{$item_detail.settings.unit}" {/if} selected="selected">{$item_detail.display_name|escape}</option>
                                                            {else}
                                                                <option value="{$item_id}_itemid" datatype="{$item_detail.data_type|escape}" {if $item_detail.data_type == 'grn.report.time'}interval="{$item_detail.settings.unit}" {/if}>{$item_detail.display_name|escape}</option>
                                                            {/if}
                                                        {/foreach}
                                                    {else}
                                                        {if $input.type == $item.value}
                                                            <option value="{$item.value}" selected="selected">{$item.label}</option>
                                                        {else}
                                                            <option value="{$item.value}">{$item.label}</option>
                                                        {/if}
                                                    {/if}
                                                {/foreach}
                                            </select>
                                        </td>
                                        <td nowrap>
                                            {if $select_form_type2_checked && $input.type == 4}
                                                <select onchange="onChangeItem({$index})" class="select_item" style="margin-right: 10px;" id="item_{$index}" name="item_{$index}">
                                                    <option datatype="" value="-1">--</option>
                                                    {foreach from=$relation_form_item_list item=item}
                                                        <option datatype="{$item.data_type}" value="{$item.id}"{if $item.data_type == 'grn.report.time'} interval="{$item.settings.unit}"{/if}{if $input.item_id == $item.id} selected="selected"{/if}>{$item.display_name}</option>
                                                    {/foreach}
                                                </select>
                                            {/if}
                                            {if $input.type == 4 && $input.item_type == 'grn.report.file'}
                                                {assign var="visible" value="none" }
                                            {else}
                                                {assign var="visible" value="" }
                                            {/if}
                                            <select name="condition[]" id="condition_{$index}" style="width:170px;display:{$visible}">
                                                {foreach from=$input.cOption item=item}
                                                    {if $input.condition == $item.value}
                                                        <option value="{$item.value}" selected="selected">{$item.label}</option>
                                                    {else}
                                                        <option value="{$item.value}">{$item.label}</option>
                                                    {/if}
                                                {/foreach}
                                            </select>
                                            {if $filter_modify}
                                            <input type="hidden" name="condition_id[]" value="{$input.id}" />
                                            {/if}
                                            <input type="hidden" name="item_id[]"   id="item_id_{$index}" value="{$input.item_id}" />
                                            <input type="hidden" name="item_index[]"   id="item_index_{$index}" value="{$index}" />
                                            <input type="hidden" name="item_type[]" id="item_type_{$index}" value="{$input.item_type}" />
                                            <input type="hidden" name="item_name[]" id="item_name_{$index}" value="{$input.item_name}" />
                                            <input type="hidden" name="type_item[]" id="type_item_{$index}" value="{$input.type_item}" />
                                        </td>
                                        <td nowrap>
                                            {if $input.type == 2 || ($input.type == 4 && $input.item_type == 'grn.report.date')}
                                                 <input type="text" id="value_{$index}" name="value[]" value="{$index}" size="30" style="display:none;" class="condition_value"/>
                                                 <span id="date_{$index}">{grn_report_select_date prefix="date_value_`$index`_" form_name=$form_name date=$input.date}</span>
                                            {elseif $input.type == 4 && $input.item_type == 'grn.report.checkbox'}
                                                 <span id="checkmsg_{$index}" ><input type="checkbox" onchange="onCheckboxChange({$index},this);" value="1" {if $input.value}checked="checked"{/if} />{$input.item_name}</span>
                                                 <input type="text" id="value_{$index}" name="value[]" style="display:none;" value="{if $input.value}1{else}0{/if}" class="condition_value" size="30" />
                                            {elseif $input.type == 4 && $input.item_type == 'grn.report.file'}
                                                 <span id="checkmsg_{$index}" ><input type="checkbox" onchange="onCheckboxChange({$index},this);" value="1" {if $input.value}checked="checked"{/if} />{if $tmp_key}{cb_msg module='grn.report' key='condition.item.file.attachedfiles' replace='true'}{else}{cb_msg module='grn.report' key='condition.item.file.attached' replace='true'}{/if}</span>
                                                 <input type="text" id="value_{$index}" name="value[]" style="display:none;" value="{if $input.value}1{else}0{/if}" class="condition_value" size="30" />
                                            {elseif $input.type == 4 && $input.item_type == 'grn.report.time'}
                                                 <input type="text" id="value_{$index}" name="value[]" value="{$index}" size="30" style="display:none;" class="condition_value"/>
                                                 <span id="time_{$index}">{grn_select_time minute_interval=$input.interval prefix="time_value_`$index`_" form_name=$form_name time=$input.time necessary=true}</span>
                                            {else}
                                                 {grn_text id="value_`$index`" name='value[]' necessary=1 value=$input.value size="30" class="condition_value" disable_return_key=true}
                                            {/if}
                                        </td>
                                        <td nowrap>
                                            <span id="error_message_{$index}" style="font-weight:bold;color:red;">
                                                {if $input.message}{$input.message}{/if}
                                            </span>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                            <td>
                                {if $index > 0}
                                    <input type="button" style="float:right;" onclick="removeFilterItem({$index})" value="{cb_msg module='grn.report' key='GRN_RPRT-55' replace='true'}"/>
                                {/if}
                            </td>
                        </tr>
                    </table>
                  </div>
        {/foreach}
    {else}
        <div class="filter_item filter_item_even" id="filter_item_0">
            <table style="width:100%">
                <tr>
                    <td>
                        <table>
                            <tr>
                                <td>
                                    <select name="type[]" id="type_0" class="target_select" onchange="onChangeType(this)" style="width:170px;">
                                        {foreach from=$type_info item=item}
                                            {if $item.item_list}
                                                {foreach from=$item.item_list item=item_detail key=item_id}
                                                 <option value="{$item_id}_itemid" datatype="{$item_detail.data_type|escape}" {if $item_detail.data_type == 'grn.report.time'}interval="{$item_detail.settings.unit}" {/if}>{$item_detail.display_name|escape}</option>
                                                {/foreach}
                                            {else}
                                                <option value="{$item.value}">{$item.label}</option>
                                            {/if}
                                        {/foreach}
                                    </select>
                                </td>
                                <td nowrap>
                                    <select name="condition[]" id="condition_0" style="width:170px;">
                                        {foreach from=$condition_info item=item}
                                            <option value="{$item.value}">{$item.label}</option>
                                        {/foreach}
                                    </select>
                                    <input type="hidden" name="item_id[]"   id="item_id_0" />
                                    <input type="hidden" name="item_index[]" id="item_index_0" value="0" />
                                    <input type="hidden" name="item_type[]" id="item_type_0" />
                                    <input type="hidden" name="item_name[]" id="item_name_0" />
                                    <input type="hidden" name="type_item[]" id="type_item_0" />
                                </td>
                                <td nowrap>
                                    {grn_text class="condition_value" id="value_0" name='value[]' necessary=1 value=$name size="30" disable_return_key=true}
                                </td>
                                <td nowrap>
                                    <span id="error_message_0" style="font-weight:bold; color:red;"></span>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
        </div>
    {/if}
</div>
<input type="button" value="{cb_msg module='grn.report' key='GRN_RPRT-57' replace='true'}" onclick="javascript:addFilterItem()">
{if $smarty.foreach.input.total > 1}
    <input id="removeButton"  type="button" value="{cb_msg module='grn.report' key='GRN_RPRT-58' replace='true'}" onclick="javascript:removeAllFilterItem()">
{else}
    <input id="removeButton" style="display:none;" type="button" value="{cb_msg module='grn.report' key='GRN_RPRT-59' replace='true'}" onclick="javascript:removeAllFilterItem()">
{/if}
    
