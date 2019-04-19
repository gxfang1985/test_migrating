<div class="overlay-grn" style="display:none;" id="background"></div>
<div id="categorySelect" class="overlayWindow msgbox overlay-categorySelector-grn" style="display:none;">
  <div class="title">{cb_msg module="grn.space" key="space-category-set-1" replace="true"}<a href="#" id="categorySelect-closeButton" class="overlayCloseButton">{grn_image image='close20.gif'}</a></div>
  <div class="content">
    <!-- tree part -->
      <div id="tree_view" class="tree_view overlay-categorySelector-tree-grn" style="margin:20px;">
        {include file='grn/org_tree_26.tpl' folder_tree=$folder_tree}
      </div>
    <!-- end of tree part -->
  </div>
  <div class="command">
      {strip}
          {capture name="grn_space_space_category_set_2"}{cb_msg module="grn.space" key="space-category-set-2" replace="true"}{/capture}
          {grn_button  id='categorySelect-OK' ui='main' caption=$smarty.capture.grn_space_space_category_set_2 spacing='normal'}
          {capture name="grn_space_space_category_set_3"}{cb_msg module="grn.space" key="space-category-set-3" replace="true"}{/capture}
          {grn_button  id='categorySelect-Cancel' ui='normal' caption=$smarty.capture.grn_space_space_category_set_3 spacing='normal'}
      {/strip}
  </div>
</div>
<script>{literal}
    grn.base.namespace("grn.page.space.create");

grn.page.space.create.overlay = new grn.component.Overlay("background", "categorySelect");
grn.page.space.create.overlay.setOnClickCancel(function(event){
    grn.page.space.create.overlay.hide();
});
grn.page.space.create.overlay.setOnClickOK(function(event){
    grn.page.space.create.overlay.hide();
});

grn.page.space.create.overlay.setOnClickCancel(function(event){
    grn.page.space.create.overlay.hide();
});

grn.page.space.create.onClickCategoryTree = function(categoryId){
    if(categoryId != "top"){
        jQuery("#categoryName").html(grn.page.space.create.categoryDataMaster[categoryId].name.replace(/&/g,'&amp;').replace(/</g,'&lt;').replace(/>/g,'&gt;'));
        jQuery("#id-cid").val(categoryId);
        obj_category_tree.selectNode(categoryId);
        grn.page.space.create.overlay.hide();
    }
};

grn.page.space.create.categoryDataMaster = JSON.parse('{/literal}{$category_data_master|escape:javascript}{literal}');

YAHOO.util.Event.onDOMReady(function(){
    jQuery("#showCategoryOverlay").on("click", function(event){
        grn.page.space.create.overlay.show(); 
    });
    var categoryId = {/literal}'{$category_id|escape:javascript}'{literal};
    if(grn.page.space.create.categoryDataMaster.hasOwnProperty(categoryId)){
        jQuery("#categoryName").html(grn.page.space.create.categoryDataMaster[categoryId]["name"].replace(/&/g,'&amp;').replace(/</g,'&lt;').replace(/>/g,'&gt;'));
    }
});
{/literal}</script>
