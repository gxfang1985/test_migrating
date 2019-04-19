//----- Javascript class GRN_StarList -----
GRN_StarList = function(){
    this.initialize.apply(this, arguments);
};

GRN_StarList.setStatus = function(star_ele, status){
    var app_path = star_ele.attributes['app_path'].nodeValue;
    var star_image = '';
    if(status == 1){
        jQuery(star_ele).removeClass('off');
        jQuery(star_ele).addClass('on');
        star_image = 'star_on.png';
    }
    else{
        jQuery(star_ele).removeClass('on');
        jQuery(star_ele).addClass('off');
        star_image = 'star_off.png';
    }
    var ele = jQuery('<img>').attr({src:app_path + star_image});
    jQuery(star_ele).html(ele);
};

GRN_StarList.getStatus = function(star_ele){
    var status = jQuery(star_ele).hasClass('on') ? 1 : 0;
    return status;
};

GRN_StarList.getItems = function(list_id){
    var star_items = [];
    if(document.getElementById(list_id) != null)
    {
        //star_items = $(list_id).select('span.star');
        star_items = jQuery('#' + list_id).parent().find('span.star');
    }
    return star_items;
};

GRN_StarList.parseParam = function(star_ele){
    var str_param = star_ele.id;
    var params = str_param.split(':');
    var retval = {module:params.shift()};
    jQuery.each(params,function(idx, param){
        var key_value = param.split('_');
        obj = "retval."+key_value[0]+"=null";
        eval(obj);
        retval[key_value[0]] = key_value[1];
    });
    
    return retval;
};

GRN_StarList.prototype = {
    initialize: function(options){
        this.setOption(options);
        //this._registerEvent();
    },
    
    setOption: function(options){
        this._url           = options.url || null;
        this._csrf_ticket   = options.csrf_ticket || null;
        this._list_id       = options.list_id || null;
        this._on_update     = options.on_update || function(star_ele, params){};
    },
    
    registerEvent: function(){
        // not need to register star click again for ajax
        return;
    },
    
    _registerEvent: function(){
        var fn = this;
        if(fn != null)
        {
            jQuery(window).on("load", function(){
                GRN_StarList.getItems(fn._list_id).each(function(idx, ele_star){
                    ele_star.star_list = fn;
                    jQuery(ele_star).on('click', jQuery.proxy(fn._onClick, fn, ele_star));
                });
            });
        }
    },
    
    _onClick: function(ele_star){
        var params = GRN_StarList.parseParam(ele_star);
        params.cmd = GRN_StarList.getStatus(ele_star) ? 'unset' : 'set';
        params.csrf_ticket = this._csrf_ticket;
        var on_update = this._on_update;
        
        this._sendRequest(params, function(data){
            // toggle star icon
            GRN_StarList.setStatus(ele_star, data.status);
            
            on_update(ele_star, params);
            
            // update for GRN2-2287
            var popup_title = jQuery('#popup_show_title');
            if(popup_title.length)
            {
                var star_item = popup_title.find('.star').get(0);
                var app_path = star_item.attributes['app_path'].nodeValue;
                if(star_item)
                {
                    var star_image = '';
                    if(params.cmd=='set')
                        star_image = 'star_on.png';
                    else
                        star_image = 'star_off.png';
                    var img = jQuery('<img>').attr({src:app_path + star_image});
                    jQuery(star_item).html(img);
                }
            }
        });
    },

    _sendRequest: function(post_data, on_update){
        var request = new grn.component.ajax.request(
            {
                url: this._url,
                method: "post",
                dataType: "json",
                data: post_data,
                grnRedirectOnLoginError: true
            }
        );
        request.send().done(
            function (json_obj)
            {
                on_update(json_obj);
            }
        );
    }
};
