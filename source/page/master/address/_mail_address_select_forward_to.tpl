<tr>
    <td></td>
    <td></td>
</tr>
<tr>
    <td id="view_part" valign="center">
        <input class="line" type="button" name="forwardTo_add" value="{cb_msg module='grn.address' key='GRN_ADDR-163' replace='true'}" onClick="if( ! grn_is_selected( this.form,'c_uid[]' ) ) return false; this.form.func.value='{$add_users}_forwardTo';PrepareSubmit( this.form, 'c_uid[]' );submit()"><br><input class="line" type="button" name="forwardTo_delete" value="{cb_msg module='grn.address' key='GRN_ADDR-164' replace='true'}" onClick="if( ! grn_is_selected( this.form,'s_uid_forwardTo[]' ) ) return false; this.form.func.value='{$remove_users}_forwardTo';PrepareSubmit( this.form, 's_uid_forwardTo[]' );submit()">
    </td>
    <td id="view_part">
        {cb_msg module="grn.mail.personal" key="GRN_MAIL_PE-264" replace="true"}<br>
        <table border="0" cellspacing="0" cellpadding="0">
            <tr>
                <td>
                    <select name="s_uid_forwardTo[]" size="5" multiple>
                        {foreach from=$selected_users.forwardTo item=user}
                            {if $user.raw_address}
                                <option value="{$user.uid}:{$user.escape_address}">{$user.email_address|escape}</option>
                            {else}
                                <<option value="{$user.uid}:{$user.escape_address}">&quot;{$user.display_name}&quot; &lt;{$user.email_address|escape}&gt;</option>
                            {/if}
                        {/foreach}
                        <option value="">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</option>
                    </select>
                </td>
                <td>&nbsp;</td>
                <td>
                    <a href="javascript:OrderTop('list', 's_uid_forwardTo[]')">{grn_image image='order_top20.gif' alt=''}</a><br>
                    <a href="javascript:OrderUp('list', 's_uid_forwardTo[]')">{grn_image image='order_up20.gif' alt=''}</a><br>
                    <a href="javascript:OrderDown('list', 's_uid_forwardTo[]')">{grn_image image='order_down20.gif' alt=''}</a><br>
                    <a href="javascript:OrderBottom('list', 's_uid_forwardTo[]')">{grn_image image='order_bottom20.gif' alt=''}</a>
                </td>
            </tr>
        </table>
    </td>
</tr>
