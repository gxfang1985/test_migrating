{if $design == 'Design-modern' }
    {assign var='Designmodern' value=TRUE}
{elseif $design == 'Design-modernred' }
    {assign var='Designmodernred' value=TRUE}
{elseif $design == 'Design-moderngreen' }
    {assign var='Designmoderngreen' value=TRUE}
{elseif $design == 'Design-modernbrown' }
    {assign var='Designmodernbrown' value=TRUE}
{elseif $design == 'Design-moderngray' }
    {assign var='Designmoderngray' value=TRUE}
{elseif $design == 'Design-simple' }
    {assign var='Designsimple' value=TRUE}
{elseif $design == 'Design-aquablue' }
    {assign var='Designaquablue' value=TRUE}
{elseif $design == 'Design-aquagreen'}
    {assign var='Designaquagreen' value=TRUE}
{elseif $design == 'Design-aquapink' }
    {assign var='Designaquapink' value=TRUE}
{elseif $design == 'Design-aquaorange'}
    {assign var='Designaquaorange' value=TRUE}
{elseif $design == 'Design-silver'}
    {assign var='Designsilver' value=TRUE}
{elseif $design == 'Design-black'}
    {assign var='Designblack' value=TRUE}
{elseif $design == 'Design-chocolate'}
    {assign var='Designchocolate' value=TRUE}
{elseif $design == 'Design-bluewave'}
    {assign var='Designbluewave' value=TRUE}
{elseif $design == 'Design-yellowwave'}
    {assign var='Designyellowwave' value=TRUE}
{elseif $design == 'Design-global' }
    {assign var='Designglobal' value=TRUE}
{elseif $design == 'Design-paris'}
    {assign var='Designparis' value=TRUE}
{elseif $design == 'Design-mtfuji'}
    {assign var='Designmtfuji' value=TRUE}
{elseif $design == 'Design-japanesestyle' }
    {assign var='Designjapanesestyle' value=TRUE}
{elseif $design == 'Design-fireworks'}
    {assign var='Designfireworks' value=TRUE}
{elseif $design == 'Design-inkpaint'}
    {assign var='Designinkpaint' value=TRUE}
{elseif $design == 'Design-dragon'}
    {assign var='Designdragon' value=TRUE}
{elseif $design == 'Design-bear'}
    {assign var='Designbear' value=TRUE}
{elseif $design == 'Design-cat'}
    {assign var='Designcat' value=TRUE}
{elseif $design == 'Design-polarbear'}
    {assign var='Designpolarbear' value=TRUE}
{elseif $design == 'Design-ocean'}
    {assign var='Designocean' value=TRUE}
{elseif $design == 'Design-sea'}
    {assign var='Designsea' value=TRUE}
{elseif $design == 'Design-pixel'}
    {assign var='Designpixel' value=TRUE}
{elseif $design == 'Design-geometric'}
    {assign var='Designgeometric' value=TRUE}
{elseif $design == 'Design-circles'}
    {assign var='Designcircles' value=TRUE}
{elseif $design == 'Design-bubble'}
    {assign var='Designbubble' value=TRUE}
{elseif $design == 'Design-relax'}
    {assign var='Designrelax' value=TRUE}
{elseif $design == 'Design-orange'}
    {assign var='Designorange' value=TRUE}
{elseif $design == 'Design-sweets'}
    {assign var='Designsweets' value=TRUE}
{elseif $design == 'Design-bozuman'}
    {assign var='Designbozuman' value=TRUE}
{elseif $design == 'Design-spacedesign'}
    {assign var='Designspacedesign' value=TRUE}
{elseif $design == 'Design-forest'}
    {assign var='Designforest' value=TRUE}
{elseif $design == 'Design-americancomic'}
    {assign var='Designamericancomic' value=TRUE}
{elseif $design == 'Design-classic2005'}
    {assign var='Designclassic2005' value=TRUE}
{elseif $design == 'Design-classic2011'}
    {assign var='Designclassic2011' value=TRUE}
{elseif $design == 'Design-mm'}
    {assign var='Designmm' value=TRUE}
{else}
    {assign var='Designmm' value=TRUE}
{/if}
<p>
{cb_msg module='grn.ui' key='GRN_UI-1' replace='true'}
<p>
<table class="theme_select_base_grn">
    <tr valign="top">
        {capture name='grn_ui_GRN_UI_3'}{cb_msg module='grn.ui' key='GRN_UI-3' replace='true'}{/capture}{include file='grn/ui/_design_cell.tpl' design_value='Design-mm' design_caption=$smarty.capture.grn_ui_GRN_UI_3 design_checked=$Designmm design_styles='styles/mm'}
        {capture name='grn_ui_GRN_UI_4'}{cb_msg module='grn.ui' key='GRN_UI-4' replace='true'}{/capture}{include file='grn/ui/_design_cell.tpl' design_value='Design-modern' design_caption=$smarty.capture.grn_ui_GRN_UI_4 design_checked=$Designmodern design_styles='styles/modern'}
        {capture name='grn_ui_GRN_UI_30'}{cb_msg module='grn.ui' key='GRN_UI-30' replace='true'}{/capture}{include file='grn/ui/_design_cell.tpl' design_value='Design-modernred' design_caption=$smarty.capture.grn_ui_GRN_UI_30 design_checked=$Designmodernred design_styles='styles/modernred'}
        {capture name='grn_ui_GRN_UI_31'}{cb_msg module='grn.ui' key='GRN_UI-31' replace='true'}{/capture}{include file='grn/ui/_design_cell.tpl' design_value='Design-moderngreen' design_caption=$smarty.capture.grn_ui_GRN_UI_31 design_checked=$Designmoderngreen design_styles='styles/moderngreen'}
        {capture name='grn_ui_GRN_UI_36'}{cb_msg module='grn.ui' key='GRN_UI-36' replace='true'}{/capture}{include file='grn/ui/_design_cell.tpl' design_value='Design-modernbrown' design_caption=$smarty.capture.grn_ui_GRN_UI_36 design_checked=$Designmodernbrown design_styles='styles/modernbrown'}
        {capture name='grn_ui_GRN_UI_32'}{cb_msg module='grn.ui' key='GRN_UI-32' replace='true'}{/capture}{include file='grn/ui/_design_cell.tpl' design_value='Design-moderngray' design_caption=$smarty.capture.grn_ui_GRN_UI_32 design_checked=$Designmoderngray design_styles='styles/moderngray'}
    </tr>
    <tr valign="top">
        {capture name='grn_ui_GRN_UI_5'}{cb_msg module='grn.ui' key='GRN_UI-5' replace='true'}{/capture}{include file='grn/ui/_design_cell.tpl' design_value='Design-simple' design_caption=$smarty.capture.grn_ui_GRN_UI_5 design_checked=$Designsimple design_styles='styles/simple'}
        {capture name='grn_ui_GRN_UI_6'}{cb_msg module='grn.ui' key='GRN_UI-6' replace='true'}{/capture}{include file='grn/ui/_design_cell.tpl' design_value='Design-aquablue' design_caption=$smarty.capture.grn_ui_GRN_UI_6 design_checked=$Designaquablue design_styles='styles/aquablue'}
        {capture name='grn_ui_GRN_UI_7'}{cb_msg module='grn.ui' key='GRN_UI-7' replace='true'}{/capture}{include file='grn/ui/_design_cell.tpl' design_value='Design-aquagreen' design_caption=$smarty.capture.grn_ui_GRN_UI_7 design_checked=$Designaquagreen design_styles='styles/aquagreen'}
        {capture name='grn_ui_GRN_UI_8'}{cb_msg module='grn.ui' key='GRN_UI-8' replace='true'}{/capture}{include file='grn/ui/_design_cell.tpl' design_value='Design-aquapink' design_caption=$smarty.capture.grn_ui_GRN_UI_8 design_checked=$Designaquapink design_styles='styles/aquapink'}
        {capture name='grn_ui_GRN_UI_9'}{cb_msg module='grn.ui' key='GRN_UI-9' replace='true'}{/capture}{include file='grn/ui/_design_cell.tpl' design_value='Design-aquaorange' design_caption=$smarty.capture.grn_ui_GRN_UI_9 design_checked=$Designaquaorange design_styles='styles/aquaorange'}
        {capture name='grn_ui_GRN_UI_10'}{cb_msg module='grn.ui' key='GRN_UI-10' replace='true'}{/capture}{include file='grn/ui/_design_cell.tpl' design_value='Design-silver' design_caption=$smarty.capture.grn_ui_GRN_UI_10 design_checked=$Designsilver design_styles='styles/silver'}
    </tr>
    <tr valign="top">
        {capture name='grn_ui_GRN_UI_11'}{cb_msg module='grn.ui' key='GRN_UI-11' replace='true'}{/capture}{include file='grn/ui/_design_cell.tpl' design_value='Design-black' design_caption=$smarty.capture.grn_ui_GRN_UI_11 design_checked=$Designblack design_styles='styles/black'}
        {capture name='grn_ui_GRN_UI_12'}{cb_msg module='grn.ui' key='GRN_UI-12' replace='true'}{/capture}{include file='grn/ui/_design_cell.tpl' design_value='Design-chocolate' design_caption=$smarty.capture.grn_ui_GRN_UI_12 design_checked=$Designchocolate design_styles='styles/chocolate'}
        {capture name='grn_ui_GRN_UI_40'}{cb_msg module='grn.ui' key='GRN_UI-40' replace='true'}{/capture}{include file='grn/ui/_design_cell.tpl' design_value='Design-bluewave' design_caption=$smarty.capture.grn_ui_GRN_UI_40 design_checked=$Designbluewave design_styles='styles/bluewave'}
        {capture name='grn_ui_GRN_UI_41'}{cb_msg module='grn.ui' key='GRN_UI-41' replace='true'}{/capture}{include file='grn/ui/_design_cell.tpl' design_value='Design-yellowwave' design_caption=$smarty.capture.grn_ui_GRN_UI_41 design_checked=$Designyellowwave design_styles='styles/yellowwave'}
        {capture name='grn_ui_GRN_UI_13'}{cb_msg module='grn.ui' key='GRN_UI-13' replace='true'}{/capture}{include file='grn/ui/_design_cell.tpl' design_value='Design-global' design_caption=$smarty.capture.grn_ui_GRN_UI_13 design_checked=$Designglobal design_styles='styles/global'}
        {capture name='grn_ui_GRN_UI_15'}{cb_msg module='grn.ui' key='GRN_UI-15' replace='true'}{/capture}{include file='grn/ui/_design_cell.tpl' design_value='Design-paris' design_caption=$smarty.capture.grn_ui_GRN_UI_15 design_checked=$Designparis design_styles='styles/paris'}
    </tr>
    <tr valign="top">
        {capture name='grn_ui_GRN_UI_17'}{cb_msg module='grn.ui' key='GRN_UI-17' replace='true'}{/capture}{include file='grn/ui/_design_cell.tpl' design_value='Design-mtfuji' design_caption=$smarty.capture.grn_ui_GRN_UI_17 design_checked=$Designmtfuji design_styles='styles/mtfuji'}
        {capture name='grn_ui_GRN_UI_16'}{cb_msg module='grn.ui' key='GRN_UI-16' replace='true'}{/capture}{include file='grn/ui/_design_cell.tpl' design_value='Design-japanesestyle' design_caption=$smarty.capture.grn_ui_GRN_UI_16 design_checked=$Designjapanesestyle  design_styles='styles/japanesestyle'}
        {capture name='grn_ui_GRN_UI_27'}{cb_msg module='grn.ui' key='GRN_UI-27' replace='true'}{/capture}{include file='grn/ui/_design_cell.tpl' design_value='Design-fireworks' design_caption=$smarty.capture.grn_ui_GRN_UI_27 design_checked=$Designfireworks  design_styles='styles/fireworks'}
        {capture name='grn_ui_GRN_UI_18'}{cb_msg module='grn.ui' key='GRN_UI-18' replace='true'}{/capture}{include file='grn/ui/_design_cell.tpl' design_value='Design-inkpaint' design_caption=$smarty.capture.grn_ui_GRN_UI_18 design_checked=$Designinkpaint design_styles='styles/inkpaint'}
        {capture name='grn_ui_GRN_UI_19'}{cb_msg module='grn.ui' key='GRN_UI-19' replace='true'}{/capture}{include file='grn/ui/_design_cell.tpl' design_value='Design-dragon' design_caption=$smarty.capture.grn_ui_GRN_UI_19 design_checked=$Designdragon design_styles='styles/dragon'}
        {capture name='grn_ui_GRN_UI_20'}{cb_msg module='grn.ui' key='GRN_UI-20' replace='true'}{/capture}{include file='grn/ui/_design_cell.tpl' design_value='Design-bear' design_caption=$smarty.capture.grn_ui_GRN_UI_20 design_checked=$Designbear design_styles='styles/bear'}
    </tr>
    <tr valign="top">
        {capture name='grn_ui_GRN_UI_28'}{cb_msg module='grn.ui' key='GRN_UI-28' replace='true'}{/capture}{include file='grn/ui/_design_cell.tpl' design_value='Design-cat' design_caption=$smarty.capture.grn_ui_GRN_UI_28 design_checked=$Designcat design_styles='styles/cat'}
        {capture name='grn_ui_GRN_UI_33'}{cb_msg module='grn.ui' key='GRN_UI-33' replace='true'}{/capture}{include file='grn/ui/_design_cell.tpl' design_value='Design-polarbear' design_caption=$smarty.capture.grn_ui_GRN_UI_33 design_checked=$Designpolarbear design_styles='styles/polarbear'}
        {capture name='grn_ui_GRN_UI_25'}{cb_msg module='grn.ui' key='GRN_UI-25' replace='true'}{/capture}{include file='grn/ui/_design_cell.tpl' design_value='Design-ocean' design_caption=$smarty.capture.grn_ui_GRN_UI_25 design_checked=$Designocean design_styles='styles/ocean'}
        {capture name='grn_ui_GRN_UI_24'}{cb_msg module='grn.ui' key='GRN_UI-24' replace='true'}{/capture}{include file='grn/ui/_design_cell.tpl' design_value='Design-sea' design_caption=$smarty.capture.grn_ui_GRN_UI_24 design_checked=$Designsea design_styles='styles/sea'}
        {capture name='grn_ui_GRN_UI_37'}{cb_msg module='grn.ui' key='GRN_UI-37' replace='true'}{/capture}{include file='grn/ui/_design_cell.tpl' design_value='Design-pixel' design_caption=$smarty.capture.grn_ui_GRN_UI_37 design_checked=$Designpixel design_styles='styles/pixel'}
        {capture name='grn_ui_GRN_UI_38'}{cb_msg module='grn.ui' key='GRN_UI-38' replace='true'}{/capture}{include file='grn/ui/_design_cell.tpl' design_value='Design-geometric' design_caption=$smarty.capture.grn_ui_GRN_UI_38 design_checked=$Designgeometric design_styles='styles/geometric'}
    </tr>
    <tr valign="top">
        {capture name='grn_ui_GRN_UI_42'}{cb_msg module='grn.ui' key='GRN_UI-42' replace='true'}{/capture}{include file='grn/ui/_design_cell.tpl' design_value='Design-circles' design_caption=$smarty.capture.grn_ui_GRN_UI_42 design_checked=$Designcircles design_styles='styles/circles'}
        {capture name='grn_ui_GRN_UI_34'}{cb_msg module='grn.ui' key='GRN_UI-34' replace='true'}{/capture}{include file='grn/ui/_design_cell.tpl' design_value='Design-bubble' design_caption=$smarty.capture.grn_ui_GRN_UI_34 design_checked=$Designbubble design_styles='styles/bubble'}
        {capture name='grn_ui_GRN_UI_23'}{cb_msg module='grn.ui' key='GRN_UI-23' replace='true'}{/capture}{include file='grn/ui/_design_cell.tpl' design_value='Design-relax' design_caption=$smarty.capture.grn_ui_GRN_UI_23 design_checked=$Designrelax design_styles='styles/relax'}
        {capture name='grn_ui_GRN_UI_22'}{cb_msg module='grn.ui' key='GRN_UI-22' replace='true'}{/capture}{include file='grn/ui/_design_cell.tpl' design_value='Design-orange' design_caption=$smarty.capture.grn_ui_GRN_UI_22 design_checked=$Designorange design_styles='styles/orange'}
        {capture name='grn_ui_GRN_UI_29'}{cb_msg module='grn.ui' key='GRN_UI-29' replace='true'}{/capture}{include file='grn/ui/_design_cell.tpl' design_value='Design-sweets' design_caption=$smarty.capture.grn_ui_GRN_UI_29 design_checked=$Designsweets design_styles='styles/sweets'}
        {capture name='grn_ui_GRN_UI_21'}{cb_msg module='grn.ui' key='GRN_UI-21' replace='true'}{/capture}{include file='grn/ui/_design_cell.tpl' design_value='Design-bozuman' design_caption=$smarty.capture.grn_ui_GRN_UI_21 design_checked=$Designbozuman design_styles='styles/bozuman'}
    </tr>
    <tr valign="top">
        {capture name='grn_ui_GRN_UI_14'}{cb_msg module='grn.ui' key='GRN_UI-14' replace='true'}{/capture}{include file='grn/ui/_design_cell.tpl' design_value='Design-spacedesign' design_caption=$smarty.capture.grn_ui_GRN_UI_14 design_checked=$Designspacedesign  design_styles='styles/spacedesign'}
        {capture name='grn_ui_GRN_UI_35'}{cb_msg module='grn.ui' key='GRN_UI-35' replace='true'}{/capture}{include file='grn/ui/_design_cell.tpl' design_value='Design-forest' design_caption=$smarty.capture.grn_ui_GRN_UI_35 design_checked=$Designforest design_styles='styles/forest'}
        {capture name='grn_ui_GRN_UI_39'}{cb_msg module='grn.ui' key='GRN_UI-39' replace='true'}{/capture}{include file='grn/ui/_design_cell.tpl' design_value='Design-americancomic' design_caption=$smarty.capture.grn_ui_GRN_UI_39 design_checked=$Designamericancomic design_styles='styles/americancomic'}
        {capture name='grn_ui_GRN_UI_43'}{cb_msg module='grn.ui' key='GRN_UI-43' replace='true'}{/capture}{include file='grn/ui/_design_cell.tpl' design_value='Design-classic2011' design_caption=$smarty.capture.grn_ui_GRN_UI_43 design_checked=$Designclassic2011 design_styles='styles/classic2011'}
        {capture name='grn_ui_GRN_UI_26'}{cb_msg module='grn.ui' key='GRN_UI-26' replace='true'}{/capture}{include file='grn/ui/_design_cell.tpl' design_value='Design-classic2005' design_caption=$smarty.capture.grn_ui_GRN_UI_26 design_checked=$Designclassic2005 design_styles='styles/classic2005'}
        <td class="theme_blank_grn" ></td>
    </tr>
</table>
<p>
 {capture name='grn_ui_GRN_UI_2'}{cb_msg module='grn.ui' key='GRN_UI-2' replace='true'}{/capture}{grn_button_submit class="line" caption=$smarty.capture.grn_ui_GRN_UI_2}
 {grn_button_cancel class="line"}
</p>
