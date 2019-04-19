{*********************************************************
  @ para:$header                    string
  @ para:$user_collection           SpaceUserCollection
  @ para:$maxNumMember              int
  @ para:$id                        string
  @ para:$append_script_file        boolean
**********************************************************}
<th>{$header}</th>
<td>
{grn_space_members_name_with_dialog spaceMemberCollection=$user_collection
                                    limit_display_count=$maxNumMember
                                    id=$id
                                    append_script_file=$append_script_file}
</td>
