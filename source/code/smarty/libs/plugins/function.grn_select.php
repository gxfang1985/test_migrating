<?php
/**
 * @name grn_select
 * @description 渡された配列をもとにセレクトボックスを生成する
 *
 * @date        2004/12/17
 * @author      K.Tokuta
 *
 * @param  string  name       セレクトボックスのname属性
 * @param  array   options    要素配列
 *
 * @option      string  onchange   onchangeイベントハンドラ
 * @option      string  size       size属性
 * @option      boolean multiple   multiple属性
 * @option      boolean disabled   禁止状態
 *
 * Examples;
 * {php}
 *  $options = array( array('value'=>'-1', 'label'=>'(デフォルト)' ),
 *             array('value'=>'-1', 'label'=>'--'),
 *             array('value'=>'1', 'label'=>'1'),
 *             array('value'=>'2', 'label'=>'2', 'selected'=>TRUE),
 *             array('value'=>'-1', 'label'=>'--'),
 *  );
 *  $this->assign( options, $options );
 * {/php}
 * {grn_select name='group_id' size='10' multiple='true' options=$options onchange='this.form.submit();'}
 */
function smarty_function_grn_select($params, &$smarty)
{
    $function_name = 'grn_select';
    $return_code = "\n";

    //-- get parameters
    if (array_key_exists('name', $params)) {
        $name = $params['name'];
    } else {
        return htmlspecialchars($function_name) . ': $name is required';
    }

    if (array_key_exists('options', $params) && is_array($params['options'])) {
        $options = (array)$params['options'];
    } else {
        return htmlspecialchars($function_name) . ': $options is not valid';
    }

    if ($options) {
        // class
        $class_str = (strlen(@ $params['class']) > 0)
            ?
            ' class="' . htmlspecialchars($params['class']) . '"'
            :
            '';

        // onchange
        $onchange_str = (strlen(@ $params['onchange']) > 0)
            ?
            ' onchange="' . htmlspecialchars($params['onchange']) . '"'
            :
            '';

        // size
        $size_str = (strlen(@ $params['size']) > 0)
            ?
            ' size="' . htmlspecialchars($params['size']) . '"'
            :
            '';

        // multiple
        $multiple_str = (@ $params['multiple'])
            ?
            ' multiple'
            :
            '';

        // disabled
        $disabled = (@ $params['disabled']) ? ' disabled' : '';

        $select_str = sprintf('<select id="%s" name="%s"%s%s%s%s%s>%s',
            htmlspecialchars($name),
            htmlspecialchars($name), $class_str, $size_str,
            htmlspecialchars($multiple_str), $onchange_str,
            htmlspecialchars($disabled), htmlspecialchars($return_code));

        $option_str = '';
        foreach ($options as $option) {
            $value = $option['value'];
            $label = $option['label'];
            $color = '';
            if (array_key_exists('color', $option)
                && strlen($option['color']) > 0
            ) {
                $color = 'style="color:#' . htmlspecialchars($option['color'])
                         . '"';
            }
            $selected = $option['selected'];
            $selected = ($selected === true) ? ' selected' : '';
            if (array_key_exists('class', $option)
                && strlen($option['class']) > 0
            ) {
                $option_str .= sprintf('<option class=%s value="%s"%s>%s</option>%s',
                    $option['class'], htmlspecialchars($value),
                    htmlspecialchars($selected), htmlspecialchars($label),
                    htmlspecialchars($return_code));
            } else {
                $option_str .= sprintf('<option %s value="%s"%s>%s</option>%s',
                    $color, htmlspecialchars($value),
                    htmlspecialchars($selected), htmlspecialchars($label),
                    htmlspecialchars($return_code));
            }
        }
        $return_string = $select_str . $option_str . '</select>';
    }

    return $return_string;

}

