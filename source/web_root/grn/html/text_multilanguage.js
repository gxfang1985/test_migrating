function MultiLanguageText(element_id, params, input_style) {
    this.element_id = element_id;
    this.params = params;
    this.rest_choices = this.getNotExistLangs();
    this.input_style = input_style;
    this.initButtonClick();
}
MultiLanguageText.prototype = {

    getExistLangs : function() {
        var self = this;
        var results = [];
        var len = this.params.choices.length;
        for(var i=0;i<len;i++){
            if(jQuery("#" + self.element_id + "-label-line-button-" + this.params.choices[i]).length > 0)
            {
                results.push(this.params.choices[i]);
            }
        }
        return results;
    },
    getNotExistLangs : function() {
        var self = this;
        var results = [];
        var len = this.params.choices.length;
        for(var i=0;i<len;i++){
            if(jQuery("#" + self.element_id + "-label-line-button-" + this.params.choices[i]).length <= 0)
            {
                results.push(this.params.choices[i]);
            }
        }
        return results;
    },
    attachAddButtonClick : function() {
        var self = this;
        if (jQuery("#" + this.element_id + "-add-language").length > 0) {
            function handler() {
                if (jQuery("#" + self.element_id + "-edit-line").length > 0) {
                    var elm_select = jQuery("#" + self.element_id + "-edit-lang");
                    var elm_text = jQuery("#" + self.element_id + "-edit-text");

                    var selectedLanguage = elm_select.find("option:selected").val();
                    var new_label_line = self.createLabelLine(selectedLanguage, elm_text.val());
                    jQuery("#" + self.element_id + "-label-lines").append(new_label_line);

                    jQuery("#" + self.element_id + "-edit-line").remove();
                    self.rest_choices = self.rest_choices.filter(function(arg) {
                        return arg != selectedLanguage;
                    });
                }
                if (self.rest_choices.length >= 0) {
                    jQuery("#" + self.element_id + "-label-lines").append(
                        self.createEditLine(self.rest_choices));
                }
                if (self.rest_choices.length == 1 ) {
                    jQuery("#" + self.element_id + "-label-lines").append(
                        self.createLabelLine(self.rest_choices.pop(), ""));
                    jQuery("#" + self.element_id + "-edit-line").remove();
                }
                if (self.rest_choices.length <= 1) {
                    jQuery("#" + self.element_id + "-add-language").remove();
                }
            }
            jQuery("#" + this.element_id + "-add-language").on("click", handler);
        }
    },
    show : function() {
        this.attachAddButtonClick();
    },
    createEditLine : function(langs) {
        var line = jQuery("<tr>").attr( {
            id : this.element_id + "-edit-line"
        }).css({style : "margin:0px;"});

        var td_select = jQuery("<td>");
        var select = jQuery("<select>").attr( {
            id : this.element_id + "-edit-lang",
            name : this.element_id + "-edit-lang"
        });
        td_select.append(select);
        for ( var i = 0, langsLength = langs.length; i < langsLength; i++) {
            var option = jQuery("<option>").attr( {
                value : langs[i]
            });
            option.html(this.params.local_name[langs[i]]);
            select.append(option);
        }
        var td_textbox = jQuery("<td>");
        var textbox = jQuery("<input>").attr( {
            "id" : this.element_id + "-edit-text",
            "name" : this.element_id + "-edit",
            "type" : "text",
            "size" : "50",
            "maxlength": "100"
        });
        td_textbox.append(textbox);

        var td_remove_self_button = jQuery("<td>");
        var remove_self_button;
        if( this.input_style === "kintone" )
        {
            /*jshint scripturl:true*/
            remove_self_button = jQuery("<a>").attr( {
                href : "javascript:void(0)",
                title : this.params.resource.deleteLanguage,
                id : this.element_id + "-edit-line-remove"
            });
            var span = document.createElement("span");
            span.setAttribute("class", "icon-close-sub-grn v-allign-middle");
            remove_self_button.append(span);
        }
        else
        {
            remove_self_button = jQuery("<input>").attr( {
                id : this.element_id + "-edit-line-remove",
                type : "button",
                value : this.params.resource.deleteLanguage
            });
        }
        td_remove_self_button.append(remove_self_button);

        var self = this;
        function handler() {
            if (jQuery("#" + self.element_id + "-edit-line").length > 0) {
                jQuery("#" + self.element_id + "-edit-line").remove();
            }
            self.createAddLanguageButton();
        }
        remove_self_button.on("click", handler);

        line.append(td_select);
        line.append(td_textbox);
        line.append(td_remove_self_button);
        return line;
    },
    createLabelLine : function(lang, value) {
        var line = jQuery("<tr>").attr( {
            id : this.element_id + "-label-line-" + lang
        });

        var td_lang = jQuery("<td>").attr( {
            id : this.element_id + "-label-line-lang-" + lang
        }).css("style", "margin:10px;");
        td_lang.html(this.getLanguageLabel(lang) + ":");

        var td_text = jQuery("<td>");
        var input_value =jQuery("<input>").attr( {
            "id" : this.element_id + "-label-line-value-" + lang,
            "name" : this.element_id + "-" + lang,
            "value" : value,
            "size" : 50,
            "type" : "text",
            "maxlength" : 100
        });
        td_text.append(input_value);

        var td_button = jQuery("<td>");
        var remove_button;
        if( this.input_style === "kintone" )
        {
            /*jshint scripturl:true*/
            remove_button = jQuery("<a>").attr( {
                href : "javascript:void(0)",
                title : this.params.resource.deleteLanguage,
                id : this.element_id + "-label-line-button-" + lang
            });
            var span = document.createElement("span");
            span.setAttribute("class", "icon-close-sub-grn v-allign-middle");
            remove_button.append(span);
        }
        else
        {
            remove_button = jQuery("<input>").attr( {
                id : this.element_id + "-label-line-button-" + lang,
                value : this.params.resource.deleteLanguage,
                type : "button"
            });
        }
        td_button.append(remove_button);

        var self = this;
        function handler() {
            self.rest_choices.push(lang);
            jQuery("#" + self.element_id + "-label-line-" + lang).remove();

            if (jQuery("#" + self.element_id + "-edit-lang").length > 0) {
                // 既に表示されている言語選択のセレクトボックスに追加する
                var option = jQuery("<option>").attr( {
                    value : lang
                });
                option.html(self.params.local_name[lang]);
                jQuery("#" + self.element_id + "-edit-lang").append(option);
            }
            self.createAddLanguageButton();
        }
        remove_button.on("click", handler);

        line.append(td_lang);
        line.append(td_text);
        line.append(td_button);
        return line;
    },
    getLanguageLabel : function(languageCode){
        return this.params.local_name[languageCode];
    },
    initButtonClick : function() {
        for ( var i = 0, choicesLength = this.params.choices.length; i < choicesLength; i++) {
            lang = this.params.choices[i];
            var button = jQuery("#" + this.element_id + "-label-line-button-" + lang);
            if (button.length > 0) {
                var self = this;
                button.on("click", (function(lang) {
                    return function() {
                        self.rest_choices.push(lang);
                        jQuery("#" + self.element_id + "-label-line-" + lang).remove();

                        if (jQuery("#" + self.element_id + "-edit-lang").length > 0) {
                            // 既に表示されている言語選択のセレクトボックスに追加する
                            var option = jQuery("<option>").attr( {
                                value : lang
                            });
                            option.html(self.params.local_name[lang]);
                            jQuery("#" + self.element_id + "-edit-lang").append(option);
                        }
                        self.createAddLanguageButton();
                    };
                })(lang));
            }
        }
    },
    createAddLanguageButton : function() {
        if (jQuery("#" + this.element_id + "-add-language").length > 0)
            return;

        var button;
        if (this.input_style === "kintone" )
        {
            /*jshint scripturl:true*/
            button = jQuery("<a>").attr( {
                href : "javascript:void(0)",
                "class" : "icon_add_grn",
                id : this.element_id + "-add-language"
             }).html(this.params.resource.addLanguage);
            button.appendTo("<div></div>");
        }
        else
        {
            button = jQuery("<input>").attr( {
                type : "button",
                value : this.params.resource.addLanguage,
                id : this.element_id + "-add-language"
            });
        }
        jQuery("#" + this.element_id).append(button);
        this.attachAddButtonClick();
    }
};
