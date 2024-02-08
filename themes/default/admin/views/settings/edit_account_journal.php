<?php defined('BASEPATH') or exit('No direct script access allowed'); ?>
<div class="modal-dialog">
    <div class="modal-content">
        <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true"><i class="fa fa-2x">&times;</i>
            </button>
            <h4 class="modal-title" id="myModalLabel"><?= lang('edit_account_journal'); ?></h4>
        </div>
        <?php $attrib = ['data-toggle' => 'validator', 'role' => 'form'];
        echo admin_form_open('system_settings/edit_account_journal', $attrib); ?>
        <div class="modal-body">
            <p><?= lang('enter_info'); ?></p>

            <div class="form-group">
                <?= lang('no_account', 'akun'); ?>
                <?= form_input('no_account', $akun->no_account, 'class="form-control" id="no_account" required="required" readonly'); ?>
            </div>

            <div class="form-group">
                <?= lang('account_desc', 'desc'); ?>
                <?= form_input('account_desc', $akun->account_desc, 'class="form-control" id="account_desc" required="required"'); ?>
            </div>

            <div class="form-group">
                <?= lang('group_account_id', 'group'); ?>
                <?php
                $dv[''] = '';
                foreach($group_account as $grp){
                    $dv[$grp->id."#".$grp->group_desc] = $grp->group_desc;
                }
                echo form_dropdown('group_account', $dv, ($akun->group_account_id."#".$akun->group_account_desc), 'id="group_account" class="form-control input-tip select" style="width:100%;" ');
                ?>
            </div>
        </div>
        <div class="modal-footer">
            <?= form_submit('edit_account_journal', lang('edit_account_journal'), 'class="btn btn-primary"'); ?>
        </div>
    </div>
    <?= form_close(); ?>
</div>
<?= $modal_js ?>