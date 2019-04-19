<?php

/**
 * @name grn_select_numbers
 * 離散値のselect
 *
 * @date   2004/10/26
 * @author M.Oomori
 *
 * @param  select_name      the select name
 * @param  options          an array of numbers
 *
 * @option selected         initially selected option
 * @option padding          left-side padding in front of a number
 * @option exception_value  the value of the exception option
 * @option exception_item   the display name of the exception option
 * @option separator_value  the value of the separator option
 * @option separator_item   the display name of the separator option
 * @option min_value        the value of the min option
 * @option min_item         the display name of the min option
 * @option max_value        the value of the max option
 * @option max_item         the display name of the max option
 * @option boolean disabled 禁止状態
 *
 * Example;
 * {grn_select_numbers options=$numbers_on_onepage selected=10 padding='&nbsp;'
 *                     exception_value='-1' exception_item='（選択なし）'
 *                     separator_value='-1' separator_item='----------'
 *                     max_value='max' max_item='無制限'
 *                     max_value='min' max_item='保存しない'}
 *
 * @date   2005/1/14
 * @author K.Tokuta
 * @date   2005/1/20
 * @author K.Tokuta
 */

function smarty_function_grn_select_numbers($params, &$smarty)
{
    $function_name = 'grn_select_numbers';

    // necessary parameter and value
    if ( ! array_key_exists('select_name', $params)) {
        return htmlspecialchars($function_name)
               . ': missing select_name parameter';
    }
    if ( ! array_key_exists('options', $params)) {
        return htmlspecialchars($function_name) . ': missing options parameter';
    }

    // assgin variables
    $select_name = $params['select_name'];

    $id_str = (strlen(@ $params['id']) > 0)
        ?
        ' id="' . htmlspecialchars($params['id']) . '"'
        :
        '';
    $options = (array)$params['options'];
    $selected = @ $params['selected'];

    // disabled
    $disabled = (@ $params['disabled']) ? ' disabled' : '';

    $padding_char = '';
    if (array_key_exists('padding', $params)) {
        $padding_char = $params['padding'];
        require_once("fw/ui.csp");
        $browser = cb_ui_get_browser();
        require_once("fw/i18n.csp");
        $i18n = CB_I18N::getInstance();
        $language = $i18n->getCurrentLanguage();
        if ( ! (($browser['type'] == 'msie' && $language == 'en')
                || ($browser['type'] != 'msie' && $language != 'zh')
                || ($browser['type'] == 'msie' && $browser['ver_major'] != '8'
                    && $language == 'ja'))
        ) {
            $padding_char .= '&nbsp;';
        }
    }

    $has_exception = false;
    $exception_value = null;
    $exception_item = null;
    if (array_key_exists('exception_value', $params)) {
        $has_exception = true;
        $exception_value = $params['exception_value'];
        if (array_key_exists('exception_item', $params)) {
            $exception_item = $params['exception_item'];
        } else {
            $exception_item = $exception_value;
        }
    }

    $has_separator = false;
    $separator_value = null;
    $separator_item = null;
    if (array_key_exists('separator_value', $params)) {
        $has_separator = true;
        $separator_value = $params['separator_value'];
        if (array_key_exists('separator_item', $params)) {
            $separator_item = $params['separator_item'];
        } else {
            $separator_item = $separator_value;
        }
    }

    $has_max = false;
    $max_value = null;
    $max_item = null;
    if (array_key_exists('max_value', $params)) {
        $has_max = true;
        $max_value = $params['max_value'];
        if (array_key_exists('max_item', $params)) {
            $max_item = $params['max_item'];
        } else {
            $max_item = $max_value;
        }
    }

    $has_min = false;
    $min_value = null;
    $min_item = null;
    if (array_key_exists('min_value', $params)) {
        $has_min = true;
        $min_value = $params['min_value'];
        if (array_key_exists('min_item', $params)) {
            $min_item = $params['min_item'];
        } else {
            $min_item = $min_value;
        }
    }

    // check if options are integer or not, and know the max digit
    $max_digit = 1;
    foreach ($options as $number) {
        if ( ! is_numeric($number)) {
            return htmlspecialchars($function_name)
                   . ': $number is not integer';
        }
        $max_digit = max(strlen($number), $max_digit);
    }

    // create the select block
    $return_code = "\n";
    $select_str = '<select' . $id_str . ' name="'
                  . htmlspecialchars($select_name) . '"'
                  . htmlspecialchars($disabled) . '>'
                  . htmlspecialchars($return_code);
    $option_str = '';

    if ($has_exception) {
        $selected_str = ($exception_value == $selected) ? ' selected' : '';
        $option_str .= sprintf('<option value="%s"%s>%s</option>%s',
            htmlspecialchars($exception_value), htmlspecialchars($selected_str),
            htmlspecialchars($exception_item),
            htmlspecialchars($return_code));
    }

    if ($has_min) {
        $selected_str = ($min_value == $selected) ? ' selected' : '';
        $option_str .= sprintf('<option value="%s"%s>%s</option>%s',
            htmlspecialchars($min_value), htmlspecialchars($selected_str),
            htmlspecialchars($min_item),
            htmlspecialchars($return_code));
    }

    foreach ($options as $number) {
        $selected_str = ($number == $selected) ? ' selected' : '';

        if ($has_separator && $number == $separator_value) {
            $option_str .= sprintf('<option value="%s">%s</option>%s',
                htmlspecialchars($$separator_value),
                htmlspecialchars($separator_item),
                htmlspecialchars($return_code));
        } else {
            $number_digit = (int)log10($number) + 1;
            $padding_count = $max_digit - strlen($number);
            $number_of_pudding = $max_digit - $number_digit;
            if ($number_of_pudding < 0) {
                $number_of_pudding = 0;
            }
            $padding = '';
            if ($padding_count > 0) {
                $padding = str_repeat($padding_char, $padding_count);
            }
            $option_str .= sprintf('<option value="%s"%s>%s%s</option>%s',
                htmlspecialchars($number), htmlspecialchars($selected_str),
                $padding, htmlspecialchars($number),
                htmlspecialchars($return_code));
        }
    }

    if ($has_max) {
        $selected_str = ($max_value == $selected) ? ' selected' : '';
        $option_str .= sprintf('<option value="%s"%s>%s</option>%s',
            htmlspecialchars($max_value), htmlspecialchars($selected_str),
            htmlspecialchars($max_item),
            htmlspecialchars($return_code));
    }

    $return_string = $select_str . $option_str . '</select>';

    return $return_string;
}
