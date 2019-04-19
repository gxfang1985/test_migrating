<div class="margin_bottom">
    <div>
        <span class="bold">{$category.name|escape}</span>
    </div>
</div>
<div class="margin_bottom">
</div>
{literal}
<style type="text/css">
<!-- 
.report_category_memo{
  width:98%;
  padding:0.8em 0.3em 0.5em 0.8em;
  background-color:#ffffff;
  border:3px double #ccccdd;
  font-size:90%;
  letter-spacing:0.1em;
  line-height:120%;
}
-->
</style>
{/literal}
{if $category.memo}
<div class="report_category_memo">
    {grn_format body=$category.memo}
</div>
{/if}

<div style="height:1.0em;"></div>
</div>
{literal}
<style type="text/css">
<!-- 
.category_hr
{
  font-weight:bold;
  padding:5px,10px,5px,10px;
  border-bottom:2px dotted #999999;
}
-->
</style>
{/literal}
{if $category_id == GRN_REPORT_CATEGORY_ROOT_ID && $form_list}
<p class="category_hr"></p>
<div class="margin_bottom">
 <div>
  <span class="bold">{cb_msg module='grn.report' key='recent_form' replace='true'}</span>
 </div>
</div>
{/if}
{foreach from=$form_list item=form}
 {if $form.cid == ''}{assign var='cid' value=-1}
 {else}{assign var='cid' value=$form.cid}
 {/if}
 {if $form.type == 0}
<nobr>
    {if $from == 'filter'}
        <a href="javascript:;" id="form_link_{$form.fid}" class="form_link" onclick="onFormSelect({$form.fid});" >{$form.name}</a> 
    {else}
        {if $eid}
            {grn_link page='report/send_form' caption=$form.name truncated_caption=$config.subject_width image='report20.gif' cid=$cid fid=$form.fid eid=$eid date=$date}
        {else}
            {grn_link page='report/send_form' caption=$form.name truncated_caption=$config.subject_width image='report20.gif' cid=$cid fid=$form.fid }
        {/if}
    {/if}
</nobr>
<blockquote style="margin-top:0px">
     <tt>
         <font size=+0>
             {grn_format body=$form.memo}
         </font>
     </tt>
</blockquote>
 {else}
<p class="category_hr"></p>
 {/if}
{/foreach}
