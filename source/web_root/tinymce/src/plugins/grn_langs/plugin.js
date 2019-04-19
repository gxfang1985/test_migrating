(function() {

    tinymce.PluginManager.requireLangPack('grn_langs', tinymce.settings.language);
    /**
     * This plugin manages locale files for Garoon.
     *
     * @class tinymce.plugins.GrnLangs
     */
    tinymce.create('tinymce.plugins.GrnLangs', {

    });

    // Register plugin
    tinymce.PluginManager.add('grn_langs', tinymce.plugins.GrnLangs);
})();
