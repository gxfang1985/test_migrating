<!--GRN2-2286 -->
{literal}
<style type="text/css">
  .hideScheduleAbsent .schedule_absent{
    height:15px;
    background-color:#A9A9A9;
  }

  .hideScheduleAbsent  .v_day .schedule_absent table{
        background-color:#A9A9A9;
  }
  
  .hideScheduleAbsent  .schedule_absent span{
        visibility:hidden;
  }
  
  .hideScheduleAbsent  .schedule_absent font{
        visibility:hidden;
  }
  
  .hideScheduleAbsent  .schedule_absent li{
        visibility:hidden;
  }
  
  .hideScheduleAbsent .schedule_absent a{
        visibility:hidden;
  }
  
  .hideScheduleAbsent  .schedule_absent img{
        visibility:hidden;
  }
  
  .hideScheduleAbsent  .show_event span{
        visibility:visible;
  }

  .hideScheduleAbsent .show_event a{
        visibility:visible;
  }

  .hideScheduleAbsent  .show_event li{
        visibility:visible;
  }
  
  .hideScheduleAbsent  .show_event font{
        visibility:visible;
  }

  .hideScheduleAbsent  .show_event img{
        visibility:visible;
        background-color:#eeeeee;
  }
  
  .hideScheduleAbsent .v_day .show_event table{
        visibility:visible;
        background-color:#eeeeee;
  }
  
  .hideScheduleAbsent .show_event{
    position:absolute;
    height:5%;
    background-color:#eeeeee;
  }
</style>
{/literal}
<script type="text/javascript" language="javascript">
    var command_show_hide_absent_schedule_url = "{grn_pageurl page='schedule/command_show_hide_absent_schedule'}";
</script>

<script type="text/javascript" language="javascript">
{literal}

function show_hide_absent_schedule(id,tag_name,screen,flag)
{
  valueCheck = $(id);
  if(screen == 'group_week')
  {
      if( valueCheck.checked)
      {
        DisplayElement_NotMouseMove(tag_name,true);
        status = 1;
      }
      else
      {
        DisplayElement_NotMouseMove(tag_name,false);
        status = 0;
      }
      
      if(flag == 1)
      {
        new Ajax.Request(
                    command_show_hide_absent_schedule_url,
                    {
                        'method':'POST',
                        'parameters':'status='+status + '&page=group_week' +
                            '&csrf_ticket={/literal}{$csrf_ticket}{literal}'
                    }
                );
       }
  }

  if(screen == 'portlet_group_week')
  {
      if( valueCheck.checked)
      {
        DisplayElement_NotMouseMove(tag_name,true);
        status = 1;
      }
      else
      {
        DisplayElement_NotMouseMove(tag_name,false);
        status = 0;
      }
      
      if(flag == 1)
      {
        new Ajax.Request(
                    command_show_hide_absent_schedule_url,
                    {
                        'method':'POST',
                        'parameters':'status='+status + '&page=portlet_group_week' +
                            '&csrf_ticket={/literal}{$csrf_ticket}{literal}'
                    }
                );
       }
  }
  
  if(screen == 'group_day')
  {
      if( valueCheck.checked)
      {
        DisplayElement(tag_name,false);
        status = 1;
      }
      else
      {
        DisplayElement(tag_name,true);
        status = 0;
      }
      
      if(flag == 1)
      {
        new Ajax.Request(
                    command_show_hide_absent_schedule_url,
                    {
                        'method':'POST',
                        'parameters':'status='+status + '&page=group_day' +
                            '&csrf_ticket={/literal}{$csrf_ticket}{literal}'
                    }
                );
       }
  }

  if(screen == 'portlet_group_day')
  {
      if( valueCheck.checked)
      {
        DisplayElement(tag_name,false);
        status = 1;
      }
      else
      {
        DisplayElement(tag_name,true);
        status = 0;
      }
      
      if(flag == 1)
      {
        new Ajax.Request(
                    command_show_hide_absent_schedule_url,
                    {
                        'method':'POST',
                        'parameters':'status='+status + '&page=portlet_group_day' +
                            '&csrf_ticket={/literal}{$csrf_ticket}{literal}'
                    }
                );
       }
  }
  
  if(screen == 'personal_day')
  {
      if( valueCheck.checked)
      {
        DisplayElement_personal(tag_name,false);
        status = 1;
      }
      else
      {
        DisplayElement_personal(tag_name,true);
        status = 0;
      }
      
      if(flag == 1)
      {
        new Ajax.Request(
                    command_show_hide_absent_schedule_url,
                    {
                        'method':'POST',
                        'parameters':'status='+status + '&page=personal_day' +
                            '&csrf_ticket={/literal}{$csrf_ticket}{literal}'
                    }
                );
       }
  }
  
  if(screen == 'portlet_personal_day')
  {
    if( valueCheck.checked)
      {
        DisplayElement('table.v_day_navi',false);
        DisplayElement('table.v_day_table',false);
        DisplayElement('table.top_day_navi',false);
        status = 1;
      }
      else
      {
        DisplayElement('table.v_day_navi',true);
        DisplayElement('table.v_day_table',true);
        DisplayElement('table.top_day_navi',true);
        status = 0;
      }
      
      if(flag == 1)
      {
        new Ajax.Request(
                    command_show_hide_absent_schedule_url,
                    {
                        'method':'POST',
                        'parameters':'status='+status + '&page=portlet_personal_day' +
                            '&csrf_ticket={/literal}{$csrf_ticket}{literal}'
                    }
                );
       }
  }
  
  if(screen == 'personal_week')
  {
      if( valueCheck.checked)
      {
        DisplayElement_personal('table.scheduleWrapper',false);
        DisplayElement_personal('div.showtime',false);
        status = 1;
      }
      else
      {
        DisplayElement_personal('table.scheduleWrapper',true);
        DisplayElement_personal('div.showtime',true);
        status = 0;
      }
      
      if(flag == 1)
      {
        new Ajax.Request(
                    command_show_hide_absent_schedule_url,
                    {
                        'method':'POST',
                        'parameters':'status='+status + '&page=personal_week' +
                            '&csrf_ticket={/literal}{$csrf_ticket}{literal}'
                    }
                );
       }
  }
  
  if(screen == 'portlet_personal_week')
  {
      if( valueCheck.checked)
      {
        DisplayElement('table.scheduleWrapper_portlet_personal_week',false);
        DisplayElement('div.showtime',false);
        status = 1;
      }
      else
      {
        DisplayElement('table.scheduleWrapper_portlet_personal_week',true);
        DisplayElement('div.showtime',true);
        status = 0;
      }
      
      if(flag == 1)
      {
        new Ajax.Request(
                    command_show_hide_absent_schedule_url,
                    {
                        'method':'POST',
                        'parameters':'status='+status + '&page=portlet_personal_week' +
                            '&csrf_ticket={/literal}{$csrf_ticket}{literal}'
                    }
                );
       }
  }
  
  if(screen == 'personal_month')
  {
      if( valueCheck.checked)
      {
        DisplayElement_Month('tr.schedule_absent',true);
        DisplayElement_Month('div.schedule_absent',true);
        status = 1;
      }
      else
      {
        DisplayElement_Month('tr.schedule_absent',false);
        DisplayElement_Month('div.schedule_absent',false);
        status = 0;
      }
      
      if(flag == 1)
      {
        new Ajax.Request(
                    command_show_hide_absent_schedule_url,
                    {
                        'method':'POST',
                        'parameters':'status='+status + '&page=personal_month' +
                            '&csrf_ticket={/literal}{$csrf_ticket}{literal}'
                    }
                );
       }
  }
  
  if(screen == 'portlet_personal_month')
  {
      if( valueCheck.checked)
      {
        DisplayElement_Month('tr.schedule_absent',true);
        DisplayElement_Month('div.schedule_absent',true);
        status = 1;
      }
      else
      {
        DisplayElement_Month('tr.schedule_absent',false);
        DisplayElement_Month('div.schedule_absent',false);
        status = 0;
      }
      
      if(flag == 1)
      {
        new Ajax.Request(
                    command_show_hide_absent_schedule_url,
                    {
                        'method':'POST',
                        'parameters':'status='+status + '&page=portlet_personal_month' +
                            '&csrf_ticket={/literal}{$csrf_ticket}{literal}'
                    }
                );
       }
  }
}

