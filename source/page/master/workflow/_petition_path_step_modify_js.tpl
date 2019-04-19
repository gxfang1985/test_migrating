<script type="text/javascript">
{literal}

function grn_onsubmit_common(f)
{
    if (grn.base.isNamespaceDefined("grn.component.member_add")) {
        var member_select = grn.component.member_add.get_instance("member_select");
        if (member_select) {
            member_select.prepareSubmit();
        }
    }

    var elements = f.elements;
    for( var i = 0 ; i < elements.length ; i ++ )
    {
        if ( elements[i].name && elements[i].name.indexOf("[]") > 0 )
        {
            var options = elements[i].options;
            if( options )
            {
                for( var j = 0 ; j < options.length ; j ++ )
                {
                    if( elements[i].name == 'partner_sUID[]' )
                    {
                        options[j].selected = options[j].value ? true : false
                    }
                    else
                    {
                        options[j].selected = false
                    }
                }
            }
        }
    }
}

{/literal}
</script>
