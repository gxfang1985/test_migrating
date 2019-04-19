<?php

/**
 * @name   grn_mobile_delete
 * Generate Javascript to handle delete task
 *
 * @param  string    title       title of message box
 * @param  string    page        path of template delete
 * @param  array     data        variables assigned to delete form
 * @param  mixed     handler     HTML ID (or array of HTML ID) of the element which control delete
 *
 * Optional params
 * @param  mixed     no_confirm            Its default value is false. false then show popup, true then not show popup, 'custom' then developer defines rule to show hide popup.
 * @param  string    multi_target          name of checkbox using for delete multi, eg: 'eid[]'
 * @param  string    form_target           name of form contents the checkboxes specified by parameter "multi_target"
 * @param  string    custom_submit         customized way to submit
 * @param  string    data_theme            data-theme, default value is 'c'
 * @param  string    beforeAjaxSend        If not 'custom_submit', this will run before ajaxSubmit().
 * @param  string    afterAjaxSend         If not 'custom_submit', this will run after ajaxSubmit().
 *
 * @return string $script
 *  Usage:
 *  {grn_delete title='Delete Memo' page='memo/delete' no_confirm=true data=$delete_info handler='delete_memo'}
 */
function smarty_function_grn_mobile_delete($params, &$smarty)
{
    $function_name = 'grn_mobile_delete';

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
    $app_name = $locator->getName($module_name[0]);
    unset($locator);
    $title = str_replace('&&app_name&&', $app_name, $title);
    $title = grn_delete__escape_js($title);
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
    $multi_target = array_key_exists('multi_target', $params)
        ? $params['multi_target'] : false;
    $form_target = array_key_exists('form_target', $params)
        ? $params['form_target'] : false;
    $custom_submit = array_key_exists('custom_submit', $params)
        ? $params['custom_submit'] : false;
    $data_theme = array_key_exists('data_theme', $params)
        ? $params['data_theme'] : 'c';
    $beforeAjaxSend = array_key_exists('beforeAjaxSend', $params)
        ? $params['beforeAjaxSend'] : false;
    $afterAjaxSend = array_key_exists('afterAjaxSend', $params)
        ? $params['afterAjaxSend'] : false;

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
    $t->assign('application_id', $module_name[0]);
    $t->assign('header_title', $title);
    $t->assign('data_theme', $data_theme);

    //get output message
    $message_output = $t->fetch($page);
    $message_output = grn_delete__escape_js($message_output);

    // generate script block
    $script
        = '
        <script type="text/javascript">
        // on page load
        $(document).ready(function(){
            // register event for delete handler
            var handler = ' . $handler . ';
            $.each(handler, function(index, element){
                var ele = $("#"+element);
                ele.click(function(event){
                    var content = $("<div>");
                    content.html("' . $message_output . '");
                    //get form element
                    var f = $(content.find("form")[0]);';

    // delete multi
    if ($multi_target && $form_target) {
        $form_target = grn_delete__escape_js($form_target);
        $multi_target = grn_delete__escape_js($multi_target);
        $script
            .= '
            var list = $("form[name=\'' . $form_target . '\'] input[name=\''
               . $multi_target . '\']").filter(function(){return this.checked;});
            if( list.length == 0 ) return;    // do nothing if these is not any item is selected

            //update number of items to delete
            content.find("#delete_count").append(list.length);

            //add hidden field
            list.each(function(i,ele){
                f.append($("<input>").attr({type:"hidden", name: ele.name, value: ele.value}));
            });';
    }

    //js for submit
    $js_submit
        = '
            content.hide();
            $("body").append(content);' .
          ($custom_submit
              ? $custom_submit . ';'
              : 'grn.component.mobile_ajax_submit.ajaxSubmit(f.attr("id"), ' .
                ($beforeAjaxSend ? $beforeAjaxSend . "," : '"",') .
                ($afterAjaxSend ? $afterAjaxSend : '""') . ');');

    //js for show popup
    $js_show_popup
        = '
            var message = content.html();
            // show message box
            var Gm = grn.component.msgbox_mobile;
            Gm.MsgBox.showDeleteConfirm(message, {
                callback : function(result, form){
                    if(result == Gm.MsgBoxResult.yes)
                    {
                    // submit form
                    ' . ($custom_submit
            ? $custom_submit . ';Gm.MsgBox.close();'
            : 'grn.component.mobile_ajax_submit.ajaxSubmit(f.attr("id"), ' .
              ($beforeAjaxSend ? 'function(){' . $beforeAjaxSend
                                 . '();Gm.MsgBox.close();},'
                  : 'function(){Gm.MsgBox.close();},') .
              ($afterAjaxSend ? $afterAjaxSend : '""') . ');') . '
                    }
                }
            });';

    if ($no_confirm) {
        $script .= $js_submit;
    } // show popup for confirm
    else {
        $script .= $js_show_popup;
    }

    $script
        .= '
            event.stopPropagation();
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
