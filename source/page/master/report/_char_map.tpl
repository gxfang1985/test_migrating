
<script language="javascript">
{literal}
function CharMap(char_container, subchar_container, url)
{
    this.char_container = char_container;
    this.subchar_container = subchar_container;
    this.url = url;

    char_index = new Array(
    '{/literal}{cb_msg module='grn.address' key='GRN_ADDR-194' replace='true'}{literal}','{/literal}{cb_msg module='grn.address' key='GRN_ADDR-195' replace='true'}{literal}','{/literal}{cb_msg module='grn.address' key='GRN_ADDR-196' replace='true'}{literal}','{/literal}{cb_msg module='grn.address' key='GRN_ADDR-197' replace='true'}{literal}','{/literal}{cb_msg module='grn.address' key='GRN_ADDR-198' replace='true'}{literal}',    //0
    '{/literal}{cb_msg module='grn.address' key='GRN_ADDR-199' replace='true'}{literal}','{/literal}{cb_msg module='grn.address' key='GRN_ADDR-200' replace='true'}{literal}','{/literal}{cb_msg module='grn.address' key='GRN_ADDR-201' replace='true'}{literal}','{/literal}{cb_msg module='grn.address' key='GRN_ADDR-202' replace='true'}{literal}','{/literal}{cb_msg module='grn.address' key='GRN_ADDR-203' replace='true'}{literal}',    //5 
    '{/literal}{cb_msg module='grn.address' key='GRN_ADDR-204' replace='true'}{literal}','{/literal}{cb_msg module='grn.address' key='GRN_ADDR-205' replace='true'}{literal}','{/literal}{cb_msg module='grn.address' key='GRN_ADDR-206' replace='true'}{literal}','{/literal}{cb_msg module='grn.address' key='GRN_ADDR-207' replace='true'}{literal}','{/literal}{cb_msg module='grn.address' key='GRN_ADDR-208' replace='true'}{literal}',    //10
    '{/literal}{cb_msg module='grn.address' key='GRN_ADDR-209' replace='true'}{literal}','{/literal}{cb_msg module='grn.address' key='GRN_ADDR-210' replace='true'}{literal}','{/literal}{cb_msg module='grn.address' key='GRN_ADDR-211' replace='true'}{literal}','{/literal}{cb_msg module='grn.address' key='GRN_ADDR-212' replace='true'}{literal}','{/literal}{cb_msg module='grn.address' key='GRN_ADDR-213' replace='true'}{literal}',    //15
    '{/literal}{cb_msg module='grn.address' key='GRN_ADDR-214' replace='true'}{literal}','{/literal}{cb_msg module='grn.address' key='GRN_ADDR-215' replace='true'}{literal}','{/literal}{cb_msg module='grn.address' key='GRN_ADDR-216' replace='true'}{literal}','{/literal}{cb_msg module='grn.address' key='GRN_ADDR-217' replace='true'}{literal}','{/literal}{cb_msg module='grn.address' key='GRN_ADDR-218' replace='true'}{literal}',    //20
    '{/literal}{cb_msg module='grn.address' key='GRN_ADDR-219' replace='true'}{literal}','{/literal}{cb_msg module='grn.address' key='GRN_ADDR-220' replace='true'}{literal}','{/literal}{cb_msg module='grn.address' key='GRN_ADDR-221' replace='true'}{literal}','{/literal}{cb_msg module='grn.address' key='GRN_ADDR-222' replace='true'}{literal}','{/literal}{cb_msg module='grn.address' key='GRN_ADDR-223' replace='true'}{literal}',    //25
    '{/literal}{cb_msg module='grn.address' key='GRN_ADDR-224' replace='true'}{literal}','{/literal}{cb_msg module='grn.address' key='GRN_ADDR-225' replace='true'}{literal}','{/literal}{cb_msg module='grn.address' key='GRN_ADDR-226' replace='true'}{literal}','{/literal}{cb_msg module='grn.address' key='GRN_ADDR-227' replace='true'}{literal}','{/literal}{cb_msg module='grn.address' key='GRN_ADDR-228' replace='true'}{literal}',    //30
    '{/literal}{cb_msg module='grn.address' key='GRN_ADDR-229' replace='true'}{literal}','{/literal}{cb_msg module='grn.address' key='GRN_ADDR-230' replace='true'}{literal}','{/literal}{cb_msg module='grn.address' key='GRN_ADDR-231' replace='true'}{literal}',            //35
    '{/literal}{cb_msg module='grn.address' key='GRN_ADDR-232' replace='true'}{literal}','{/literal}{cb_msg module='grn.address' key='GRN_ADDR-233' replace='true'}{literal}','{/literal}{cb_msg module='grn.address' key='GRN_ADDR-234' replace='true'}{literal}','{/literal}{cb_msg module='grn.address' key='GRN_ADDR-235' replace='true'}{literal}','{/literal}{cb_msg module='grn.address' key='GRN_ADDR-236' replace='true'}{literal}',    //38
    '{/literal}{cb_msg module='grn.address' key='GRN_ADDR-237' replace='true'}{literal}','{/literal}{cb_msg module='grn.address' key='GRN_ADDR-238' replace='true'}{literal}','{/literal}{cb_msg module='grn.address' key='GRN_ADDR-239' replace='true'}{literal}',            //43
    'A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z'); //46

    master_index = new Array();
    master_index['{/literal}{cb_msg module='grn.address' key='GRN_ADDR-240' replace='true'}{literal}'] = new Array( 0,  4);
    master_index['{/literal}{cb_msg module='grn.address' key='GRN_ADDR-241' replace='true'}{literal}'] = new Array( 5,  9);
    master_index['{/literal}{cb_msg module='grn.address' key='GRN_ADDR-242' replace='true'}{literal}'] = new Array(10, 14);
    master_index['{/literal}{cb_msg module='grn.address' key='GRN_ADDR-243' replace='true'}{literal}'] = new Array(15, 19);
    master_index['{/literal}{cb_msg module='grn.address' key='GRN_ADDR-244' replace='true'}{literal}'] = new Array(20, 24);
    master_index['{/literal}{cb_msg module='grn.address' key='GRN_ADDR-245' replace='true'}{literal}'] = new Array(25, 29);
    master_index['{/literal}{cb_msg module='grn.address' key='GRN_ADDR-246' replace='true'}{literal}'] = new Array(30, 34);
    master_index['{/literal}{cb_msg module='grn.address' key='GRN_ADDR-247' replace='true'}{literal}'] = new Array(35, 37);
    master_index['{/literal}{cb_msg module='grn.address' key='GRN_ADDR-248' replace='true'}{literal}'] = new Array(38, 42);
    master_index['{/literal}{cb_msg module='grn.address' key='GRN_ADDR-249' replace='true'}{literal}'] = new Array(43, 45);
    master_index['A'] = new Array(46, 71);
    
    this.writeMasterIndex = function()
    {

        var html ='';
        for( key in master_index )
        {
            if( char_index.toString().indexOf(key) >=0 )
            {
                char_for_display = (key == 'A') ? 'ABC...' : key;
                html += "<span>[<a href=\"javascript:void(0);\" onclick=\"CharMap.showSubIndex('" + key + "','"+this.subchar_container+"','"+this.url+"');\">" + char_for_display + '</a>]</span> ';
            }
        }

        document.getElementById(this.char_container).innerHTML = html;
    }
    
    CharMap.showSubIndex = function( charKey, container, url, onclick)
    {
        var char_for_display = '';

        key_pos = 0;
        for(i=0; i<char_index.length; i++)
        {
            if(char_index[i]==charKey)
            {
                key_pos = i;
                break;
            }
        }

        for(mkey in master_index)
        {
            if( master_index[mkey][0] <= key_pos && key_pos <= master_index[mkey][1] )
            {
                char_for_display = mkey;
                break;
            }
        }

        if (char_for_display == '') return;
        
        var html = '';
        
        for( i = master_index[char_for_display][0]; i<=master_index[char_for_display][1]; i++)
        {
            sub_index_char = char_index[i];
            html += "<span>[<a href=\"" + url + "\" onclick=\"GRN_ReportAddress.clickIndex(" + i + ");\">"+ sub_index_char +"</a>]</span> ";
        }
        
        document.getElementById(container).innerHTML = html;
    }
}
{/literal}
</script>
