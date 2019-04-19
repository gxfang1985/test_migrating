{include file='grn/system_head.tpl'}
{include file='grn/system_header.tpl'}
{grn_load_css file="grn/html/schedule.css"}
{grn_load_javascript file="fw/jquery/jquery-3.2.1.min.js"}
<script language="JavaScript" type="text/javascript">
jQuery.noConflict();
</script>

{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}
{literal}
<script type="text/javascript">
<!--
(function($){
function addRow(target)
{
        var li = $('<li><a href="javascript:void(0)"><span class="event_menu_color_none_grn"></span></a></li><li><a href="javascript:void(0)"><span class="event_menu_color1_grn"></span></a></li><li><a href="javascript:void(0)"><span class="event_menu_color2_grn"></span></a></li><li><a href="javascript:void(0)"><span class="event_menu_color3_grn"></span></a></li><li><a href="javascript:void(0)"><span class="event_menu_color4_grn"></span></a></li><li><a href="javascript:void(0)"><span class="event_menu_color5_grn"></span></a></li><li><a href="javascript:void(0)"><span class="event_menu_color6_grn"></span></a></li><li><a href="javascript:void(0)"><span class="event_menu_color7_grn"></span></a></li><li><a href="javascript:void(0)"><span class="event_menu_color8_grn"></span></a></li>');
        var img = $("<a/>",{"text":'{/literal}{cb_msg module="grn.schedule.system" key="GRN_SCH_SY-580" replace="true"}{literal}'}).attr({"class":"icon-delete-grn mRight15 mLeft15","href":'javascript:void(0)'});//<img class='icon-delete-grn' src='/cbgrn/grn/image/cybozu/image-common/delete16.png' />");
        var a = $("<a/>").attr({"href":'javascript:void(0)'});
        var ul = $("<ul/>").attr({"class":'dropdownContents_grn',"style":'width: 37px; display: none;padding:0;margin:0'}).append(li);
        a.click(function(sender, e){
            $(".pulldownbutton_standard_grn dd ul").hide();
            ul.toggle();
            $(this).children(".pulldownbutton_arrow_down_grn").removeClass("pulldownbutton_arrow_down_grn").addClass("pulldownbutton_arrow_up_grn");
        });
        var input = $("<input/>").attr({"type":'text', "maxlength":'100', "size":'50', "name":'st', "class":'mTop5 mBottom5 mLeft10 mRight10'});
        var span = $("<span/>").attr({"class":'event_menu_color_none_grn mRight2'});
        var span_up_down = $("<span/>").attr({"class":'pulldownbutton_arrow_down_grn'});
        li.click(function(sender, e){
            var cla = $(this).children("a").find("span").attr('class');
            span.attr('class', '').addClass(cla+" mRight2");
            $(".pulldownbutton_standard_grn dd ul").hide();
            span_up_down.removeClass("pulldownbutton_arrow_up_grn").addClass("pulldownbutton_arrow_down_grn");
        });
        var div = $("<div/>").attr({"class":'mRight15 mLeft15'});
        var dl = $("<dl/>").attr({"class":"pulldownbutton_standard_grn mRight15 mLeft15","style":'display:inline;margin:0; padding:0'})
        .append($("<dt>").attr({"style":'margin:0;padding:0'})
            .append(
                    a.append(span).append(span_up_down)
                    )
            ).append($('<dd/>').attr({"style":'margin:0; padding:0'})
                .append(ul
                        )
                    );
           var tRow = $('<tr>');
           var tCell = $('<td>').html(input);
           var tCell2 =$('<td>').html(div.append(dl));
           var tCell3 =$('<td>').append(img);
           tRow.append(tCell);
           tRow.append(tCell2);
           tRow.append(tCell3);
                   img.bind("click",function(){tRow.remove();});

            target.append(tRow);

}
//click begin command
    $(document).ready(function(){
        $(".pulldownbutton_standard_grn dt a").click(function(e) {
            var clss = $(($(this).children())[1]).attr('class');
            $(".pulldownbutton_standard_grn dd ul").hide();
            var target = $(this).parent().parent().children("dd").find("ul");
            if(clss == 'pulldownbutton_arrow_down_grn'){
                target.toggle();
                $(this).children(".pulldownbutton_arrow_down_grn").removeClass("pulldownbutton_arrow_down_grn").addClass("pulldownbutton_arrow_up_grn");
            }else if(clss == 'pulldownbutton_arrow_up_grn'){
                $(this).children(".pulldownbutton_arrow_up_grn").removeClass("pulldownbutton_arrow_up_grn").addClass("pulldownbutton_arrow_down_grn");
            }
        });
//User click item li
        $(".pulldownbutton_standard_grn dd ul li").click(function() {
            var sel = $(this).children("a").find("span").attr('class');
            var target = $(this).parent().parent().parent().find("a").children();
            $(target[0]).attr('class', '').addClass(sel);
            $(".pulldownbutton_standard_grn dd ul").hide();
            $(target[1]).removeClass("pulldownbutton_arrow_up_grn").addClass("pulldownbutton_arrow_down_grn");
        }); 
// bin event click docment range
        $(document).bind('click', function(e) {
            var $clicked = $(e.target);
            if (! $clicked.parents().hasClass("pulldownbutton_standard_grn"))
            {
                $(".pulldownbutton_standard_grn dd ul").hide();
                $(".pulldownbutton_standard_grn dt a").children("span.pulldownbutton_arrow_up_grn").removeClass("pulldownbutton_arrow_up_grn").addClass("pulldownbutton_arrow_down_grn");
            }
        });
// bin event click delete icon
        $(".icon-delete-grn").click(function(){
            var target = $(this).parent().parent();
            target.remove();
        });
//bin event click add row icon
        $(".icon_add_grn").click(function(){
            addRow($("#tablecolor"));
        });
        
// bin data before submit to server input[type='button'].margin
        jQuery("form[name='{/literal}{$form_name}{literal}']").submit(function(){
        var value = '';
             $("#tablecolor tr").each(function(){
                if (!this.rowIndex) return;
                var text = $($(this).find("input[type=text]")).val();
                var color = $($(this).find("td").eq(1).html()).find("span:first").attr("class").replace(/\smRight2$/gi,'');
                //ver2.0
                var result = (/event_menu_color(\d+)\_grn$/i).exec(color);
                if(result != null && result.length > 0){
                    if(text != ""){ 
                        value += (text + ";#" +result[1]) + '\r\n';
                    }else if(result[1] != 0){
                        value += (text + ";#" + result[1]) + '\r\n';
                    }
                } else if(text.length > 0) {
                    value += text + ';#0\r\n';
                }
             });
             $("#menu").val(value);
            return 0;
        });
        // add new default row
        addRow($("#tablecolor"));
    }); 
})(jQuery);

