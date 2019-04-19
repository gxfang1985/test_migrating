YAHOO.namespace("grn");

YAHOO.grn.fgNode = function(oData, oParent, expanded) {

    if (oData) {
        this.init(oData, oParent, expanded);
        this.setUpLabel(oData);
    }
};

YAHOO.extend(YAHOO.grn.fgNode, YAHOO.widget.TextNode, {
    getContentHtml: function() {
        var sb = [];
        sb[sb.length] = this.href?'<a':'<span';
        sb[sb.length] = ' id="' + this.labelElId + '"';
        sb[sb.length] = ' class="' + this.labelStyle ;

        if (this.enableHighlight) {
            sb[sb.length] = ' ygtv-highlight' + this.highlightState;
        }

        sb[sb.length] = '"';

        if (this.href) {
            sb[sb.length] = ' href="' + this.href + '"';
            sb[sb.length] = ' target="' + this.target + '"';
        }
        if (this.title) {
            sb[sb.length] = ' title="' + this.title + '"';
        }
        sb[sb.length] = ' >';
        sb[sb.length] = this.label;
        sb[sb.length] = this.href?'</a>':'</span>';
        return sb.join("");
    },

    getNodeHtml: function() {
        var sb = [];

        sb[sb.length] = '<table id="ygtvtableel' + this.index + '"border="0" cellpadding="0" cellspacing="0" class="ygtvtable ygtvdepth' + this.depth;
        if (this.className) {
            sb[sb.length] = ' ' + this.className;
        }
        sb[sb.length] = '"><tr class="ygtvrow">';

        for (var i=0;i<this.depth;++i) {
            sb[sb.length] = '<td class="ygtvcell ' + this.getDepthStyle(i) + '"><div class="ygtvspacer"></div></td>';
        }

        if (this.hasIcon) {
            sb[sb.length] = '<td id="' + this.getToggleElId();
            sb[sb.length] = '" class="ygtvcell ';
            sb[sb.length] = this.getStyle() ;
            sb[sb.length] = '"><a href="#" class="ygtvspacer">&nbsp;&nbsp;&nbsp;&nbsp;</a></td>';
        }

        sb[sb.length] = '<td id="' + this.contentElId;
        sb[sb.length] = '" class="ygtvcell ';
        sb[sb.length] = this.contentStyle  + ' ygtvcontent" ';
        sb[sb.length] = (this.nowrap) ? ' nowrap="nowrap" ' : '';
        sb[sb.length] = ' >';
        sb[sb.length] = this.getContentHtml();
        sb[sb.length] = '</td></tr></table>';

        return sb.join("");

    }
} );

YAHOO.grn.fagTree = function( treeName, pageName, asyncURL, callback, selectedOID, csrf_ticket, manager ) {
    this._treeName = treeName;
    this._pageName = pageName;
    this._asyncURL = asyncURL;
    this._callback = callback;
    this._selectedOID = selectedOID;
    this._csrf_ticket = csrf_ticket;
    this._manager = manager;
};

