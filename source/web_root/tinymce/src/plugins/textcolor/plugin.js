(function () {

var defs = {}; // id -> {dependencies, definition, instance (possibly undefined)}

// Used when there is no 'main' module.
// The name is probably (hopefully) unique so minification removes for releases.
var register_3795 = function (id) {
  var module = dem(id);
  var fragments = id.split('.');
  var target = Function('return this;')();
  for (var i = 0; i < fragments.length - 1; ++i) {
    if (target[fragments[i]] === undefined)
      target[fragments[i]] = {};
    target = target[fragments[i]];
  }
  target[fragments[fragments.length - 1]] = module;
};

var instantiate = function (id) {
  var actual = defs[id];
  var dependencies = actual.deps;
  var definition = actual.defn;
  var len = dependencies.length;
  var instances = new Array(len);
  for (var i = 0; i < len; ++i)
    instances[i] = dem(dependencies[i]);
  var defResult = definition.apply(null, instances);
  if (defResult === undefined)
     throw 'module [' + id + '] returned undefined';
  actual.instance = defResult;
};

var def = function (id, dependencies, definition) {
  if (typeof id !== 'string')
    throw 'module id must be a string';
  else if (dependencies === undefined)
    throw 'no dependencies for ' + id;
  else if (definition === undefined)
    throw 'no definition function for ' + id;
  defs[id] = {
    deps: dependencies,
    defn: definition,
    instance: undefined
  };
};

var dem = function (id) {
  var actual = defs[id];
  if (actual === undefined)
    throw 'module [' + id + '] was undefined';
  else if (actual.instance === undefined)
    instantiate(id);
  return actual.instance;
};

var req = function (ids, callback) {
  var len = ids.length;
  var instances = new Array(len);
  for (var i = 0; i < len; ++i)
    instances.push(dem(ids[i]));
  callback.apply(null, callback);
};

var ephox = {};

ephox.bolt = {
  module: {
    api: {
      define: def,
      require: req,
      demand: dem
    }
  }
};

var define = def;
var require = req;
var demand = dem;
// this helps with minificiation when using a lot of global references
var defineGlobal = function (id, ref) {
  define(id, [], function () { return ref; });
};
/*jsc
["tinymce.plugins.textcolor.Plugin","tinymce.core.dom.DOMUtils","tinymce.core.PluginManager","tinymce.core.util.I18n","tinymce.core.util.Tools","global!tinymce.util.Tools.resolve"]
jsc*/
defineGlobal("global!tinymce.util.Tools.resolve", tinymce.util.Tools.resolve);
/**
 * ResolveGlobal.js
 *
 * Released under LGPL License.
 * Copyright (c) 1999-2017 Ephox Corp. All rights reserved
 *
 * License: http://www.tinymce.com/license
 * Contributing: http://www.tinymce.com/contributing
 */

define(
  'tinymce.core.dom.DOMUtils',
  [
    'global!tinymce.util.Tools.resolve'
  ],
  function (resolve) {
    return resolve('tinymce.dom.DOMUtils');
  }
);

/**
 * ResolveGlobal.js
 *
 * Released under LGPL License.
 * Copyright (c) 1999-2017 Ephox Corp. All rights reserved
 *
 * License: http://www.tinymce.com/license
 * Contributing: http://www.tinymce.com/contributing
 */

define(
  'tinymce.core.PluginManager',
  [
    'global!tinymce.util.Tools.resolve'
  ],
  function (resolve) {
    return resolve('tinymce.PluginManager');
  }
);

/**
 * ResolveGlobal.js
 *
 * Released under LGPL License.
 * Copyright (c) 1999-2017 Ephox Corp. All rights reserved
 *
 * License: http://www.tinymce.com/license
 * Contributing: http://www.tinymce.com/contributing
 */

define(
  'tinymce.core.util.I18n',
  [
    'global!tinymce.util.Tools.resolve'
  ],
  function (resolve) {
    return resolve('tinymce.util.I18n');
  }
);

/**
 * ResolveGlobal.js
 *
 * Released under LGPL License.
 * Copyright (c) 1999-2017 Ephox Corp. All rights reserved
 *
 * License: http://www.tinymce.com/license
 * Contributing: http://www.tinymce.com/contributing
 */

define(
  'tinymce.core.util.Tools',
  [
    'global!tinymce.util.Tools.resolve'
  ],
  function (resolve) {
    return resolve('tinymce.util.Tools');
  }
);

/**
 * Plugin.js
 *
 * Released under LGPL License.
 * Copyright (c) 1999-2017 Ephox Corp. All rights reserved
 *
 * License: http://www.tinymce.com/license
 * Contributing: http://www.tinymce.com/contributing
 */

/**
 * This class contains all core logic for the code plugin.
 *
 * @class tinymce.textcolor.Plugin
 * @private
 */
define(
  'tinymce.plugins.textcolor.Plugin',
  [
    'tinymce.core.dom.DOMUtils',
    'tinymce.core.PluginManager',
    'tinymce.core.util.I18n',
    'tinymce.core.util.Tools'
  ],
  function (DOMUtils, PluginManager, I18n, Tools) {
    var translate = I18n.translate;

    PluginManager.add('textcolor', function (editor) {
      var cols, rows;

      rows = {
        forecolor: editor.settings.forecolor_rows || editor.settings.textcolor_rows || 5,
        backcolor: editor.settings.backcolor_rows || editor.settings.textcolor_rows || 5
      };
      cols = {
        forecolor: editor.settings.forecolor_cols || editor.settings.textcolor_cols || 8,
        backcolor: editor.settings.backcolor_cols || editor.settings.textcolor_cols || 8
      };

      function getCurrentColor(format) {
        var color;

        editor.dom.getParents(editor.selection.getStart(), function (elm) {
          var value;

          if ((value = elm.style[format == 'forecolor' ? 'color' : 'background-color'])) {
            color = value;
          }
        });

        return color;
      }

      function mapColors(type) {
        var i, colors = [], colorMap;

        colorMap = [
          "000000", "Black",
          "993300", "Burnt orange",
          "333300", "Dark olive",
          "003300", "Dark green",
          "003366", "Dark azure",
          "000080", "Navy Blue",
          "333399", "Indigo",
          "333333", "Very dark gray",
          "800000", "Maroon",
          "FF6600", "Orange",
          "808000", "Olive",
          "008000", "Green",
          "008080", "Teal",
          "0000FF", "Blue",
          "666699", "Grayish blue",
          "808080", "Gray",
          "FF0000", "Red",
          "FF9900", "Amber",
          "99CC00", "Yellow green",
          "339966", "Sea green",
          "33CCCC", "Turquoise",
          "3366FF", "Royal blue",
          "800080", "Purple",
          "999999", "Medium gray",
          "FF00FF", "Magenta",
          "FFCC00", "Gold",
          "FFFF00", "Yellow",
          "00FF00", "Lime",
          "00FFFF", "Aqua",
          "00CCFF", "Sky blue",
          "993366", "Red violet",
          "FFFFFF", "White",
          "FF99CC", "Pink",
          "FFCC99", "Peach",
          "FFFF99", "Light yellow",
          "CCFFCC", "Pale green",
          "CCFFFF", "Pale cyan",
          "99CCFF", "Light sky blue",
          "CC99FF", "Plum"
        ];

        colorMap = editor.settings.textcolor_map || colorMap;
        colorMap = editor.settings[type + '_map'] || colorMap;

        for (i = 0; i < colorMap.length; i += 2) {
          colors.push({
            text: colorMap[i + 1],
            color: '#' + colorMap[i]
          });
        }

        return colors;
      }

      function renderColorPicker() {
        var self = this, colors, color, html, last, x, y, i, id = self._id, count = 0, type;

        type = self.settings.origin;

        function getColorCellHtml(color, title) {
          var isNoColor = color == 'transparent';

          return (
            '<td class="mce-grid-cell' + (isNoColor ? ' mce-colorbtn-trans' : '') + '">' +
            '<div id="' + id + '-' + (count++) + '"' +
            ' data-mce-color="' + (color ? color : '') + '"' +
            ' role="option"' +
            ' tabIndex="-1"' +
            ' style="' + (color ? 'background-color: ' + color : '') + '"' +
            ' title="' + translate(title) + '">' +
            (isNoColor ? '&#215;' : '') +
            '</div>' +
            '</td>'
          );
        }

        colors = mapColors(type);
        colors.push({
          text: translate("No color"),
          color: "transparent"
        });

        html = '<table class="mce-grid mce-grid-border mce-colorbutton-grid" role="list" cellspacing="0"><tbody>';
        last = colors.length - 1;

        for (y = 0; y < rows[type]; y++) {
          html += '<tr>';

          for (x = 0; x < cols[type]; x++) {
            i = y * cols[type] + x;

            if (i > last) {
              html += '<td></td>';
            } else {
              color = colors[i];
              html += getColorCellHtml(color.color, color.text);
            }
          }

          html += '</tr>';
        }

        var langCode = editor.settings.language || 'en';
        var moreColor = tinymce.i18n.data[langCode].grn_common.more_color;
        if (editor.settings.color_picker_callback) {
          html += (
            '<tr>' +
            '<td colspan="' + cols[type] + '" class="mce-custom-color-btn">' +
            '<div id="' + id + '-c" class="mce-widget mce-btn mce-btn-small mce-btn-flat" ' +
            'role="button" tabindex="-1" aria-labelledby="' + id + '-c" style="width: 100%; text-align: center">' +
            '<button type="button" role="presentation" tabindex="-1" style="width: 100%;">' + moreColor + '</button>' +
            '</div>' +
            '</td>' +
            '</tr>'
          );
        }

        html += '</tbody></table>';

        return html;
      }

      function applyFormat(format, value) {
        editor.undoManager.transact(function () {
          editor.focus();
          editor.formatter.apply(format, { value: value });
          editor.nodeChanged();
        });
      }

      function removeFormat(format) {
        editor.undoManager.transact(function () {
          editor.focus();
          editor.formatter.remove(format, { value: null }, null, true);
          editor.nodeChanged();
        });
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

      function onPanelClick(e) {
        var buttonCtrl = this.parent(), value;

        function selectColor(value) {
          buttonCtrl.hidePanel();
          buttonCtrl.color(value);
          applyFormat(buttonCtrl.settings.format, value);
        }

        function resetColor() {
          buttonCtrl.hidePanel();
          buttonCtrl.resetColor();
          removeFormat(buttonCtrl.settings.format);
        }

        if (DOMUtils.DOM.getParent(e.target, '.mce-custom-color-btn')) {
          buttonCtrl.hidePanel();

          var langCode = editor.settings.language || 'en';
          var currentColor = getCurrentColor(buttonCtrl.settings.format) || null;
          editor.windowManager.open(
            {
              title: tinymce.i18n.data[langCode].grn_common.change_text_color,
              url: editor.settings.grn_color_palette,
              width: 410,
              height: 305
            },
            {
              init_color: currentColor == null ? "" : convertRGBToHex(currentColor),
              callback_apply_function: selectColor,
              is_text_color: true,
              convertRGBToHex: convertRGBToHex
            }
          );
        }

        value = e.target.getAttribute('data-mce-color');
        if (value) {
          if (this.lastId) {
            document.getElementById(this.lastId).setAttribute('aria-selected', false);
          }

          e.target.setAttribute('aria-selected', true);
          this.lastId = e.target.id;

          if (value == 'transparent') {
            resetColor();
          } else {
            selectColor(value);
          }
        } else if (value !== null) {
          buttonCtrl.hidePanel();
        }
      }

      function onButtonClick() {
        var self = this;

        if (self._color) {
          applyFormat(self.settings.format, self._color);
        } else {
          removeFormat(self.settings.format);
        }
      }

      editor.addButton('forecolor', {
        type: 'colorbutton',
        tooltip: 'Text color',
        format: 'forecolor',
        panel: {
          origin: 'forecolor',
          role: 'application',
          ariaRemember: true,
          html: renderColorPicker,
          onclick: onPanelClick
        },
        onclick: onButtonClick
      });

      editor.addButton('backcolor', {
        type: 'colorbutton',
        tooltip: 'Background color',
        format: 'hilitecolor',
        panel: {
          origin: 'backcolor',
          role: 'application',
          ariaRemember: true,
          html: renderColorPicker,
          onclick: onPanelClick
        },
        onclick: onButtonClick
      });
    });

    return function () { };
  }
);
dem('tinymce.plugins.textcolor.Plugin')();
})();
