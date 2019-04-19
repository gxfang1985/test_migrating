<?xml version="1.0" encoding="{php}echo mb_preferred_mime_name( cb_get_http_output_encoding() );{/php}"?>
<methodResponse>
   <fault>
      <value>
         <struct>
            <member>
               <name>faultCode</name>
               <value><int>{php}global $G_grn_cbapi_code; echo $G_grn_cbapi_code;{/php}{$ErrorNumber|regex_replace:"/^(GRN_CBAPI_)|(00)$/":""}</int></value>
            </member>
            <member>
               <name>faultString</name>
               <value><string>{$ErrorDiag|grn_noescape}</string></value>
            </member>
            <member>
               <name>causeString</name>
               <value><string>{$ErrorCause|grn_noescape}</string></value>
            </member>
            <member>
               <name>guideString</name>
               <value><string>{$ErrorCounterMeasure|grn_noescape}</string></value>
            </member>
         </struct>
      </value>
   </fault>
</methodResponse>
