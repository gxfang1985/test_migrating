{*
This file includes the bundled common JS file and
the JS files written in ES5 which a new ES6 class inherites from them.

For example:
Assuming you implement a new ES6 class which extends from "grn.component.EditableTable" component,
so the "grn/html/component/editable_table.js" file should be included in "_common_js.tpl" file,
otherwise you will meet the error about inheritance when the page is loading.
*}

{*
Prevent duplicate module loaded multiple times
Ref. Webpack config: optimization.runtimeChunk: "single"
https://webpack.js.org/configuration/optimization/#optimization-runtimechunk
*}
{grn_load_javascript file="js/dist/runtime.js"}

{* common modules shared between multiple entry points *}
{grn_load_javascript file="js/dist/commons_chunk.js"}

{* common entry *}
{if $mobile}
    {grn_load_javascript file="js/dist/common_mobile.js"}
{else}
    {grn_load_javascript file="js/dist/common.js"}
{/if}