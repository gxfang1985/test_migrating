<script type="text/javascript">{literal}
var GRN_BaseWorkHours = {
    nextNumber : {/literal}{$next_number}{literal},
    copy : function(){
        var newWorkHours = jQuery("#work_hours_1").clone(true).get(0),
            newNumber = this.nextNumber,
            regexpWorkHours = new RegExp('work_hours_1', 'g'),
            regexpSelected = new RegExp('selected', 'g'),
            removeButton = document.createElement("input");

        newWorkHours.innerHTML = newWorkHours.innerHTML.replace(regexpWorkHours, 'work_hours_'+newNumber);
        
        newWorkHours.innerHTML = newWorkHours.innerHTML.replace(regexpSelected, '');

        newWorkHours.id = 'work_hours_'+newNumber;
        
        removeButton.id = "remove_work_hours_"+newNumber;
        removeButton.type = "button";
        removeButton.onclick = function(){
            GRN_BaseWorkHours.remove(newNumber);
        };
        removeButton.value = "{/literal}{cb_msg module='grn.system.i18n.base' key='remove' replace='true'}{literal}";
        newWorkHours.appendChild(removeButton);

        jQuery(newWorkHours).insertBefore("#add_work_hours");
        this.nextNumber += 1;
        GRN_BaseWorkHours.check();

    },
    remove : function(number){

        jQuery("#work_hours").find("#work_hours_" + number).remove();
        GRN_BaseWorkHours.check();

    },
    check : function(){
        var numberNode = GRN_BaseWorkHours.count();

        if ( numberNode > 9 && document.getElementById("add_work_hours").hasChildNodes()) {
            document.getElementById("add_work_hours").innerHTML = "";
        }

        if ( numberNode < 10 && !document.getElementById("add_work_hours").hasChildNodes() ) {
            AddWorkHoursButton = document.createElement("input");
            AddWorkHoursButton.id = "add_work_hours_button";
            AddWorkHoursButton.type = "button";
            AddWorkHoursButton.onclick = function(){
                GRN_BaseWorkHours.copy();
            };
            AddWorkHoursButton.value = "{/literal}{cb_msg module='grn.system.i18n.base' key='add_work_hours' replace='true'}{literal}";
            document.getElementById("add_work_hours").appendChild(AddWorkHoursButton);
        }

    },
    count : function(){
        var work_hour_nodes = document.getElementById("work_hours").childNodes,
            numberNode = 0;

        for (var i=0; i<work_hour_nodes.length; i++)
        {
          if ( work_hour_nodes.item(i).nodeType == 1 )
          {
              numberNode += 1;
          }
        }
        numberNode -= 1;

        return numberNode;

    }
};
{/literal}</script>