function DisplayElement_Month(typeElement, valueCheck)
{
    var displayType = "inline";
  if(!valueCheck)
  {
    displayType = "none";
  }
  var updateElements = $$(typeElement);
  updateElements.each( function(e){
    e.style.display = displayType;
  });
}

function DisplayElement_NotMouseMove(typeElement, valueCheck)
{
    var displayType = "inline";
  if(!valueCheck)
  {
    displayType = "none";
  }
  var updateElements = $$(typeElement)[0];
  var absentSchedule = updateElements.select('div.schedule_absent');
  absentSchedule.each( function(e){
    e.style.display = displayType;
  });
}

function DisplayElement_personal(typeElement, valueCheck)
{
    var scheduleWrapper = $$(typeElement)[0];
    var absentSchedule = scheduleWrapper.select('div.schedule_absent');
    if(!valueCheck)
    {
      scheduleWrapper.removeClassName('hideScheduleAbsent');
      absentSchedule.each(function(e){
                e.stopObserving("mouseover");
                e.stopObserving("mouseout");
            });
    }
    else
    {
        scheduleWrapper.addClassName('hideScheduleAbsent');
        absentSchedule.each(function(e){
                e.observe("mouseover", function(event){
                    e.addClassName('show_event');
                });
                e.observe("mouseout", function(event){
                    e.removeClassName('show_event');
                });
            });
    }
}

function DisplayElement(typeElement, valueCheck)
{
    var scheduleWrapper = $$(typeElement)[0];
    var absentSchedule = scheduleWrapper.select('div.schedule_absent');
    if(!valueCheck)
    {
      scheduleWrapper.removeClassName('hideScheduleAbsent');
      absentSchedule.each(function(e){
                e.stopObserving("mouseover");
                e.stopObserving("mouseout");
            });
    }
    else
    {
        scheduleWrapper.addClassName('hideScheduleAbsent');
        absentSchedule.each(function(e){
                e.observe("mouseover", function(event){
                    e.addClassName('show_event');
                });
                e.observe("mouseout", function(event){
                    e.removeClassName('show_event');
                });
            });
    }
}
{/literal}
</script>
<!--GRN2-2286 -->