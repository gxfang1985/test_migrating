(function($){
    $(document).bind('mobileinit', function()
    {
        $.mobile.ajaxEnabled = false;
        $.mobile.pushStateEnabled = false;
        var need_hash_regexps =
        [
             new RegExp(/\/space\/mobile\/application\/todo\/add\?/i),
             new RegExp(/\/space\/mobile\/application\/todo\/add\.csp\?/i),
             new RegExp(/\/space\/mobile\/application\/todo\/modify\?/i),
             new RegExp(/\/space\/mobile\/application\/todo\/modify\.csp\?/i),
             new RegExp(/\/schedule\/mobile\//i)
        ];
        $.each(need_hash_regexps, function(i, regexp)
        {
            if ( location.href.match(regexp) )
            {
                $.mobile.hashListeningEnabled = true;
                return false; //break
            }
            $.mobile.hashListeningEnabled = false;
        });
        //Created by Vien Tran,
        //Get URl parameters by key, in the case param not provider return all paramter
        //Using Example: $.GetURLParameter('bdate');//return 2014-02-12, $.GetURLParameter();//bdate=2014-02-12&gid=
        $.GetURLParameter = function (sParam)
        {
            var sPageURL = window.location.search;
            if(sParam === undefined || $.trim(sParam) == ""){
                return sPageURL;
            }
            if(sPageURL.length < 1){
                return "";
            }
            sPageURL = sPageURL.substring(1);
            var sURLVariables = sPageURL.split('&');
            for (var i = 0; i < sURLVariables.length; i++)
            {
                var sParameterName = sURLVariables[i].split('=');
                if (sParameterName[0] == sParam)
                {
                    return sParameterName[1];
                }
            }
            return "";
        };
        //Created by Vien Tran,
        //Client prevent xss,
        $.htmlEscape = function(str) {
            return String(str)
                .replace(/&/g, '&amp;')
                .replace(/"/g, '&quot;')
                .replace(/'/g, '&#39;')
                .replace(/</g, '&lt;')
                .replace(/>/g, '&gt;');
        };
        //Created by Vien Tran,
        //Computed length of object in javascript
        Object.size = function(obj) {
            var size = 0, key;
            for (key in obj) {
                if (obj.hasOwnProperty(key)) size++;
            }
            return size;
        };
    });
})(jQuery);