grn.base.namespace("grn.component.star_mobile");

(function () {
    if (grn.component.star_mobile.StarMobile) {
        return;
    }

    grn.component.star_mobile.StarMobile = function(){};

    grn.component.star_mobile.StarMobile.prototype = {
        initialize : function(options){
            this._setOption(options);
        },

        _setOption : function(options){
            this._url            = options.url || null;
            this._csrf_ticket    = options.csrf_ticket || null;
            this._star_on_class  = options.star_on_class || 'mobile-icon-starOn-grn';
            this._star_off_class = options.star_off_class || 'mobile-icon-starOff-grn';
        },

        _setStatus : function(star_element, status){
            if(status == 1){
                $(star_element).removeClass(this._star_off_class);
                $(star_element).addClass(this._star_on_class);
            }
            else{
                $(star_element).removeClass(this._star_on_class);
                $(star_element).addClass(this._star_off_class);
            }
        },

        _getStatus : function(star_element){
            var status = $(star_element).hasClass(this._star_on_class) ? 1 : 0;
            return status;
        },

        _parseParam : function(star_element){
            var str_param = star_element.id;
            var params = str_param.split(':');
            var retval = {module:params.shift()};
            $.each(params, function(index, param){
                var key_value = param.split('_');
                obj = "retval."+key_value[0]+"=null";
                eval(obj);
                retval[key_value[0]] = key_value[1];
            });
            return retval;
        },

        onClick : function(star_element){
            var params = this._parseParam(star_element);
            params.cmd = this._getStatus(star_element) ? 'unset' : 'set';
            params.csrf_ticket = this._csrf_ticket;
            var on_update = this._on_update;
            var fn = this;
            this._sendRequest(params, function(data){
                // toggle star icon
                fn._setStatus(star_element, data.status);
            });
        },

        _sendRequest : function(post_data, on_update){
            var fn = this;
            $.ajax({
                url : this._url,
                data : post_data,
                type : 'post',
                headers : {Accept: 'application/json'},
                success : function(data, text_status, transport){
                    //checking error
                    var headers = transport.getAllResponseHeaders();
                    var regex = new RegExp( /X-Cybozu-Error/i );
                    if (headers.match(regex)) {
                        fn._showErrorMessage(transport.responseText);
                        return false;
                    }
                    // response success
                    on_update($.parseJSON(data || "null"));
                },
                error : function(transport){
                    return fn._showErrorMessage(transport.responseText);
                }
            });
        },

        _showErrorMessage : function(message){
            if (message != undefined) {
                document.write(message);
                document.close();
            }
        }
    };
})();
