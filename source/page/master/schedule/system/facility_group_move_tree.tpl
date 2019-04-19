<script type="text/javascript" src="{$app_path}/fw/yui/build/yahoo/yahoo-min.js?{$build_date}" ></script>
<script type="text/javascript" src="{$app_path}/fw/yui/build/event/event-min.js?{$build_date}" ></script>
<script type="text/javascript" src="{$app_path}/fw/yui/build/dom/dom-min.js?{$build_date}" ></script>
<script type="text/javascript" src="{$app_path}/fw/yui/build/treeview/treeview-min.js?{$build_date}" ></script>
<script type="text/javascript" src="{$app_path}/fw/yui/build/connection/connection-min.js?{$build_date}" ></script>

<script language="JavaScript">
<!--
{literal}
YAHOO.namespace("grn");
YAHOO.grn.orgTree = function(treeName, asyncURL, pageName, linkURL, selectedOID) {
    this._treeName = treeName;
    this._asyncURL = asyncURL;
    this._pageName = pageName;
    this._linkURL = linkURL;
    this._selectedOID = selectedOID;
}

YAHOO.grn.orgTree.prototype = {
    _tree: null, 
    
    _treeName: null,
    _asyncURL: '',
    _pageName: '',
    _linkURL: '',
    _selectedOID: null,
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
    
    _buildTree: function(data,node,refreshCount) {

        var tmpNode;
        
        if (node.children.length > 0) return;

        var dataCount = 0;
        for (var i = 0; i < data.length; i++) {
            if ( data[i] == null ) continue;
            dataCount++;
            
            var oid = data[i]['oid'];
            var name = data[i]['name'];
            var count = data[i]['count'];
            var expanded = data[i]['expanded'];
            var status = data[i]['status'];

            var tmpNode = this.createNode(node, oid, name, count, status);
            
            tmpNode.sendExpanded = (expanded != 1);
            tmpNode.method="POST";
            tmpNode.url=this._asyncURL;
            tmpNode.postData="csrf_ticket={/literal}{$csrf_ticket}{literal}&page=" + this._pageName + "&oid=" + oid;
            
            tmpNode.selected = (oid == this._selectedOID);
            
            if ( count > 0 ) {
                var children = data[i]['children'];
                if (children.length > 0) {
                    this._buildTree(children,tmpNode,false);
                    
                    if (expanded == 1) {
                        tmpNode.expand();
                    }
                } else {
                    this._loadTreeData(tmpNode);
                }
                
            }
        }

        if (refreshCount) {
            this._refreshCount(node, dataCount);
        }
        
        this._tree.draw();
    },

    _refreshCount: function(node, count) {
        if (count > 0) {
            node.html = node.html.replace( /&nbsp;\(\d+\)<\/a>/, "&nbsp;(" + count + ")</a>" );
        } else {
            node.html = node.html.replace( /&nbsp;\(\d+\)<\/a>/, "&nbsp;</a>" );
            node.setDynamicLoad(null);
        }
    },
    
    _getResponse: function(data, jqXHR) {

        refresh_count = (jqXHR.argument['action'] == 'getchild');
        jqXHR.argument.object._buildTree(data,jqXHR.argument.node,refresh_count);
        
        if (jqXHR.argument['complete'] != null) {
            jqXHR.argument.complete();
        }

        if (typeof jqXHR.argument.node !== "undefined") {
            jqXHR.argument.node.focus();
        }
    },
    
    init: function(data) {

        this.buildTree(data,null);
        
        var obj = this;

        this._tree.subscribe( 'expand', function(node) {
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
        } );
        
    this._tree.subscribe( 'collapse', function(node) {
            if (node.children.length > 0) {
                obj._loadTreeData(node);
                node.sendExpanded = true;

                var ajaxSubCollapseRequest= new grn.component.ajax.request(
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
        });
    },
    
    createNode: function(parent, oid, name, count, status) {
        var html = '';
        var url = this._linkURL;

    if ( status === "normal" || status == ""){
         html += name;
             if ( !url.match( /.+\?$/ ) ) url += '&';
         if ( oid == this._selectedOID ) {
                  html = "<div id='selected_node' class='tree-select-current'>" + html + "</div>";
             } else {
                  html = "<div style='white-space: nowrap;'>"
                       + "<a href='" + url + this._oidKey + "=" + oid + "'>" + html
                       + "</a></div>";
             }
        }else if ( status === "gray" ){
             html += "<div class='grayout'>" + name + "</div>";
        }
        
        var node = new YAHOO.widget.HTMLNode(html, parent, false, true);
        node.href = url + this._oidKey + "=" + oid;
        return node;
    },
    
    setNodeStyle: function(oid, html) {
        if (oid == this._selectedOID) {
            html = "<div id='selected_node' class='tree-select-current'>" + html + "</div>";
        } else {
            html = "<div style='white-space: nowrap;'>" + html + "</div>";
        }
        return html;
    },
    
    buildTree: function(data,node) { 

        this._tree = new YAHOO.widget.TreeView(this._treeName);

        var root = node;
        if (root == null) root = this._tree.getRoot(); 
        
        this._buildTree(data,root,false);
        
    },
    
    getTree: function() {
        return this._tree;
    },
    
    getSelectionTop: function() {
    
        var root = this._tree.getRoot();
        
        var count = 0;
        var break_flag = false;
        return getCount(root,count);
        
        function getCount(node, cnt) {
            for (var i = 0; i < node.children.length; i++ ) {
                var child = node.children[i];
                if (child.selected) {
                    break_flag = true;
                    break;
                }
                cnt++;
                if (child.expanded) {
                    cnt = getCount(child, cnt);
                    if (break_flag) break;
                }
            }
            
            return cnt;
        }
    },

    setOidKey: function( value ) {
        this._oidKey = value;
    }
    
};
{/literal}

//-->
</script>

