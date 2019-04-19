var grn_component_editor_Color_Palette_Dialog = {

    init: function () {
        var self = this;
        this.is_text_color = top.tinymce.activeEditor.windowManager.getParams().is_text_color;

        var palette_container = document.getElementById("grn_color_palette_container");
        palette_container.innerHTML = this.renderColorPicker();

        var init_color = top.tinymce.activeEditor.windowManager.getParams().init_color;
        init_color = this.isValidColorString(init_color) ? init_color : '';
        this.updateSelectedColor(init_color);

        var palette_table = palette_container.childNodes[0];
        palette_table.addEventListener("click", function(e){
            self.colorPaletteClick(e);
        });
    },

    generateColorDiv: function (color) {
        var div = document.createElement("div");
        div.setAttribute("id", "grn_selected_color");
        div.setAttribute("tabIndex", "-1");
        div.style.backgroundColor = (color ? color : "");

        return div;
    },

    updateSelectedColor: function (color) {
        var selected_color_color = document.getElementById("grn_palette_selected_color");
        selected_color_color.innerHTML = "";
        selected_color_color.appendChild(this.generateColorDiv(color));

        var selected_color_value = document.getElementById("grn_palette_color_value");
        selected_color_value.value = color;
    },

    normalizeColorString: function (value) {
        value = value.replace(/\s/g, "");

        var is_rgb_type = /^rgb\(.*\)$/i.test(value);
        if (!is_rgb_type) {
            if (value[0] !== "#" && (this.is_text_color || value.length > 0)) {
                value = "#" + value;
            }
        }

        return value;
    },

    isValidColorString: function (value) {
        value = value.replace(/\s/g, "");
        var is_rgb_type = /^rgb\(.*\)$/i.test(value);

        if (is_rgb_type) {
            if (/^rgb\(\d{1,3},\d{1,3},\d{1,3}\)$/i.test(value)) {
                var convertRGBToHex = top.tinymce.activeEditor.windowManager.getParams().convertRGBToHex;
                value = convertRGBToHex(value);
            }
            else {
                return false;
            }
        }

        if (typeof value === "string" && (value === "#" || value.length === 0)) {
            return true;
        }

        if (value[0] !== "#") {
            value = "#" + value;
        }

        return /^#(?=[A-F0-9]*$)(?:.{3}|.{6})$/i.test(value);
    },

    colorPaletteClick: function (event) {
        var selected_div = event.target || event.srcElement;
        if (selected_div && selected_div.nodeName != "DIV") {
            return;
        }

        var convertRGBToHex = top.tinymce.activeEditor.windowManager.getParams().convertRGBToHex;
        var selected_color = convertRGBToHex(selected_div.style.backgroundColor);
        this.updateSelectedColor(selected_color);
    },

    applyColor: function () {
        var selected_color = document.getElementById("grn_palette_color_value").value;

        if (!this.isValidColorString(selected_color)) {
            var lang_code = top.tinymce.activeEditor.settings.language || 'en';
            top.tinymce.activeEditor.windowManager.alert({
                text: top.tinymce.i18n.data[lang_code].grn_common.invalid_color + selected_color
            }, function () {
                //this callback prevents the contextmenu of table display after press Enter to close the Alert
            });
            return;
        }

        var callback_apply_function = top.tinymce.activeEditor.windowManager.getParams().callback_apply_function;
        callback_apply_function(this.normalizeColorString(selected_color));
        top.tinymce.activeEditor.windowManager.close();
    },

    mapColors: function () {
        var i, colors = [], colorMap;

        colorMap = [
            "#000000", "#000033", "#000066", "#000099", "#0000cc", "#0000ff", "#330000", "#330033",
            "#330066", "#330099", "#3300cc", "#3300ff", "#660000", "#660033", "#660066", "#660099",
            "#6600cc", "#6600ff", "#990000", "#990033", "#990066", "#990099", "#9900cc", "#9900ff",
            "#cc0000", "#cc0033", "#cc0066", "#cc0099", "#cc00cc", "#cc00ff", "#ff0000", "#ff0033",
            "#ff0066", "#ff0099", "#ff00cc", "#ff00ff", "#003300", "#003333", "#003366", "#003399",
            "#0033cc", "#0033ff", "#333300", "#333333", "#333366", "#333399", "#3333cc", "#3333ff",
            "#663300", "#663333", "#663366", "#663399", "#6633cc", "#6633ff", "#993300", "#993333",
            "#993366", "#993399", "#9933cc", "#9933ff", "#cc3300", "#cc3333", "#cc3366", "#cc3399",
            "#cc33cc", "#cc33ff", "#ff3300", "#ff3333", "#ff3366", "#ff3399", "#ff33cc", "#ff33ff",
            "#006600", "#006633", "#006666", "#006699", "#0066cc", "#0066ff", "#336600", "#336633",
            "#336666", "#336699", "#3366cc", "#3366ff", "#666600", "#666633", "#666666", "#666699",
            "#6666cc", "#6666ff", "#996600", "#996633", "#996666", "#996699", "#9966cc", "#9966ff",
            "#cc6600", "#cc6633", "#cc6666", "#cc6699", "#cc66cc", "#cc66ff", "#ff6600", "#ff6633",
            "#ff6666", "#ff6699", "#ff66cc", "#ff66ff", "#009900", "#009933", "#009966", "#009999",
            "#0099cc", "#0099ff", "#339900", "#339933", "#339966", "#339999", "#3399cc", "#3399ff",
            "#669900", "#669933", "#669966", "#669999", "#6699cc", "#6699ff", "#999900", "#999933",
            "#999966", "#999999", "#9999cc", "#9999ff", "#cc9900", "#cc9933", "#cc9966", "#cc9999",
            "#cc99cc", "#cc99ff", "#ff9900", "#ff9933", "#ff9966", "#ff9999", "#ff99cc", "#ff99ff",
            "#00cc00", "#00cc33", "#00cc66", "#00cc99", "#00cccc", "#00ccff", "#33cc00", "#33cc33",
            "#33cc66", "#33cc99", "#33cccc", "#33ccff", "#66cc00", "#66cc33", "#66cc66", "#66cc99",
            "#66cccc", "#66ccff", "#99cc00", "#99cc33", "#99cc66", "#99cc99", "#99cccc", "#99ccff",
            "#cccc00", "#cccc33", "#cccc66", "#cccc99", "#cccccc", "#ccccff", "#ffcc00", "#ffcc33",
            "#ffcc66", "#ffcc99", "#ffcccc", "#ffccff", "#00ff00", "#00ff33", "#00ff66", "#00ff99",
            "#00ffcc", "#00ffff", "#33ff00", "#33ff33", "#33ff66", "#33ff99", "#33ffcc", "#33ffff",
            "#66ff00", "#66ff33", "#66ff66", "#66ff99", "#66ffcc", "#66ffff", "#99ff00", "#99ff33",
            "#99ff66", "#99ff99", "#99ffcc", "#99ffff", "#ccff00", "#ccff33", "#ccff66", "#ccff99",
            "#ccffcc", "#ccffff", "#ffff00", "#ffff33", "#ffff66", "#ffff99", "#ffffcc", "#ffffff"
        ];
        for (i = 0; i < colorMap.length; i++) {
            colors.push({
                text: colorMap[i],
                color: colorMap[i]
            });
        }

        return colors;
    },

    renderColorPicker: function () {
        var self = this, colors, color, html, last, x, y, i, id = self._id, count = 0;

        function getColorCellHtml(color, title) {
            var isNoColor = color == "";

            return (
                '<td class="mce-grid-cell' + (isNoColor ? ' mce-colorbtn-trans' : '') + '">' +
                '<div id="' + id + '-' + (count++) + '"' +
                ' data-mce-color="' + (color ? color : '') + '"' +
                ' role="option"' +
                ' tabIndex="-1"' +
                ' style="' + (color ? 'background-color: ' + color : '') + '"' +
                ' title="' + title + '">' +
                (isNoColor ? '&#215;' : '') +
                '</div>' +
                '</td>'
            );
        }

        colors = this.mapColors();

        html = '<table class="mce-grid mce-grid-border mce-colorbutton-grid " role="list" cellspacing="0"><tbody>';
        last = colors.length - 1;
        var cols = 18;
        var rows = (last+1)/cols;

        for (y = 0; y < rows; y++) {
            html += '<tr>';

            for (x = 0; x < cols; x++) {
                i = y * cols + x;

                if (i > last) {
                    html += '<td></td>';
                } else {
                    color = colors[i];
                    html += getColorCellHtml(color.color, color.text);
                }
            }

            html += '</tr>';
        }

        html += '</tbody></table>';

        return html;
    }
};