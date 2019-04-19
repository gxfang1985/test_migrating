<?php

/**
 * Create a button
 *
 * Parameters:
 * - caption: The caption of button
 * - action: The action of button. Available options: submit, cancel
 * - ui: The ui of the button. Available options: normal, main, attention
 * - spacing:  The spacing between the button. Available options: tight, normal, loose, very_loose
 * - size: The size of the button. Available options: default, small, big
 * - image The URL of the image which is displayed in the button
 * - page: The URL of a page for redirection
 * - page_param_xx, page_param_yy, ...: The URL fragment for the given URL specified by "page" parameter
 * - disabled: The button is disabled or else. Available options: true, false
 * - auto_disable: The button will be automatically disabled after clicks on.Available options: true, false
 * - onclick: If this parameter is set, its value will be added to "onclick=..." attribute of the button.
 * - id : The "id" for the button element
 * - class: The CSS class for the button element
 * - html_xx, html_yy, ...: The extra attributes for the button </br>
 * "html_" is just the prefix, the attribute name of HTML element is after the prefix.
 * - onclick: The onclick event handler.
 *
 * NOTICE:
 *  If you set the "onclick" event handler, the "click" event is still be triggered, even the button is being disabled.
 *  So that it's recommended to use grn.common.button component for handling event instead using inline event "onclick".
 *  For example: grn.component.button("#your_button").on("click", function() { });
 *
 * @param array       $params
 * @param \GRN_Smarty $smarty
 *
 * @return string
 */
function smarty_function_grn_button(array $params, &$smarty)
{
    require_once('grn/ui.csp');

    $UI = [
        'normal'    => 'button1_normal_grn',
        'main'      => 'button1_main_grn',
        'attention' => 'button1_attention_grn',
        'disabled'  => 'button_disable_filter_grn'
    ];

    $SPACING = [
        'tight'      => 'button1_r_margin1_grn',
        'normal'     => 'button1_r_margin2_grn',
        'loose'      => 'button1_r_margin3_grn',
        'very_loose' => 'button1_r_margin4_grn'
    ];

    $caption = '';
    $extra_attributes = '';
    $id = '';
    $class = '';
    $disabled = '';
    $spacing = '';
    $onclick = '';
    $auto_disable = '';
    $ui = cb_at($UI, 'normal');

    foreach ($params as $key => $val) {
        $param = htmlspecialchars($key);
        $value = htmlspecialchars($val);

        switch ($param) {
            case 'id':
                $id = $value;
                break;

            case 'class':
                $class = $value;
                break;

            case 'caption':
                $caption = $value;
                break;

            case 'action':
                if ($value === 'cancel') {
                    $page = cb_at($params, 'page');

                    if ( ! $page) {
                        $onclick
                            = "grn.component.button.util.redirect(this,'history_back');";
                    }

                    if ( ! $caption) {
                        $caption = cb_msg('fw.ui', 'cancel');
                    }
                } elseif ($value === 'submit') {
                    $auto_disable = 'data-auto-disable="true"';
                    $onclick = 'grn.component.button.util.submit(this);';
                }
                break;

            case 'ui':
                $ui = cb_at($UI, $value);

                break;

            case 'spacing':
                $spacing = cb_at($SPACING, $value);

                break;

            case 'size'://This is reserved parameter that can be used in the future
                break;
            case 'image'://This is reserved parameter that can be used in the future
                break;
            case 'page':
                if (cb_at($params, 'onclick')) {
                    break;
                }

                $page_params = [];

                foreach ($params as $param_key => $param_value) {
                    $page_param_pos = strpos($param_key, 'page_param_');
                    if ($page_param_pos !== false) {
                        $page_param = substr($param_key,
                            strlen('page_param_'));
                        $page_params[$page_param] = $param_value;
                    }
                }

                $page_fragment = cb_at($params, 'page_fragment');
                $page = cb_pageurl($value, $page_params,
                    $page_fragment);
                $onclick
                    = "grn.component.button.util.redirect(this,'{$page}');";

                break;

            case 'disabled':
                if ($value) {
                    $disabled = cb_at($UI, 'disabled');
                }
                break;

            case 'onclick':
                break;

            case 'auto_disable':
                $auto_disable = "data-auto-disable={$value}";
                break;

            case 'html_id':
            case 'html_class':
            case 'html_onclick':
            case 'html_data_auto_disable':
                // use "id", "class", "auto_disable" instead!
                break;

            default:
                if ( ! is_array($value)) {
                    $html_param_pos = strpos($param, 'html_');

                    if ($html_param_pos !== false) {
                        $html_param = substr($param, strlen('html_'));
                        $extra_attributes .= " " . htmlspecialchars($html_param)
                                             . '="' . htmlspecialchars($value)
                                             . '"';
                    }
                } else {
                    $smarty->trigger_error("grn_button: extra attribute '$param' cannot be an array",
                        E_USER_NOTICE);
                }
                break;
        }
    }

    if (isset($params["onclick"])) {
        $onclick = htmlspecialchars($params["onclick"]);
    }

    if ($id !== '') {
        $id = "id=\"{$id}\"";
    }

    $classes = trim("button_grn_js {$ui} {$disabled} {$spacing} {$class}");
    $class_attribute = "class=\"{$classes}\"";

    $onclick_attribute = '';

    if ($onclick !== '') {
        $onclick_value = trim($onclick);
        $onclick_attribute = "onclick=\"{$onclick_value}\"";
    }

    $attributes
        = "{$id} {$class_attribute} {$onclick_attribute} {$extra_attributes} {$auto_disable}";

    $aria_attribute = '';
    if (strlen($disabled) > 0) {
        $aria_attribute = ' aria-disabled="true"';
    }

    return "<span {$attributes}><a href=\"javascript:void(0);\" role=\"button\"{$aria_attribute}>{$caption}</a></span>";
}
