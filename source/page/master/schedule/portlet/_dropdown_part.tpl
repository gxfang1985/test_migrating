{grn_load_css file="grn/html/fag_tree_26.css"} 

<table id="group-select{$portlet.plid}" border="0" cellspacing="0" cellpadding="0" class="wrap_dropdown_menu">
  <tbody>
	<tr height="20" >
      <td id="title{$portlet.plid}" class="dropdown_menu_current" height="20" nowrap>{$default_group_name}</td>
      <td id="user-button{$portlet.plid}" class="dropdown_menu_user" style="margin:0px;paddig:0px;" valign="center" aligh="left" width="37" height="20">
	    <img src="{$app_path}/grn/image/cybozu/user-dropdown30x20.gif?{$build_date}" style="margin:0px;paddig:0px;" border="0"/>
	  </td>
	  <td id="facility-button{$portlet.plid}" class="dropdown_menu_facility" style="margin:0px;paddig:0px;" valign="center" aligh="left" width="37" height="20">
	    <img src="{$app_path}/grn/image/cybozu/facility-dropdown30x20.gif?{$build_date}" style="margin:0px;paddig:0px;" border="0"/>
	  </td>
	</tr>
  </tbody>
</table>
<div id="user-popup{$portlet.plid}" class="wrap_dropdown_option"></div>
<div id="facility-popup{$portlet.plid}" class="wrap_dropdown_option"></div>
<div id="dummy-popup{$portlet.plid}" class="wrap_dropdown_option"></div>
<div></div>
<div id="facility-popup{$portlet.plid}-dummy_root" style="border:1px solid #000000; top:-10000px; left:-10000px; position:absolute; background-color:#FFFFFF; overflow:scroll; width:1px;height:1px;">
  <div id="facility-popup{$portlet.plid}-dummy_tree_wrap_tree1" class="wrap_tree1">
    <div id="facility-popup{$portlet.plid}-dummy_tree_wrap_tree2" class="wrap_tree2">
      <div id="facility-popup{$portlet.plid}-dummy_tree"></div>
    </div>
  </div>
</div>
<script type="text/javascript">
{literal}

(function () {

    var group_select_id    = 'group-select{/literal}{$portlet.plid}{literal}';
    var title_id           = 'title{/literal}{$portlet.plid}{literal}';
    var user_button_id     = 'user-button{/literal}{$portlet.plid}{literal}';
    var facility_button_id = 'facility-button{/literal}{$portlet.plid}{literal}';
    var user_popup_id      = 'user-popup{/literal}{$portlet.plid}{literal}';
    var facility_popup_id  = 'facility-popup{/literal}{$portlet.plid}{literal}';
    var is_multi_view      = {/literal}{if $page_info.last == 'personal_week' or $page_info.last == 'personal_day'}true{else}false{/if}{literal};

    var dropdown = new GRN_DropdownMenu(
        group_select_id, title_id, user_button_id, facility_button_id,
        {/literal}{if $prefer_fg_button}GRN_DropdownMenu.prototype.PreferFacilityGroup{else}GRN_DropdownMenu.prototype.PreferOrganization{/if}{literal},
        user_popup_id, facility_popup_id,
        clickOrganizationCallback, clickFacilityGroupCallback,
        "{/literal}{$app_path}/grn/html/space.html?{$build_date}{literal}" );

    function updateTitle( title ) {
        var old_width = $(group_select_id).getWidth();
        $(group_select_id).setStyle( {'width':''} );
        $(title_id).update( title );
        if( old_width > $(group_select_id).getWidth() ) {
            $(group_select_id).setStyle( { 'width': old_width +"px"} );
        }
    }

    function clickOrganizationCallback( group_item ) {
        return function(){
            updateTitle( group_item.name )
            dropdown.organization.hide();
            
            if (is_multi_view) {
                
                jQuery(document).trigger("scheduler.select_user_org_facility_dropdownlist.select", {gid: group_item.gid, target: dropdown});
                return;
            }
            
            location.href = "{/literal}{grn_pageurl page=$detail_page_url}{literal}"+ '&bdate=' + document.forms["{/literal}{$form_name}{literal}"].bdate.value + '&gid='+group_item.gid;
        }
    }

    function clickFacilityGroupCallback( node ) {
        if( node.extra_param ) { //よく使う施設グループ or 最近選択した施設グループ
            updateTitle( node.label );
        }
        else {
            if( node.oid == 'f' ) {
                updateTitle( '{/literal}{cb_msg module='grn.schedule.portlet' key='GRN_SCH_PO-246' replace='true'}{literal}' );
            }else{
                updateTitle(  node.label + ' {/literal}{cb_msg module='grn.schedule.portlet' key='GRN_SCH_PO-247' replace='true'}{literal}' );
            }
        }
        dropdown.facility.hide();

        var oid = node.oid;
        if( oid.substr(0, 1) == 'x' ) {
            oid = oid.substr( 1 );
        }

        if (is_multi_view) {
            var gid = "f" + oid;
            jQuery(document).trigger("scheduler.select_user_org_facility_dropdownlist.select", {
                gid: gid,
                target: dropdown,
                node: node
            });
            return;
        }
        
        location.href = "{/literal}{grn_pageurl page=$detail_page_url}{literal}"+ '&bdate=' + document.forms["{/literal}{$form_name}{literal}"].bdate.value + '&gid=f'+oid + '&p='+node.extra_param;
    }
    dropdown.initializeOrganization(
        new Array(
            {/literal}{grn_display_organization_json_list group_list=$group}{literal}
                 ) );

    var group_select_width = dropdown.organization.getWidth( $(title_id).getWidth() );
    $(group_select_id).setStyle( {'width': group_select_width +"px"} );

    dropdown.updateTitle = updateTitle;

    dropdown.initializeFacilityGroup( { 'page_name': "{/literal}{if $page_name}{$page_name}{else}portlet{$portlet.plid}{/if}{literal}",
                                        'ajax_path':'{/literal}{cb_pageurl page=$ftree_async_page}{literal}',
                                        'csrf_ticket':'{/literal}{$csrf_ticket}{literal}',
                                        'callback':clickFacilityGroupCallback,
                                        'selectedOID':"{/literal}{$fgroup_selected_id}{literal}",
                                        'title_width': $(title_id).getWidth(),
                                        'node_info':
                                        {/literal}{grn_display_facilitygroup_json_list fgroup_list=$fgroup_list}{literal}
                                      });
}());

{/literal}</script>
