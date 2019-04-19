{if ! $file_dpage}{assign var='file_dpage' value='space/file_download'}{/if}
{if ! $discussion_vpage}{assign var='discussion_vpage' value='space/application/discussion/index'}{/if}
{if ! $todo_vpage}{assign var='todo_vpage' value='space/application/todo/view'}{/if}
{if ! $file_list}{assign var='file_list' value=$all_file_list}{/if}
<ul class="space-threadRightList-attachedFile-grn">
 {foreach from=$file_list item=file}
 <li>
   <div>{$file.mtime|escape}</div>
   <div>
     <div class="space-threadRightList-attachedFileLink-grn">
   {if $file.type==1}
     <a class="icon-jumpButton-grn" href="{grn_pageurl page=$discussion_vpage spid=$space_id fragment='tid='|cat:$thread_id|cat:'&slidebar=file'}"></a>
   {elseif $file.type==2}
      <a href="{grn_pageurl page=$todo_vpage spid=$space_id tdid=$file.parent_id}" class="icon-jumpButton-grn"></a>
   {elseif $file.type==3 || $file.type==4}
     <a href="{grn_pageurl page=$discussion_vpage spid=$space_id fragment='tid='|cat:$thread_id|cat:'&cmid='|cat:$file.parent_id|cat:'&slidebar=file'}" class="icon-jumpButton-grn"></a>
   {/if}
     </div>
     <div class="space-threadRightList-attachedFileName-grn icon-attachedFile-grn">
       {grn_space_attach_file_link name=$file.name mime=$file.mime dpage=$file_dpage vpage=$discussion_vpage fid=$file.id tid=$thread_id spid=$space_id short=true class=''}
     </div>
     <div class="clear_both_0px"></div>
   </div>
  </li>
 {/foreach}
</ul>
