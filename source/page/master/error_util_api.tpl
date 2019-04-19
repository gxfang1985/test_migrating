<?xml version="1.0" encoding="utf-8"?>
<soap:Envelope xmlns:soap="http://www.w3.org/2003/05/soap-envelope"
               xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
               xmlns:xsd="http://www.w3.org/2001/XMLSchema"
               xmlns:wsa="http://schemas.xmlsoap.org/ws/2004/08/addressing"
               xmlns:wsse="http://docs.oasis-open.org/wss/2004/01/oasis-200401-wss-wssecurity-secext-1.0.xsd"
               xmlns:wsu="http://docs.oasis-open.org/wss/2004/01/oasis-200401-wss-wssecurity-utility-1.0.xsd">
 <soap:Header><vendor>Cybozu</vendor><product>Garoon</product><product_type>{$product_type}</product_type><version>{$version}</version><apiversion>{$apiversion}</apiversion></soap:Header>
  <soap:Body>
    <soap:Fault>
      <soap:Code>
        <soap:Value>soap:Receiver</soap:Value>
      </soap:Code>
      <soap:Reason>
        <soap:Text>{$ErrorDiag|grn_noescape}</soap:Text>
      </soap:Reason>
      <soap:Detail>
        <code>{$ErrorNumber}</code>
        <diagnosis>{$ErrorDiag|grn_noescape}</diagnosis>
        <cause>{$ErrorCause|grn_noescape}</cause>
        <counter_measure>{$ErrorCounterMeasure|grn_noescape}</counter_measure>
        {if $show_backtrace}
          <developerinfo>{$ErrorDeveloperInfo|grn_noescape}</developerinfo>
          <backtrace>{$ErrorDetailTable|grn_noescape}</backtrace>
        {/if}
      </soap:Detail>
    </soap:Fault>
  </soap:Body>
</soap:Envelope>
