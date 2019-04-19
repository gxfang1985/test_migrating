{grn_load_css file="grn/html/report.css"}
{grn_load_css file="grn/html/msgbox.css"}
{if $address_available && $address_available_for_external}
<div class="cover" style="display:none;" id="background"></div>
<div class="msgbox" id="address_dialog" style="display:none;">
  <div id="address_dialog_title" class="title">
    {cb_msg module='grn.report' key='select_address' replace='true'}
    <a id="close_address_dialog" style="position: absolute; right: 5px;top:5px;text-decoration:none;" onclick="GRN_ReportAddress.closeAddressDialog();" href="javascript:;">{grn_image image="close20.gif"}</a>
  </div>
</div>
{/if}
 {literal}
<style type="text/css">
#spinner-loading{
  background-image : url( {/literal}{$app_path}/grn/image/cybozu/spinner.gif?{$build_date}{literal} );
}
</style>
<script language="JavaScript" type="text/javascript">
<!--
GRN_ReportPartner = {
    form: document.forms['{/literal}{$form_name}{literal}'],
    addOption: function(selected_name, text, value){
        var dst_options = this.form.elements[selected_name];

        var last = dst_options.length - 1;
        dst_options[dst_options.length] = new Option( dst_options[last].text, "" );
        dst_options[last] = new Option( text, value, false, true );
    },
    removeSelectedOptions: function(selected_name){
        RemoveMember('{/literal}{$form_name}{literal}', selected_name);
    }
};
{/literal}{if $address_available && $address_available_for_external}{literal}
YAHOO.util.Event.onDOMReady(function()
{
    GRN_ReportAddress.loadAddressDialog();
    jQuery(window).resize(function()
    {
        var body = document.body;
        jQuery('#background').width(Math.max(body.clientWidth,body.scrollWidth)).height(Math.max(body.clientHeight,body.scrollHeight));
    });
});

