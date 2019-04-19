function GRN_OrganizationSelector(elm_id, callback, blank_page) {
    this.elm_id = elm_id;
    this.callback = callback;
    this.blank_page = blank_page;

    jQuery("#" + this.elm_id).hide();
    this.items = [];

    this.visible = false;
}

GRN_OrganizationSelector.prototype = {
    initialize: function (items) {
        for (var i = 0; i < items.length; i++) {
            this.appendItem(items[i].id, items[i].name, items[i].is_selected, items[i].type);
        }
        this.draw();
    },

    appendItem: function (id, name, is_selected, type) {
        this.items.push(new GRN_OrganizationItem(id, name, this.callback, is_selected, type));
    },

    show: function () {
        if (this.visible) return;
        this.visible = true;

        jQuery("#" + this.elm_id).show();
    },

    _makePopupDivElm: function () {
        var popup_div = document.createElement("div");
        popup_div.setAttribute("id", this.elm_id + "-div");
        popup_div.setAttribute("style", "z-index:1003; position:absolute; border:1px solid #999999; background-color:#FFFFFF;");

        this.el = popup_div;
        return this.el;
    },

    _makePopupIframe: function () {
        var popup_iframe = document.createElement("iframe");
        popup_iframe.setAttribute("id", this.elm_id + '-if');
        popup_iframe.setAttribute("src", this.blank_page);
        popup_iframe.setAttribute("style", "z-index:1002; position:absolute; border:0px;");

        this.el_if = popup_iframe;
        return this.el_if;
    },

    draw: function () {
        var popup_div = this._makePopupDivElm();
        var popup_iframe = this._makePopupIframe();
        var element = jQuery("#" + this.elm_id);

        element.prepend(popup_div);
        element.append(popup_iframe);

        var table = document.createElement("table");
        table.setAttribute("cellspacing", "0");
        table.setAttribute("cellpadding", "0");
        table.setAttribute("id", this.elm_id + "-table");

        jQuery("#" + this.elm_id + '-div').html(table);

        var tbody = document.createElement("tbody");
        table.appendChild(tbody);

        for (var i = 0; i < this.items.length; i++) {
            tbody.appendChild(this.items[i].createElement());
        }
    },

    setSize : function( title_width ) {
        var icon_size = 37;
        var margin = icon_size * 2;
        var height_max = 240;
        var scroll_bar = 17;

        this.show();
        var element = jQuery("#" + this.elm_id);
        var div_element = jQuery("#" + this.elm_id + "-div");
        var iframe_element = jQuery("#" + this.elm_id + "-if");
        var table_element = jQuery("#" + this.elm_id + "-table");
        element.css({'visibility': 'hidden'});

        div_element.css({'width': '', 'height': ''});

        var height = div_element.outerHeight();
        var width = div_element.outerWidth();

        if (this.items.length <= 0) {
            height = 0;
            width = 0;
            element.css({'display': 'none'});
            div_element.css({'display': 'none'});
            iframe_element.css({'display': 'none'});
        }

        var set_width = width;
        if (width < title_width) {
            set_width = title_width;
        }
        set_width += margin;

        if (height > height_max) // overflow
        {
            table_element.css({'width': (set_width - scroll_bar) + "px"});
            div_element.css({'overflowY': 'scroll'});
        }
        else {
            table_element.css({'width': set_width + "px"});
        }

        div_element.css({'width': set_width + "px", 'height': Math.min(height_max, height) + "px"});
        iframe_element.css({
            'width': (set_width - 2) + "px",
            'height': Math.min(height_max, height) + "px"
        });

        element.css({'visibility': 'visible'});
        this.hide();
    },

    getWidth : function( title_width ) {
        this.setSize( title_width );
        this.show();
        var ret = jQuery("#" + this.elm_id + "-div").outerWidth();
        this.hide();
        return ret;
    },

    hide : function() {
        if( ! this.visible ) return;
        this.visible = false;

        jQuery("#" + this.elm_id).hide();
    },

    removeDivIframeElement : function() {
        this.el.remove();
        this.el_if.remove();
    },

    toggle: function () {
        if (this.visible) {
            this.hide();
        }
        else {
            this.show();
        }
    },

    getEl : function() {
        return this.el;
    },

    getSelectedItem : function() {
        for( var i = 0; i< this.items.length; i++ )
        {
            if ( this.items[i].isSelected() ) {
                return this.items[i];
            }
        }
    },

    selectItem : function( gid ) {
        for( var i = 0; i< this.items.length; i++ )
        {
            this.items[i].setSelected( this.items[i].gid == gid );
        }
    },

    getItem: function (gid) {
        var items = jQuery.grep(this.items, function (item, index) {
            return item.gid === gid;
        });

        var item_type_array = ["primary", "membership"];
        if (items.length === 1) {
            return items[0];
        } else if (items.length > 1) {
            if (jQuery.inArray(items[0].type, item_type_array) > -1) {
                return items[0];
            } else {
                return items[1];
            }
        }

        return false;
    }
};

