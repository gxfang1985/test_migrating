{include file="grn/doctype.tpl"}
<html lang="{$html_tag_lang}">
<head>
  <meta name="viewport" content="width=device-width, initial-scale=1,maximum-scale=1, user-scalable=no">
  <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  <title>{$page_title|escape}</title>
  {grn_load_css file="fw/jquery_mobile/jquery.mobile-1.4.5.min.css"}
  {grn_load_css file="grn/html/component/msgbox_mobile.css"}
  {grn_load_css file="grn/html/mobile_standard.css"}
  {grn_load_css file="grn/html/mobile_select.css"}
  {grn_load_css file="grn/html/mobile_change_panel.css"}
  {grn_load_css file="grn/html/mobile_toolbar.css"}
  {grn_load_css file="grn/html/mobile_folderlist.css"}
  {grn_load_css file="grn/html/mobile_list.css"}
  {if $application_id}
    {grn_load_css file="grn/html/mobile_$application_id.css"}
  {/if}
  {grn_load_css file="grn/html/mobile_design_standard.css"}
  <link rel="shortcut icon" href="{$app_path}/grn/image/cybozu/garoon.ico?{$build_date}">
  <link rel="apple-touch-icon-precomposed" href="{$app_path}/grn/image/cybozu/image-mobile/apple-touch-icon.png?{$build_date}">
  {grn_load_javascript file="fw/jquery/jquery-2.2.4.min.js"}
  {if $page_info.all == 'schedule/mobile/group_day'
   || $page_info.all == 'schedule/mobile/personal_week'
   || $page_info.all == 'mail/mobile/send'
   || $page_info.all == 'mail/mobile/resend'
   || $page_info.all == 'mail/mobile/reply_all'
   || $page_info.all == 'mail/mobile/reply'
   || $page_info.all == 'mail/mobile/preview_modify'
   || $page_info.all == 'mail/mobile/forward'
   || $page_info.all == 'mail/mobile/draft_modify'
   || $page_info.all == 'space/mobile/application/discussion/comment_add'
   || $page_info.all == 'space/mobile/application/discussion/comment_detail'
   || $page_info.all == 'message/mobile/view'
   || $page_info.all == 'message/mobile/comment_detail'
   || $page_info.all == 'message/mobile/comment_add'
  }
      {grn_load_javascript file="fw/jquery/jquery-ui-1.11.4.custom.min.js"}
  {/if}
  {grn_load_javascript file="grn/common/base.js"}
  {include file="grn/browser.tpl"}
  {grn_load_javascript file="grn/html/component/custom_jquery_mobile.js"}
  {grn_load_javascript file="fw/jquery_mobile/jquery.mobile-1.4.5.min.js"}
  {grn_load_javascript file="grn/html/component/msgbox_mobile.js"}
  {grn_load_javascript file="grn/html/component/define_cybozu_browser.js"}
  {grn_load_javascript file="grn/html/component/mobile_common.js"}
  {grn_load_javascript file="grn/html/component/mobile_loading.js"}
  {include file="grn/mobile_error_handler.tpl"}
  {grn_load_javascript file="grn/html/component/mobile_ajax_submit.js"}
  {include file="grn/url_builder.tpl"}
  {grn_load_javascript file="grn/html/component/i18n.js"}
  {grn_load_javascript_resource}
  {include file="grn/component/ajax.tpl"}
  {include file="grn/_common_js.tpl" mobile=TRUE}
  <script type="text/javascript" language="javascript">
    grn.data = {ldelim}{rdelim};
    grn.data.login = {ldelim}{rdelim};
    grn.data.login.id = {$login.id};
    grn.data['CSRF_TICKET'] = "{$csrf_ticket}";
    grn.component.define_cybozu_browser.kunai_api_version = '{$kunai_api_version}';
    grn.msg = {ldelim}{rdelim};
    grn.msg.OK = '{cb_msg module='grn.common' key='ok' replace='true'}';
    grn.msg.CANCEL = '{cb_msg module='grn.common' key='cancel' replace='true'}';
    grn.msg.YES = '{cb_msg module='grn.common' key='yes' replace='true'}';
    grn.msg.NO = '{cb_msg module='grn.common' key='no' replace='true'}';

    var getNumberNotificationUrl = "{grn_pageurl page='grn/ajax_get_number_notification'}";

    grn.component.mobile_common.setNextUpdateNotification({grn_get_update_notification_time_mobile});

    grn.component.mobile_common.productTerm = "{$product_term|escape}";
    grn.component.mobile_common.copyright = "{$copyright|escape}";
  </script>
</head>
<body>
  {include file='grn/mobile_loading.tpl'}
  <div data-role="page">
  {if $footer_bar|@count >= 1}
    {grn_load_javascript file="grn/html/component/mobile_appmenu_grn.js"}
    {include file='grn/mobile_appmenu.tpl'}
  {/if}