GRN_ReportAddress = {
    loaded: false,
    offset: 0,
    selectedAddressesHTML: '',
    bookId: null,
    index: null,
    form: document.forms['{/literal}{$form_name}{literal}'],
    openAddressDialog: function(){
        disableOnKeyDown(GRN_ReportAddress.closeAddressDialog);
        coverBackground(true);
        var dialog = jQuery('#address_dialog');

        if( ! this.loaded )
        {
            this.loadAddressDialog();
        }

        dialog.show();

        var scrollTop = document.documentElement.scrollTop || document.body.scrollTop;
        var body = ((document.documentElement.clientHeight==0)? document.getElementsByTagName('body')[0] : document.documentElement);
        dialog.css({"left": (body.clientWidth / 2) - (dialog.outerWidth() / 2), "top": (GRN_Window.getHeight() / 2) - (dialog.outerHeight() / 2) + scrollTop});
        jQuery('#st').val(jQuery('#st_hidden').val());
        updateDialogFocus("address_dialog", GRN_ReportAddress.closeAddressDialog);
    },
    loadAddressDialog: function(){
        jQuery.ajax("{/literal}{grn_pageurl page=$path_mode }{literal}", {//system

            type : "post",
            data : "",
            success  : function(data, textStatus, request)
            {
                if( ! GRN_ReportAddress.loaded )
                {
                    var headers = request.getAllResponseHeaders();
                    if(headers.match(/X-Cybozu-Error/i))
                    {
                        showErrorMessage(request);
                    }
                    else
                    {
                        jQuery('#address_dialog').append(request.responseText);
                        GRN_ReportAddress.loaded = true;
                    }
                    var url = "javascript:void(0);";
                    var nameIndex = new CharMap('char_container', 'subchar_container', ''+url+'');
                    nameIndex.writeMasterIndex();

                    {/literal}{if $selected_char}{literal}
                    CharMap.showSubIndex( '{$selected_char}', 'subchar_container', ''+url+'');
                    {/literal}{/if}{literal}

                    updateDialogFocus("address_dialog", GRN_ReportAddress.closeAddressDialog);
                    var $selectPartner = jQuery("#selected_partners select[name='s_uid_to[]']");
                    var $selectedOptions = jQuery("select[name='partner_sUID[]'] > option").clone();
                    if($selectedOptions.length > 1 && $selectPartner.length > 0) {
                        $selectPartner.empty()
                            .prepend($selectedOptions);
                    }
                }
            },
            error : function(request){
                showErrorMessage(request);
            }
        });
    },
    closeAddressDialog: function(){
        var dialog = jQuery('#address_dialog');
        dialog.hide();

        coverBackground(false);
        clearDialogFocus('address_dialog');
        enableOnKeyDown();
    },
    switchBook: function(id){
        jQuery('#st_hidden').val("");
        jQuery('#st').val("");
        if( jQuery('#tab_'+id).attr('class') != 'tab_on' ){
            this.bookId = id;

            var selected_left_tabs = document.getElementsByClassName('tab_left_on');
            var selected_tabs = document.getElementsByClassName('tab_on');
            var selected_right_tabs = document.getElementsByClassName('tab_right_on');
            for( i=0; i<selected_left_tabs.length; i++ ){
                selected_left_tabs[i].className = 'tab_left_off';
            }
            for( i=0; i<selected_tabs.length; i++ ){
                selected_tabs[i].className = 'tab_off';
            }
            for( i=0; i<selected_right_tabs.length; i++ ){
                selected_right_tabs[i].className = 'tab_right_off';
            }

            jQuery('#tab_left_'+id).attr('class','tab_left_on');
            jQuery('#tab_'+id).attr('class','tab_on');
            jQuery('#tab_right_'+id).attr('class','tab_right_on');

            this.updateAddressList(id, 0, -1, null);
        }
    },
    clickIndex: function(index){
        jQuery('#st_hidden').val("");
        jQuery('#st').val("");
        this.updateAddressList(this.getSelectedBookId(), 0, index, null);
    },
    getSelectedBookId: function(){
        if( ! this.bookId ){
            var selected_tabs = document.getElementsByClassName('tab_on');
            selected_tabs[0].id.match(/tab_(\d+)/);
            this.bookId = RegExp.$1;
        }

        return this.bookId;
    },
    updateAddressList: function(book_id, offset, index,search_text){
        this.initSelectOptions('c_uid[]');
        this.displaySpinner();
        this.index = index;
        this.selectedAddressesHTML = jQuery('#selected_partners').html();

        var params = new Object();
        params.bid = book_id;
        if( offset > 0 ){
            params.sp = offset;
        }
        if( index >= 0 ){
            params.cidx = index;
        }
        search_text = YAHOO.lang.trim(search_text);
        if(search_text != null){
            params.st = search_text;
        }

        jQuery.ajax(//'report/ajax/get_addresses'
            "{/literal}{grn_pageurl page=$path_mode_get_address}{literal}",
            {
                type: "post",
                data: params,
                success: function (data, textStatus, request){
                    var headers = request.getAllResponseHeaders();
                    if(headers.match(/X-Cybozu-Error/i))
                    {
                        showErrorMessage(request);
                    }
                    else
                    {
                        jQuery('#select_area').html(request.responseText);
                        jQuery('#selected_partners').html(GRN_ReportAddress.selectedAddressesHTML);
                        var url = "javascript:void(0);";
                        var nameIndex = new CharMap('char_container', 'subchar_container', ''+url+'');
                        nameIndex.writeMasterIndex();
                        if( jQuery('#selected_char').val() ){
                            CharMap.showSubIndex( jQuery('#selected_char').val(), 'subchar_container', ''+url+'');
                        }
                        updateDialogFocus("address_dialog", GRN_ReportAddress.closeAddressDialog);
                    }
                },
                error : function(request){
                    showErrorMessage(request);
                }
            });
    },
    displaySpinner: function(){
        jQuery('#spinner-loading-cid').show();
        var spinner_img = document.createElement( 'div' );
        spinner_img.id = 'spinner-loading';
        spinner_img.style.position = 'absolute';
        spinner_img.style.margin = '3px 0pt 0pt 3px';
        spinner_img.style.zIndex = '2';
        spinner_img.style.height = '16';
        spinner_img.style.width = '16';
        var parent_form = this.form.elements['c_uid[]'].parentNode;
        parent_form.insertBefore( spinner_img, document.getElementById('c_uid[]') );
    },
    addSelectedAddresses: function(){
        var src_options = this.form.elements['c_uid[]'];
        var dst_options = this.form.elements['s_uid_to[]'];
        for(i=0; i<src_options.length; i++){
            if( src_options[i].selected ){
                var exist = false;
                for( j=0; j<dst_options.length; j++ ){
                    if( src_options[i].value == dst_options[j].value ){
                        dst_options[j].selected = true;
                        exist = true;
                    }
                }
                if( ! exist )
                    GRN_ReportPartner.addOption('s_uid_to[]', src_options[i].text, src_options[i].value);
            }
        }
    },
    addAddressesToForm: function(){
        var src_options = this.form.elements['s_uid_to[]'];
        if( src_options.length > 1 ){
            var dst_options = this.form.elements['{/literal}{$sUID}{literal}'];
            for(i=0; i<src_options.length - 1; i++){
                var exist = false;
                for( j=0; j<dst_options.length; j++ ){
                    if( src_options[i].value == dst_options[j].value ){
                        dst_options[j].selected = true;
                        exist = true;
                        break;
                    }
                }
                if( ! exist )
                    GRN_ReportPartner.addOption('{/literal}{$sUID}{literal}', src_options[i].text, src_options[i].value);
            }
            this.closeAddressDialog();
        }
    },
    initSelectOptions: function(selected_item){
        var options = this.form.elements[selected_item];
        while(options.length > 1){
            options[0] = null;
        }
    },
    paging: function(index){
        var search_text = jQuery('#st_hidden').val();
        jQuery('#st').val(search_text);
        this.updateAddressList(this.getSelectedBookId(), index, this.index, search_text);
    },
    searchAddresses: function(){
        jQuery('#st_hidden').val(jQuery('#st').val());
        var search_text = jQuery('#st_hidden').val();
        this.updateAddressList(this.getSelectedBookId(), 0, -1, search_text);
    },
    clearSearchAddresses: function(){
        jQuery('#st_hidden').val("");
        jQuery('#st').val("");
        this.updateAddressList(this.getSelectedBookId(), 0, -1, null);
    }
};
{/literal}{/if}{literal}
//-->
</script>
 {/literal}

