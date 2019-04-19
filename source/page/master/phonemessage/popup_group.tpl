{include file="grn/popup_head.tpl"}
{include file="grn/popup_header.tpl"}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page=$form_name}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
<input type="hidden" name="ss" value="1">
<div id="one_parts">
 <div id="action">
  <!----->
    {include file=grn/organization_modify.tpl show_root="1"} 
  <!----->
 </div>
 <!--action_end--->
</div>
<p>
 <input type=button value="{cb_msg module='grn.phonemessage' key='GRN_PHM-60' replace='true'}" onClick="popup_apply( this.form )"{if $is_candidate_organization} disabled{/if}>
 <input type="button" value="{cb_msg module='grn.phonemessage' key='GRN_PHM-61' replace='true'}" onClick="window.close();">
</p>
<input type="hidden" name="gid" value="{$organization_id}">
<script language="JavaScript" type="text/javascript">
<!--
{literal}
function on_change_organization( hid )
{
    f = document.forms["{/literal}{$form_name}{literal}"];
    e = f.elements["gid"];
    e.value = hid;
    f.submit();
}
function popup_apply( form )
{
    var c = form.elements['gid']
    var v = c.value;
    if (v) {
        var wpo = window.parent.opener;
        var ls = wpo.location.search
        var lss = ls.split("&");
        var lssl = lss.length;
        var b_found = false;
        var eye;
        if (ls)
        {
            for( i = 0 ; i < lssl ; i ++ )
            {
                var lssli = lss[i];
                if (lssli.match(/^gid=/))
                {
                    lss[i] = "&gid=" + v;
                    eye += lss[i];
                    b_found = true;
                }
                else if (i != 0)
                {
                    lss[i] = "&" + lss[i];
                    eye += lss[i];
                }
                else
                {
                    eye = lss[i];
                }
            }
            
            if( ! b_found )
                eye = eye + "&gid=" + v;
        }
        else
        {
            eye = "?gid=" + v;
        }
        wpo.location.href = wpo.location.pathname + eye;
    }
    window.parent.close();
}
{/literal}
//-->
</script>
</form>
{include file="grn/popup_footer.tpl"}
