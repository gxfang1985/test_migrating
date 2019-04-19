{include file='grn/system_head.tpl'}
{include file='grn/system_header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}

<p>
 <div class="explanation">{cb_msg module='grn.system.sso' key='GRN_SY_SS-13' replace='true'}</div>
</p>

{include file='grn/show_validation_errors.tpl'}
{include file='grn/indispensable.tpl'}
{grn_sso_include_method method=$sso_method display="add-system" identifier=$identifier}
{include file='grn/system_footer.tpl'}
