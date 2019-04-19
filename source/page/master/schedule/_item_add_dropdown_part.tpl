{grn_load_css file="grn/html/fag_tree_26.css"}

{if $use_dropdown}
{strip}
<dl id="group-select" class="selectmenu_grn selectmenu_base_grn">
    <dt>
        <a id="facility-button" href="javascript:void(0)" class="nowrap-grn">
            <span></span>
            <span id="dropdown_title" class="selectlist_selectmenu_item_grn pulldown_head">{$default_group_name}</span>
            <span id="dropdown_arrow_image" class="pulldownbutton_arrow_down_grn mLeft3"></span>
            <input type="hidden" name="pulldown_head" value="0">
        </a>
    </dt>
</dl>
{/strip}
{else}
<table id="group-select" class="wrap_dropdown_menu" cellspacing="0" cellpadding="0" border="0" style="width: 237px;">
    <tbody>
    <tr height="20">
        <td id="dropdown_title" class="dropdown_menu_current" width="auto;" height="20">{$default_group_name}</td>
        <td id="facility-button" class="dropdown_menu_facility" style="margin:0px;paddig:0px;" valign="center"  width="37" height="20">
            <img src="{$app_path}/grn/image/cybozu/facility-dropdown30x20.gif?{$build_date}" style="margin:0px;paddig:0px;" border="0"/>
        </td>
    </tr>
    </tbody>
</table>
{/if}
<div id="user-popup" class="wrap_dropdown_option"></div>
<div id="facility-popup" class="wrap_dropdown_option"></div>
<div id="dummy-popup" class="wrap_dropdown_option"></div>
<div></div>
<div id="facility-popup-dummy_root" style="border:1px solid #000000; top:-10000px; left:-10000px; position:absolute; background-color:#FFFFFF; overflow:scroll; width:1px;height:1px;">
  <div id="facility-popup-dummy_tree_wrap_tree1" class="wrap_tree1">
    <div id="facility-popup-dummy_tree_wrap_tree2" class="wrap_tree2">
      <div id="facility-popup-dummy_tree"></div>
    </div>
  </div>
</div>
<script type="text/javascript">
{literal}

(function () {

    var group_select_id    = 'group-select';
    var title_id           = 'dropdown_title';
    var user_button_id     = 'user-button';
    var facility_button_id = 'facility-button';
    var user_popup_id      = 'user-popup';
    var facility_popup_id  = 'facility-popup';

    var dropdown = new GRN_DropdownMenu(
        group_select_id, title_id, user_button_id, facility_button_id,
        {/literal}{if $prefer_fg_button}GRN_DropdownMenu.prototype.PreferFacilityGroup{else}GRN_DropdownMenu.prototype.PreferOrganization{/if}{literal},
        user_popup_id, facility_popup_id,
        clickOrganizationCallback, clickFacilityGroupCallback,
        "{/literal}{$app_path}/grn/html/space.html?{$build_date}{literal}" );

    function updateTitle( title ) {
        var group_select = jQuery("#" + group_select_id);
        var old_width = parseInt(group_select.outerWidth());
        group_select.css("width", "");
        jQuery("#" + title_id).html( title );
        if( old_width > parseInt(group_select.outerWidth()) ) {
            group_select.css("width", old_width + "px");
        }
    }

    function clickOrganizationCallback( group_item ) {
        return function(){
            updateTitle( group_item.name );
            dropdown.organization.hide();
            location.href = "{/literal}{grn_pageurl page=$detail_page_url}{literal}"+ '&bdate=' + document.forms["{/literal}{$form_name}{literal}"].bdate.value + '&gid='+group_item.gid;
        }
    }

    function clickFacilityGroupCallback( node ) {
        node.tree.fagTree.removeSpecialNode( 's' );
        if( node.extra_param ) { //よく使う施設グループ or 最近選択した施設グループ
            updateTitle( node.label );
        }
        else {
            if( node.oid == 'f' ) {
                updateTitle( '{/literal}{cb_msg module='grn.schedule' key='GRN_SCH-853' replace='true'}{literal}' );
            }else{
                updateTitle(  node.label );
            }
        }
        dropdown.facility.hide();

        var oid = node.oid;
        if( oid.substr(0, 1) == 'x' ) {
            oid = oid.substr( 1 );
        }
        grn.base.namespace("grn.component.facility_add");
        if (typeof grn.component.facility_add.get_instance === "function") {
            var facility_select = grn.component.facility_add.get_instance("facility_select");
            if (facility_select) {
                var facility_group_id = oid ? oid : 0;
                facility_select.changeCategory(facility_group_id);
                return;
            }
        }
        ChangeITEM( "{/literal}{$form_name}{literal}", {'fagid': oid } );
    }

    dropdown.initializeOrganization(
        new Array(
            {/literal}{grn_display_organization_json_list group_list=$group}{literal}
                 ) );

    var icon_size = 37;
    var min_width = 200;

    var group_select = jQuery("#" + group_select_id);
    var current_width = group_select.outerWidth();

    if ( current_width  < min_width ){
        group_select.css( "width", (min_width + icon_size) + "px" );
    }

    var title_width  = group_select.outerWidth();

    dropdown.initializeFacilityGroup( { 'page_name': "{/literal}{if $ftree_name}{$ftree_name}{else}portlet{/if}{literal}",
                                        'ajax_path':'{/literal}{cb_pageurl page=$ftree_async_page}{literal}',
                                        'csrf_ticket':'{/literal}{$csrf_ticket}{literal}',
                                        'callback':clickFacilityGroupCallback,
                                        'selectedOID':"{/literal}{$fgroup_selected_id}{literal}",
                                        'title_width': title_width,
                                        'node_info':
                                        {/literal}{grn_display_facilitygroup_json_list fgroup_list=$fgroup_list}{literal}
                                      });

    YAHOO.namespace("global");
    YAHOO.global.dropdown = dropdown;
    YAHOO.global.updateTitle = updateTitle;
}());

{/literal}</script>
