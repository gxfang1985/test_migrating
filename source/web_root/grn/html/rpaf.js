// delete fileselect
function grn_report_delete_fileselect( id, init_values )
{
    eval(init_values);
    eval(__rpaf_file_count_name+"-= 1;");
    grn_report_check_file_count(init_values);
    var p = document.getElementById( id );
    if( p ) {
        p.innerHTML = '';
        p.style.display = 'none';
    }
}

function grn_report_check_file_count(init_values)
{
  eval(init_values);
  max_file_count = eval(__rpaf_max_file_count_name);
  file_count     = eval(__rpaf_file_count_name);
  
  var p = document.getElementById(__rpaf_link_name);
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
