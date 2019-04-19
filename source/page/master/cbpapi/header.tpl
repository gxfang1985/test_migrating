<?xml version="1.0" encoding="utf-8"?>
<soap:Envelope
  xmlns:soap="http://www.w3.org/2003/05/soap-envelope"
  xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
{if $xml_namespaces}
  xmlns:xsd="http://www.w3.org/2001/XMLSchema"
{foreach from=$xml_namespaces item="namespace" name="namespaces"}
{if $smarty.foreach.namespaces.last}
  {$namespace|grn_noescape}>
{else}
  {$namespace|grn_noescape}
{/if}
{/foreach}
{else}
  xmlns:xsd="http://www.w3.org/2001/XMLSchema">
{/if}
  <soap:Header><vendor>Cybozu</vendor><product>Garoon</product><product_type>{$product_type}</product_type><version>{$version}</version><apiversion>{$apiversion}</apiversion></soap:Header>
  <soap:Body>
