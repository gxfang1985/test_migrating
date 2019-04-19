{include file='grn/head.tpl'}
{include file='grn/header_no_siteposition.tpl'}

{include file='link/_title_search.tpl'}

<div class="mainarea">
    {assign var='form_name' value=$smarty.template|basename}
    <div id="menu_part">
        {if $management || $is_root || $type == 'personal'}
            <div id="smart_main_menu_part">
                {if $is_root || $type == 'personal'}
                    <span class="menu_item">{capture name='grn_link_GRN_LNK_102'}{cb_msg module='grn.link' key='GRN_LNK-102' replace='true'}{/capture}{grn_link image='linklist20.gif' element_id='link-add' page='link/add' cid=$category_id caption=$smarty.capture.grn_link_GRN_LNK_102}</span>
                    <span class="menu_item">{capture name='grn_link_GRN_LNK_103'}{cb_msg module='grn.link' key='GRN_LNK-103' replace='true'}{/capture}{grn_link image='write20.gif' page='link/separator_add' cid=$category_id caption=$smarty.capture.grn_link_GRN_LNK_103}</span>
                    <span class="menu_item">{capture name='grn_link_GRN_LNK_104'}{cb_msg module='grn.link' key='GRN_LNK-104' replace='true'}{/capture}{grn_link image='category20.gif' page='link/category_add' pcid=$category_id caption=$smarty.capture.grn_link_GRN_LNK_104}</span>
                {/if}
                <span class="menu_item">
                    {include file='link/_display_options.tpl'}
                </span>
            </div>
        {/if}

    <div id="smart_rare_menu_part" style="white-space:nowrap;">
        {capture name='grn_link_GRN_LNK_7'}{cb_msg module='grn.link' key='GRN_LNK-7' replace='true'}{/capture}{grn_simple_search caption=$app_name|cat:$smarty.capture.grn_link_GRN_LNK_7 name='search_text' action='link/search' page='link/search' cid=$category_id type=$type}
    </div>
</div>


