(function()
 {
     if(typeof mailPortlet != "undefined") { return; }
     mailPortlet = {
         valueStore : {},
         createCheckMailsParameter  :
         function(update_element_id, update_element_id_on_failure, url, parameter, header, method, span, error_message)
         {
             return { 'updateElementId'          : update_element_id,
                      'url'                      : url,
                      'httpParameter'            : parameter,
                      'httpHeader'              : header,
                      'span'                     : span,
                      'method'                   : method,
                      'errorMessage'             : error_message,
                      'updateElementIdOnFailure' : update_element_id_on_failure };
         },
         getNumberOfNewMails : function ( param )
         {

             function is_XCybozuLogin_Exists( response )
             {
                 var headers = response.getAllResponseHeaders();
                 return (headers.match(/X-CybozuLogin/i) || !headers.match(/X-Cybozu-User/i));
             }

             function is_XCybozuError_Exists( response )
             {
                 return response.getAllResponseHeaders().match(new RegExp( /X-Cybozu-Error/i ));
             }

             var ajax_request = new grn.component.ajax.request({
                 grnUrl: param.url,
                 method: param.method,
                 data: param.httpParameter
             });

             ajax_request.on("beforeShowError", function (e) {
                 e.preventDefault();
             });

             ajax_request.send().done(function (data) {
                 if (is_XCybozuLogin_Exists(arguments[2])) {
                     return false;
                 }
                 jQuery("#" + param.updateElementId).html(data);
                 setTimeout(function () {
                     return mailPortlet.getNumberOfNewMails(param);
                 }, param.span);
             }).fail(function (response) {
                 /* オンプレはエラー情報も中に入っているので書き換え */
                 if (is_XCybozuError_Exists(response)) {
                     jQuery("#" + param.updateElementId).html(param.errorMessage + response.responseJSON.code + ")");
                     return;
                 }
                 jQuery("#" + param.updateElementIdOnFailure).html(param.errorMessage + response.status + ")");
             });
         }
     };
 })();
