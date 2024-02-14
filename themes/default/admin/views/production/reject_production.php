<?php defined('BASEPATH') or exit('No direct script access allowed'); ?>
<script>
    $(document).ready(function () {
        $('.gen_slug').change(function(e) {
            console.log($(this).val());
            getSlug($(this).val(), 'products');
        });

        
    });
</script>
<div class="box">
    <div class="box-header">
        <h2 class="blue"><i class="fa-fw fa fa-trash"></i><?= $title ?></h2>
    </div>
    <div class="box-content">
        <div class="row">
            <div class="col-md-12">

                <p class="introtext"><?php echo lang('enter_info'); ?></p>

                <?php
                $attrib = ['data-toggle' => 'validator', 'role' => 'form'];
                echo admin_form_open_multipart('production/reject_production', $attrib);
                ?>
                <div class="row">
                    <div class="col-md-5">
                        <div class="form-group">
                            <div class="form-group all">
                                <?= lang('batch_production', 'batch_production'); ?>
                                <?= form_input('reff_doc', ($_POST['reff_doc'] ?? ($header ? $header->reff_doc : "")), 'class="form-control' . ($Settings->use_code_for_slug ? '' : ' gen_slug') . '" id="reff_doc" required="required" readonly'); ?>
                                <?= form_input('id', ($_POST['id'] ?? ($header ? $header->id : "")), 'class="form-control' . ($Settings->use_code_for_slug ? '' : ' gen_slug') . '" id="id" required="required" style="display:none;" readonly'); ?>
                            </div>
                        </div>
                        <div class="form-group">
                            <?= lang('division', 'division'); ?>
                            <?= form_input('division', $header->division, 'class="form-control" id="division" required="required" readonly'); ?>
                        </div>
                        <div class="form-group">
                            <div class="form-group all">
                                <label>Total Cost</label>
                                <?= form_input('total_cost', ($_POST['total_cost'] ?? ($header ? number_format($header->total_cost) : "")), 'class="form-control' . ($Settings->use_code_for_slug ? '' : ' gen_slug') . '" id="total_cost" required="required" readonly'); ?>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-5">
                        <div class="form-group">
                            <div class="form-group all">
                                <?= lang('status', 'status'); ?>
                                <?= form_input('status_doc', 'Reject', 'class="form-control' . ($Settings->use_code_for_slug ? '' : ' gen_slug') . '" id="status_doc" required="required" readonly'); ?>
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="form-group all">
                                Note
                                <?= form_input('note', ($_POST['note'] ?? ($header ? $header->note : "")), 'class="form-control' . ($Settings->use_code_for_slug ? '' : ' gen_slug') . '" id="note" required="required"'); ?>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-12">
                        <div class="control-group table-group">
                            <label class="table-label">Raw Material</label>

                            <div class="controls table-controls">
                                <table
                                    class="table items table-striped table-bordered table-condensed table-hover sortable_table">
                                    <thead>
                                        <tr>
                                            <th>Produk (Code - Nama)</th>
                                            <th>Qty</th>
                                            <th>UOM</th>
                                            <th>Gudang</th>
                                            <th>Unit Cost</th>
                                            <th>Total Cost</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <?php
                                        foreach($detail as $dtl){
                                            if($dtl->type_item != "raw"){ continue; }
                                            $tr = "<tr>";
                                                $tr .= "<td>" . $dtl->product_code . " - " . $dtl->name . "</td>";
                                                $tr .= "<td>" . $dtl->qty . "</td>";
                                                $tr .= "<td>" . $dtl->unit_code . "</td>";
                                                $tr .= "<td>" . $warehouse[$dtl->warehouse_id] . "</td>";
                                                $tr .= "<td>" . number_format($dtl->product_unit_cost) . "</td>";
                                                $tr .= "<td>" . number_format($dtl->product_total_cost) . "</td>";
                                            $tr .= "</tr>";
                                            echo $tr;
                                        }
                                        ?>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-12">
                        <div
                            class="from-group"><?php echo form_submit('reject_production', $this->lang->line('submit'), 'id="add_production" class="btn btn-primary" style="padding: 6px 15px; margin:15px 0;"'); ?>
                        </div>
                    </div>
                </div>
                <?= form_close(); ?>
            </div>
        </div>
    </div>
</div>
<div style="display:none;">
<?php
// foreach ($warehouse as $warehouse) {
//     $wh[$warehouse->id] = $warehouse->name;
// }
echo form_dropdown('warehouse_id[]', $warehouse, ($_POST['warehouse_id'] ?? $Settings->default_warehouse), 'id="list_warehouse" class="form-control input-tip select" data-placeholder="' . lang('select') . ' ' . lang('warehouse') . '" style="width:100%;" '); 
?>
</div>