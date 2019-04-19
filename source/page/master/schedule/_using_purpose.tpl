<tr valign="top" {if ! $usingApprovalFacility}style="display:none;"{/if} id="using_purpose_element">
    <th nowrap>{cb_msg module='grn.schedule' key='GRN_SCH-1100' replace='true'}<span class="attention">*</span></th>
    <td>
        <div class="attention" name="using_purpose_error" id="using_purpose_error" style="display:none;">
            <span class="bold"><span class="nowrap-grn"><span class="subnotify16">{cb_msg module='grn.schedule' key='GRN_SCH-1104' replace='true'}</span></span></span>
        </div>
        {grn_textarea id="using_purpose" name="using_purpose" value=$usingPurposeValue rows="5" cols="65"} 
    </td>
</tr>