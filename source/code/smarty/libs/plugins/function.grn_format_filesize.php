<?php

/**
 * @name           grn_format_filesize
 * @description    show filesize with specified format
 *
 * @date           2004/12/14
 * @author         K.Tokuta
 * @option         mixed  size   ファイルサイズ
 * @option         string unit   単位。省略時は "KB"  (byte,KB,MB,GB,TB)
 * @option         int precision 小数点以下の精度(省略時=0)
 * @option         string round 小数点以下切り上げ("ceil")または切り下げ("floor")、precision=0の場合のみ有効
 *
 * Examples;
 *  {grn_format_filesize size='1024' unit='byte' precision='2'}
 */
function smarty_function_grn_format_filesize($params, &$smarty)
{
    $function_name = 'grn_format_filesize';

    require_once('grn/file.csp');
    //-- check parameters
    if ( ! array_key_exists('size', $params)) {
        return htmlspecialchars($function_name) . ": \$size is required";
    }

    return grn_get_filesize_format(@$params['size'], @$params['unit'],
        @$params['precision'], @$params['round']);
}

