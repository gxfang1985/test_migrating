{if $item.not_modify}
     {$card.$family_key|escape}
{else}
     {if $necessary}{capture name='grn_address_GRN_ADDR_135'}{cb_msg module='grn.address' key='GRN_ADDR-258' replace='true'}{/capture}{validate form=$form_name field=$family_key criteria='notEmpty' message=$family_validate|cat:$smarty.capture.grn_address_GRN_ADDR_135 transform="cb_trim" append="validation_errors"}{/if}{grn_text id=$family_id name=$family_key size='20' value=$card.$family_key disable_return_key=true onfocus="get_subject_type( this.form );" onchange="complete_subject( this.form, false );"}<small>{cb_msg module='grn.address' key='GRN_ADDR-136' replace='true'}</small>
{/if}
{if $item.not_modify}
     {$card.$given_key|escape}
{else}
     {if $necessary}{capture name='grn_address_GRN_ADDR_137'}{cb_msg module='grn.address' key='GRN_ADDR-258' replace='true'}{/capture}{validate form=$form_name field=$given_key criteria='notEmpty' message=$given_validate|cat:$smarty.capture.grn_address_GRN_ADDR_137 transform="cb_trim" append="validation_errors"}{/if}{grn_text id=$given_id name=$given_key size='20' value=$card.$given_key disable_return_key=true onfocus="get_subject_type( this.form );" onchange="complete_subject( this.form, false );"}<small>{cb_msg module='grn.address' key='GRN_ADDR-138' replace='true'}</small>
{/if}
