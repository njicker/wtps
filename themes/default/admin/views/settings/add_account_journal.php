<?php defined('BASEPATH') or exit('No direct script access allowed'); ?>
<div class="modal-dialog">
    <div class="modal-content">
        <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true"><i class="fa fa-2x">&times;</i>
            </button>
            <h4 class="modal-title" id="myModalLabel"><?= lang('add_account_journal'); ?></h4>
        </div>
        <?php $attrib = ['data-toggle' => 'validator', 'role' => 'form'];
        echo admin_form_open('system_settings/add_account_journal', $attrib); ?>
        <div class="modal-body">
            <p><?= lang('enter_info'); ?></p>

            <div class="form-group">
                <?= lang('no_account', 'akun'); ?>
                <?= form_input('no_account', '', 'class="form-control" id="no_account" required="required"'); ?>
            </div>

            <div class="form-group">
                <?= lang('account_desc', 'desc'); ?>
                <?= form_input('account_desc', '', 'class="form-control" id="account_desc" required="required"'); ?>
            </div>

            <div class="form-group">
                <?= lang('group_account_id', 'group'); ?>
                <?php
                $dv[''] = '';
                foreach($group_account as $grp){
                    $dv[$grp->id."#".$grp->group_desc] = $grp->group_desc;
                }
                echo form_dropdown('group_account', $dv, (isset($_POST['group_account']) ? $_POST['group_account'] : ''), 'id="group_account" class="form-control input-tip select" style="width:100%;" ');
                ?>
            </div>

            <div class="form-group">
                <?= lang('expense_type', 'expense_type'); ?>
                <?php
                $exp[''] = '-';
                $exp['overhead'] = 'Biaya Overhead';
                $exp['labour'] = 'Biaya Tenaga Kerja';
                echo form_dropdown('expense_type', $exp, (isset($_POST['expense_type']) ? $_POST['expense_type'] : ''), 'id="expense_type" class="form-control input-tip select" style="width:100%;" ');
                ?>
            </div>
        </div>
        <div class="modal-footer">
            <?= form_submit('add_account_journal', lang('add_account_journal'), 'class="btn btn-primary"'); ?>
        </div>
    </div>
    <?= form_close(); ?>
</div>
<?= $modal_js ?>