    <{$event.root} {grn_attr name="id" value=$event.id require=true}
           {if $event.hidden_private}{grn_attr name="event_type" value="normal" require=true}{else}{grn_attr name="event_type" value=$event.event_type require=true}{/if} 
           {grn_attr name="public_type" value=$event.public_type} 
           {grn_attr name="plan" value=$event.plan}
           {grn_attr name="detail" value=$event.detail} 
           {grn_attr name="description" value=$event.memo} 
           {grn_attr name="version" value=$event.version require=true}
           {grn_attr name="timezone" value=$event.timezone require=true}
           {grn_attr name="end_timezone" value=$event.end_timezone}
           {grn_attr name="allday" value=$event.allday} 
           {grn_attr name="start_only" value=$event.start_only}
           {grn_attr name="hidden_private" value=$event.hidden_private}
           {if $event.required_facility_using_purpose}{grn_attr name="facility_using_purpose" value=$event.facility_using_purpose require=true}{/if}
           >
           
    <members xmlns="http://schemas.cybozu.co.jp/schedule/2008">
        {if $event.users}
        {foreach from=$event.users item=user}
        <member>
            <user {grn_attr name="id" value=$user.id require=true} {grn_attr name="name" value=$user.name require=true} {grn_attr name="order" value=$user.order}/>
        </member>
        {/foreach}
        {/if}
        {if $event.groups}
        {foreach from=$event.groups item=group}
        <member>
           <organization {grn_attr name="id" value=$group.id require=true} {grn_attr name="name" value=$group.name require=true} {grn_attr name="order" value=$group.order}/>
        </member>
        {/foreach}
        {/if}
        {if $event.facilities}
        {foreach from=$event.facilities item=facility}
        <member>
           <facility {grn_attr name="id" value=$facility.id require=true} {grn_attr name="name" value=$facility.name require=true} {grn_attr name="order" value=$facility.order}/>
        </member>
        {/foreach}
        {/if}
    </members>

    {if $event.observers}
     <observers xmlns="http://schemas.cybozu.co.jp/schedule/2008">
    {foreach from=$event.observers item=observer}
        {if $observer.type eq 'user'}
        <observer>
            <user {grn_attr name="id" value=$observer.id require=true} {grn_attr name="name" value=$observer.name require=true} {grn_attr name="order" value=$observer.order}/>
        </observer>
        {elseif $observer.type eq 'group'}
        <observer>
           <organization {grn_attr name="id" value=$observer.id require=true} {grn_attr name="name" value=$observer.name require=true} {grn_attr name="order" value=$observer.order}/>
        </observer>
        {elseif $observer.type eq 'static_role'}
        <observer>
           <role {grn_attr name="id" value=$observer.id require=true} {grn_attr name="name" value=$observer.name require=true} {grn_attr name="order" value=$observer.order}/>
        </observer>
        {/if}
    {/foreach}
    </observers>
    {/if}

    {if $event.customer }
        <customer {grn_attr name="name"                         value=$event.customer.name}
                  {grn_attr name="zipcode"                      value=$event.customer.zipcode}
                  {grn_attr name="address"                      value=$event.customer.address}
                  {grn_attr name="map"                          value=$event.customer.map}
                  {grn_attr name="route"                        value=$event.customer.route}
                  {grn_attr name="route_time"                   value=$event.customer.route_time}
                  {grn_attr name="route_fare"                   value=$event.customer.route_fare}
                  {grn_attr name="phone"                        value=$event.customer.phone}
                  {grn_attr name="fax"                          value=$event.customer.fax}
                  {grn_attr name="url"                          value=$event.customer.url} xmlns="http://schemas.cybozu.co.jp/schedule/2008"/>
    {/if}
    
    {if $event.event_type == 'repeat' && !$event.hidden_private}
    <repeat_info xmlns="http://schemas.cybozu.co.jp/schedule/2008">
      <condition {grn_attr name="type" value=$event.repeat_type require=true} {grn_attr name="day" value=$event.day}  
      {grn_attr name="week" value=$event.week} {grn_attr name="start_date" value=$event.start_date require=true} {grn_attr name="end_date" value=$event.end_date}
      {grn_attr name="start_time" value=$event.start_time} {grn_attr name="end_time" value=$event.end_time}/>
      <exclusive_datetimes>
      {foreach from=$event.exclusive_datetimes item=exclusive_datetime}
        <exclusive_datetime {grn_attr name="start" value=$exclusive_datetime.start require=true} {grn_attr name="end" value=$exclusive_datetime.end require=true} />
      {/foreach}
      </exclusive_datetimes>
    </repeat_info>
    {/if}
       
    {if $event.event_type != 'repeat'}
     <when xmlns="http://schemas.cybozu.co.jp/schedule/2008">
      {if $event.allday == 'true' || $event.event_type == 'banner' }
      <date {grn_attr name="start" value=$event.start_date require=true} {grn_attr name="end" value=$event.end_date require=true} />
      {else}
          {if $event.event_type == 'temporary'}
               {if $event.temporary_type == 'or'}
                 {foreach from=$event.temporary item=facility_data}
                   {foreach from=$facility_data.dates item=temporary}
                   <datetime {grn_attr name="start" value=$temporary.setdatetime require=true} {grn_attr name="end" value=$temporary.enddatetime} 
                     {grn_attr name="facility_id" value=$facility_data.facility_id require=true} />
                   {/foreach}
                 {/foreach}
               {else}
               {foreach from=$event.temporary item=temporary}
               <datetime {grn_attr name="start" value=$temporary.setdatetime require=true} {grn_attr name="end" value=$temporary.enddatetime}/>
               {/foreach}
             {/if}
          {else}
              <datetime {grn_attr name="start" value=$event.start_date require=true} {grn_attr name="end" value=$event.end_date}/>
          {/if}
      {/if}
    </when>
    {else}
    {if $action eq "ScheduleGetEventsByTarget" || $action eq "ScheduleSearchEvents"}
    <when xmlns="http://schemas.cybozu.co.jp/schedule/2008">
        {if $event.allday eq "true"}
            <date {grn_attr name="start" value=$event.start_date_time require=true} {grn_attr name="end" value=$event.end_date_time require=true} />
        {else}
            <datetime {grn_attr name="start" value=$event.start_date_time require=true} {grn_attr name="end" value=$event.end_date_time require=true} />
        {/if}
    </when>
    {/if}
    {/if}
    
     {if $event.follows}
     <follows xmlns="http://schemas.cybozu.co.jp/schedule/2008">
     {foreach from=$event.follows item=follow}
      <follow {grn_attr name="id" value=$follow.id require=true} {grn_attr name="text" value=$follow.content} {grn_attr name="version" value=$follow.ctime->unix_ts require=true}>
        <creator {grn_attr name="user_id" value=$follow.creator_id } {grn_attr name="name" value=$follow.creator_name require=true} {grn_attr name="date" value=$follow.date require=true} />
      </follow>
     {/foreach}
     </follows>
     {/if}

    {* GTM-1136 *}
    {if $event.event_type == 'normal' || $event.event_type == 'banner'}
        {if is_array($event.files) && count($event.files) > 0}
            {foreach from=$event.files item=file}
                <file id="{$file.id}" {grn_attr name="name" value=$file.name require=true} {grn_attr name="size" value=$file.size}
                {grn_attr name="mime_type" value=$file.mime}/>
            {/foreach}
        {/if}
    {/if}
    {* End GTM-1136 *}

    </{$event.root}>
