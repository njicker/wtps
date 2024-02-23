<?php defined('BASEPATH') or exit('No direct script access allowed'); ?>
<div class="modal-dialog">
    <div class="modal-content">
        <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true"><i class="fa fa-2x">&times;</i>
            </button>
            <h4 class="modal-title" id="myModalLabel"><?= lang('add_group_account'); ?></h4>
        </div>
        <?php $attrib = ['data-toggle' => 'validator', 'role' => 'form'];
        echo admin_form_open('system_settings/add_group_account', $attrib); ?>
        <div class="modal-body">
            <p><?= lang('enter_info'); ?></p>

            <div class="form-group">
                <?= lang('group_account_desc', 'desc'); ?>
                <?= form_input('group_desc', '', 'class="form-control" id="group_desc" required="required"'); ?>
            </div>

            <div class="form-group">
                <?= lang('sub_account', 'group'); ?>
                <?php
                $dv[''] = '';
                foreach($sub_account as $grp){
                    $dv[$grp->id] = $grp->name;
                }
                echo form_dropdown('id_sub_account', $dv, (isset($_POST['id_sub_account']) ? $_POST['id_sub_account'] : ''), 'id="id_sub_account" class="form-control input-tip select" style="width:100%;" ');
                ?>
            </div>

        </div>
        <div class="modal-footer">
            <?= form_submit('add_group_account', lang('add_group_account'), 'class="btn btn-primary"'); ?>
        </div>
    </div>
    <?= form_close(); ?>
</div>
<?= $modal_js ?>