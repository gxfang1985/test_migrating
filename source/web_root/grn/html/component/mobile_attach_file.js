// namespace
grn.base.namespace("grn.component.mobile_attach_file");
(function () {
    var G = grn.component.mobile_attach_file;
    if (G.is_loaded)
    {
        return;
    }

    // Click checkbox to select or unselect a file.
    $(document).on("click", "#file_checkbox", function() {
        var file_div = $(this).parents("div.mobile-attachmentArea-grn").get(0);
        // If file has been selected, disable file select button; If not, enable button.
        if ( $('#file_checkbox').hasClass("mobile-checkboxOff-todo-grn") )
        {
            // Disable file select button.
            G.toggleButtons(file_div, true);
            $("input[name='attached_file']").val(1);
        }
        else
        {
            // Enable file select button.
            G.toggleButtons(file_div, false);
            $("input[name='attached_file']").val(0);
        }
    });

    // When input file value was changed.
    G.onSelected = function(form, obj)
    {
        if (form)
        {
            var file_div = document.getElementById(form.name + "_file");
            // Disable file select button.
            G.init(file_div);
            if (obj.value)
            {
                G.toggleButtons(file_div, true);
                $("input[name='attached_file']").val(1);
                var name = G.getFileName(obj.value);
                G.showFileName(file_div, name);
            }
        }
    };

    // Split file path to get file name.
    G.getFileName = function(path)
    {
        var pos1 = path.lastIndexOf('/');
        var pos2 = path.lastIndexOf('\\');
        var pos  = Math.max(pos1, pos2);
        if( pos<0 )
            return path;
        else
            return path.substring(pos+1);
    };

    // Create selected file div.
    G.showFileName = function(parent, name)
    {
        if (parent)
        {
            /* The follow DIV will be created.
            <div class="mobile-uppedAttachment-grn">
              <span class="mobile-filename-grn">
                <label for="xx">
                  <a id="file_checkbox" href="javascript:void(0);" class="mobile-checkbox-normal-grn"></a>
                  <input name="attached_file" id="xx" type="checkbox" data-role="none" class="mobile-input-grn" checked="checked"/>
                </label>
                <span class="mobile-icon-attachmentArea-grn"></span>
                <span>aaaaa.xlsx</span>
              </span>
            </div>
            */
            var div = document.createElement("div");
            div.setAttribute("class", "mobile-uppedAttachment-grn");

            var span = document.createElement("span");
            span.setAttribute("class", "mobile-filename-grn");

            var label = document.createElement("label");
            var checkbox = document.createElement('a');
            var input = document.createElement("input");
            var checkbox_id = parent.id + "_checkbox";

            label.setAttribute("for", checkbox_id);
            checkbox.setAttribute("id", "file_checkbox");
            checkbox.setAttribute("href", 'javascript:void(0);');
            checkbox.setAttribute("class", "mobile-checkbox-normal-grn");

            input.setAttribute("name", "attached_file");
            input.setAttribute("id", checkbox_id);
            input.setAttribute("type", "checkbox");
            input.setAttribute("data-role", "none");
            input.setAttribute("class", "mobile-input-grn");
            input.setAttribute("checked", "checked");

            label.appendChild(checkbox);
            label.appendChild(input);
            span.appendChild(label);

            var icon = document.createElement("span");
            icon.setAttribute("class", "mobile-icon-attachmentArea-grn");
            span.appendChild(icon);

            var file_name = document.createElement("span");
            $(file_name).text(name);
            span.appendChild(file_name);
            $(file_name).css({'display':'inline'});

            div.appendChild(span);
            parent.appendChild(div);
        }
    };

    G.toggleButtons = function(parent, disable)
    {
        if (parent)
        {
            var select_file_div = $(parent).find("div.mobile-selectAttachment-grn").get(0);
            if (disable)
            {
                if ( ! $(select_file_div).hasClass("ui-disabled") )
                {
                    $(select_file_div).addClass("ui-disabled");
                }
            }
            else
            {
                if ( $(select_file_div).hasClass("ui-disabled") )
                {
                    $(select_file_div).removeClass("ui-disabled");
                }
            }
        }
    };

    G.init = function(parent)
    {
        if (parent)
        {
            var div = $(parent).find(".mobile-uppedAttachment-grn").get(0);
            if (div)
            {
                parent.removeChild(div);
            }
        }
    };

    // delete fileselect
    G.attachedDelete = function( id )
    {
        var p = document.getElementById( id );
        if( p ) {
            p.innerHTML = '';
            p.style.display = 'none';
        }
    };

    G.is_loaded = true;
})();
