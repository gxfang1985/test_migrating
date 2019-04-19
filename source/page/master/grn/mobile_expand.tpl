{*********************************************************
  @ para:$name                       string
  @ para:$title                      string
  @ para:$contents                   string
  @ para:$contents_class             string
  @ para:$default                    string("open" or "close")
**********************************************************}
{grn_load_javascript file="grn/html/component/mobile_expand.js"}
<script language="JavaScript" type="text/javascript">
<!--
    new grn.component.mobile_expand.MobileExpand("{$name}");
//-->
</script>


<div id="{$name}_mobile_expand_opener">
    <a href="#" class="mobile_switch_link_grn" id="{$name}_mobile_expand_link">
        {if $default eq "open"}
            {assign var='mobile_expand_icon_class' value='mobile_arrow_inline_up_grn'}
        {/if}
        {if $default eq "close"}
            {assign var='mobile_expand_icon_class' value='mobile_arrow_inline_down_grn'}
        {/if}
        {** Do not break a line for design **}
        <span class="{$mobile_expand_icon_class}" id="{$name}_mobile_expand_icon"></span><span>{$title}</span>
    </a>
</div>
<div class="{$contents_class}" id="{$name}_mobile_expand_contents" {if $default eq "close"}style="display: none;"{/if}>
    {$contents|smarty:nodefaults}
</div>