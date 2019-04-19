function setFontSize(fontValue)
{
    jQuery("#view").css( "fontSize", fontValue );
}
function doPrint()
{
    jQuery('#div_print_setting').hide();
    window.print();
}
function setLocale( setting ){
    if(setting == 'system') {
        jQuery(".system").show();
        jQuery(".user").hide();
    }
    else if(setting == 'user') {
        jQuery(".user").show();
        jQuery(".system").hide();
    }
}
