// namespace
grn.base.namespace("grn.page.space.appmanage_view");

(function ($) {
    var G = grn.page.space.appmanage_view;
    var url;
    var spid;
    var ticket;

    G.sync = function () {
        with (document.getElementById('sync_panel').style) {
            width = '400px';
            height = '175px';
            border = '1px solid #B0B0B0';
            backgroundColor = 'White';
            position = 'absolute';
            left = (jQuery(document.body).outerWidth()/2) - 200 + 'px';
            top = '30%';
            display = 'block';
        }

        document.getElementById('syncing').style.display = 'block';
        document.getElementById('sync_complete').style.display = 'none';
        document.getElementById('sync_failure').style.display = 'none';

        var ajaxRequest = new grn.component.ajax.request(
            {
                url: this.url,
                data: "spid=" + this.spid + "&csrf_ticket=" + this.ticket,
                method: "post"
            });

        ajaxRequest.on('beforeShowError', function (e, jqXHR) {
            G.closeDialog();
        });

        ajaxRequest.send().done(function (data, textStatus, jqXHR) {
            G.showSyncCompleteDialog(jqXHR);
        });
    };

    G.showSyncCompleteDialog = function (req) {
        try {
            var json = JSON.parse(req.responseText);
            if (json.success) {
                document.getElementById('syncing').style.display = 'none';
                document.getElementById('sync_complete').style.display = 'block';
                document.getElementById('sync_failure').style.display = 'none';
            }
            else {
                G.showSyncIncompleteDialog( json );
            }
        }
        catch (err) {
            G.closeDialog();
        }
    };


    G.showSyncIncompleteDialog = function (json) {
        document.getElementById('error_code').innerHTML = json.code;
        document.getElementById('error_diag').innerHTML = json.diag;
        document.getElementById('error_cause').innerHTML = json.cause;
        document.getElementById('error_counter').innerHTML = json.counter;

        document.getElementById('sync_panel').style.height = '220px';
        document.getElementById('syncing').style.display = 'none';
        document.getElementById('sync_complete').style.display = 'none';
        document.getElementById('sync_failure').style.display = 'block';
    };

    G.closeDialog = function () {
        document.getElementById('sync_panel').style.display = 'none';
    };
})(jQuery);
