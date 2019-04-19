/**
 * Folder Tree Library
 * Author: Huy Nguyen @ 2009/12
 */
 
YAHOO.namespace("grn");
YAHOO.grn.orgTree = function(treeName, asyncURL, pageName, linkURL, selectedOID, treeParams) {
    this._treeName = treeName;
    this._asyncURL = asyncURL;
    this._pageName = pageName;
    this._linkURL = linkURL;
    this._selectedOID = selectedOID;
    this._nodes = [];
    this._treeParams = (treeParams === undefined) ? '' : treeParams;
};

YAHOO.grn.orgTree.prototype = {
    _tree: null,
    
    _treeName: null,
    _asyncURL: '',
    _pageName: '',
    _linkURL: '',
    _selectedOID: null,
    _oidKey: 'oid',
    _iconPath: null,
    _hideChildrenNum: false,
    _onSelect: '',
    _selectedNode: null,
    _reflectionInfo: {'source_key': '', 'source_oid': '', 'caption': ''},
    _checkInfo: {'id_prefix': '', 'name': '', 'on_click': ''},
    _subscribeTitle: null,
    _loadTreeData: function(tmp) {
        var obj = this;

        tmp.setDynamicLoad(
            function (node, onCompleteCallback){
                node.sendExpanded = false;

                var useDataType = "json";
                if( /(report).*(category_json)/.test(node.url) )
                {
                    useDataType = "";
                }

                var ajaxDynamicRequest = new grn.component.ajax.request(
                {
                    url: node.url,
                    method: node.method,
                    data: node.postData + "&action=getchild",
                    dataType: useDataType,
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
            var checkbox = data[i]['checkbox'];
            var deleted = data[i]['deleted'];

            var node_info = data[i];
            node_info.parent = node;
            node_info.selected = (oid == this._selectedOID);
            node_info.is_source = (oid == this._reflectionInfo['source_oid']);
            
            var tmpNode = this.createNode(node_info);
            
            tmpNode.sendExpanded = (expanded != 1);
            tmpNode.method='POST';
            tmpNode.url=this._asyncURL;
            tmpNode.postData='csrf_ticket='+YAHOO.grn.orgTree.csrf_ticket+'&page=' + this._pageName + '&oid=' + oid + this._treeParams;
            
            tmpNode.oid = oid;
            tmpNode.selected = (oid == this._selectedOID);
            tmpNode.is_source = (oid == this._reflectionInfo['source_oid']);
            tmpNode.checkbox = checkbox;
            tmpNode.deleted = deleted;
            
            // store node
            if( !this._checkExistNode(oid) )
            {
                this._nodes[oid] = tmpNode;
            }
            
            if ( count > 0 ) {
                var children = data[i]['children'];
                if (children.length > 0) {
                    this._buildTree(children,tmpNode,false);
                    
                    if (expanded == 1) {
                        tmpNode.expand();
                    }
                }else {
                    this._loadTreeData(tmpNode);
                }
                
            }
        }

        if (refreshCount) {
            this._refreshCount(node, dataCount);
        }
        
        if(this._checkInfo['name'])
        {
            checkList = this.getCheckList();
        }
        
        this._tree.draw();

        if(this._checkInfo['name'])
        {
            this.setCheckList(checkList);
        }
    },

    _refreshCount: function(node, count) {
        if (count > 0) {
            node.html = node.html.replace( /&nbsp;\(\d+\)<\/a>/, '&nbsp;(' + count + ')</a>' );
        } else {
            node.html = node.html.replace( /&nbsp;\(\d+\)<\/a>/, '&nbsp;</a>' );
            node.setDynamicLoad(null);
        }
    },
    _checkExistNode: function(oid){
        var ret = false;
        if( this._nodes.length == 0 ){
            return ret;
        }
        /*jshint -W088 */ /* Creating global 'for' variable. Should be '{a}' */
        for( folder_id in this._nodes ){
            if(folder_id == oid){
                ret = true;
            }
        }
        /*jshint +W088 */
        return ret;
    },
    _buildTreeWithNumber: function(data,node) {
        var tmpNode;
        
        if (node.children.length > 0) return;

        var dataCount = 0;
        for (var i = 0; i < data.length; i++) {
            if ( data[i] == null ) continue;
            dataCount++;
            
            var oid = data[i]['oid'];
            if (data[i]['unread']){
                //data[i]['name'] += '<span class="tree-unread-num">' + data[i]['unread'] + '</span>';
            }
            var name = data[i]['name'];
            var count = data[i]['count'];
            var expanded = data[i]['expanded'];
            var checkbox = data[i]['checkbox'];
            var deleted = data[i]['deleted'];

            var node_info = data[i];
            node_info.parent = node;
            node_info.selected = (oid == this._selectedOID);
            node_info.is_source = (oid == this._reflectionInfo['source_oid']);

            var temp_url =  this._linkURL.split("/");
            for(var j = 0 ; j < temp_url.length; j++)
            {
                if(temp_url[j] == "mail")
                {
                    node_info.flag_mail = 1;
                }
            }
            var tmpNode = this.createNode(node_info);
            
            tmpNode.sendExpanded = (expanded != 1);
            tmpNode.method='POST';
            tmpNode.url=this._asyncURL;
            tmpNode.postData='csrf_ticket='+YAHOO.grn.orgTree.csrf_ticket+'&page=' + this._pageName + '&oid=' + oid + this._treeParams;
            
            tmpNode.oid = oid;
            tmpNode.selected = (oid == this._selectedOID);
            tmpNode.is_source = (oid == this._reflectionInfo['source_oid']);
            tmpNode.checkbox = checkbox;
            tmpNode.deleted = deleted;
            
            // store node
            if( !this._checkExistNode(oid) )
            {
                this._nodes[oid] = tmpNode;
            }
            
            if ( count > 0 ) {
                var children = data[i]['children'];
                if (children.length > 0) {
                    //this._buildTree(children,tmpNode,false);
                    this._buildTreeWithNumber(children,tmpNode);
                    
                    if (expanded == 1) {
                        tmpNode.expand();
                    }
                }else {
                    this._loadTreeData(tmpNode);
                }
                
            }
        }
        
        this._tree.draw();
    },
        
    _getResponse: function(data, jqXHR) {

        if ( typeof jqXHR !== "undefined" && (jqXHR.getResponseHeader('X-Cybozu-Json') != null || jqXHR.getResponseHeader('x-cybozu-json') != null )) {
            data = eval(jqXHR.responseText);
        }
        if ( ! data || typeof jqXHR === "undefined" ) return;

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
        this._iconPath = YAHOO.grn.orgTree.app_path + '/grn/image/cybozu/';
        this.buildTree(data,null);
        
        var obj = this;

        this._tree.subscribe( 'expand', function(node) {
            if (YAHOO.grn.orgTree.useIncrementalSearch) {
                return;
            }

            if (node.children.length > 0 && node['sendExpanded']) {

                var useDataType = "json";
                if( /(report).*(category_json)/.test(node.url) )
                {
                    useDataType = "";
                }

                var ajaxSubExpandRequest = new grn.component.ajax.request(
                {
                    url: node.url,
                    method: node.method,
                    data: node.postData + "&action=expand",
                    dataType: useDataType,
                    grnRedirectOnLoginError: true
                });

                ajaxSubExpandRequest.send().done(function (data, textStauts, jqXHR) {
                    jqXHR.argument = {
                        'node': node,
                        'object': obj,
                        'action': 'expand'
                    };
                    obj._getResponse(data, jqXHR);
                });
            }
        });
        
        this._tree.subscribe( 'collapse', function(node) {
            if (YAHOO.grn.orgTree.useIncrementalSearch) {
                return;
            }

            if (node.children.length > 0) {
                obj._loadTreeData(node);
                node.sendExpanded = true;

                var useDataType = "json";

                if( /(report).*(category_json)/.test(node.url) )
                {
                    useDataType = "";
                }

                var ajaxSubCollapseRequest = new grn.component.ajax.request(
                {
                    url: node.url,
                    method: node.method,
                    data: node.postData + "&action=collapse",
                    dataType: useDataType,
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
    },
    
    initWithNumber: function(data) {
        this._iconPath = YAHOO.grn.orgTree.app_path + '/grn/image/cybozu/';
        this.buildTreeWithNumber(data,null);
        
        var obj = this;

        this._tree.subscribe( 'expand', function(node) {
            if (YAHOO.grn.orgTree.useIncrementalSearch) {
                return;
            }

            if (node.children.length > 0 && node['sendExpanded']) {

                var useDataType = "json";
                if( /(report).*(category_json)/.test(node.url) )
                {
                    useDataType = "";
                }

                var ajaxNumExpandRequest = new grn.component.ajax.request(
                {
                    url: node.url,
                    method: node.method,
                    data: node.postData + "&action=expand",
                    dataType: useDataType,
                    grnRedirectOnLoginError: true
                });

                ajaxNumExpandRequest.send().done(function (data, textStatus, jqXHR) {
                    jqXHR.argument = {
                        'node': node,
                        'object': obj,
                        'action': 'expand'
                    };
                    obj._getResponse(data, jqXHR);
                });
            }
        });
        
        this._tree.subscribe( 'collapse', function(node) {
            if (YAHOO.grn.orgTree.useIncrementalSearch) {
                return;
            }

            if (node.children.length > 0) {
                obj._loadTreeData(node);
                node.sendExpanded = true;

                var useDataType = "json";
                if( /(report).*(category_json)/.test(node.url) )
                {
                    useDataType = "";
                }

                var ajaxNumCollapseRequest = new grn.component.ajax.request(
                {
                    url: node.url,
                    method: node.method,
                    data: node.postData + "&action=collapse",
                    dataType: useDataType,
                    grnRedirectOnLoginError: true
                });

                ajaxNumCollapseRequest.send().done(function (data, textStatus, jqXHR) {
                    jqXHR.argument = {
                        'node': node,
                        'object': obj,
                        'action': 'collapse'
                    };
                    obj._getResponse(data, jqXHR);
                });
            }
        } );

        var tree_name = "#"+ this._treeName;
        this._tree.subscribe( 'expandComplete', function(node) {
            jQuery(tree_name + " div.tree-node").each(function(index,node){
                try{
                    new YAHOO.util.DDTarget(node);
                }
                catch(e)
                {}
            });
        });
    },
        
    createNode: function(node_info) {
        var html = '';
        var url = node_info.link_url || this._linkURL;
        if ( !url.match( /.+\?$/ ) ) url += '&';
        
        var a_node_id = 'id='+this._treeName+'-node-'+node_info.oid;
        var reflectParam = '';
        if(this._reflectionInfo['source_key'] && this._reflectionInfo['source_oid'])
        {
            reflectParam = '&' + this._reflectionInfo['source_key'] + '=' + this._reflectionInfo['source_oid'];
        }

        if( node_info.checkbox && this._checkInfo['name'] && ! node_info.is_source )
        {
            if (YAHOO.grn.orgTree.useIncrementalSearch) {
                html += '<input type="checkbox" id="' + this._checkInfo['id_prefix'] + node_info.oid + '" name="' + this._checkInfo['name'] + '" value="' + node_info.oid + '" class="tree_checkbox_grn" onClick="' + this._checkInfo['on_click'] + '(' + node_info.oid + ',this)">';
            }
            else {
                html += '<input type="checkbox" id="' + this._checkInfo['id_prefix'] + node_info.oid + '" name="' + this._checkInfo['name'] + '" value="' + node_info.oid + '" class="tree_checkbox_grn" onClick="' + this._checkInfo['on_click'] + '()">';
            }
        }

        if (this._onSelect){
            if (YAHOO.grn.orgTree.useIncrementalSearch) {
                html += '<a ' + a_node_id + ' href="javascript:void(0);" onclick="' + this._onSelect + '(' + node_info.oid + ');return false;">' + node_info.name;
            }
            else {
                html += '<a ' + a_node_id + ' href="javascript:' + this._onSelect + '(' + node_info.oid + ')">' + node_info.name;
            }
        }
        else{
            if (node_info.deleted)
            {
                html += '<a ' + a_node_id + ' href="' + url + this._oidKey + '=' + node_info.oid + reflectParam + '"' + ' class="deleled_folder" ' + '>' + node_info.name;
            }
            else
            {
                html += '<a ' + a_node_id + ' href="' + url + this._oidKey + '=' + node_info.oid + reflectParam + '">' + node_info.name;
            }
        }
        
        html += '</a>';
        
        if(this._reflectionInfo['caption'] && node_info.is_source)
        {
            html += '<span class="category_important_grn">' + this._reflectionInfo['caption'] + '</span>';
        }

        var span_unread_id = 'id="tree-unread-num-' + node_info.oid + '"';
        if (node_info.unread){
            html += '&nbsp;<span class="tree-unread-num" ' + span_unread_id + '>' + node_info.unread + '</span>';
        }
        else{
            html += ' <span class="tree-unread-num" style="display:none;" ' + span_unread_id + '>0</span>';
        }
        if (node_info.subscribed && node_info.flag_mail == null)
        {
            html += '&nbsp;<span class="icon_mark_subscribe_grn" title="' + this._subscribeTitle + '"></span>';
        }
        if (node_info.deleted && node_info.flag_mail == null)
        {
            html += '<span class="tree_label01_grn">' + deleted_folder_caption + '</span>';
        }
        if(node_info.new_group )
        {
            html += '<span class="sandbox_label_new_grn">' + new_group_caption + '</span>';
        }
        else if(node_info.update_group )
        {
            html += '<span class="sandbox_label_update_grn">' + update_group_caption + '</span>';
        }

        html = this.setNodeStyle(node_info, html);
        
        var node = new YAHOO.widget.HTMLNode(html, node_info.parent, false, true);
        node.href = url + this._oidKey + '=' + node_info.oid;
        return node;
    },
    
    setNodeStyle: function(node_info, html) {
        var selected = ('selected' in node_info) ? node_info.selected : false;

        if (selected) {
            html = '<div id="'+this._treeName+'-selected_node" class="tree-select-current">' + html + '</div>';
        } else {
            html = '<div class="tree-node">' + html + '</div>';
        }
        if (node_info.subscribed && node_info.flag_mail != null)
        {
            html += '&nbsp;<span class="icon_mark_subscribe_grn" title="' + this._subscribeTitle + '"></span>';
        }
        return html;
    },
    
    buildTree: function(data,node) {
        this._tree = new YAHOO.widget.TreeView(this._treeName);
        
        var root = node;
        if (root == null) root = this._tree.getRoot();
        
        this._buildTree(data,root,false);
        
    },
        
    buildTreeWithNumber: function(data,node) {
        this._tree = new YAHOO.widget.TreeView(this._treeName);
        
        var root = node;
        if (root == null) root = this._tree.getRoot();
        
        this._buildTreeWithNumber(data,root);
        
        this.initDrapDropTarget();
    },
    initDrapDropTarget: function(){
        // init drop target
        var tree_name = "#"+ this._treeName;
        jQuery(tree_name + " div.tree-node").each(function(index, node){
            try{
                new YAHOO.util.DDTarget(node);
            }
            catch(e)
            {}
        });
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
    },
    
    setHideChildrenNum: function( value ) {
        this._hideChildrenNum = value;
    },
    
    setOnSelect: function( value ){
        this._onSelect = value;
    },
    
    setReflectionInfo: function( sourceKey, sourceOID, caption ){
        this._reflectionInfo['source_key'] = sourceKey;
        this._reflectionInfo['source_oid'] = sourceOID;
        this._reflectionInfo['caption'] = caption;
    },
    
    setCheckInfo: function( idPrefix, name, onClick ){
        this._checkInfo['id_prefix'] = idPrefix;
        this._checkInfo['name'] = name;
        this._checkInfo['on_click'] = onClick;
    },
    setUnreadNumForFolder: function(folder_id,unread ){
        node = this._nodes[folder_id];
        if (node) {
            var tmp_ele = jQuery("<div></div>");
            tmp_ele.html(node.html);
            var obj_unread = tmp_ele.find("span:first");
            obj_unread.html(unread);
            unread == 0 ? obj_unread.hide() : obj_unread.show();
            node.initContent(tmp_ele.html());
        }
    },
    setSubscribeTitle: function( title ){
        this._subscribeTitle = title;
    },
    draw: function(){
        if( this._tree)
            this._tree.draw();
    },
    selectNode: function( oid ){
        var root = this._tree.getRoot();
        var dom = YAHOO.util.Dom;
        var selector = YAHOO.util.Selector;
        
        var top = selector.query('#'+this._treeName+'_top a')[0];
        if( oid == 'top' ){
            dom.addClass(top, 'tree-select-current');
        }else{
            dom.removeClass(top, 'tree-select-current');
        }
        
        _selectNode(root, oid);
        
        function _selectNode(node, oid){
            for (var i = 0; i < node.children.length; i++ ) {
                var child = node.children[i];
                var cnt = child.getContentEl();
                var ele = null;
                if( cnt )
                {
                    var ele = selector.query('.tree-node, .tree-select-current', cnt)[0];
                }
                if(ele){
                    if(child.oid == oid){
                        dom.removeClass(ele, 'tree-node');
                        dom.addClass(ele, 'tree-select-current');
                        child.selected = true;
                    }
                    else if(ele){
                        dom.addClass(ele, 'tree-node');
                        dom.removeClass(ele, 'tree-select-current');
                        child.selected = null;
                    }
                }
                _selectNode(child, oid);
            }
        }
    },

    getSelecteOID:function(){
        return this._selectedOID;
    },

    getCheckList: function(){
        /*jshint -W058 */ /* Missing '()' invoking a constructor. */
        var array = new Array;
        /*jshint +W058 */
        var obj = document.getElementsByName(this._checkInfo['name']);
        for(var i = 0; i < obj.length; i++)
        {
            if(obj[i].checked)
            {
                array.push(obj[i].value);
            }
        }
        return array;
    },
    
    setCheckList: function(list){
        var check_exist = false;
        for(var i = 0; i < list.length; i++)
        {
            var el = document.getElementById(this._checkInfo['id_prefix'] + list[i]);
            if(el)
            {
                el.checked = true;
                check_exist = true;
            }
        }
        return check_exist;
    },

    /**
     *
     * @param {String} selected_oid
     */
    buildTreeCollapseAndExpand: function (selected_oid) {
        if (this._nodes.length === 0) {
            return;
        }

        var _tmpNode;
        var _eachNode;
        for (_eachNode in this._nodes) {
            _tmpNode = this._nodes[_eachNode];
            if (_tmpNode) {
                if (!_eachNode.match(/[^0-9]+/)) {
                    _tmpNode.collapse()
                }
            }
        }
        this.buildTreeExpand(selected_oid);
    },

    /**
     *
     * @param {String} node_id
     */
    buildTreeExpand: function (node_id) {
        var _node = this._nodes[node_id];
        if (_node) {
            _node.expand();
            if (_node.parent) {
                this.buildTreeExpand(_node.parent.oid);
            }
        }
    },

    /**
     *
     * @param {String} node_id
     */
    highlightNode: function (node_id) {
        var treeName = "#" + this._treeName;
        jQuery(treeName + " div.tree-select-current").each(function (i,e) {
            e.className = "tree-node";
        });
        var root_element = document.getElementById(this._treeName + "_top");
        root_element.className = "tree-node";

        if (node_id == 1) {
            root_element.className = "tree-select-current";
        }
        else {
            document.getElementById(this._treeName + '-node-' + node_id).parentNode.className = "tree-select-current";
            this.buildTreeExpand(node_id);
        }
    },

    /**
     *
     * @param {Array} list
     */
    setForceNotifyList: function (list) {
        for (var i = 0; i < list.length; i++) {
            var el = document.getElementById(this._checkInfo['id_prefix'] + list[i]);
            if (el) {
                el.disabled = true;
            }
        }
    }

};

