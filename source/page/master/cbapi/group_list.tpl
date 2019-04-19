<?xml version="1.0" encoding="{$encoding}"?>
<methodResponse>
  <params>
    <param>
      <value>
        <struct>
          <member>
            <name>apiver</name>
            <value><double>{$api_ver}</double></value>
          </member>
          <member>
            <name>c_groupid</name>
            <value><string>{$group.id}</string></value>
          </member>
          <member>
            <name>c_groupname</name>
{if $group.id == 'root'}
            <value><string>{cb_msg module='grn.cbapi' key='GRN_CBAPI-1' replace='true'}</string></value>
{else}
            <value><string>{$group.name|escape}</string></value>
{/if}
          </member>
          <member>
            <name>count</name>
            <value><int>{$group.count}</int></value>
          </member>
{if $hierarchy}
          <member>
            <name>hierarchy</name>
            <value>
              <array>
                <data>
{foreach from=$hierarchy key=gid item=group}
                  <value>
                    <struct>
                      <member>
                        <name>h_groupid</name>
                        <value><string>{$gid}</string></value>
                      </member>
                      <member>
                        <name>h_groupname</name>
{if $gid == 'root'}
                        <value><string>{cb_msg module='grn.cbapi' key='GRN_CBAPI-2' replace='true'}</string></value>
{else}
                        <value><string>{$group.name|escape}</string></value>
{/if}
                      </member>
                      <member>
                        <name>h_level</name>
                        <value><int>{$group.level}</int></value>
                      </member>
                    </struct>
                  </value>
{/foreach}
                </data>
              </array>
            </value>
          </member>
{/if}
{if $groups}
          <member>
            <name>group_list</name>
            <value>
              <array>
                <data>
{foreach from=$groups key=gid item=group}
                  <value>
                    <struct>
                      <member>
                        <name>groupid</name>
                        <value><string>{$gid}</string></value>
                      </member>
                      <member>
                        <name>groupname</name>
{if $gid == 'root'}
                        <value><string>{cb_msg module='grn.cbapi' key='GRN_CBAPI-3' replace='true'}</string></value>
{else}
                        <value><string>{$group.name|escape}</string></value>
{/if}
                      </member>
                      <member>
                        <name>order</name>
                        <value><int>{$group.order}</int></value>
                      </member>
                      <member>
                        <name>children</name>
                        <value><int>{$group.children}</int></value>
                      </member>
                    </struct>
                  </value>
{/foreach}
                </data>
              </array>
            </value>
          </member>
{/if}
        </struct>
      </value>
    </param>
  </params>
</methodResponse>
