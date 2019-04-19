{literal}
<script language="JavaScript" text="text/javascript">
<!--
GRN_ReportInitialMinute = {
    unit: '{/literal}{cb_msg module='fw.ui' key='time_minute_unit'}{literal}',
    changeInterval: function(selectElementId, interval, necessary){
        interval = parseInt(interval);
        var selectedIndex = document.getElementById(selectElementId).selectedIndex;
        if( ! selectedIndex )
            selectedIndex = 0;
        var selectedValue = document.getElementById(selectElementId).options[selectedIndex].value;
        var options = document.getElementById(selectElementId).options;
        var index = 0;

        if( necessary )
            this.addOption(selectElementId, index++, "--", "");
        
        for( i=0; i<60; i += interval ){
            selected = (selectedValue != "" && i == selectedValue);
            this.addOption(selectElementId, index++, i, i, selected);
        }
        for( ; index < options.length; ){
            options[index] = null;
        }
    },
    addOption: function(selectElementId, index, text, value, selected){
        text = ""+text;
        if(text.length == 1)
            text = "0"+text;

        document.getElementById(selectElementId).options[index] = new Option(text+this.unit, value);
        if( selected )
            document.getElementById(selectElementId).options[index].selected = true;
    }
};
//-->
</script>
{/literal}
