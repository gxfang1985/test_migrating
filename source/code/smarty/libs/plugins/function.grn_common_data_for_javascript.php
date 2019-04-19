<?php

/**
 * Create common data used by javascript code.
 * The data is generated in JSON format and saved into the "grn.data" namespace.
 *
 * @param $params array
 * @param $smarty GRN_Smarty
 */
function smarty_function_grn_common_data_for_javascript(array $params, &$smarty)
{
    $data = [];

    $data['CSRF_TICKET'] = $smarty->get_template_vars('csrf_ticket');

    $data['locale'] = $smarty->get_template_vars('html_tag_lang');

    $data['login'] = $smarty->get_template_vars('login');

    require_once('grn/locale.csp');
    $data['short_date_format']
        = CB_LocaleManager::getCurrentShortDateFormat($data['login']['id']);

    $data_json = json_encode($data);

    echo "grn.data = $data_json;";
}
