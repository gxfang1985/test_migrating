<?php

/**
 * @name   grn_autolink
 *                        自動リンク生成フィルター
 *
 * @date   2004/10/13
 *
 * @param  string $string 変換する文字列
 *
 *  記述例
 *  {'あああ grn.exe/sample/hoge?fuga=3 いいい'|grn_autolink}
 *
 *  出力例
 *  あああ <a href="/.../grn.exe/sample/hoge?fuga=3">grn.exe/sample/hoge?fuga=3</a> いいい
 */
function smarty_modifier_grn_autolink($string)
{
    require_once('grn/ui.csp');

    return grn_autolink($string);
}


