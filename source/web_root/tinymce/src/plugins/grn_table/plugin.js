(function () {
    tinymce.PluginManager.add('grn_table', function (editor, url) {

        var langCode = editor.settings.language || 'en';
        var each = tinymce.util.Tools.each;

        function appendStylesToData(dom, data, elm) {
            var css = dom.parseStyle(dom.getAttrib(elm, 'style'));
            if (css["background-color"]) {
                data.backgroundColor = css["background-color"];
            }
        }

        function convertRGBToHex(color) {
            var re = new RegExp("rgb\\s*\\(\\s*([0-9]+).*,\\s*([0-9]+).*,\\s*([0-9]+).*\\)", "gi");

            var rgb = color.replace(re, "$1,$2,$3").split(',');
            if (rgb.length == 3) {
                r = parseInt(rgb[0]).toString(16);
                g = parseInt(rgb[1]).toString(16);
                b = parseInt(rgb[2]).toString(16);

                r = r.length == 1 ? '0' + r : r;
                g = g.length == 1 ? '0' + g : g;
                b = b.length == 1 ? '0' + b : b;

                return "#" + r + g + b;
            }

            return color;
        }

        // Register dialog commands
        each({
            mceGrnTableBorder: function () {
                var dom = editor.dom, data, cells = [];
                var tableElm, tdElm, borderColor;

                function setProperties(elm, name, value) {
                    if (cells.length === 1 || value) {
                        dom.setAttrib(elm, name, value);
                        dom.setStyle(elm, name, value);
                    }
                }

                function onSubmitBorderForm(color) {
                    editor.undoManager.transact(function () {
                        setProperties(tableElm, 'border-color', color);

                        each(tableElm.rows, function (row) {
                            each(row.cells, function (cell) {
                                setProperties(cell, 'border-color', color);
                            });
                        });
                        editor.focus();
                    });
                }

                tableElm = dom.getParent(editor.selection.getStart(), 'table');

                tdElm = dom.getParent(editor.selection.getStart(), "td,th");
                borderColor = dom.getStyle(tdElm, 'border-color') ? dom.getStyle(tdElm, 'border-color') : dom.getStyle(tdElm, 'borderLeftColor');
                borderColor = convertRGBToHex(borderColor);

                data = {};
                data.borderColor = borderColor;

                editor.windowManager.open(
                    {
                        title: tinymce.i18n.data[langCode].grn_table.change_border_color,
                        url: editor.settings.grn_color_palette,
                        width: 410,
                        height: 305
                    },
                    {
                        init_color: data.borderColor == null ? "" : data.borderColor,
                        callback_apply_function: onSubmitBorderForm,
                        convertRGBToHex: convertRGBToHex
                    }
                );
            },
            mceGrnTableCellBgColor: function () {
                var dom = editor.dom, cellElm, data, cells = [];

                function setAttrib(elm, name, value) {
                    if (cells.length >= 1 || value) {
                        dom.setAttrib(elm, name, value);
                    }
                }

                function setStyle(elm, name, value) {
                    if (cells.length >= 1 || value) {
                        dom.setStyle(elm, name, value);
                    }
                }

                function onSubmitCellForm(color) {

                    editor.undoManager.transact(function () {
                        tinymce.util.Tools.each(cells, function (cellElm) {
                            setStyle(cellElm, 'background-color', color);
                            setAttrib(cellElm, 'background-color', color);
                        });
                        editor.focus();
                    });
                }

                // Get selected cells or the current cell
                cells = editor.dom.select('td[data-mce-selected],th[data-mce-selected]');
                cellElm = editor.dom.getParent(editor.selection.getStart(), 'td,th');
                if (!cells.length && cellElm) {
                    cells.push(cellElm);
                }

                cellElm = cellElm || cells[0];

                if (!cellElm) {
                    // If this element is null, return now to avoid crashing.
                    return;
                }

                data = {};
                appendStylesToData(dom, data, cellElm);

                editor.windowManager.open(
                    {
                        title: tinymce.i18n.data[langCode].grn_table.change_cell_bg_color,
                        url: editor.settings.grn_color_palette,
                        width: 410,
                        height: 305
                    },
                    {
                        init_color: data.backgroundColor == null ? "" : data.backgroundColor,
                        callback_apply_function: onSubmitCellForm,
                        convertRGBToHex: convertRGBToHex
                    }
                );
            },
            mceGrnTableRowBgColor: function () {
                var each = tinymce.util.Tools.each;
                var dom = editor.dom, tableElm, cellElm, rowElm, data, rows = [];

                function setAttrib(elm, name, value) {
                    if (rows.length >= 1 || value) {
                        dom.setAttrib(elm, name, value);
                    }
                }

                function setStyle(elm, name, value) {
                    if (rows.length >= 1 || value) {
                        dom.setStyle(elm, name, value);
                    }
                }

                function setProperties(elm, name, value) {
                    setStyle(elm, name, value);
                    setAttrib(elm, name, value);
                }

                function onSubmitRowForm(color) {
                    editor.undoManager.transact(function () {
                        each(rows, function (rowElm) {
                            setProperties(rowElm, 'background-color', color);
                            each(rowElm.cells, function (cell) {
                                setProperties(cell, 'background-color', color);
                            });
                        });
                        editor.focus();
                    });
                }

                tableElm = editor.dom.getParent(editor.selection.getStart(), 'table');
                cellElm = editor.dom.getParent(editor.selection.getStart(), 'td,th');

                each(tableElm.rows, function (row) {
                    each(row.cells, function (cell) {
                        if (dom.getAttrib(cell, 'data-mce-selected') || cell == cellElm) {
                            rows.push(row);
                            return false;
                        }
                    });
                });

                rowElm = rows[0];
                if (!rowElm) {
                    // If this element is null, return now to avoid crashing.
                    return;
                }


                data = {};
                appendStylesToData(dom, data, rowElm);

                editor.windowManager.open(
                    {
                        title: tinymce.i18n.data[langCode].grn_table.change_row_bg_color,
                        url: editor.settings.grn_color_palette,
                        width: 410,
                        height: 305
                    },
                    {
                        init_color: data.backgroundColor == null ? "" : data.backgroundColor,
                        callback_apply_function: onSubmitRowForm,
                        convertRGBToHex: convertRGBToHex
                    }
                );
            },
            mceGrnTableColBgColor: function () {
                var each = tinymce.util.Tools.each;
                var dom = editor.dom, tableElm, cellElm, cells = [], data, rows = [], targetColNums = [];

                function setAttrib(elm, name, value) {
                    if (value != null) {
                        dom.setAttrib(elm, name, value);
                    }
                }

                function setStyle(elm, name, value) {
                    if (value != null) {
                        dom.setStyle(elm, name, value);
                    }
                }

                function setProperties(elm, name, value) {
                    setStyle(elm, name, value);
                    setAttrib(elm, name, value);
                }

                function onSubmitColumnForm(color) {
                    editor.undoManager.transact(function () {
                        each(tableElm.rows, function (row) {
                            each(row.cells, function (cell, index) {
                                if (targetColNums[index]) {
                                    setProperties(cell, 'background-color', color);
                                }
                            });
                        });
                        editor.focus();
                    });
                }

                tableElm = editor.dom.getParent(editor.selection.getStart(), 'table');
                cellElm = editor.dom.getParent(editor.selection.getStart(), 'td,th');

                each(tableElm.rows, function (row) {
                    each(row.cells, function (cell, index) {
                        if (dom.getAttrib(cell, 'data-mce-selected') || cell == cellElm) {
                            targetColNums[index] = true;
                        }
                    });
                });

                // Get selected cells or the current cell
                cells = editor.dom.select('td[data-mce-selected],th[data-mce-selected]');
                if (!cells.length && cellElm) {
                    cells.push(cellElm);
                }

                cellElm = cellElm || cells[0];

                if (!cellElm) {
                    // If this element is null, return now to avoid crashing.
                    return;
                }

                data = {};
                appendStylesToData(dom, data, cellElm);

                editor.windowManager.open(
                    {
                        title: tinymce.i18n.data[langCode].grn_table.change_col_bg_color,
                        url: editor.settings.grn_color_palette,
                        width: 410,
                        height: 305
                    },
                    {
                        init_color: data.backgroundColor == null ? "" : data.backgroundColor,
                        callback_apply_function: onSubmitColumnForm,
                        convertRGBToHex: convertRGBToHex
                    }
                );
            }
        }, function (func, name) {
            editor.addCommand(name, function (ui, val) {
                func(val);
            });
        });

        function selectGrid(tx, ty, control) {
            var table = control.getEl().getElementsByTagName('table')[0];
            var x, y, focusCell, cell, active;
            var rtl = control.isRtl() || control.parent().rel == 'tl-tr';

            table.nextSibling.innerHTML = (tx + 1) + ' x ' + (ty + 1);

            if (rtl) {
                tx = 9 - tx;
            }

            for (y = 0; y < 10; y++) {
                for (x = 0; x < 10; x++) {
                    cell = table.rows[y].childNodes[x].firstChild;
                    active = (rtl ? x >= tx : x <= tx) && y <= ty;

                    editor.dom.toggleClass(cell, 'mce-active', active);

                    if (active) {
                        focusCell = cell;
                    }
                }
            }

            return focusCell.parentNode;
        }

        function insertTable(cols, rows) {
            var y, x, tableElm;
            var td = '<td style="padding: 2px 3px; border-width: 1px;border-color: #999999;border-style: solid; min-width:10px; width: auto;">';
            var html = '<table id="__mce" border="0" cellspacing="0" style="border: none; border-collapse: collapse; margin:0; padding:0; width: auto;" data-mce-new="1"><tbody>'

            for (y = 0; y < rows; y++) {
                html += '<tr>';

                for (x = 0; x < cols; x++) {
                    html += td + (tinymce.Env.ie && tinymce.Env.ie < 10 ? '&nbsp;' : '<br>') + '</td>';
                }

                html += '</tr>';
            }

            html += '</tbody></table>';

            editor.undoManager.transact(function () {
                var patt = '';

                editor.focus();
                editor.selection.setContent('<br class="_mce_marker" />');

                each('h1,h2,h3,h4,h5,h6,p,div'.split(','), function (n) {
                    if (patt)
                        patt += ',';

                    patt += n + ' ._mce_marker';
                });

                each(editor.dom.select(patt), function (n) {
                    editor.dom.split(editor.dom.getParent(n, 'h1,h2,h3,h4,h5,h6,p,div'), n);
                });

                editor.selection.select(editor.dom.select('br._mce_marker')[0]);
                editor.selection.collapse();
                editor.insertContent(html);

                var el = editor.dom.select('br._mce_marker')[0];
                if (el && el.parentNode) {
                    el.parentNode.removeChild(el);
                }

                if (tinymce.Env.ie && tinymce.Env.ie <= 11 && editor.getBody().lastChild.lastChild.nodeName == 'TABLE') {
                    editor.dom.add(editor.getBody(), 'br', {'data-mce-bogus': '1'});
                }
                tableElm = editor.dom.get('__mce');
                editor.dom.setAttrib(tableElm, 'id', null);

                editor.$('tr', tableElm).each(function (index, row) {
                    editor.fire('newrow', {
                        node: row
                    });

                    editor.$('th,td', row).each(function (index, cell) {
                        editor.fire('newcell', {
                            node: cell
                        });
                    });
                });

                editor.dom.setAttribs(tableElm, editor.settings.table_default_attributes || {});
                editor.dom.setStyles(tableElm, editor.settings.table_default_styles || {});
            });

            return tableElm;
        }

        function generateTableGrid() {
            var html = '<table role="grid" class="mce-grid mce-grid-border" aria-readonly="true">';

            for (var y = 0; y < 10; y++) {
                html += '<tr>';

                for (var x = 0; x < 10; x++) {
                    html += '<td role="gridcell" tabindex="-1"><a id="mcegrid' + (y * 10 + x) + '" href="#" ' +
                        'data-mce-x="' + x + '" data-mce-y="' + y + '"></a></td>';
                }

                html += '</tr>';
            }

            html += '</table>';

            html += '<div class="mce-text-center" role="presentation">1 x 1</div>';

            return html;
        }

        function handleAppearanceState(ctrl, selector) {
            function bindAppearanceStateListener() {
                var selectedElm, selectedCells, state;

                selectedCells = editor.dom.select('td[data-mce-selected],th[data-mce-selected]');
                selectedElm = selectedCells[0];
                if (!selectedElm) {
                    selectedElm = editor.selection.getStart(true);
                }

                state = !editor.dom.getParent(selectedElm, selector);
                if (!state && ctrl.visible) {
                    ctrl.hide();
                }

                editor.selection.selectorChanged(selector, function (state) {
                    if (state && ctrl.visible) {
                        ctrl.hide();
                    }
                    else {
                        ctrl.show();
                    }
                });
            }

            if (editor.initialized) {
                bindAppearanceStateListener();
            } else {
                editor.on('init', bindAppearanceStateListener);
            }
        }

        function postRenderForInsertTable() {
            handleAppearanceState(this, 'table');
        }

        function initTableDialog(event) {
            if (event.aria) {
                this.parent().hideAll();
                event.stopImmediatePropagation();
                var dialogs = new tinymce.plugins.table.ui.Dialogs(editor);
                dialogs.table();
            }
        }

        function resetSelectGrid() {
            if (typeof this.menu !== 'undefined') {
                var elements = this.menu.items()[0].getEl().getElementsByTagName('a');
                editor.dom.removeClass(elements, 'mce-active');
                editor.dom.addClass(elements[0], 'mce-active');
            }
        }

        var menuTableGrid = [
            {
                type: 'container',
                html: generateTableGrid(),

                onPostRender: function () {
                    this.lastX = this.lastY = 0;
                },

                onmousemove: function (e) {
                    var target = e.target, x, y;

                    if (target.tagName.toUpperCase() == 'A') {
                        x = parseInt(target.getAttribute('data-mce-x'), 10);
                        y = parseInt(target.getAttribute('data-mce-y'), 10);

                        if (this.isRtl() || this.parent().rel == 'tl-tr') {
                            x = 9 - x;
                        }

                        if (x !== this.lastX || y !== this.lastY) {
                            selectGrid(x, y, e.control);

                            this.lastX = x;
                            this.lastY = y;
                        }
                    }
                },

                onclick: function (e) {
                    var self = this;

                    if (e.target.tagName.toUpperCase() == 'A') {
                        e.preventDefault();
                        e.stopPropagation();
                        self.parent().cancel();

                        editor.undoManager.transact(function () {
                            insertTable(self.lastX + 1, self.lastY + 1);
                        });

                        editor.addVisual();
                    }
                }
            }
        ];

        editor.on('init', function () {
            editor.addMenuItem('inserttable', {
                text: tinymce.i18n.data[langCode].grn_table.desc,
                icon: 'table',
                context: 'table',
                ariaHideMenu: true,
                onPostRender: postRenderForInsertTable,
                onclick: initTableDialog.bind(this),
                onshow: function () {
                    if (typeof this.menu !== 'undefined') {
                        selectGrid(0, 0, this.menu.items()[0]);
                    }
                },
                onhide: resetSelectGrid.bind(this),
                menu: menuTableGrid
            });
        });

        var myButton = null;
        editor.addButton('grn_table', {
            title: tinymce.i18n.data[langCode].grn_table.desc,
            icon: 'table',
            type: 'menubutton',
            onPostRender: function () {
                myButton = this;
            },
            onclick: initTableDialog.bind(this),
            onshow: function () {
                if (typeof this.menu !== 'undefined') {
                    selectGrid(0, 0, this.menu.items()[0]);
                }
            },
            onhide: resetSelectGrid.bind(this),
            menu: menuTableGrid
        });

        editor.on('NodeChange', function () {
            if (myButton) {
                var selectedElm = editor.selection.getStart(true);
                var inTable = !!editor.dom.getParent(selectedElm, 'table');

                myButton.disabled(inTable);
            }
        });

    });
})();