<div class="mobile_delete_confirm_grn">
  <span class="mobile_icon_attention_grn"></span>
  <span class="mobile_text_grn"><span>{$smarty.capture.message|escape}</span></span>
  {if $smarty.capture.title || $smarty.capture.titlecontent || $smarty.capture.count_text}
    <span class="mobile_delete_confirm_text_grn" {if $smarty.capture.count_text}id="delete_count"{/if}>
      <span class="mobile_delete_confirm_texttitle_grn">{$smarty.capture.title|escape}</span>{$smarty.capture.titlecontent|escape}
      {if $smarty.capture.count_text}
        <br/><span class="mobile_delete_confirm_texttitle_grn">{$smarty.capture.count_text|escape}</span>
      {/if}
    </span>
  {/if}
  {if $smarty.capture.explain}
    <span class="mobile_text_grn mobile_delete_confirm_point_grn">{$smarty.capture.explain|escape}</span>
  {/if}
</div>
