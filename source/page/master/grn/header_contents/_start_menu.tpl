{strip}
    <div id="header_pulldown_appmenu_grn" class="cloudHeader-dropdownMenu-grn header_appmenu_grn">

        <button type="button" id="header_appmenu_title_grn"
                class="header_appmenu_title_grn button_style_off_grn"
                aria-controls="header_pulldown_appmenu_base_grn"
                aria-haspopup="true" aria-expanded="false"
                title="{cb_msg module='grn' key='HEADER_APP_LAUNCHER_TITLE' replace='true'}"
                aria-label="{cb_msg module='grn' key='HEADER_APP_LAUNCHER_ARIA_LABEL' replace='true'}">
        </button>

        <div id="header_pulldown_appmenu_base_grn"
             class="cloudHeader-dropdownContents-grn"
             aria-labelledby="header_appmenu_title_grn" aria-hidden="true">
            <ul></ul>
        </div>
    </div>
    {grn_load_javascript file="grn/html/component/start_menu.js"}
{/strip}