function GRN_DropdownMenu(
    wrap_id, title_button, organization_button, facility_button, button_preference,
    organization_id, facility_id,
    organization_callback, facilitygroup_callback,
    blank_page )
{
    this.wrap_id = wrap_id;
    this.title_button = title_button;
    this.organization_button = organization_button;
    this.facility_button = facility_button;
    this.button_preference = button_preference;
    this.organization_id = organization_id;
    this.facility_id = facility_id;
    this.organization_callback = organization_callback;

    this.organization = new GRN_OrganizationSelector( organization_id, organization_callback, blank_page );
    this.facility = new GRN_FacilityGroupSelectManager( facility_id, facilitygroup_callback, blank_page );

    // ボタンのマウスオーバー
    var facility_button_element = jQuery("#" + facility_button);
    facility_button_element.on("mouseover", function () {
        facility_button_element.addClass("dropdown_menu_mouse_over");
    });

    facility_button_element.on('mouseout', function () {
        facility_button_element.removeClass("dropdown_menu_mouse_over");
    });

    var organization_button_element = jQuery("#" + organization_button);
    if (organization_button_element.length > 0) {
        organization_button_element.on("mouseover", function () {
            organization_button_element.addClass("dropdown_menu_mouse_over");
        });

        organization_button_element.on("mouseout", function () {
            organization_button_element.removeClass("dropdown_menu_mouse_over");
        });
    }

    jQuery(document).on("click", this.handlerClick.bind(this));

    GRN_DropdownMenu.instances = GRN_DropdownMenu.instances || [];
    GRN_DropdownMenu.instances[wrap_id] = this;
}

GRN_DropdownMenu.getInstance = function (instance_id) {
    return GRN_DropdownMenu.instances[instance_id];
};

GRN_DropdownMenu.prototype = {
    handlerClick: function (event) {
        var target = event.target;
        var title_button_element = jQuery("#" + this.title_button);
        var organization_button_element = jQuery("#" + this.organization_button);
        var organization_id_element = jQuery("#" + this.organization_id);
        var facility_button_element = jQuery("#" + this.facility_button);
        var facility_id_element = jQuery("#" + this.facility_id);
        if (title_button_element.is(target) || title_button_element.has(target).length > 0) {
            if (this.button_preference == this.PreferOrganization) {
                this.organization.toggle();
                this.facility.hide();
                if (organization_button_element.length > 0) {
                    organization_button_element.toggleClass("dropdown_menu_select");
                }
                facility_button_element.removeClass("dropdown_menu_select");
            } else {
                this.organization.hide();
                this.facility.toggle();
                if (organization_button_element.length > 0) {
                    organization_button_element.removeClass("dropdown_menu_select");
                }
                facility_button_element.toggleClass("dropdown_menu_select");
            }
        }
        else if (organization_button_element.is(target) || organization_button_element.has(target).length > 0) {
            this.organization.toggle();
            this.facility.hide();
            organization_button_element.toggleClass("dropdown_menu_select");
            facility_button_element.removeClass("dropdown_menu_select");
        }
        else if (facility_button_element.is(target) || facility_button_element.has(target).length > 0) {
            this.organization.hide();
            this.facility.toggle();
            if (organization_button_element.length > 0) {
                organization_button_element.removeClass("dropdown_menu_select");
            }
            facility_button_element.toggleClass("dropdown_menu_select");
        }
        else if (!( organization_id_element.has(target).length > 0 || facility_id_element.has(target).length > 0 )) {
            this.organization.hide();
            this.facility.hide();
            if (organization_button_element.length > 0) {
                organization_button_element.removeClass("dropdown_menu_select");
            }
            if (facility_button_element.length > 0) {
                facility_button_element.removeClass("dropdown_menu_select");
            }
        }
        var dropdown_arrow_image = jQuery("#dropdown_arrow_image");
        if (dropdown_arrow_image.length > 0) {
            if (this.facility.visible) {
                dropdown_arrow_image.removeClass("pulldownbutton_arrow_down_grn").addClass("pulldownbutton_arrow_up_grn");
            } else {
                dropdown_arrow_image.removeClass("pulldownbutton_arrow_up_grn").addClass("pulldownbutton_arrow_down_grn");
            }
        }
    },

    initializeOrganization : function( organization_items ) {
        this.organization.initialize( organization_items );
    },

    initializeFacilityGroup : function( f_params ) {
        this.facility.initialize( f_params.tree_name,
                                  f_params.page_name,
                                  f_params.ajax_path,
                                  f_params.callback,
                                  f_params.selectedOID,
                                  f_params.csrf_ticket,
                                  f_params.title_width,
                                  f_params.node_info
                                );
    },

    prependSearchLabel: function (search_label) {
        var node_info = {oid: "search", extra_param: "search", name: search_label};
        this.facility.insertNode(node_info);
        jQuery("dl#group-select span#dropdown_title").html(search_label);
    },

    removeSearchLabel: function () {
        this.facility.fag_tree.removeSpecialNode("search");
    },

    PreferOrganization : 1,
    PreferFacilityGroup : 2
};