//-->
</script>
{/literal}
<form id="submitform" name="{$form_name}" method="post" action="{grn_pageurl page='schedule/system/command_'|cat:$page_info.last}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
   <div class="explanation">{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-434' replace='true'}</div>
<div id="main_menu_part">

   {if count($menu) > 1}
<span class="menu_item">{capture name='grn_schedule_system_GRN_SCH_SY_583'}{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-579' replace='true'}{/capture}{grn_link page='schedule/system/menu_color_order_all' caption=$smarty.capture.grn_schedule_system_GRN_SCH_SY_583 image='order20.gif'}</span>
   {else}
<span class="menu_item">{capture name='grn_schedule_system_GRN_SCH_SY_583'}{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-579' replace='true'}{/capture}{grn_link page='schedule/system/menu_color_order_all' caption=$smarty.capture.grn_schedule_system_GRN_SCH_SY_583 image='order20.gif' disabled=TRUE}</span>
   {/if}
</div>
   

   <table class="list_column mLeft10" id="tablecolor" style="width:auto;" >
    <tr>
        <th>
        {cb_msg module='grn.schedule.system' key='GRN_SCH_SY-576' replace='true'}
        </th>
        <th style="text-align:center">
        {cb_msg module='grn.schedule.system' key='GRN_SCH_SY-577' replace='true'}
        </th>
        <th>
        &nbsp;
        </th>

    </tr>
     {foreach from=$menu key=key item=item}
    <tr>
    <td>
     {grn_text necessary=true name="st" value=$item[0] size='50' class="mTop5 mBottom5 mLeft10 mRight10"}
    </td>
    <td>
        <div class="mRight15 mLeft15">
           <dl class="pulldownbutton_standard_grn" style="display:inline; margin:0;padding:0">
                <dt>
                    <a href="javascript:void(0)"><span class="event_menu_color{if $item[1] eq 0}_none{else}{$item[1]}{/if}_grn mRight2"></span><span class="pulldownbutton_arrow_down_grn"></span></a>
                </dt>
                <dd style="margin:0;padding:0">
                    <ul class="dropdownContents_grn" style="width:37px;">
                                <li><a href="javascript:void(0)" ><span class="event_menu_color_none_grn"></span></a></li>
                                <li><a href="javascript:void(0)"><span class="event_menu_color1_grn"></span></a></li>
                                <li><a href="javascript:void(0)"><span class="event_menu_color2_grn"></span></a></li>
                                <li><a href="javascript:void(0)"><span class="event_menu_color3_grn"></span></a></li>
                                <li><a href="javascript:void(0)"><span class="event_menu_color4_grn"></span></a></li>
                                <li><a href="javascript:void(0)"><span class="event_menu_color5_grn"></span></a></li>
                                <li><a href="javascript:void(0)"><span class="event_menu_color6_grn"></span></a></li>
                                <li><a href="javascript:void(0)"><span class="event_menu_color7_grn"></span></a></li>
                                <li><a href="javascript:void(0)"><span class="event_menu_color8_grn"></span></a></li>
                    </ul>
                </dd>
            </dl>
            </td>
        <div>
    <td>
    <a href="javascript:void(0)"  class='icon-delete-grn mRight15 mLeft15'>{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-580' replace='true'}</a>
    </td>
    </tr>
      {/foreach}

</table>
<div class="mLeft10 mTop10" >
    <a href="javascript:void(0)" class="icon_add_grn" >{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-578' replace='true'}</a>
</div>
{grn_textarea name="menu" id="menu" rows="3" style='display:none;'}
<p style='display:block; height:30px;margin:5px;'>
   <input class="margin" type="submit" value="{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-435' replace='true'}" >
{grn_button_cancel page='system/application_list' app_id='schedule'}
</form>

{include file='grn/system_footer.tpl'}