<table border="0" cellspacing="0">
 <tr>
  <td valign="bottom" style="padding-left:0">
   <table border="0" cellspacing="0" cellpadding="0">
    <tr>
     <td style="padding-left:0; padding-bottom:0">
<a href="javascript:OrderTop('{$form_name}', '{$sUID}')">{grn_image image='order_top20.gif' alt=''}</a><br><br><a href="javascript:OrderUp('{$form_name}', '{$sUID}')">{grn_image image='order_up20.gif' alt=''}</a><br><br><a href="javascript:OrderDown('{$form_name}', '{$sUID}')">{grn_image image='order_down20.gif' alt=''}</a><br><br><a href="javascript:OrderBottom('{$form_name}', '{$sUID}')">{grn_image image='order_bottom20.gif' alt=''}</a>
     </td>
     <td class="item_select" style="padding-bottom:0">
      <div id='user_add'>
       <select name="{$sUID}" class="user_select_list" size="13" multiple id="selectbox_selected_users_{$sUID}" >
    {foreach from=$partners key=id item=partner}
        {if $no_escape}
        <option value="{$partner->getValue()|escape}" selected>{$partner->getDisplayName()|grn_noescape}</option>
        {else}
        <option value="{$partner->getValue()|escape}" selected>{$partner->getDisplayName()|escape}</option>
        {/if}
    {/foreach}
        {if $os == 'mac' }
        <option value="">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</option>
        {else}
        <option value="">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</option>
        {/if}
       </select>
<input type="hidden" name="selected_groups_{$sUID}" value="">
<input type="hidden" name="selected_users_{$sUID}" value="">
      </div>
     </td>
    </tr>
   </table>
  </td>
  <td class="item_right_left">
   {if $address_available && $address_available_for_external}{include file='report/_char_map.tpl'}<a id="link_add_{$CID}_by_address" href="javascript:void(0);" onClick="GRN_ReportAddress.openAddressDialog();" style="width:13em">{grn_image image='person20.gif'}{cb_msg module='grn.report' key='add_partner_by_address' replace='true'}</a><br /><br />{/if}<input id="btn_add_{$CID}" type="button" value="{cb_msg module='grn.report' key='add_partner_by_string' replace='true'}" onClick="if(jQuery('#partner_name').val() != '') GRN_ReportPartner.addOption('{$sUID}', jQuery('#partner_name').val(), '{$input}'+jQuery('#partner_name').val());" />&nbsp;&nbsp;<input id="partner_name" type="text" /><br /><br /><input id="btn_rmv_{$CID}" type="button" value="{cb_msg module='grn.report' key='delete_partner' replace='true'}" onClick="{$btn_rmv_onClick|grn_noescape}GRN_ReportPartner.removeSelectedOptions('{$sUID}')" />
  </td>
 </tr>
</table>
