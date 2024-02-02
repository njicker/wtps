<?php defined('BASEPATH') or exit('No direct script access allowed'); ?>
<div class="modal-dialog">
    <div class="modal-content">
        <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true"><i class="fa fa-2x">&times;</i>
            </button>
            <h4 class="modal-title" id="myModalLabel"><?= lang('add_expense_category'); ?></h4>
        </div>
        <?php $attrib = ['data-toggle' => 'validator', 'role' => 'form'];
        echo admin_form_open('system_settings/add_expense_category', $attrib); ?>
        <div class="modal-body">
            <p><?= lang('enter_info'); ?></p>

            <div class="form-group">
                <?= lang('category_code', 'code'); ?>
                <?= form_input('code', '', 'class="form-control" id="code" required="required"'); ?>
            </div>

            <div class="form-group">
                <?= lang('category_name', 'name'); ?>
                <?= form_input('name', '', 'class="form-control" id="name" required="required"'); ?>
            </div>

            <div class="form-group">
                <label>No. Account</label>
                <?= form_input('no_account', '', 'class="form-control" id="no_account" required="required"'); ?>
            </div>

            <div class="form-group">
                <label>Group Account</label>
                <?php
                // $dv['All'] = 'All';
                $dv['1'] = 'Kas/Bank';
                $dv['2'] = 'Akun Piutang';
                echo form_dropdown('group_account_id', $dv, (isset($_POST['group_account']) ? $_POST['group_account'] : ''), 'id="group_account" class="form-control input-tip select" style="width:100%;" ');
                ?>
            </div>

            <div class="form-group">
                <label>Tipe Pengeluaran</label>
                <?php
                // $dv['All'] = 'All';
                $lbr['overhead'] = 'Biaya Overhead';
                $lbr['labour'] = 'Biaya Tenaga Kerja';
                echo form_dropdown('expense_type', $lbr, (isset($_POST['expense_type']) ? $_POST['expense_type'] : ''), 'id="expense_type" class="form-control input-tip select" style="width:100%;" ');
                ?>
            </div>

        </div>
        <div class="modal-footer">
            <?= form_submit('add_expense_category', lang('add_expense_category'), 'class="btn btn-primary"'); ?>
        </div>
    </div>
    <?= form_close(); ?>
</div>
<?= $modal_js ?>