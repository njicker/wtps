<?php defined('BASEPATH') or exit('No direct script access allowed'); ?>
<script type="text/javascript">
    
</script>

<div class="box">
    <div class="box-header">
        <h2 class="blue"><i class="fa-fw fa fa-plus"></i><?= lang('add_return'); ?></h2>
    </div>
    <div class="box-content">
        <div class="row">
            <div class="col-lg-12">

                <p class="introtext"><?php echo lang('enter_info'); ?></p>
                <?php
                $attrib = ['data-toggle' => 'validator', 'role' => 'form'];
                echo admin_form_open_multipart('returns/add', $attrib);
                ?>
                <div class="row">
                    <div class="col-lg-12">
                        <div class="col-md-4">
                            <div class="form-group">
                                <label>No Delivery*</label>
                                <?php echo form_input('no_delivery', '', 'class="form-control input-tip" id="no_delivery" required="required"'); ?>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-12">
                        <div class="col-md-4">
                            <div class="form-group">
                                <?php echo form_submit('add_return', lang('submit'), 'id="add_return" class="btn btn-primary" style="padding: 6px 15px; margin:15px 0;"'); ?>
                                <button type="button" class="btn btn-danger" id="reset"><?= lang('reset') ?></div>
                            </div>
                        </div>
                    </div>
                </div>
                <?php echo form_close(); ?>
            </div>
        </div>
    </div>
</div>
