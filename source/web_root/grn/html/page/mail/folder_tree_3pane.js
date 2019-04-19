/**
 * Copy from grn/html/org_tree_26.js
 */
 
YAHOO.namespace("grn.mail");
YAHOO.grn.mail.folderTree = function(treeName, asyncURL, pageName, linkURL, selectedOID, treeParams) {
    this._treeName = treeName;
    this._asyncURL = asyncURL;
    this._pageName = pageName;
    this._linkURL = linkURL;
    this._selectedOID = selectedOID;
    this._nodes = [];
    this._treeParams = (treeParams === undefined) ? '' : treeParams;
};

YAHOO.grn.mail.folderTree.prototype = {
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
    _trash_id: '',
    _afterExpandCompleteFunction: '',

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

                ajaxDynamicRequest.send().done(function (data, textStauts, jqXHR) {
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

            var node_info = data[i];
            node_info.parent = node;
            node_info.selected = (oid == this._selectedOID);
            node_info.is_source = (oid == this._reflectionInfo['source_oid']);

            var tmpNode = this.createNode(node_info);

            tmpNode.sendExpanded = (expanded != 1);
            tmpNode.method='POST';
            tmpNode.url=this._asyncURL;
            tmpNode.postData='csrf_ticket='+YAHOO.grn.mail.folderTree.csrf_ticket+'&page=' + this._pageName + '&oid=' + oid + this._treeParams;

            tmpNode.oid = oid;
            tmpNode.selected = (oid == this._selectedOID);
            tmpNode.is_source = (oid == this._reflectionInfo['source_oid']);
            tmpNode.checkbox = checkbox;

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
            tmpNode.postData='csrf_ticket='+YAHOO.grn.mail.folderTree.csrf_ticket+'&page=' + this._pageName + '&oid=' + oid + this._treeParams;

            tmpNode.oid = oid;
            tmpNode.selected = (oid == this._selectedOID);
            tmpNode.is_source = (oid == this._reflectionInfo['source_oid']);
            tmpNode.checkbox = checkbox;

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
        if ( ! data || typeof jqXHR === "undefined") return;

        refresh_count = (jqXHR.argument['action'] == 'getchild');
        jqXHR.argument.object._buildTree(data, jqXHR.argument.node, refresh_count);

        if (jqXHR.argument['complete'] != null) {
            jqXHR.argument.complete();
        }

        if (typeof jqXHR.argument.node !== "undefined") {
            jqXHR.argument.node.focus();
        }
    },

    init: function(data) {
        this._iconPath = YAHOO.grn.mail.folderTree.app_path + '/grn/image/cybozu/';
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
        });

        this._tree.subscribe( 'collapse', function(node) {
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
    },

    initWithNumber: function(data) {
        this._iconPath = YAHOO.grn.mail.folderTree.app_path + '/grn/image/cybozu/';
        this.buildTreeWithNumber(data,null);
        
        var obj = this;
        
        this._tree.subscribe( 'expand', function(node) {
            if (node.children.length > 0 && node['sendExpanded']) {

                var ajaxNumExpandRequest = new grn.component.ajax.request(
                {
                    url: node.url,
                    method: node.method,
                    data: node.postData + "&action=expand",
                    dataType: "json",
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
            if (node.children.length > 0) {
                obj._loadTreeData(node);
                node.sendExpanded = true;

                var ajaxNumCollapseRequest = new grn.component.ajax.request(
                {
                    url: node.url,
                    method: node.method,
                    data: node.postData + "&action=collapse",
                    dataType: "json",
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

        var tree_name = "#" + this._treeName;
        this._tree.subscribe( 'expandComplete', function(node) {
            if (typeof(obj._afterExpandCompleteFunction) == 'function')
            {
                obj._afterExpandCompleteFunction();
            }
            jQuery(tree_name + " table.menu_unselect_grn").each(function(index, node){
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
            html += '<input type="checkbox" id="' + this._checkInfo['id_prefix'] + node_info.oid + '" name="' + this._checkInfo['name'] + '" value="' + node_info.oid + '" class="tree_checkbox_grn" onClick="' + this._checkInfo['on_click'] + '()">';
        }

        if (this._onSelect){
            html += '<a ' + a_node_id + ' href="javascript:' + this._onSelect + '(' + node_info.oid + ')">' + node_info.name;
        }
        else{
            html += '<a ' + a_node_id + ' href="' + url + this._oidKey + '=' + node_info.oid + reflectParam + '">' + node_info.name;
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
        html = this.setNodeStyle(node_info, html);
        
        var node = new YAHOO.widget.HTMLNode(html, node_info.parent, false, true);
        node.href = url + this._oidKey + '=' + node_info.oid;
        return node;
    },

    setNodeStyle: function(node_info, html) {
        var selected = ('selected' in node_info) ? node_info.selected : false;

        trash_class = '';
        if (node_info.oid == this._trash_id)
        {
            trash_class = 'icon_trash_small_grn';
        }
        if (selected) {
            html = '<div id="'+this._treeName+'-selected_node" class="tree-select-current ' + trash_class + '">' + html + '</div>';
        } else {
            html = '<div class="tree-node ' + trash_class + '">' + html + '</div>';
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
    initDrapDropTarget: function(select_id){
        if (typeof(this._afterExpandCompleteFunction) == 'function')
        {
            this._afterExpandCompleteFunction(select_id);
        }
        // init drop target
        jQuery("#" + this._treeName + " table.menu_unselect_grn").each(function(index, node){
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
        if(node){
            var tmp_ele = jQuery("<div></div>");
            try{
                tmp_ele.html(node.getContentEl().innerHTML);
            }catch(e){
                tmp_ele.html(node.html);
            }
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
                var ele = selector.query('.tree-node, .tree-select-current', cnt)[0];
                
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
                    
                    child.initContent(ele.innerHTML);
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

    setTrashid: function(trash_id){
        this._trash_id = trash_id;
    },

    setAfterExpandCompleteFunction: function(fun){
        this._afterExpandCompleteFunction = fun;
    }
};

