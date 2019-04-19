// check user agent
msie = window.navigator.userAgent.indexOf( "MSIE" ) == -1 ? false : true;

// delete fileselect
function grn_workflow_delete_fileselect( id, init_values )
{
    eval(init_values);
    eval(__wfaf_file_count_name+"-= 1;");
    grn_workflow_check_file_count(init_values);
    var p = document.getElementById( id );
    if( p ) {
        p.innerHTML = '';
        p.style.display = 'none';
    }
}

function grn_workflow_check_file_count(init_values)
{
  eval(init_values);
  max_file_count = eval(__wfaf_max_file_count_name);
  file_count     = eval(__wfaf_file_count_name);
  
  var p = document.getElementById(__wfaf_link_name);
  if (p)
  {
    if (max_file_count <= file_count)
    {
      p.style.display = 'none';
    }
    else
    {
      p.style.display = 'block';
    }
  }
  return;
}

//ワークフロー作成時のバリデーション
//必須ファイルが存在するかどうかのみ調べる
function workflow_file_validate(isDraft)
{
  if(isDraft)
    return true;
  
  //Flash有りの場合とそうでない場合で方法が変わる
  var vdata = new Object();
  
  if(grn.browser.isSupportHTML5)
  {
      jQuery("div.html5_content").each(
          function(index, node)
          {
            name = node.id.replace("html5_content_", "");
            vdata[name] = false;
            jQuery("input.upload_checkbox_" + name).each(
            function(index, node2)
            {
              vdata[name] |= node2.checked;
            }
            );
          }
        );
  }
  else
  {
      jQuery("div.not_support_html5_content").each(
          function(index, node)
          {
            name = node.id.replace("no_flash_plugin_content_", "");
            vdata[name] = false;
            
            if( jQuery("#attached_file_" + name).length > 0 )
            {
              vdata[name] = true;
            }
            else
            {
                jQuery("input.infile").each(
                function(index, node2)
                {
                  if(node2.name.indexOf(name, 0) == 0)
                    vdata[name] |= (node2.value != null && node2.value.length > 0);
                }
              );
            }
          }
      );
  }
  
  validate = true;

  var scrollHeight = 0;
  var liteTop = jQuery(".cloudHeader-inner-grn").height();

  for(var i in vdata)
  {
    require = eval('__upload_'+i+'_require');
    if(require && !vdata[i])
    {
      msg = eval('__upload_msg_'+i+'_error');
      if (scrollHeight === 0)
      {
          scrollHeight = jQuery('#attention_'+i).offset().top-liteTop;
      }
      jQuery('#attention_'+i).html(msg);
      validate = false;
    }
    else
    {
      jQuery('#attention_'+i).html('');
    }
  }

  if (validate === false)
  {
      window.scrollTo(0, scrollHeight);
  }

  return validate;
}

