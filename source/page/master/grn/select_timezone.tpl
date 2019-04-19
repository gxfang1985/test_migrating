<div id="{$timezone_key}-region-block" class="div_select_timezone">
    <select id="{$timezone_key}-region" name="{$timezone_key}-region" onchange="GRN_System_I18N_SelectTimezone.switchTimezoneRegion(this.options[this.selectedIndex].value, '{$timezone_key}');" class="select_timezone">
        {if $smarty.const.ON_FOREST!==1}
        <option value="(Favourite)">{cb_msg module='grn.system.i18n.base' key='favourite_timezones' replace='true'}</option>
        {/if}
        {foreach from=$timezone_regions item=timezone_region}
        {if $timezone_region !== 'UTC'}
        <option value="{$timezone_region}">{cb_msg module='fw.timezone' key=$timezone_region}</option>
        {/if}
        {/foreach}
    </select>
</div>
<div id="all-{$timezone_key}-block"  style="display:none" class="div_select_timezone">
    <select id="all-{$timezone_key}" name="all-{$timezone_key}" class="select_timezone">
        {foreach from=$all_timezones item=timezone_name}
        {if $timezone_name !== 'Etc/GMT'}
        <option value="{$timezone_name}"{if $timezone_name == $select_timezone} selected{/if}>{cb_msg module='fw.timezone' key=$timezone_name}</option>
        {/if}
        {/foreach}
    </select>
</div>
<div id="{$timezone_key}-block" class="div_select_timezone">
    <select id="{$timezone_key}" name="{$timezone_key}" class="select_timezone">
        {foreach from=$timezone_candidates item=timezone_name}
        <option value="{$timezone_name}"{if $timezone_name == $select_timezone} selected{/if}>{cb_msg module='fw.timezone' key=$timezone_name}</option>
        {/foreach}
    </select>
</div>
{literal}
<script type="text/javascript">
var GRN_System_I18N_SelectTimezone = {
    allTimezoneOptions : (function(){
                             var options = [],
                                 elements = document.getElementById('all-{/literal}{$timezone_key}{literal}').getElementsByTagName('option'),
                                 elementsLength = elements.length;
                             for( var i=0; i<elementsLength; i+=1 ){
                                 options.push(elements[i].cloneNode(true));
                             }
                             return options;
                         }()),
    favouriteTimezoneOptions : (function(){
                             var options = [],
                                 elements = document.getElementById('{/literal}{$timezone_key}{literal}').getElementsByTagName('option'),
                                 elementsLength = elements.length;
                             for( var i=0; i<elementsLength; i+=1 ){
                                 options.push(elements[i].cloneNode(true));
                             }
                             return options;
                         }()),
    switchTimezoneRegion : function(region, key) {
        var options,
            max,
            regionLength = region.length;
        
        if( region === '(Favourite)' ){
            options = this.favouriteTimezoneOptions;
        }else{
            options = this.allTimezoneOptions;
        }
        max = options.length;

        document.getElementById(key).innerHTML = '';
        
        for( var i=0; i<max; i+=1 ){
            if( region === '(All)' || region === '(Favourite)' || region === options[i].value.substr(0, regionLength) || options[i].value === '' ){
                document.getElementById(key).appendChild(options[i].cloneNode(true));
            }
        }
    }
};
</script>
{/literal}
