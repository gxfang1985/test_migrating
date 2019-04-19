{capture name="wsdl_path" assign="wsdl_path"}{$app_path}/api/2008{/capture}
<?xml version="1.0" ?>
<definitions name="GaroonServices"
             targetNamespace="http://wsdl.cybozu.co.jp/api/2008"
             xmlns="http://schemas.xmlsoap.org/wsdl/"
             xmlns:wsdl="http://schemas.xmlsoap.org/wsdl/"
             xmlns:soap12="http://schemas.xmlsoap.org/wsdl/soap12/"
             xmlns:tns="http://wsdl.cybozu.co.jp/api/2008"
             xmlns:base_services="http://wsdl.cybozu.co.jp/base/2008"
             xmlns:schedule_services="http://wsdl.cybozu.co.jp/schedule/2008"
             xmlns:address_services="http://wsdl.cybozu.co.jp/address/2008"
             xmlns:workflow_services="http://wsdl.cybozu.co.jp/workflow/2008"
             xmlns:mail_services="http://wsdl.cybozu.co.jp/mail/2008"
             xmlns:message_services="http://wsdl.cybozu.co.jp/message/2008"
             xmlns:notification_services="http://wsdl.cybozu.co.jp/notification/2008"
             xmlns:report_services="http://wsdl.cybozu.co.jp/report/2008"
             xmlns:cabinet_services="http://wsdl.cybozu.co.jp/cabinet/2008"
             xmlns:admin_services="http://wsdl.cybozu.co.jp/admin/2008"
             xmlns:util_api_services="http://wsdl.cybozu.co.jp/util_api/2008"
             xmlns:star_services="http://wsdl.cybozu.co.jp/star/2008"
             xmlns:bulletin_services="http://wsdl.cybozu.co.jp/bulletin/2008"
             >

  <wsdl:import namespace="http://wsdl.cybozu.co.jp/base/2008" location="{$wsdl_path}/base.wsdl" />
  <wsdl:import namespace="http://wsdl.cybozu.co.jp/schedule/2008" location="{$wsdl_path}/schedule.wsdl" />
  <wsdl:import namespace="http://wsdl.cybozu.co.jp/address/2008" location="{$wsdl_path}/address.wsdl" />
  <wsdl:import namespace="http://wsdl.cybozu.co.jp/workflow/2008" location="{$wsdl_path}/workflow.wsdl" />
  <wsdl:import namespace="http://wsdl.cybozu.co.jp/mail/2008" location="{$wsdl_path}/mail.wsdl" />
  <wsdl:import namespace="http://wsdl.cybozu.co.jp/message/2008" location="{$wsdl_path}/message.wsdl" />
  <wsdl:import namespace="http://wsdl.cybozu.co.jp/notification/2008" location="{$wsdl_path}/notification.wsdl" />
  <wsdl:import namespace="http://wsdl.cybozu.co.jp/report/2008" location="{$wsdl_path}/report.wsdl" />
  <wsdl:import namespace="http://wsdl.cybozu.co.jp/cabinet/2008" location="{$wsdl_path}/cabinet.wsdl" />
  <wsdl:import namespace="http://wsdl.cybozu.co.jp/admin/2008" location="{$wsdl_path}/admin.wsdl" />
  <wsdl:import namespace="http://wsdl.cybozu.co.jp/util_api/2008" location="{$wsdl_path}/util_api.wsdl" />
  <wsdl:import namespace="http://wsdl.cybozu.co.jp/star/2008" location="{$wsdl_path}/star.wsdl" />
  <wsdl:import namespace="http://wsdl.cybozu.co.jp/bulletin/2008" location="{$wsdl_path}/bulletin.wsdl" />
  
  <service name="BaseService">
    <port name="BasePort" binding="base_services:BaseBinding">
      <soap12:address location="{$url_prefix}{grn_pageurl page='cbpapi/base/api'}" />
    </port>
  </service>

  <service name="ScheduleService">
    <port name="SchedulePort" binding="schedule_services:ScheduleBinding">
      <soap12:address location="{$url_prefix}{grn_pageurl page='cbpapi/schedule/api'}" />
    </port>
  </service>

  <service name="AddressService">
    <port name="AddressPort" binding="address_services:AddressBinding">
      <soap12:address location="{$url_prefix}{grn_pageurl page='cbpapi/address/api'}" />
    </port>
  </service>
  
  <service name="WorkflowService">
    <port name="WorkflowPort" binding="workflow_services:WorkflowBinding">
      <soap12:address location="{$url_prefix}{grn_pageurl page='cbpapi/workflow/api'}" />
    </port>
  </service>
  
  <service name="MailService">
    <port name="MailPort" binding="mail_services:MailBinding">
      <soap12:address location="{$url_prefix}{grn_pageurl page='cbpapi/mail/api'}" />
    </port>
  </service>
  
  <service name="MessageService">
    <port name="MessagePort" binding="message_services:MessageBinding">
      <soap12:address location="{$url_prefix}{grn_pageurl page='cbpapi/message/api'}" />
    </port>
  </service>
  
  <service name="NotificationService">
    <port name="NotificationPort" binding="notification_services:NotificationBinding">
      <soap12:address location="{$url_prefix}{grn_pageurl page='cbpapi/notification/api'}" />
    </port>
  </service>
  
  <service name="ReportService">
    <port name="ReportPort" binding="report_services:ReportBinding">
      <soap12:address location="{$url_prefix}{grn_pageurl page='cbpapi/report/api'}" />
    </port>
  </service>

  <service name="CabinetService">
    <port name="CabinetPort" binding="cabinet_services:CabinetBinding">
      <soap12:address location="{$url_prefix}{grn_pageurl page='cbpapi/cabinet/api'}" />
    </port>
  </service>
  
  <service name="AdminService">
    <port name="AdminPort" binding="admin_services:AdminBinding">
      <soap12:address location="{$url_prefix}{grn_pageurl page='sysapi/admin/api'}" />
    </port>
  </service>

  <service name="UtilService">
    <port name="UtilPort" binding="util_api_services:UtilBinding">
      <soap12:address location="{$url_prefix}{grn_pageurl page='util_api/util/api'}" />
    </port>
  </service>
  
  <service name="StarService">
    <port name="StarPort" binding="star_services:StarBinding">
      <soap12:address location="{$url_prefix}{grn_pageurl page='cbpapi/star/api'}" />
    </port>
  </service>
  
  <service name="BulletinService">
    <port name="BulletinPort" binding="bulletin_services:BulletinBinding">
      <soap12:address location="{$url_prefix}{grn_pageurl page='cbpapi/bulletin/api'}" />
    </port>
  </service>
  
</definitions>