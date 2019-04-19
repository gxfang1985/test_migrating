<?php

/**
 * Smarty prefilter plugin
 * Smartyテンプレート内の変数に対して、コンパイル前に自動的にescape修正子を追加する。
 * すでに修正子を指定している変数には影響しない。
 *
 * Type:     prefilter<br>
 * Name:     grn_escape_variables<br>
 */
function smarty_prefilter_grn_escape_variables($source, &$smarty)
{
    return preg_replace('/(\{\$[\w->.\[\]$]+)(\})/', '$1|escape$2', $source);
}

/* vim: set expandtab: */


