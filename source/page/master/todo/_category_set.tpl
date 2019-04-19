 <div id="one_parts">
  <div id="action">
   <div class="explanation">{cb_msg module='grn.todo' key='GRN_TOD-25' replace='true'}</div>
{capture name='categories'}
{foreach from=$categories.category item=element}
{$element.title|grn_noescape}
{/foreach}
{/capture}
   {grn_textarea name='category' value=$smarty.capture.categories cols="50" rows="10"}
  </div>
 </div>
 {strip}
     <div class="mTop15 mBottom15">
         {capture name='grn_todo_GRN_TOD_27'}{cb_msg module='grn.todo' key='GRN_TOD-27' replace='true'}{/capture}
         {grn_button id="todo-category-set-submit" ui="main" spacing="normal" action="submit" caption=$smarty.capture.grn_todo_GRN_TOD_27}
         {grn_button id="todo-category-set-cancel" action="cancel"}
     </div>
 {/strip}
