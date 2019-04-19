<?php

/**
 * @name   grn_design
 * デザイン設定の取得
 *
 * @param string assign     アサインする変数名
 *
 *  記述例
 *  <pre>{grn_design assign="sample"}
 */
function smarty_function_grn_design($params, &$smarty)
{
    $function_name = 'grn_design';

    // necessary parameter and value
    if ( ! array_key_exists('assign', $params)) {
        return htmlspecialchars($function_name) . ': missing assign parameter';
    }

    $assign_name = $params['assign'];

    require_once('grn/ui.csp');
    $ucm = GRN_UIConfigManager::getInstance();

    if (array_key_exists('system', $params) && $params['system']) {
        $config = $ucm->getSystemConfig();
    } else {
        global $G_container_app;
        $uum = $G_container_app->getInstance('uum');

        if (($login = $uum->getLoginUser()) === false) {
            return;
        }
        $config = $ucm->getUserConfig($login);
    }

    $smarty->assign($assign_name, $config->getDesign());
}

