{if $settings.font_size == "large"}
 {assign var="font_size" value='font-size:110%;'}
{elseif $settings.font_size == "normal"}
 {assign var="font_size" value=''}
{elseif $settings.font_size == "small"}
 {assign var="font_size" value='font-size:70%;'}
{/if}
<div style="{$font_size}">
    <table class="top_title">{strip}
        <tbody>
        <tr>
            <td>
                <span class="portlet_title_grn">
                    <span class="portlet_title_name_grn" >{$page_title|escape}</span>
                    {if ! $date_list & ! $disabled_services.weather} - {cb_msg module='grn.cbwebsrv.portlet' key='GRN_WBS_PO-50' replace='true'}
                    {/if}
                </span>
            </td>
        </tr>
        </tbody>
    </table>{/strip}

<div class="portal_frame portal_frame_weather_grn">
{if $disabled_services.weather}
 <div>{cb_msg module='grn.cbwebsrv.portlet' key='GRN_WBS_PO-51' replace='true'}</div>
{else}
{if $date_list}
<table class="admin_list_table">
 <tr>
  <td colspan="2" style="border-top:0px solid" nowrap></td>
{foreach from=$date_list key=format_date item=date_info}
  <td style="padding:0px; border-top:0px solid;" nowrap>
   <div class="{$date_info.type}" style="padding:2px">
   {grn_date_format date=$format_date format='DateShort_MDW'}
 {if ! $disabled_services.six_kinds_of_day && $settings.six_kinds_of_day}
   <br>
  {if $date_info.six_kinds_of_day}
   {$date_info.six_kinds_of_day}
  {else}
   --
  {/if}
 {/if}
   </div>
  </td>
{/foreach}
 </tr>
{foreach from=$weather item=locale}
 <tr valign="top">
  <td rowspan={$visible_row_num}>{$locale.name}</td>
  <td nowrap>{cb_msg module='grn.cbwebsrv.portlet' key='GRN_WBS_PO-52' replace='true'}</td>
 {foreach from=$locale.date_list item=date}
  <td nowrap>
  {if $date.weather & $date.weather}
   {grn_image image=$date.image alt=$date.weather}
  {else}
   --
  {/if}
  </td>
 {/foreach}
 </tr>
{/foreach}
</table>
{/if}
{/if}
</div> <!--end of portal_frame -->

</div>