<?php

/**
 * @param array $params
 * @param       $smarty
 *
 * @return string
 */
function smarty_function_grn_notification_search($params, &$smarty)
{
    if (array_key_exists('caption', $params)) {
        $caption = htmlspecialchars($params['caption']);
    }
    unset($params['caption']);

    $action = $params['action'];
    unset($params['action']);

    $form_target = $params['form_target'] ?? null;
    $form_target_area = $form_target ? (' target="'
                                        . htmlspecialchars($form_target) . '"')
        : '';
    unset($params['form_target']);

    $name = $params['name'] ?? null;
    unset($params['name']);

    $detail_search = true;
    if (isset($params['detail_search']) && ! (bool)$params['detail_search']) {
        $detail_search = false;
    }
    unset($params['detail_search']);

    $disabled = empty($params['disabled']) ? '' : 'disabled';
    unset($params['disabled']);

    $detail = '';
    if ($detail_search) {
        $msg = cb_msg('grn.common', 'simple_search_detail');
        $detail = '<span class="searchboxSub-grn">';
        if ($disabled === 'disabled') {
            $detail .= $msg;
        } else {
            $detail .= '<a href="' . cb_pageurl($action, $params) . '" '
                       . $disabled . '>' . $msg . '</a>';
        }
        $detail .= '</span>';
    }

    $form = '<div class="search_navi">';
    $form .= '<form name="search" action="' . cb_pageurl($action) . '"'
             . $form_target_area . '>';
    $form .= '<div class="search_navi_base_grn">';
    $form .= '<div class="search_navi inline_block_grn">';
    $form .= '<div class="searchbox-grn">';
    $form .= '<div id="searchbox-cybozu-user" class="input-text-outer-cybozu searchbox-keyword-area searchbox_keyword_grn">';
    foreach ($params as $hidden_name => $hidden_value) {
        $form .= '<input type="hidden" name="' . htmlspecialchars($hidden_name)
                 . '" value="'
                 . htmlspecialchars($hidden_value) . '">';
    }

    $form .= '<input class="input-text-cybozu" style="width:160px;" id="" name="'
             . htmlspecialchars($name)
             . '" autocomplete="off" maxlength="" type="text" ' . $disabled
             . '>';

    $form .= '<button id="" class="searchbox-submit-cybozu" type="submit" title="'
             . $caption . '" aria-label="'
             . $caption . '" ' . $disabled . '></button>';

    return $form . '</div><div class="clear_both_0px"></div></div></div>'
           . $detail . '</div></form></div>';
}