<table class="maincontents_list">
    <tbody>
        <tr>
            <td class="maincontents_list_td">
                <table style="width:100%">
                    <tr valign="top">
                        <td id="tree_part">
                            {include file='grn/org_tree_26.tpl'}
                            <script language="javascript">
                            {literal}
                            obj_folder_tree.original_createNode = obj_folder_tree.createNode;

                            obj_folder_tree.createNode = function(node_info){
                                var node = obj_folder_tree.original_createNode(node_info);
                                // replace caption of virtual categories
                                if(node_info.oid == 'personal_1' || node_info.oid == 'share_1' ){
                                    var tmp_ele = document.createElement("div");
                                    tmp_ele.innerHTML = node.html;
                                    var current_html = jQuery(tmp_ele).find("a").get(0);
                                    var new_html = document.createElement("div");
                                    new_html.setAttribute("class", "sub_title");
                                    new_html.innerHTML = current_html.innerHTML.replace(/(\(\d+\))/,'');
                                    jQuery(current_html).replaceWith( new_html );

                                    node.initContent(tmp_ele.innerHTML);
                                }

                                return node;
                            };

                            {/literal}

                            {if $tree_init}
                                {literal}
                                YAHOO.util.Event.onDOMReady(function(){
                                        // auto expading virtual categories
                                        obj_folder_tree.getTree().getRoot().children.each(function(node){
                                        node.expand();
                                    });
                                });
                                {/literal}
                            {/if}
                            </script>
                            {***
                            {if ! $is_root}
                               {if $type == 'personal'}<div class="sub_title">{cb_msg module='grn.link' key='GRN_LNK-110' replace='true'}</div>{/if}
                               {if $type == 'share'}<div class="sub_title">{cb_msg module='grn.link' key='GRN_LNK-111' replace='true'}</div>{/if}
                               <hr size="1">
                               <div class="tree_item">
                                   {capture name='grn_link_GRN_LNK_112'}{cb_msg module='grn.link' key='GRN_LNK-112' replace='true'}{/capture}{grn_link image='category20.gif' page=$page_info.all cid=$parent_cid type=$type caption=$smarty.capture.grn_link_GRN_LNK_112}
                               </div>
                               <hr size="1">
                            {/if}

                            {if $is_root || $type == 'personal'}
                                <div class="sub_title">{if $is_root}{cb_msg module='grn.link' key='GRN_LNK-113' replace='true'}{else}{cb_msg module='grn.link' key='GRN_LNK-114' replace='true'}{/if}</div>
                                {foreach from=$personal_category_list item=item}
                                    <div class="tree_item">
                                        {grn_link image='category20.gif' page=$page_info.all cid=$item.cid type='personal' caption=$item.title}
                                    </div>
                                {/foreach}
                                {if $is_root || ( ! $is_root && ! $personal_category_list) }<p>{/if}
                            {/if}

                            {if $is_root || $type == 'share'}
                                <div class="sub_title">{if $is_root}{cb_msg module='grn.link' key='GRN_LNK-115' replace='true'}{else}{cb_msg module='grn.link' key='GRN_LNK-116' replace='true'}{/if}</div>
                                {foreach from=$share_category_list item=item}
                                    <div class="tree_item">
                                        {grn_link image='category20.gif' page=$page_info.all cid=$item.cid type='share' caption=$item.title}
                                    </div>
                                {/foreach}
                                {if $is_root || ( ! $is_root && ! $share_category_list) }<p>{/if}
                            {/if}
                            ***}
                        </td>
                        <td id="view_part" width="90%">
                            {if $is_root}
                                <div>
                                    <span class="sub_title">{cb_msg module='grn.link' key='GRN_LNK-117' replace='true'}</span>
                                    {capture name='grn_link_GRN_LNK_118'}{cb_msg module='grn.link' key='GRN_LNK-118' replace='true'}{/capture}{grn_link page='link/category_view' caption=$smarty.capture.grn_link_GRN_LNK_118 image='detail20.gif'}
                                </div>
                            {else}
                                <div>
                                    <span class="sub_title">{$category.title|escape}</span>
                                    {capture name='grn_link_GRN_LNK_119'}{cb_msg module='grn.link' key='GRN_LNK-119' replace='true'}{/capture}{grn_link page='link/category_view' cid=$category_id type=$type caption=$smarty.capture.grn_link_GRN_LNK_119 image='detail20.gif'}
                                </div>
                                {include file='grn/memo.tpl' category_memo=$category.memo}
                                <div class="br">&nbsp;</div>
                            {/if}
                            {if $is_root || $type != 'share'}
                                {grn_delete title=$delete_info_multi_personal.title page=$delete_info_multi_personal.page no_confirm=$delete_info_multi_personal.no_confirm data=$delete_info_multi_personal.data handler=$delete_info_multi_personal.handler multi_target=$delete_info_multi_personal.multi_target form_target=$delete_info_multi_personal.form_target}
                                <form name="{$form_name}_personal" method="post" action="{grn_pageurl page='link/delete_multi'}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
                                    <div class="list_menu">
                                        <span class="list_menu_item">{include file='grn/checkall.tpl' form_name="`$form_name`_personal" elem_name='ids[]' func_name='PersonalCheckAll'}</span>
                                        <span class="list_menu_item">{capture name='grn_link_GRN_LNK_120'}{cb_msg module='grn.link' key='GRN_LNK-120' replace='true'}{/capture}{grn_button_submit caption=$smarty.capture.grn_link_GRN_LNK_120 onclick="return false;" id='btn_delete_multi1'}</span>
                                    </div>
                                    <table class="list_column">
                                        <colgroup>
                                            <col width="1%">
                                            <col width="90%">
                                            <col width="10%" align="right">
                                        </colgroup>
                                        <tr>
                                            <th></th>
                                            <th>{cb_msg module='grn.link' key='GRN_LNK-121' replace='true'}</th>
                                            <th></th>
                                        </tr>
                                        {foreach from=$personal_link_list item=item}
                                            <tr>
                                                <td>{grn_checkbox name='ids[]' id="ids_`$item.lid`" value=$item.lid}</td>
                                                {if $item.object == 'link'}
                                                    <td>
                                                        {if $set_popup_personal}
                                                            {capture name='grn_link_GRN_LNK_122'}{cb_msg module='grn.link' key='GRN_LNK-122' replace='true'}{/capture}{grn_link_raw page=$item.url caption=$item.title truncated_caption=$subject_width target='_blank' title=$smarty.capture.grn_link_GRN_LNK_122 no_script=true}
                                                            {capture name='grn_link_GRN_LNK_123'}{cb_msg module='grn.link' key='GRN_LNK-123' replace='true'}{/capture}{grn_link_raw page=$item.url caption='' image='window20.gif' title=$smarty.capture.grn_link_GRN_LNK_123 no_script=true}
                                                        {else}
                                                            {grn_link_raw page=$item.url caption=$item.title truncated_caption=$subject_width no_script=true}
                                                            {capture name='grn_link_GRN_LNK_124'}{cb_msg module='grn.link' key='GRN_LNK-124' replace='true'}{/capture}{grn_link_raw page=$item.url caption='' image='blank20.gif' target='_blank' title=$smarty.capture.grn_link_GRN_LNK_124 no_script=true}
                                                        {/if}
                                                    </td>
                                                    <td nowrap class='personal_link_detail'>{capture name='grn_link_GRN_LNK_125'}{cb_msg module='grn.link' key='GRN_LNK-125' replace='true'}{/capture}{grn_link page='link/view' cid=$category_id lid=$item.lid type='personal' caption=$smarty.capture.grn_link_GRN_LNK_125 image='detail20.gif'}</td>
                                                {else}
                                                    <td colspan="2"><hr></td>
                                                {/if}
                                            </tr>
                                        {/foreach}
                                    </table>
                                    <input type="hidden" name="cid" value="{$category_id}">
                                    <div class="list_menu">
                                        <span class="list_menu_item">{include file='grn/checkall.tpl' form_name="`$form_name`_personal" elem_name='ids[]' func_name='PersonalCheckAll'}</span>
                                        <span class="list_menu_item">{capture name='grn_link_GRN_LNK_126'}{cb_msg module='grn.link' key='GRN_LNK-126' replace='true'}{/capture}{grn_button_submit caption=$smarty.capture.grn_link_GRN_LNK_126 onclick="return false;" id='btn_delete_multi2'}</span>
                                    </div>
                                </form>
                            {/if}

                            {if $is_root}
                                <p>
                                <div>
                                    <span class="sub_title">{cb_msg module='grn.link' key='GRN_LNK-127' replace='true'}</span>
                                    {capture name='grn_link_GRN_LNK_128'}{cb_msg module='grn.link' key='GRN_LNK-128' replace='true'}{/capture}{grn_link page='link/category_view' caption=$smarty.capture.grn_link_GRN_LNK_128 image='detail20.gif' type='share'}
                                </div>
                            {/if}
                            {if $is_root || $type == 'share'}
                                <form name="{$form_name}_share" method="post" action="{grn_pageurl page='link/operation/delete_multi'}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
                                    <table class="list_column">
                                        <colgroup>
                                            <col width="1%">
                                            <col width="90%">
                                            <col width="10%" align="right">
                                        </colgroup>
                                        <tr>
                                            {if $management}
                                                <th>{include file='grn/checkall.tpl' form_name="`$form_name`_share" elem_name='ids[]' func_name='ShareCheckAll'}</th>
                                            {else}
                                                <th>{grn_image image='spacer20.gif'}</th>
                                            {/if}
                                            <th>{cb_msg module='grn.link' key='GRN_LNK-129' replace='true'}</th>
                                            <th></th>
                                        </tr>
                                        {foreach from=$share_link_list item=item}
                                            <tr>
                                                {if $management}
                                                    <td>{grn_checkbox name='ids[]' id="ids_`$item.lid`" value=$item.lid}</td>
                                                {else}
                                                    <td></td>
                                                {/if}
                                                {if $item.object == 'link'}
                                                    <td>
                                                        {if $set_popup_share}
                                                            {if $item.sid > 0}
                                                                {grn_sso_link caption=$item.title truncated_caption=$subject_width sso_id=$item.sid app_id="link" id_list=$item.sso_param redirect_url=$item.url target='_blank'}
                                                                {grn_sso_link caption='' sso_id=$item.sid app_id="link" id_list=$item.sso_param redirect_url=$item.url image='window20.gif'}
                                                            {else}
                                                                {capture name='grn_link_GRN_LNK_130'}{cb_msg module='grn.link' key='GRN_LNK-130' replace='true'}{/capture}{grn_link_raw page=$item.url caption=$item.title truncated_caption=$subject_width target='_blank' title=$smarty.capture.grn_link_GRN_LNK_130 no_script=true}
                                                                {capture name='grn_link_GRN_LNK_131'}{cb_msg module='grn.link' key='GRN_LNK-131' replace='true'}{/capture}{grn_link_raw page=$item.url caption='' image='window20.gif' title=$smarty.capture.grn_link_GRN_LNK_131 no_script=true}
                                                            {/if}
                                                        {else}
                                                            {if $item.sid > 0}
                                                                {grn_sso_link caption=$item.title truncated_caption=$subject_width sso_id=$item.sid app_id="link" id_list=$item.sso_param redirect_url=$item.url}
                                                                {grn_sso_link caption='' sso_id=$item.sid app_id="link" id_list=$item.sso_param redirect_url=$item.url image='blank20.gif' target='_blank'}
                                                            {else}
                                                                {grn_link_raw page=$item.url caption=$item.title truncated_caption=$subject_width no_script=true}
                                                                {capture name='grn_link_GRN_LNK_132'}{cb_msg module='grn.link' key='GRN_LNK-132' replace='true'}{/capture}{grn_link_raw page=$item.url caption='' image='blank20.gif' target='_blank' title=$smarty.capture.grn_link_GRN_LNK_132 no_script=true}
                                                            {/if}
                                                        {/if}
                                                    </td>
                                                    <td nowrap class='shared-link-detail'>{capture name='grn_link_GRN_LNK_133'}{cb_msg module='grn.link' key='GRN_LNK-133' replace='true'}{/capture}{grn_link page='link/view' cid=$category_id lid=$item.lid type='share' caption=$smarty.capture.grn_link_GRN_LNK_133 image='detail20.gif'}</td>
                                                {else}
                                                    <td colspan="2"><hr></td>
                                                {/if}
                                            </tr>
                                        {/foreach}
                                    </table>

                                    {if $management}
                                        <input type="hidden" name="cid" value="{$category_id}">
                                        {capture name='grn_link_GRN_LNK_134'}{cb_msg module='grn.link' key='GRN_LNK-134' replace='true'}{/capture}{grn_button_submit caption=$smarty.capture.grn_link_GRN_LNK_134 onclick="if(!grn_is_checked(this.form,'ids[]')) return false;"}
                                    {/if}
                                </form>
                            {/if}
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </tbody>
</table>
<!--end of maincontents_list-->

{include file="grn/footer.tpl"}
