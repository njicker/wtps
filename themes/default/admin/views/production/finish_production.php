<?php defined('BASEPATH') or exit('No direct script access allowed'); ?>
<script>
    $(document).ready(function () {
        $('.gen_slug').change(function(e) {
            console.log($(this).val());
            getSlug($(this).val(), 'products');
        });

        $("#add_item_goods").autocomplete({
            // source: '<?= admin_url('purchases/suggestions/combo'); ?>',
            source: function (request, response) {
                $.ajax({
                    type: 'get',
                    url: '<?= admin_url('purchases/suggestions/combo'); ?>',
                    dataType: "json",
                    data: {
                        term: request.term,
                        // supplier_id: $("#posupplier").val()
                    },
                    success: function (data) {
                        $(this).removeClass('ui-autocomplete-loading');
                        response(data);
                    }
                });
            },
            minLength: 1,
            autoFocus: false,
            delay: 250,
            response: function (event, ui) {
                if ($(this).val().length >= 16 && ui.content[0].id == 0) {
                    //audio_error.play();
                    bootbox.alert('<?= lang('no_match_found') ?>', function () {
                        $('#add_item_goods').focus();
                    });
                    $(this).removeClass('ui-autocomplete-loading');
                    $(this).val('');
                }
                else if (ui.content.length == 1 && ui.content[0].id != 0) {
                    ui.item = ui.content[0];
                    $(this).data('ui-autocomplete')._trigger('select', 'autocompleteselect', ui);
                    $(this).autocomplete('close');
                    $(this).removeClass('ui-autocomplete-loading');
                }
                else if (ui.content.length == 1 && ui.content[0].id == 0) {
                    //audio_error.play();
                    bootbox.alert('<?= lang('no_match_found') ?>', function () {
                        $('#add_item_goods').focus();
                    });
                    $(this).removeClass('ui-autocomplete-loading');
                    $(this).val('');
                }
            },
            select: function (event, ui) {
                event.preventDefault();
                if (ui.item.id !== 0) {
                    var row = add_finish_item(ui.item);
                    if (row)
                        $(this).val('');
                } else {
                    //audio_error.play();
                    bootbox.alert('<?= lang('no_match_found') ?>');
                }
            }
        });
    });
</script>
<div class="box">
    <div class="box-header">
        <h2 class="blue"><i class="fa-fw fa fa-check"></i><?= $title ?></h2>
    </div>
    <div class="box-content">
        <div class="row">
            <div class="col-md-12">

                <p class="introtext"><?php echo lang('enter_info'); ?></p>

                <?php
                $attrib = ['data-toggle' => 'validator', 'role' => 'form'];
                echo admin_form_open_multipart('production/finish_production', $attrib);
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
                    </div>
                    <div class="col-md-5">
                        <div class="form-group">
                            <div class="form-group all">
                                <?= lang('status', 'status'); ?>
                                <?= form_input('status_doc', 'Finish', 'class="form-control' . ($Settings->use_code_for_slug ? '' : ' gen_slug') . '" id="status_doc" required="required" readonly'); ?>
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
                                            <th style="width:100px;">Confirm Qty</th>
                                            <th>UOM</th>
                                            <th>Product batch</th>
                                            <th>Gudang</th>
                                            <!-- <th>Total Cost</th> -->
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <?php
                                        foreach($detail as $dtl){
                                            $tr = "<tr>";
                                                $tr .= "<td>" . $dtl->product_code . " - " . $dtl->name . "</td>";
                                                $tr .= "<td>" . $dtl->qty . "</td>";
                                                $tr .= "<td><input type='text' value='" . $dtl->qty . "' name='raw_confirm_qty[]' class='form-control' />";
                                                $tr .= "<input type='hidden' name='raw_product_id[]' value='" . $dtl->product_id . "'/>";
                                                $tr .= "<input type='hidden' name='raw_product_code[]' value='" . $dtl->product_code . "'/>";
                                                $tr .= "<input type='hidden' name='raw_qty[]' value='" . $dtl->qty . "'/>";
                                                $tr .= "<input type='hidden' name='raw_warehouse_id[]' value='" . $dtl->warehouse_id . "'/>";
                                                $tr .= "<input type='hidden' name='raw_type_item[]' value='" . $dtl->type_item . "'/>";
                                                $tr .= "<input type='hidden' name='raw_unit_id[]' value='" . $dtl->unit_id . "'/>";
                                                $tr .= "<input type='hidden' name='raw_unit_code[]' value='" . $dtl->unit_code . "'/>";
                                                $tr .= "<input type='hidden' name='raw_purchase_id[]' value='" . $dtl->purchase_id . "'/>";
                                                $tr .= "<input type='hidden' name='raw_product_batch[]' value='" . $dtl->product_batch . "'/>";
                                                $tr .= "</td>";
                                                $tr .= "<td>" . $dtl->unit_code . "</td>";
                                                $tr .= "<td>" . $dtl->product_batch . "</td>";
                                                $tr .= "<td>" . $warehouse[$dtl->warehouse_id] . "</td>";
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
                    <div class="col-md-12" id="sticker">
                        <div class="well well-sm">
                            <div class="form-group" style="margin-bottom:0;">
                                <div class="input-group wide-tip">
                                    <div class="input-group-addon" style="padding-left: 10px; padding-right: 10px;">
                                        <i class="fa fa-2x fa-barcode addIcon"></i></a></div>
                                    <?php echo form_input('add_item_goods', '', 'class="form-control input-lg" id="add_item_goods" placeholder="' . $this->lang->line('add_product_to_order') . '"'); ?>
                                    <?php if ($Owner || $Admin || $GP['products-add']) {
                                ?>
                                    <div class="input-group-addon" style="padding-left: 10px; padding-right: 10px;">
                                        <a href="<?= admin_url('products/add') ?>" id="addManually1"><i
                                                class="fa fa-2x fa-plus-circle addIcon" id="addIcon"></i></a></div>
                                    <?php
                            } ?>
                                </div>
                            </div>
                            <div class="clearfix"></div>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-12">
                        <div class="control-group table-group">
                            <label class="table-label">Finish Goods</label>

                            <div class="controls table-controls">
                                <table id="poTable"
                                    class="table items table-striped table-bordered table-condensed table-hover sortable_table">
                                    <thead>
                                        <tr>
                                            <th>Produk (Code - Nama)</th>
                                            <th>Qty</th>
                                            <th>UOM</th>
                                            <th>Gudang</th>
                                            <th></th>
                                        </tr>
                                    </thead>
                                    <tbody></tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="row">
                <div class="col-md-12">
                    <div
                        class="from-group"><?php echo form_submit('finish_production', $this->lang->line('submit'), 'id="add_production" class="btn btn-primary" style="padding: 6px 15px; margin:15px 0;"'); ?>
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