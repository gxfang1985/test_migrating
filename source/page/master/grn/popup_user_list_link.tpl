{if ! $duplication}
    <script language="JavaScript" type="text/javascript">
    <!--
    var {if $popup_function_name}{$popup_function_name}{else}popupUserList{/if}_count = 0;
    function {if $popup_function_name}{$popup_function_name}{else}popupUserList{/if}(Aform)
    {ldelim}
        if ( ! {if $popup_function_name}{$popup_function_name}{else}popupUserList{/if}_count || document.getElementById('form_{$var_CID}') == null)
        {ldelim}
            var p = document.getElementById('div_{$var_CID}');
            var c = document.createElement('DIV');
            p.style.display = "";
            p.appendChild(c);
            c.innerHTML = '<iframe id="form_{$var_CID}" name="form_{$var_CID}" frameborder="no" scrolling="no" style="position:absolute; width:0em; height:0em;" src=""></iframe>';
        {rdelim}

        popupWin("","user_list",800,600,0,0,0,1,0,1);
        var url = '{grn_pageurl page=$popup_user_list_link}';
        var html = '{grn_doctype trim="true"}<html lang="{$html_tag_lang}"><body><form method="post" target="user_list" action="' + url + '">';
        html += '<input type="hidden" name="system_display" value="{$system_display}">';
        var form_frame = document.getElementById('form_{$var_CID}').contentWindow.document;
{if $list_name}
        var instance = grn.component.member_select_list.get_instance("{$list_name}");
        var values = instance.getSelectedUsersValues();
        html += '<input type="hidden" name="cid" value="' + values.join(':') + '">';
{else}
        var options = Aform.elements['{$var_CID}'];
        var options_values = [];
        {literal}
        for ( var i = 0, options_length = options.length ; i < options_length; i++ )
        {
            if( ! options[i].selected || ! options[i].value ) continue;

            var options_value = options[i].value.split(':');
            if ( options_value.length > 0 && isFinite( options_value[0] ) )
            {
                options_values.push(options_value[0]);
            }
        }
        html += '<input type="hidden" name="cid" value="' + options_values.join(':') + '">';

        if(YAHOO.env.ua.ie < 9)
        {
            form_frame.clear();
        }
        html += '<input type="hidden" name="app" value="' + Aform.getAttribute('name').split('/')[0] + '">';
        {/literal}
{/if}
        html += '</form></body></html>';
        form_frame.write( html );
        form_frame.close();
        form_frame.forms[0].submit();
        {if $popup_function_name}{$popup_function_name}{else}popupUserList{/if}_count = 1;
        if( !grn.browser.chrome && !grn.browser.safari && typeof update_back_step == 'function' )
        {ldelim}
            update_back_step();
        {rdelim}
        return true;
    {rdelim}
    //-->
    </script>

    <div id="div_{$var_CID}" style="display:none; position:absolute; width:0em; height:0em;">&nbsp;</div>
{/if}

{if $is_button}
    <input type="button" value="{$caption}"
           onClick="javascript:{if $popup_function_name}{$popup_function_name}{else}popupUserList{/if}(this.form);">
{elseif $module !== 'schedule'}
    <a href="javascript:void(0);" onClick="{$popup_function_name}();">{$caption}</a>
{else}
    {if $form_name}
        <script language="JavaScript" type="text/javascript">
            var form_name = document.getElementById('{$form_name}');
        </script>
    {/if}
    <a href="javascript:void(0);"
       onClick="{if $popup_function_name}{$popup_function_name}{else}popupUserList{/if}(form_name);">{$caption}</a>
{/if}
