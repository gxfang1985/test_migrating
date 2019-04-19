var ScheduleDisplayOptions = {};

ScheduleDisplayOptions.todo =
{
    create : function(url, pageKey, checkbox_id, plid, ticket, schedule_id,todo_class_name)
    {
         var  todoURL = url;
         var  page    = pageKey;
         var  checkbox = checkbox_id + plid;
         var  csrfTicket = ticket;
         var  scheduleListID = schedule_id;
         var  toDoClassName = todo_class_name;
         var  plid = plid;
 
         return {
            
              onClickShowToDo : function()
              {
                  return $( checkbox ).checked ? this.onCheckedShowToDo() : this.onUncheckedShowToDo();
              },

              onCheckedShowToDo : function(){
                  // Ajaxの週送り&月送りを考えると、毎回要素を取得しなおす必要がある
                  var scheduleToDos = this.getToDos();
                  var scheduleToDosLength = scheduleToDos.length;
                  for(var i=0; i<scheduleToDosLength; i+=1){
                      scheduleToDos[i].show();
                  }
                  this.sendShowToDoStatus('1');
                  this.setAjaxBufferInitFlagFalse();
              },
    
              onUncheckedShowToDo : function(){
                  // Ajaxの週送り&月送りを考えると、毎回要素を取得しなおす必要がある
                  var scheduleToDos = this.getToDos(),
                      scheduleToDosLength = scheduleToDos.length;
                  for(var i=0; i<scheduleToDosLength; i+=1){
                      scheduleToDos[i].hide();
                  }
                  this.sendShowToDoStatus('0');
                  this.setAjaxBufferInitFlagFalse();
              },
    
              getToDos : function(){
                  // Ajaxの週送り&月送りを考えると、毎回要素を取得しなおす必要がある
                  return $(scheduleListID).getElementsByClassName(toDoClassName);
              },
    
              sendShowToDoStatus : function(status){
                  new Ajax.Request(
                      todoURL,
                      {
                          'method':'POST',
                          'parameters':'status='+status+'&page='+page+'&csrf_ticket='+csrfTicket
                      }
                  );
              },
              setAjaxBufferInitFlagFalse : function () {
                  if( typeof CyScheduleGw !== 'undefined' && /week/.test(page) )
                  {
                      CyScheduleGw.setInitFlagFalse(plid);
                  }
              },
              getCheckBoxElement : function(){ return $(checkbox); }
       };
    }
};


