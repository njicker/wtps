<?php defined('BASEPATH') or exit('No direct script access allowed'); ?>
<script>
    $(document).ready(function () {
        $('.gen_slug').change(function(e) {
            console.log($(this).val());
            getSlug($(this).val(), 'products');
        });

        $("#add_item").autocomplete({
            // source: '<?= admin_url('purchases/suggestions'); ?>',
            source: function (request, response) {
                $.ajax({
                    type: 'get',
                    url: '<?= admin_url('purchases/suggestions'); ?>/all',
                    dataType: "json",
                    data: {
                        term: request.term,
                        supplier_id: $("#posupplier").val(),
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
                        $('#add_item').focus();
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
                        $('#add_item').focus();
                    });
                    $(this).removeClass('ui-autocomplete-loading');
                    $(this).val('');
                }
            },
            select: function (event, ui) {
                event.preventDefault();
                if (ui.item.id !== 0) {
                    var row = add_item(ui.item);
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
        <h2 class="blue"><i class="fa-fw fa fa-plus"></i><?= $title ?></h2>
    </div>
    <div class="box-content">
        <div class="row">
            <div class="col-md-12">

                <p class="introtext"><?php echo lang('enter_info'); ?></p>

                <?php
                $attrib = ['data-toggle' => 'validator', 'role' => 'form'];
                echo admin_form_open_multipart('storage/add_damage', $attrib);
                ?>
                <div class="row">
                    <div class="col-md-5">
                        <div class="form-group">
                            <div class="form-group all">
                                <label>No. Referensi</label>
                                <?= form_input('reference', ($_POST['reference'] ?? ""), 'class="form-control" id="reference" readonly'); ?>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-5">
                        <div class="form-group">
                            <div class="form-group all">
                                <label>Reason</label>
                                <?= form_input('reason', ($_POST['reason'] ?? ""), 'class="form-control" id="reason" required="required"'); ?>
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
                                    <?php echo form_input('add_item', '', 'class="form-control input-lg" id="add_item" placeholder="' . $this->lang->line('add_product_to_order') . '"'); ?>
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
                            <label class="table-label">Produk</label>

                            <div class="controls table-controls">
                                <table id="poTable"
                                    class="table items table-striped table-bordered table-condensed table-hover sortable_table">
                                    <thead>
                                        <tr>
                                            <th>Produk (Code - Nama)</th>
                                            <th>Batch Produk</th>
                                            <th>Qty</th>
                                            <th>UOM</th>
                                            <th>Gudang</th>
                                            <th>Notes</th>
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
                        class="from-group"><?php echo form_submit('add_damage', $this->lang->line('submit'), 'id="add_production" class="btn btn-primary" style="padding: 6px 15px; margin:15px 0;"'); ?>
                    </div>
                </div>
                <?= form_close(); ?>
            </div>
        </div>
    </div>
</div>
<div style="display:none;">
<?php
// foreach ($warehouses as $warehouse) {
//     $wh[$warehouse->id] = $warehouse->name;
// }
echo form_dropdown('warehouse_id[]', $warehouses, ($_POST['warehouse_id'] ?? $Settings->default_warehouse), 'id="list_warehouse" class="form-control input-tip select" data-placeholder="' . lang('select') . ' ' . lang('warehouse') . '" style="width:100%;" '); 
?>
</div>