YAHOO.grn.fagTree.prototype = {
    _tree: null,

    _treeName: null,
    _asyncURL: '',
    _pageName: '',
    _callback: '',
    _selectedOID: null,
    _manager: null,
    _oidKey: 'oid',

    _loadTreeData: function(tmp) {
        var obj = this;

        tmp.setDynamicLoad(
            function (node, onCompleteCallback){
                node.sendExpanded = false;

                var ajaxDynamicRequest = new grn.component.ajax.request(
                {
                    url: node.url,
                    method: node.method,
                    data: node.postData + "&action=getchild",
                    dataType: "json",
                    grnRedirectOnLoginError: true
                });

                ajaxDynamicRequest.send().done(function (data, textStatus, jqXHR) {
                    jqXHR.argument = {
                        'node': node,
                        'object': obj,
                        'action': 'getchild',
                        'complete': onCompleteCallback
                    };
                    obj._getResponse(data, jqXHR);
                });
            }
        );
    },

    _buildTree: function(data,node) {
        var tmpNode;

        if (node.children.length > 0) return;

        var dataCount = 0;
        for (var i = 0; i < data.length; i++) {
            if ( data[i] == null ) continue;
            dataCount++;

            if( data[i]['expanded'] == "0" ) data[i]['expanded'] = false;
            if( data[i]['expanded'] == "1" ) data[i]['expanded'] = true;

            var oid = data[i]['oid'];
            var name = data[i]['name'];
            var count = data[i]['count'];
            var expanded = data[i]['expanded'];
            var extra_param = data[i]['extra_param'];

            var node_info = data[i];
            node_info.parent = node;

            node_info.selected = oid == this._selectedOID;

            var tmpNode = this.createNode(node_info);

            tmpNode.sendExpanded = (expanded != 1);
            tmpNode.method='POST';
            tmpNode.url=this._asyncURL;
            tmpNode.postData='csrf_ticket='+this._csrf_ticket+'&page=' + this._pageName + '&oid=' + oid;

            tmpNode.oid = oid;
            tmpNode.extra_param = extra_param;
            tmpNode.selected = (oid == this._selectedOID);
            if( tmpNode.selected ) {
                tmpNode.highlight();
            }

            if ( count > 0 ) {
                var children = data[i]['children'];
                if (children.length > 0) {
                    this._buildTree(children,tmpNode,false);

//                    if (expanded == 1) {
//                        tmpNode.expand();
//                    }
                }else {
                    this._loadTreeData(tmpNode);
                }
            }
        }

        this._tree.render();
    },

    _getResponse: function(data, jqXHR) {
        jqXHR.argument.object._buildTree(data,jqXHR.argument.node);

        if (jqXHR.argument['complete'] != null) {
            jqXHR.argument.complete();
        }
//      if( ua.indexOf("MSIE") > 0 )
//        {
//            oj.argument.object._manager.setSize();
//        }

        if (typeof jqXHR.argument.node !== "undefined") {
            jqXHR.argument.node.focus();
        }
    },

    init: function(data) {
        //this._iconPath = YAHOO.grn.fagTree.app_path + '/grn/image/cybozu/';
        this.buildTree(data,null);

        var obj = this;

        this._tree.subscribe( 'expandComplete', function(node) {
            obj._manager.setSize();
            if (node.children.length > 0 && node['sendExpanded']) {
                var ajaxSubExpandRequest = new grn.component.ajax.request(
                {
                    url: node.url,
                    method: node.method,
                    data: node.postData + "&action=expand",
                    dataType: "json",
                    grnRedirectOnLoginError: true
                });

                ajaxSubExpandRequest.send().done(function (data, textStatus, jqXHR) {
                    jqXHR.argument = {
                        'node': node,
                        'object': obj,
                        'action': 'expand'
                    };
                    obj._getResponse(data, jqXHR);
                });
            }
        });

        this._tree.subscribe( 'collapseComplete', function(node) {
            obj._manager.setSize();
            if (node.children.length > 0) {
                obj._loadTreeData(node);
                node.sendExpanded = true;

                var ajaxSubCollapseRequest = new grn.component.ajax.request(
                {
                    url: node.url,
                    method: node.method,
                    data: node.postData + "&action=collapse",
                    dataType: "json",
                    grnRedirectOnLoginError: true
                });

                ajaxSubCollapseRequest.send().done(function (data, textStatus, jqXHR) {
                    jqXHR.argument = {
                        'node': node,
                        'object': obj,
                        'action': 'collapse'
                    };
                    obj._getResponse(data, jqXHR);
                });
            }
        } );

        this._tree.onEventHighlight = function (oArgs) {
            var node;
            if ('node' in oArgs && oArgs.node instanceof YAHOO.widget.Node) {
                node = oArgs.node;
            } else if (oArgs instanceof YAHOO.widget.Node) {
                node = oArgs;
            } else {
                return false;
            }
            node.highlight();
        };

        this._tree.subscribe('labelClick',this._tree.onEventHighlight );

        if( this._callback )
        {
            this._tree.subscribe( 'labelClick', this._callback );
        }
    },

    createNode: function( node_info ) {
        var hasIcon = node_info.extra_param ? false : true;
        var expanded = node_info['expanded'];
        var tmp= new YAHOO.grn.fgNode(
            {
                'id' : node_info['oid'],
                'label' : node_info['name'],
                'oid' : node_info['oid']
            },
            node_info.parent, node_info['expanded'] );

        tmp.hasIcon = hasIcon;
        tmp.nowrap = true;

        tmp._setHighlightClassName = function() {
            var el = YAHOO.util.Dom.get('ygtvlabelel' + this.index);
            if (el) {
                el.className = el.className.replace(/\bygtv-highlight\d\b/gi,'ygtv-highlight' + this.highlightState);
            }
        };
        return tmp;
    },

    buildTree: function(data,node) {
        this._tree = new YAHOO.widget.TreeView(this._treeName);

        this._tree.fagTree = this;

        this._tree.singleNodeHighlight = true;
        var root = node;
        if (root == null) root = this._tree.getRoot();

        this._buildTree(data,root,false);

    },

    getTree: function() {
        return this._tree;
    },

    insertSpecialNode: function( node_info ){
        if( this._tree.getNodesByProperty( 'oid', node_info['oid'] ) )
            return;
        var tmp = node_info;
        tmp['parent'] = this._tree.getRoot();
        var new_node = this.createNode( tmp );
        if( this._tree.getRoot().hasChildren() ) {
            new_node.insertBefore( this._tree.getRoot().children[0] );
        }
        new_node.highlight();
        this._tree.render();
    },

    removeSpecialNode: function( node_oid ){
        var nodes = this._tree.getNodesByProperty( 'oid', node_oid );
        var tree = this._tree;
        if( nodes ){
            jQuery.each( nodes, function(index, node){ tree.removeNode( node ); } );
        }
        this._tree.render();
    }
};
