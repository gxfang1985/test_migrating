<?php

function smarty_validate_criteria_grn_workflow_cellular_notEmoji(
    $value,
    $empty,
    &$params,
    &$formvars
) {
    if (strlen($value) == 0) {
        return true;
    }

    $_ua = $_SERVER['HTTP_USER_AGENT'];
    $_regex = '';
    $_regex_softbank_sjis = '';
    $flag = '';

    if (strpos($_ua, 'DoCoMo') !== false) {
        // Docomo絵文字（UTF-8コード）
        $_regex
            = '[\x{E63E}-\x{E6A5}]|[\x{E6AC}-\x{E6AE}]|[\x{E6B1}-\x{E6B3}]|[\x{E6B7}-\x{E6BA}]|[\x{E6CE}-\x{E757}]';
        $flag = 'u';
    } elseif (strpos($_ua, 'J-PHONE') !== false
              || strpos($_ua, 'Vodafone') !== false
    ) {
        // Vodafone絵文字（シフトイン～シフトアウト）
        $_regex = '\x1B[\x24][\x21-\x7A]{2,}\x0F';
    } elseif (strpos($_ua, 'SoftBank') !== false) {
        // SoftBank絵文字（シフトイン～シフトアウト）
        $emoji_range = '[G|E|F|O|P|Q][\x21-\x7E]';
        $_regex = '[\x1B][\x24]' . $emoji_range . '+[\x0F]';
        // SoftBank絵文字（Shift_JISコード）
        $_regex_softbank_sjis
            = '^.*([\xF7\x41-\xF7\x9B]|[\xF7\xA1-\xF7\xF3]|[\xF9\x41-\xF9\x9B]|[\xF9\xA1-\xF9\xED]|[\xFB\x41-\xFB\x8D]|[\xFB\xA1-\xFB\xD7]).*$';
    } elseif (strpos($_ua, 'UP.Browser') !== false) {
        // au絵文字（UTF-8コード）
        $_regex = '[\x{E234}-\x{E33C}]|[\x{E468}-\x{E5DF}]';
        $flag = 'u';
    }

    if (strlen($_regex)) {
        if (preg_match("/$_regex/$flag", $value)) {
            return false;
        }
    }

    if (strlen($_regex_softbank_sjis)) {
        global $G_RAW_INPUT;
        if (array_key_exists('field', $params)
            && strlen($params['field']) !== 0
        ) {
            $key = $params['field'];
            if (array_key_exists($key, $G_RAW_INPUT)
                && strlen($G_RAW_INPUT[$key]) !== 0
            ) {
                $raw_value = $G_RAW_INPUT[$key];
                if ( ! is_null($raw_value) && strlen($raw_value) !== 0) {
                    $tmp_encoding = mb_regex_encoding();
                    mb_regex_encoding('SJIS-win');
                    if (mb_ereg_match("$_regex_softbank_sjis", $raw_value)) {
                        mb_regex_encoding($tmp_encoding);

                        return false;
                    }
                    mb_regex_encoding($tmp_encoding);
                }
            }
        }
    }

    return true;
}


