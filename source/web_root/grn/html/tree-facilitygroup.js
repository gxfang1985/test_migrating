function GRN_FacilityGroupSelectManager( elm_id, callback, blank_page )
{
    this.elm_id = elm_id;
    this.callback = callback;
    this.blank_page = blank_page;

    jQuery("#" + this.elm_id).hide();

    this.items = new Array();

    this.visible = false;
}

GRN_FacilityGroupSelectManager.prototype = {
    show : function() {
        if( this.visible ) return;
        this.visible = true;
        
        jQuery("#" + this.elm_id).show();
        if( jQuery("#" + this.elm_id + "-div" ).length === 0 )
        {
            this.draw();
        }
    },

    hide : function() {
        if( ! this.visible ) return;
        this.visible = false;
        
        jQuery("#" + this.elm_id).hide();
    },

    toggle : function() {
        if( this.visible )
        {
            this.hide();
        }
        else
        {
            this.show();
        }
    },

    draw : function() {
        var wrap_div1 = document.createElement("div");
        wrap_div1.setAttribute("id", this.elm_id + "-div");
        wrap_div1.setAttribute("class", "wrap_tree1");

        var wrap_div2 = document.createElement("div");
        wrap_div2.setAttribute("id", this.elm_id + "-div2");
        wrap_div2.setAttribute("class", "wrap_tree2");

        var popup_iframe = document.createElement("iframe");
        popup_iframe.setAttribute("id", this.elm_id + "-if");
        popup_iframe.setAttribute("src", this.blank_page);
        popup_iframe.setAttribute("style", "z-index:2; position:absolute; border:0px;");

        var popup_div_for_tree = document.createElement("div");
        popup_div_for_tree.setAttribute("id", this.elm_id + "-div-tree");
        popup_div_for_tree.setAttribute("style", "background-color:#FFFFFF;");

        var father_elm = jQuery("#" + this.elm_id);
        father_elm.append(wrap_div1);
        father_elm.prepend(popup_iframe);
        jQuery(wrap_div1).append(wrap_div2);
        jQuery(wrap_div2).append(popup_div_for_tree);
    },

    setSize : function() {
        var max_width = 320;
        var max_height = 240;
        var menu_part_width = this.title_width;
        
        var before_visible = this.visible;
        var father_elm = jQuery("#" + this.elm_id);
        if( ! this.visible )
        {
            father_elm.css("visibility","hidden");
            this.show();
        }

        // ダミーのサイズをリセット
        var dummy_tree_wrap_tree1 = jQuery( "#" + this.elm_id + "-dummy_tree_wrap_tree1" );
        var dummy_tree_wrap_tree2 = jQuery( "#" + this.elm_id + "-dummy_tree_wrap_tree2" );
        var div1 = jQuery( "#" + this.elm_id + "-div" );
        var div2 = jQuery( "#" + this.elm_id + "-div2" );

        dummy_tree_wrap_tree1.css( {width : "", height : ""} );
        dummy_tree_wrap_tree2.css( {width : "", height : "", overflowX : "", overflowY: ""} );

        jQuery("#" + this.elm_id + "-dummy_tree").html( this.fag_tree._tree.root.getHtml().replace( new RegExp( 'id="[^"]+"', "g"), "" ) );

        // 幅はタイトル部分の幅と 320px のうち、大きいほう
        var real_width  = document.getElementById( this.elm_id + "-dummy_root").scrollWidth;
        var new_width = Math.max( menu_part_width, max_width );
        div1.css( "width", new_width + "px" );
        dummy_tree_wrap_tree1.css( "width", new_width + "px" );

        // reduce the border width
        div2.css( "width", new_width - 22 + "px" );
        dummy_tree_wrap_tree2.css( "width", new_width - 22 + "px" );

        if( real_width > new_width )
        {
            // add a scroll bar
            div2.css( "overflowX", "scroll" );
            dummy_tree_wrap_tree2.css( "overflowX", "scroll" );
        }
        else
        {
            div2.css( "overflowX", "" );
            dummy_tree_wrap_tree2.css( "overflowX", "" );
        }
        
        //高さは中身の高さと 240px のうち、小さいほう
        var real_height = document.getElementById( this.elm_id + "-dummy_root").scrollHeight;
        var new_height = (real_height <= 0) ? max_height : Math.min( real_height, max_height );
        div1.css( "height", new_height + "px" );
        dummy_tree_wrap_tree2.css( "height", new_height + "px" );
        
        // reduce the border width
        div2.css( "height", new_height - 22 + "px" );

        if( real_height > new_height )
        {
            //add a scroll bar
            div2.css( "overflowY", "scroll" );
        }
        else
        {
            div2.css( "overflowY", "" );
        }

        // update the size of iframe
        jQuery( "#" + this.elm_id + "-if" ).css( {height: new_height + 2 + "px",
                                        width : new_width + 2 + "px" } );

        if( before_visible == 0 )
        {
            this.hide();
        }
        father_elm.css( "visibility", "" );
    },

    initialize : function( treeName, pageName, asyncURL,  callback, selectedOID, csrf_ticket, title_width, facilitygroup_params ){
        this.groups = facilitygroup_params;
        this.draw();
        this.fag_tree = new YAHOO.grn.fagTree( this.elm_id + "-div-tree",
                                               pageName,
                                               asyncURL,
                                               callback,
                                               selectedOID,
                                               csrf_ticket,
                                               this
                                             );
        this.title_width = title_width;
        this.fag_tree.init( facilitygroup_params );
        this.setSize();
    },
    
    insertNode : function( node_info ) {
        this.fag_tree.insertSpecialNode( node_info );
        this.setSize();
    },

    removeNode : function( node_info ) {
        this.fag_tree.removeSpecialNode( node_info );
        this.setSize();
    },

    getItem: function (id) {
        var result_group = null;
        this.groups.forEach(function (group) {
            if (group.oid === id.toString()) {
                result_group = group;
                return;
            }
        });

        return result_group;
    },

    highlightGroup: function (id) {
        var tree = this.fag_tree.getTree();
        var node = tree.getNodeByProperty("oid", id);

        if (!node) {
            return;
        }

        var highlightedNode = tree.getHighlightedNode();

        if (highlightedNode) {
            highlightedNode.unhighlight(true);
        }

        node.highlight(true);
    },

    unhighlightGroup: function () {
        var tree = this.fag_tree.getTree();

        var highlightedNode = tree.getHighlightedNode();

        if (highlightedNode) {
            highlightedNode.unhighlight(true);
        }
    }
};
