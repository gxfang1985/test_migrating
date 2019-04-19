{include file="grn/xss_prevent.tpl"}
{if $has_error}
<table class="list_column" width="100%">
<tr>
<td align="center">
  <table width="80%" cellspacing="0" cellpadding="6" 
         style="border:1px solid #999999; background:#F7F7FF; padding:1em; margin: 1em;">
  <tr><td align="center">{grn_image image='warn100x60.gif'}</td></tr>
  <tr>
  <td>
    <blockquote>
    <br>
    <h2>{cb_msg module='fw.error' key="Error"} ({$ErrorNumber})</h2>
    {$ErrorDiag|grn_noescape}
    <h3>{cb_msg module='fw.error' key="Cause"}</h3>
    {$ErrorCause|grn_noescape}
    <h3>{cb_msg module='fw.error' key="Counter Measure"}</h3>
    {$ErrorCounterMeasure|grn_noescape}
    </blockquote>
  </td>
  </tr>
  </table>
</td>
</tr>
</table>
{/if}

{$portlet_data|grn_noescape}
{include file="grn/end_xss_prevent.tpl"}