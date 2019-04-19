(function () {

    tinymce.PluginManager.add('grn_contextmenu', function (editor, url) {
        var postRenderForEditTableItems = function (editor) {
            return function () {
                var self = this;

                function tableIsSelected() {
                    var el = editor.selection.getStart();
                    return editor.dom.getParent(el, 'td')
                        || editor.dom.getParent(el, 'th')
                        || editor.dom.select('td.mceSelected,th.mceSelected').length;
                }

                var toggleVisibility = function () {
                    if (tableIsSelected()) {
                        self.show();
                    } else {
                        self.hide();
                    }
                };

                if (!tableIsSelected()) {
                    self.hide();
                }

                editor.on('nodechange', toggleVisibility);

                self.on('remove', function () {
                    editor.off('nodechange', toggleVisibility);
                });
            };
        };

        editor.on("init", function () {
            var langCode = editor.settings.language || 'en';

            function cmd(command) {
                return function () {
                    editor.execCommand(command);
                };
            }

            editor.addMenuItem('deletetable', {
                text: 'Delete table',
                context: 'table',
                icon: 'tabledelete',
                onPostRender: postRenderForEditTableItems(editor),
                cmd: 'mceTableDelete'
            });

            editor.addMenuItem('fillcolor', {
                text: tinymce.i18n.data[langCode].grn_table.change_bg_color,
                context: 'table',
                onPostRender: postRenderForEditTableItems(editor),
                menu: [
                    {
                        text: 'Cell',
                        onclick: cmd('mceGrnTableCellBgColor')
                    },
                    {
                        text: 'Row',
                        onclick: cmd('mceGrnTableRowBgColor')
                    },
                    {
                        text: 'Column',
                        onclick: cmd('mceGrnTableColBgColor')
                    }
                ]
            });

            editor.addMenuItem('bordercolor', {
                text: tinymce.i18n.data[langCode].grn_table.change_border_color,
                context: 'table',
                onPostRender: postRenderForEditTableItems(editor),
                cmd: 'mceGrnTableBorder'
            });

            editor.addMenuItem('unlink', {
                icon: 'unlink',
                text: 'Remove link',
                 onclick: function() {
                     editor.execCommand('Unlink');
                 }
            });
        });

    });

})();


