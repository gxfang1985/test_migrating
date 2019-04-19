{include file='grn/system_head.tpl'}
{include file='grn/system_header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var="form_name" value=$smarty.template|basename}
<script type="text/javascript" src="{$app_path}/fw/inplace_edit.js?{$build_date}"></script>

<p class="explanation">{cb_msg module='grn.system.user' key='GRN_SY_US-575' replace='true'}<br />
<span class="attention">{cb_msg module='grn.system.user' key='GRN_SY_US-576' replace='true'}</span><br />
</p>


<div class="attention"><span class="bold">{capture name='grn_system_user_GRN_SY_US_577'}{cb_msg module='grn.system.user' key='GRN_SY_US-577' replace='true'}{/capture}{validate form=$form_name criteria="isNotEqual" field="delete_start" field2="delete_end" message=$smarty.capture.grn_system_user_GRN_SY_US_577}</span></div>

<table class="view_table" width="75%" style="margin-bottom: 5px">
 <tbody>
  <tr>
   <th nowrap>{cb_msg module='grn.system.user' key='GRN_SY_US-579' replace='true'}</th>
   <td nowrap style="padding-left: 10px">
    <div id="deleted_term">
     <span id="term" class="bold">{if $disable eq TRUE}{cb_msg module='grn.system.user' key='GRN_SY_US-580' replace='true'}{else}{$start_hour}&nbsp;{cb_msg module='grn.system.user' key='GRN_SY_US-581' replace='true'}&nbsp;{cb_msg module='grn.system.user' key='GRN_SY_US-582' replace='true'}&nbsp;{if $start_hour > $end_hour}{cb_msg module='grn.system.user' key='GRN_SY_US-583' replace='true'}{/if}{$end_hour}&nbsp;{cb_msg module='grn.system.user' key='GRN_SY_US-584' replace='true'}{/if}</span>&nbsp;&nbsp;
     <a href="#" onclick='toggleEditForm( "deleted_form", "deleted_term" )'>{grn_image image='modify20.gif'}{cb_msg module='grn.system.user' key='GRN_SY_US-585' replace='true'}</a>
     <br>
     {if $disable eq FALSE}
    <span id="term" class="bold">UTC : ({$start_hour_UTC}:{$start_minute_UTC} ~ {$end_hour_UTC}:{$end_minute_UTC}) </span>
    {/if}
    </div>

    <div id="deleted_form" style="display: none">
      <input type="checkbox" name="disable" value="0" id="ic0" {if $disable eq TRUE}checked="checked"{/if} onclick='disableForm( "{$form_name}", this )' />
      <label for="ic0" onmouseout="this.style.color=''" onmouseover="this.style.color='#ff0000'">{cb_msg module='grn.system.user' key='GRN_SY_US-586' replace='true'}</label>
      <form name="{$form_name}" method="POST" action="{grn_pageurl page='system/user/command_delete_user_list'}" style="margin-top: 10px">
        {grn_select name='start_hour' options=$start_hours onchange="hid_s.value=this.value"}
        &nbsp;{cb_msg module='grn.system.user' key='GRN_SY_US-587' replace='true'}&nbsp;{cb_msg module='grn.system.user' key='GRN_SY_US-588' replace='true'}&nbsp;
        {grn_select name='end_hour' options=$end_hours onchange="hid_e.value=this.value"}
        &nbsp;{cb_msg module='grn.system.user' key='GRN_SY_US-589' replace='true'}
        <input type="hidden" name="delete_start" value="{$start_hour}" />
        <input type="hidden" name="delete_end" value="{$end_hour}" />
        <input type="hidden" name="csrf_ticket" value="{$csrf_ticket}" />
        <input type="submit" value="{cb_msg module='grn.system.user' key='GRN_SY_US-590' replace='true'}" class="left" style="font-weight: bold;" />
        <input type="button" value="{cb_msg module='grn.system.user' key='GRN_SY_US-591' replace='true'}" class="left" onclick='toggleEditForm( "deleted_term", "deleted_form" );revert()' />
      </form>
    </div>
   </td>
  </tr>
 </tbody>
</table>

<hr />

<div class="sub_title" style="margin-top: 5px">{cb_msg module='grn.system.user' key='GRN_SY_US-592' replace='true'} {include file="grn/smart_data_count.tpl" start_num=$navi_info.start_count end_num=$navi_info.end_count all_num=$navi_info.count}</div>

<div class="list"><nobr>{include file='grn/word_navi.tpl' navi=$navi_info.navi}</nobr></div>

<form name="system/user/org_list" method="post" action="{grn_pageurl page='system/user/command_delete_user_list}">
 <input type="hidden" name="csrf_ticket" value="{$csrf_ticket}" />
 <input type="hidden" name="cmd" />
 <table class="list_column" style="width:75%">
   <colgroup>
    <col width="1%" />
    <col width="30%" />
    <col width="35%" />
    <col width="35%" />
   </colgroup>
   <tbody>
    <tr>
     <th nowrap>{include file='grn/checkall.tpl' elem_name='eid[]' form_name='system/user/org_list'}</th>
     <th nowrap>
       {cb_msg module='grn.system.user' key='GRN_SY_US-595' replace='true'}
     </th>
     <th nowrap>{cb_msg module='grn.system.user' key='GRN_SY_US-596' replace='true'}</th>
     <th nowrap>{cb_msg module='grn.system.user' key='GRN_SY_US-597' replace='true'}</th>
    </tr>
    {foreach from=$user_list item=user key=key}
    <tr>
     <td nowrap>{grn_checkbox name='eid[]' id="eid_`$key`" value=$key}</td>
     <td>{grn_date_format date=$user.col_deleted format="DateTimeMiddle_YMDW_HM"}</td>
     <td><nobr>{grn_image image='invaliduser20.gif'}{$user.col_display_name}</nobr></td>
     <td>{$user.col_foreign_key}</td>
    </tr>
    {/foreach}
   </tbody>
 </table>

  <div class="list">
   <p class="item">
     {include file="grn/word_navi.tpl" navi=$navi_info.navi}
   </p>
   <p class="item">
     {if $smarty.const.ON_FOREST !== 1}
     {cb_msg module='grn.system.user' key='GRN_SY_US-598' replace='true'}<input type="submit" name="restore" value="{cb_msg module='grn.system.user' key='GRN_SY_US-599' replace='true'}" onclick="if( ! grn_is_checked( this.form, 'eid[]' ) ) return false; this.form.elements['cmd'].value='restore'"> /
     {/if}
     <input type="submit" name="undelete" value="{cb_msg module='grn.system.user' key='GRN_SY_US-600' replace='true'}" onclick="if( ! grn_is_checked( this.form, 'eid[]' ) ) return false; this.form.elements['cmd'].value='delete'">
    </span>
   </p>
  </div>
</form>

<script type="text/javascript">
s = document.getElementsByName('start_hour')[0];
e = document.getElementsByName('end_hour')[0];
d = document.getElementsByName('disable')[0];

hid_s = document.getElementsByName('delete_start')[0];
hid_e = document.getElementsByName('delete_end')[0];

def_s = hid_s.value = s.value;
def_e = hid_e.value = e.value;
def_d = s.disabled = e.disabled = d.checked;

{literal}
function revert(){
    s.value = hid_s.value = def_s;
    e.value = hid_e.value = def_e;
    s.disabled = e.disabled = d.checked = def_d;
}
{/literal}

{if $invalid eq TRUE}toggleEditForm( "deleted_form", "deleted_term" );{/if}
</script>

{include file="grn/system_footer.tpl"}
