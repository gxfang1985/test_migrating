goog.provide("grn.mailwise.portlet");
goog.require('goog.dom');
goog.require('goog.dom.query');
goog.require('goog.dom.classes');
goog.require('goog.array');
goog.require('goog.json');
goog.require('goog.net.XhrIo');

grn.mailwise.portlet.MW_CGI = '/m/mw.cgi';

grn.mailwise.portlet.MW_STATIC /* = '/cbmw5/' */ = (function(){
    var linkTags = document.getElementsByTagName("link");
    for(var i=0; i<linkTags.length; i++){
        if(linkTags.item(i).href.match( /std/ )){
            return linkTags.item(i).href.replace( /grn\/html\/std.css.*/, "cbmw5/" );
        }
    }
    return false;
})();

/**
 *
 * @constructor
 */
grn.mailwise.portlet.Connector = function(elem, num) {
    this.dest_ = grn.mailwise.portlet.MW_CGI + '?page=ApiNotificationSummary&ct=json&oencoding=UTF-8&ver=1&num=' + num;
    this.elem_ = elem;
};
grn.mailwise.portlet.Connector.prototype = {
    getNotify: function () {
        var xhr = new goog.net.XhrIo();
        goog.events.listen(xhr, goog.net.EventType.SUCCESS, function (o) {
            var isError = false;
            var xhr = o.target;
            var errorMsg = this.errorMessage();
            try {
                var res = xhr.getResponseJson();
                if (res["status"] == "ok") {
                    this.showNotify(res, this.elem_);
                }
                else {
                    isError = true;
                    errorMsg = this.errorMessageWithCode(res["code"]);
                }
            }
            catch (e) {
                isError = true;
                if (xhr.getResponseHeader('X-CybozuLogin')) {
                    errorMsg = this.errorMessageWithCode(10102);
                }
            }
            if (isError) {
                this.showError(errorMsg, this.elem_);
            }
        }.bind(this));

        goog.events.listen(xhr, goog.net.EventType.ERROR, function (o) {
            this.showError(this.errorMessage(), this.elem_);
        }.bind(this));
        xhr.send( this.dest_, "POST" );
    },
    showNotify: function (res, eleWhatsNew) {
        var exist = false;
        var strSuffix = ' あります。';
        eleWhatsNew.innerHtml = '';
        for (var i = 0; i < res["Workspaces"].length; i++) {
            for (var j = 0; j < res["Workspaces"][i]["mails"].length; j++) {
                if (res["Workspaces"][i]["mails"][j]["assigned"]["count"] + res["Workspaces"][i]["mails"][j]["todos"]["count"] > 0) {
                    if (!exist) {
                        exist = true;
                    }
                    var resMails = res["Workspaces"][i]["mails"][j];

                    var divMails = document.createElement('div');
                    divMails.style.marginBottom = '3px';
                    divMails.appendChild(this.createNotifyImg());
                    //メールアプリケーション
                    divMails.appendChild(this.createA(resMails["url"], resMails["name"]));
                    divMails.appendChild(document.createTextNode('に'));
                    // 担当メール
                    if (resMails["assigned"]["count"] > 0) {
                        divMails.appendChild(this.createNum(resMails["assigned"], '担当メールが '));
                    }
                    // 確認メール
                    if (resMails["todos"]["count"] > 0) {
                        if (resMails["assigned"]["count"] > 0) {
                            divMails.appendChild(document.createTextNode('、'));
                        }
                        divMails.appendChild(this.createNum(resMails["todos"], '確認メールが '));
                    }
                    divMails.appendChild(document.createTextNode(strSuffix));
                    eleWhatsNew.appendChild(divMails);
                }
            }
        }

        if (!exist) {
            goog.dom.setTextContent(eleWhatsNew, 'お知らせはありません');
        }
    },
    createNum: function (detail, label) {
        var num = this.createA(detail["url"], label);
        num.appendChild(this.createB(detail["count"]));
        num.appendChild(document.createTextNode(' 件'));
        return num;
    },
    createNotifyImg: function () {
        return this.createImg(grn.mailwise.portlet.MW_STATIC + 'image/notify_mailwise16.png');
    },
    createErrorImg: function () {
        return this.createImg(grn.mailwise.portlet.MW_STATIC + 'image/notify_mailwise16_e.png');
    },
    createImg: function (src) {
        var img = document.createElement('img');
        img.src = src;
        img.width = 16;
        img.height = 16;
        return img;
    },
    createA: function (href, text) {
        var a = document.createElement("a");
        a.href = href;
        a.target = '_blank';
        a.appendChild(document.createTextNode(text));
        return a;
    },
    createB: function (text) {
        var b = document.createElement('b');
        b.appendChild(document.createTextNode(text));
        return b;
    },
    // エラーメッセージ関連
    showError: function (msg, elem) {
        var div = document.createElement('div');
        div.appendChild(this.createErrorImg());
        div.appendChild(document.createTextNode(msg));
        elem.appendChild(div);
    },
    strErrorMessage: '情報の取得に失敗しました',
    errorMessage: function (code) {
        return this.strErrorMessage + '。';
    },
    errorMessageWithCode: function (code) {
        return this.strErrorMessage + '（エラー番号:' + code + '）。';
    }
};

grn.mailwise.portlet.draw = function(){
    goog.array.forEach(goog.dom.query(".mailwise_portlet_main"), function(t, i){
        if(! goog.dom.classes.has(t, "mailwise_portlet_main_done")) {
            goog.dom.classes.add(t, "mailwise_portlet_main_done");
            var portlet = new grn.mailwise.portlet.Connector(t, i);
            portlet.getNotify();
        }
    });
};

goog.exportSymbol("grn.mailwise.portlet.draw", grn.mailwise.portlet.draw);
// goog.exportSymbol('grn.mailwise.portlet.Connector', grn.mailwise.portlet.Connector);
// goog.exportSymbol('grn.mailwise.portlet.Connector.prototypegetNotify', grn.mailwise.portlet.Connector.prototypegetNotify);

