{*
 *  @param  string  design_value    デザイン指定文字列
 *  @param  string  design_caption  デザインタイトル
 *  @param  string  design_checked  選択されているか
 *  @param  string  design_body     全体背景色
 *  @param  string  design_hdimage  ヘッダ画像色
 *  @param  string  design_header   ヘッダ背景色
 *  @param  string  design_sitepos  サイトポジション背景色
 *  @param  string  design_menubar  メニューバー背景色
 *  @param  string  design_portlet  ポートレットタイトル背景色
 *  @param  string  design_footer   フッタ背景色
 *  @param  string  class_header    ヘッダCSSクラス
 *  @param  string  class_sitepos   サイトポジションCSSクラス
 *  @param  string  class_menubar   メニューバーCSSクラス
 *  @param  string  class_portlet   ポートレットタイトルCSSクラス
 *  @param  string  class_footer    フッタCSSクラス
 *}

<td id='td_{$design_value}' align="center" nowrap>
    {grn_radio name='design' id=$design_value value=$design_value caption=$design_caption checked=$design_checked onclick="clickDesignRadio('"|cat:$design_value|cat:"')"}
    <br>
    {grn_image image=$design_styles|cat:".jpg" class="design_thumbnail" noborder="1" onclick="clickDesignImage('"|cat:$design_value|cat:"')"}
</td>
{if $design_checked}
    {literal}
    <script language="JavaScript" type="text/javascript">
    <!--
        clickDesignImage("{/literal}{$design_value}{literal}");
    // -->
    </script>
    {/literal}
{/if}
