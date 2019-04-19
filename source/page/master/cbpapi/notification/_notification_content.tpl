<{$notification.type} module_id="{$notification.module_id}" 
                    item="{$notification.item}" status="{$notification.status}"
                    is_history="{$notification.is_history}" version="{$notification.version}"
                    {grn_attr name="read_datetime" value=$notification.read_datetime}
                    {grn_attr name="receive_datetime" value=$notification.receive_datetime}
                    {grn_attr name="subject" value=$notification.subject}
                    {grn_attr name="subject_url" value=$notification.subject_url}
                    {grn_attr name="subject_icon" value=$notification.subject_icon}
                    {grn_attr name="abstract" value=$notification.abstract}
                    {grn_attr name="abstract_url" value=$notification.abstract_url}
                    {grn_attr name="abstract_icon" value=$notification.abstract_icon}
                    {grn_attr name="sender_name" value=$notification.sender_name}
                    {grn_attr name="sender_id" value=$notification.sender_id}
                    {grn_attr name="sender_url" value=$notification.sender_url}
                    {grn_attr name="group_name" value=$notification.group_name}
                    {grn_attr name="attached" value=$notification.attached}
                      />