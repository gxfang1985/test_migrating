<?php

use grn\fts\Application as FtsApplication;
use grn\favour\Application as FavourApplication;
use \grn\grn\access\service\AppAccess;

require_once('grn/application.csp');
require_once('grn/ui.csp');

function smarty_function_grn_com_header_assign($params, $smarty)
{

    global $G_container_base;
    $uum = $G_container_base->getInstance('uum');
    $login = $uum->getLoginUser();
    $user_id = $login->getOID();

    $locator = GRN_ApplicationLocator::instance();
    $using_space = AppAccess::isAppAvailable('space', $user_id);

    $smarty->assign('space_active', $using_space);
    $smarty->assign('notify_active', $locator->isActive('notification'));

    require_once('grn/system_logic.csp');
    $system = GRN_System::getInstance();
    $is_password_config = $system->getPasswordEnablePersonalConfig();
    $smarty->assign('is_password_config', $is_password_config);
    if ( ! defined('ON_FOREST')) {
        require_once('fw/i18n.csp');
        $smarty->assign('is_changeble_locale',
            CB_I18N_SystemConfig::isUserChangeableLocale());
    }
    if (FtsApplication::isViewable()
        && count(FtsApplication::getAvailableSearcheableApplications()) > 0
    ) {
        $smarty->assign('use_fts', true);
    }

    if ($locator->isActive('favour')) {
        $smarty->assign('favour_active', true);
    }

    // check admin user
    $roles = [];
    if ($login) {
        $roles = $uum->getUserRolesInfo($login->getOID());
    }
    $is_admin = isset($roles[GRN_UUM_ADMINISTRATION_ROLE]);
    $smarty->assign('is_admin', $is_admin);

    // check admin application & Subsystem admin
    $is_admin_application = false;
    if ( ! $is_admin) {
        require_once('fw/session_manager.csp');
        $session_manager = CB_SessionManager::getInstance();
        $session = $session_manager->getSession('system');
        $is_admin_application = $session->get('is_sub_admin');
        if (is_null($is_admin_application)) {
            $groups = $uum->getUserGroups($login->getOID());
            if ($system->isApplicationAdmin($login, $groups, $roles)
                || $system->isSubsystemAdmin($login, $groups, $roles)
            ) {
                $is_admin_application = true;
                $session->set('is_sub_admin', true);
            } else {
                $session->set('is_sub_admin', false);
            }
        }
    }
    $smarty->assign('is_admin_application', $is_admin_application);
    $smarty->assign('is_system_page', cb_is_system_page());
    unset($uum, $login);
}
