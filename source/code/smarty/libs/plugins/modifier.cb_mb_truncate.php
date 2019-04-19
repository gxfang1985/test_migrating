<?php

/**
 * @name   cb_mb_truncate
 *                           smarty の truncate修飾子のマルチバイト版
 *
 * @date   2004/10/13
 *
 * @param  string $string    変換する文字列
 * @param  string $length    切り捨てを行うキャラクタ数 (default=80)
 * @param  string $trimmaker 切り捨てが発生した際に終端に付加するキャラクタ (default='...')
 *
 *  記述例
 *  <pre>
 *  {'あいうえおかきくけこさしすせそ'|cb_mb_truncate}
 *  {'あいうえおかきくけこさしすせそ'|cb_mb_truncate:10}
 *  {'あいうえおかきくけこさしすせそ'|cb_mb_truncate:']]]'}
 *  </pre>
 *  出力例
 *  <pre>
 *  あいうえおかきくけこさしすせそ
 *  あいう...
 *  あいう]]]
 *  </pre>
 */
function smarty_modifier_cb_mb_truncate(
    $string,
    $length = 30,
    $trimmaker = '...'
) {
    //return mb_substr($string, 0, $length) . $etc;
    return mb_strimwidth($string, 0, $length, $trimmaker);
}


