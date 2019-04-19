<?php

/**
 * @name   grn_mobile_logout
 *                   Generate Javascript to handle logout task
 *
 * Optional params
 *
 * @param  string    form                 logout form name,default: form_logout.
 * @param  string    page                 path of template logout,default: grn/mobile_logout.tpl.
 * @param  mixed     handler              HTML ID (or array of HTML ID) of the element which control logout,default: mobile_logout.
 * @param  string    logout_url           forest logout url,default: /g/logout.csp.
 *
 * @return string $script
 *  Usage:
 *  {grn_mobile_logout form ='form_logout' page='grn/mobile_logout.tpl' handler='mobile_logout' logout_url='/g/logout.csp'}
 */
function smarty_function_grn_mobile_logout($params, &$smarty)
{
    $function_name = 'grn_mobile_logout';

    // optional params
    $logout_form = array_key_exists('form', $params) ? $params['form']
        : 'form_logout';
    $page = array_key_exists('page', $params) ? $params['page']
        : 'grn/mobile_logout.tpl';
    $handler = array_key_exists('handler', $params) ? $params['handler']
        : 'mobile_logout';

    if (is_array($handler)) {
        $temp_array = [];
        foreach ($handler as $value) {
            $temp_array[] = "'" . grn_logout__escape_js($value) . "'";
        }
        $handler = '[' . implode(',', $temp_array) . ']';
    } else {
        $handler = "['" . grn_logout__escape_js($handler) . "']";
    }

    // prepare content of message box
    require_once("grn/smarty.csp");
    $t = new GRN_Smarty;

    //get output message
    $message_output = $t->fetch($page);
    $message_output = grn_logout__escape_js($message_output);

    // generate script block
    $script
        = '
        <script type="text/javascript">
        // on page load
        $(document).ready(function(){
            // register event for logout handler
            var handler = ' . $handler . ';
            $.each(handler, function(index, element){
                var ele = $("#"+element);
                ele.click(function(event){
                    var message = "' . $message_output . '";
                    // show message box
                    var Gm = grn.component.msgbox_mobile;
                    Gm.MsgBox.showDeleteConfirm(message, {
                        callback : function(result, form){
                            if(result == Gm.MsgBoxResult.yes)
                            {
                                ';
    $logout_script = '$("#' . $logout_form . '").submit();';
    $script .= $logout_script . '
                                Gm.MsgBox.close();
                            }
                        }
                    });

                    $("#msgbox").find("div.mobile_ul_grn").css({height: "", minHeight: $(window).height() * 0.5});
                    $("#msgbox").css("top", $(window).scrollTop() + ($(window).height() - $("#msgbox").innerHeight()) / 3);
                    $(window).resize(function(){
                        $("#msgbox").find("div.mobile_ul_grn").css({height: "", minHeight: $(window).height() * 0.5});
                        $("#msgbox").css("top", $(window).scrollTop() + ($(window).height() - $("#msgbox").innerHeight()) / 3);
                    });
                    $(window).scroll(function(){
                        $("#msgbox").css("top", $(window).scrollTop() + ($(window).height() - $("#msgbox").innerHeight()) / 3);
                    });

                    event.stopPropagation();
                });
            });
        });
        </script>';

    //return <script> block
    return $script;
}

/**
 * escape string using for Javascript
 */
function grn_logout__escape_js($str)
{
    return smarty_modifier_escape($str, 'javascript');
}
