grn.base.namespace("grn.component.define_cybozu_browser");

(function () {
    var G = grn.component.define_cybozu_browser;

    cbGetVersion = function () {
        return G.getVersion();
    };

    cbGetScreenDefinition = function () {
        return G.getScreenDefinition();
    };

    var iconTypes =
        {
            my_space: "com.cybozu.icontype.garoon.space",
            discussion_add: "com.cybozu.icontype.kunai.add",
            todo_add: "com.cybozu.icontype.garoon.space_add_todo",
            todo_edit: "com.cybozu.icontype.kunai.edit",
            comment_delete: "com.cybozu.icontype.kunai.trash",
            member_view: "com.cybozu.icontype.garoon.space_member",
            add_comment: "com.cybozu.icontype.kunai.add_comment"
        };

    G.getVersion = function () {
        return G.kunai_api_version;
    };

    G.getScreenDefinition = function () {
        return { "ToolBar"  : { "ToolBarItems" : toolBarItems },
            "BackLink": G._getBackLink()
        };
    };

    var toolBarItems = [];
    G.addToolBarItem = function (icon, label, url) {
        toolBarItems.push({
            "Type": "Link",
            "IconType": iconTypes[icon],
            "URL": G._replaceUrl(url),
            "Label": label
        });
    };

    G._getBackLink = function () {
        var back_link = G.back_link;
        G.back_link = "";
        if (back_link) {
            if (back_link == "hidden") {
                return {"Hidden" : "True"};
            }
            else {
                return {"URL" : G._replaceUrl(back_link)};
            }
        }
        else {
            return {"HistoryBack" : "True"};
        }
    };

    G._replaceUrl = function (url) {
        return url.replace(/&amp;/g, "&");
    };
})();
