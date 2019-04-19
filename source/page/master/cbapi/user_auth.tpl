<?xml version="1.0" encoding="{$encoding}"?>
<methodResponse>
  <params>
    <param>
      <value>
        <struct>
          <member>
            <name>apiver</name>
            <value><double>{$api_ver}</double></value>
          </member>
          <member>
            <name>result</name>
            <value><string>OK</string></value>
          </member>
{if $ssid}
          <member>
            <name>ssid</name>
            <value><string>{$ssid|escape}</string></value>
          </member>
{/if}
        </struct>
      </value>
    </param>
  </params>
</methodResponse>
