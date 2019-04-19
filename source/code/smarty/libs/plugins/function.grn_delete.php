<?php

/**
 * @name   grn_delete
 * Generate Javascript to handle delete task
 *
 * @param string    title       title of message box
 * @param string    page        path of template delete
 * @param array     data        variables assigned to delete form
 * @param mixed     handler     HTML ID (or array of HTML ID) of the element which control delete
 *
 * Optional params
 * @param mixed     no_confirm            Its default value is false. false then show popup, true then not show popup, 'custom' then developer defines rule to show hide popup.
 * @param array     msgbox_options        options to customize UI of message box (eg: width, height)
 * @param string    multi_target          name of checkbox using for delete multi, eg: 'eid[]'
 * @param string    form_target           name of form contents the checkboxes specified by parameter "multi_target"
 * @param mixed     before_delete         string if hasn't param ( array if has params)
 *
 *  Usage:
 *  {grn_delete title='Delete Memo' page='memo/delete' no_confirm=true data=$delete_info handler='delete_memo'}
 */
function smarty_function_grn_delete($params, &$smarty)
{
    $function_name = 'grn_delete';

    // necessary parameter and value
    if ( ! array_key_exists('title', $params)) {
        return htmlspecialchars($function_name) . ': missing "title" parameter';
    }

    if ( ! array_key_exists('page', $params)) {
        return htmlspecialchars($function_name) . ': missing "page" parameter';
    }

    if ( ! array_key_exists('data', $params)) {
        return htmlspecialchars($function_name) . ': missing "data" parameter';
    }

    if ( ! array_key_exists('handler', $params)) {
        return htmlspecialchars($function_name)
               . ': missing "handler" parameter';
    }

    //check params
    if ( ! $params['title'] || ! $params['page'] || ! $params['handler']) {
        return '';
    }

    //require params
    $title = $params['title'];
    $page = $params['page'];
    //get application name
    require_once('grn/application.csp');
    $locator = GRN_ApplicationLocator::instance();
    $module_name = explode('/', $page);
    $app_name
        = $locator->getName($module_name[0]);//htmlspecialchars( $locator->getName( $module_name[0] ) );
    unset($locator);
    $title = str_replace('&&app_name&&', $app_name, $title);
    $title = grn_delete__escape_js($title);
    $title = grn_delete__escape_html($title);
    $data = $params['data'];
    $handler = $params['handler'];
    if (is_array($handler)) {
        $temp_array = [];
        foreach ($handler as $value) {
            $temp_array[] = "'" . grn_delete__escape_js($value) . "'";
        }
        $handler = '[' . implode(',', $temp_array) . ']';
    } else {
        $handler = "['" . grn_delete__escape_js($handler) . "']";
    }

    // optional params
    $no_confirm = array_key_exists('no_confirm', $params)
        ? $params['no_confirm'] : false;
    $msgbox_options = array_key_exists('msgbox_options', $params)
        ? $params['msgbox_options'] : false;
    $multi_target = array_key_exists('multi_target', $params)
        ? $params['multi_target'] : false;
    $form_target = array_key_exists('form_target', $params)
        ? $params['form_target'] : false;
    $before_delete = array_key_exists('before_delete', $params)
        ? $params['before_delete'] : false;
    $custom_submit = array_key_exists('custom_submit', $params)
        ? $params['custom_submit'] : false;
    $attachment_search = array_key_exists('attachment_search', $params)
        ? $params['attachment_search'] : false;

    // prepare content of message box
    require_once("grn/smarty.csp");
    $t = new GRN_Smarty;
    if (is_array($data)) {
        foreach ($data as $key => $value) {
            $t->assign($key, $value);
        }
    }
    //assign application name
    $t->assign('app_name', $app_name);
    //get output message
    $message_output = $t->fetch($page);
    $message_output = grn_delete__escape_js($message_output);

    // generate script block
    $script
        = '
            <script language="javascript" type="text/javascript">
                // on page load
                YAHOO.util.Event.onDOMReady(function(){
                  // register event for delete handler
                  var handler = ' . $handler . '; 
                  jQuery.each( handler, function(index, value){
                    var ele = jQuery("#" + value);
                    if( ele.length == 0 ) return;
                    ele.click(function(event){
                        var title = "' . $title . '";
                        var content = document.createElement("div");
                        content.innerHTML = "' . $message_output . '";
                        //get form element
                        var f = content.getElementsByTagName("form")[0];
                        if(!f) return; ';

    // delete multi
    if ($multi_target && $form_target) {
        $form_target = grn_delete__escape_js($form_target);
        $multi_target = grn_delete__escape_js($multi_target);
        $script
                      .= '
                        var list = jQuery("form[name=\'' . $form_target
                         . '\'] input[name=\'' . $multi_target . '\']").filter(function(i){return jQuery(this).prop( "checked" );});';
        if ($attachment_search) {
            $script
                      .= '
                        list = list.filter(function(i){return jQuery(this).data().hasAttachment;});';
        } else {
            $script
                      .= '
                        if( list.length == 0 ) return;    // do nothing if these is not any item is selected';
        }
        $script
                      .= '
                        //update number of items to delete
                        var delete_number_span = content.getElementsByTagName("span");
                        for (i = 0; i < delete_number_span.length; i++) {
                            if ( jQuery(delete_number_span[i]).hasClass("delete_count") )
                            {
                                var delete_number = delete_number_span[i];
                            }
                        }
                        if(delete_number) delete_number.innerHTML = list.length;

                        //add hidden field
                        jQuery.each( list, function(index, value){
                            var hidden_input = document.createElement("input");
                            var input_name = jQuery(this).prop( "name" );
                            var input_value = jQuery(this).val();
                            hidden_input.setAttribute("type", "hidden");
                            hidden_input.setAttribute("name", input_name);
                            hidden_input.setAttribute("value", input_value);
                            f.appendChild( hidden_input );
                        });';
    }

    // customize output
    if ($before_delete) {
        //function js with param
        if (is_array($before_delete) && (count($before_delete) == 2)) {
            $script
                .= '
                        var before_delete_data = '
                   . grn_delete__json_encode($before_delete[1]) . ';
                        var before_delete_ret  = ' . $before_delete[0]
                   . '.call(ele[0], f, before_delete_data);';
        } else //function js no param
        {
            $script
                .= '
                        var before_delete_ret  = ' . $before_delete
                   . '.call(ele[0], f);';
        }
    }

    //js for submit
    $js_submit
        = '
                            if( f ){
                                content.style.display = "none";
                                document.body.appendChild(content);'
          . ($custom_submit ? $custom_submit . ';' : 'f.submit();') . '
                            }';
    //js for show popup
    $js_show_popup
        = '
                            var ui_options = '
          . grn_delete__json_encode($msgbox_options) . ';
                            // real HTML of $content is not equal to $content.innerHTML so message is not cerrect (browser behaviour about innerHTML attribute)
                            // So for this case we need to pass whole $content DOM object
                            var message = content.innerHTML;
                            
                            // show message box
                            GRN_MsgBox.show(message, title, GRN_MsgBoxButtons.yesno,
                                { ui       : ui_options,
                                  caption : { ok: \'' . cb_msg('grn.common',
            'ok') . '\', cancel: \'' . cb_msg('grn.common', 'cancel')
          . '\', yes: \'' . cb_msg('grn.common', 'yes') . '\', no: \''
          . cb_msg('grn.common', 'no') . '\' },
                                  callback : function(result, form){
                                      if(result == GRN_MsgBoxResult.yes){
                                         // submit form
                                         jQuery(\'#msgbox\').find(\'input[type="button"]\').each(function(index, value){jQuery(this).prop( "disabled", true );});
                                         ' . ($custom_submit
            ? 'GRN_MsgBox.close();' . $custom_submit . ';'
            : 'document.body.style.cursor = \'progress\';form.submit();') . '
                                      }
                                  }
                                });';

    // custom show hide popup with value return form before delete
    if (strcmp($no_confirm, 'custom') == 0) {
        $script
            .= '
                        //show popup
                        if ( before_delete_ret ){
                                ' . $js_show_popup . '
                        }
                        //not show popup
                        else{
                                ' . $js_submit . '
                        }';
    } //not show popup -> auto submit
    elseif ($no_confirm) {
        $script .= $js_submit;
    } // show popup for confirm
    else {
        $script .= $js_show_popup;
    }

    $script
        .= '
                        event.stopPropagation();
                        event.preventDefault();
                    });
                  });
                }); 
            </script>';

    //return <script> block
    return $script;
}

/**
 * encode array to JSON object
 */
function grn_delete__json_encode($arr)
{
    if ( ! is_array($arr) || (count($arr) == 0)) {
        return '{}';
    }

    $ret = [];
    foreach ($arr as $key => $value) {
        $value = grn_delete__escape_js($value);
        $str_value = is_numeric($value) ? $value : "'$value'";
        $ret[] = "'$key':" . $str_value;
    }

    return '{' . implode(',', $ret) . '}';
}

/**
 * escape string using for Javascript
 */
function grn_delete__escape_js($str)
{
    return smarty_modifier_escape($str, 'javascript');
}

function grn_delete__escape_html($str)
{
    return smarty_modifier_escape($str, 'html');
}

