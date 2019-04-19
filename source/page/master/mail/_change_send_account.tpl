<script language="JavaScript">
<!--
function changeSign(i,d_id,name)
{literal}
{
    var num = i.selectedIndex;
    var select_value = i.options[num].value;
    var s_id = 'change_sign_';
    var check_name = s_id + select_value;
    var d = document.getElementById(check_name);
    if(d.childNodes[0].name)
    {
        changeAccount2(i,s_id,name);
        var d = document.getElementById(d_id);
        var d_1 = document.getElementById(d_id + "_1");
        if(d.style.display == 'none')
        {
            d.style.display = '';
            d_1.style.display = '';
        }
        checkSign(i,i.form,'user_sign',i.form.sign_value);
    }
    else
    {
        i.form.sign_value.value = '';
        var d = document.getElementById(d_id);
        var d_1 = document.getElementById(d_id + "_1");
        if(d.style.display == '')
        {
            d.style.display = 'none';
            d_1.style.display = 'none';
        }
    }
    return;
}
{/literal}
function checkSign(i,form,ename,target)
{literal}
{
    var num = i.selectedIndex;
    var select_value = i.options[num].value;
    var name = ename + select_value;
    var d = form.elements[name];
    var mySign = {/literal}"{$sign_set}"{literal};
    if(mySign == 1)
    {
        signValue(d,target);
    }
    return;
}
{/literal}
//-->
</script>
{if $account_name}
       {$account_name|escape}
       <input type='hidden' name='user_account' value="{$account_id}">
{elseif count($user_account) == 1}
       {$user_account.$aid.label}
       <input type='hidden' name='user_account' value="{$aid}">
{else}
       {grn_select class="selectStandard-grn" name='user_account' options=$user_account onchange="changeAccount2(this,'change_from_','');changeSign(this,'display_sign','')"}
{/if}
