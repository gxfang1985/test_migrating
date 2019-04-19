<?php

/**
 * @name   grn_cellular_truncate
 *                           smarty の truncate修飾子のマルチバイト版
 *                           の バグ対応版（バグが解消されたら処理変更予定）
 *
 * @date   2005/02/22
 *
 * @param  string $string    変換する文字列
 * @param  string $width     切り捨てを行う文字幅 (default=20)
 * @param  string $trimmaker 切り捨てが発生した際に終端に付加するキャラクタ (default='..')
 *
 *  記述例
 *  <pre>
 *  {'あいうえおかきくけこさしすせそ'|grn_cellular_truncate:10:'--'}
 *  </pre>
 *  出力例
 *  <pre>
 *  あいうえ--
 *  </pre>
 */
function smarty_modifier_grn_report_cellular_truncate(
    $string,
    $width = 20,
    $trimmaker = '..'
) {
    require_once('report/cellular.csp');

    return grn_report_cellular_utf8_strimwidth($string, $width, $trimmaker);
}


