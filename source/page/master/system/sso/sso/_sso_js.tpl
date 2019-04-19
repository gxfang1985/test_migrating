{literal}
<script language="JavaScript" type="text/javascript">
<!--
function sso_select(selectid,changeid,textid,form)
{
    var c = form.elements[selectid];
    var opt = c.options; 
    for( i = 0 ; i < opt.length  ; i ++ ) 
    {
        if (opt[i].selected == true)
        {
            if ((opt[i].value != 0) && (opt[i].value))
            {
                form.elements[textid].style.display = "none";
                var o;
                var a = form.elements[changeid].options;
                var len = a.length;
                for( i = 0 ; i < len ; i ++ ) { a[0] = null; }
                var esid = form.elements[selectid].value;
{/literal}
{foreach from=$application item=ac}
                if( esid == "{$ac.id}" )
                {literal}{{/literal}
 {foreach from=$ac.option item=esid}
                    add_sso(a,"{$esid.id}","{$esid.title}");
 {/foreach}
                {literal}}{/literal}
{/foreach}
{literal}
                 eye = form.elements[changeid].options
                 form.elements[textid].value = eye[0].value;
                 form.elements[changeid].style.display = "";

            }
            else if (opt[i].value == 0)
            {
                form.elements[changeid].style.display = "none";
                form.elements[textid].value = '';
                form.elements[textid].className = "";
                form.elements[textid].style.display = "";
            }
        }
    }
}
function add_sso( a, id, text )
{
var li = a.length;
a[li] = new Option( text, id );
}
function sso_input(selectid,textid,form)
{
    var c = form.elements[selectid];
    var opt = c.options; 
    for( i = 0 ; i < opt.length  ; i ++ ) 
    {
        if (opt[i].selected == true)
        {
            if ((opt[i].value != 0) && (opt[i].value))
            {
                form.elements[textid].value = opt[i].value;
                form.elements[textid].style.display = "none";
            }
        }
    }
}
//-->
</script>
{/literal}
