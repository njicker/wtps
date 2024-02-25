<?php defined('BASEPATH') or exit('No direct script access allowed'); ?>
<script type="text/javascript">
    var count = 1, an = 1, product_variant = 0, DT = <?= $Settings->default_tax_rate ?>,
        product_tax = 0, invoice_tax = 0, product_discount = 0, order_discount = 0, total_discount = 0, total = 0, allow_discount = <?= ($Owner || $Admin || $this->session->userdata('allow_discount')) ? 1 : 0; ?>,
        tax_rates = <?php echo json_encode($tax_rates); ?>;

    $(document).ready(function () {
        ItemnTotals();
        $('.bootbox').on('hidden.bs.modal', function (e) {
            $('#add_item').focus();
        });
        $("#add_item").autocomplete({
            source: function (request, response) {
                $.ajax({
                    type: 'get',
                    url: '<?= admin_url('returns/suggestions'); ?>',
                    dataType: "json",
                    data: { term: request.term },
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
                    bootbox.alert('<?= lang('no_match_found') ?>', function () {
                        $('#add_item').focus();
                    });
                    $(this).removeClass('ui-autocomplete-loading');
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
                    var row = add_return_item(ui.item);
                    if (row)
                        $(this).val('');
                } else {
                    bootbox.alert('<?= lang('no_match_found') ?>');
                }
            }
        });

        $(document).on('change', '.rqty', function(){
            var rq = parseFloat($(this).val());
            var dq = parseFloat($(this).closest("tr").find(".dqty").val());
            if(rq > dq){
                alert("Quantity retur tidak boleh lebih dari delivery");
                $("#add_return").prop("disabled", true);
                $(this).closest("tr").addClass("danger");
            }
            else {
                $("#add_return").prop("disabled", false);
                $(this).closest("tr").removeClass("danger");
            }
        });
    });

    function deleteRow(elm){
        $(elm).closest("tr").remove();
    }
</script>

<?php
$wh[''] = '';
foreach ($warehouses as $warehouse) {
    $wh[$warehouse->id] = $warehouse->name;
}
?>
<div class="box">
    <div class="box-header">
        <h2 class="blue"><i class="fa-fw fa fa-plus"></i><?= lang('add_return'); ?> (<?=$header->do_reference_no?>)</h2>
    </div>
    <div class="box-content">
        <div class="row">
            <div class="col-lg-12">

                <p class="introtext"><?php echo lang('enter_info'); ?></p>
                <?php
                $attrib = ['data-toggle' => 'validator', 'role' => 'form'];
                echo admin_form_open_multipart('returns/addprocess?no_doc='. $header->do_reference_no, $attrib);
                ?>
                <div class="row">
                    <div class="col-lg-12">
                        <?php if ($Owner || $Admin) {
                    ?>
                            <div class="col-md-4">
                                <div class="form-group">
                                    <?= lang('date', 'redate'); ?>
                                    <?php echo form_input('date', (isset($_POST['date']) ? $_POST['date'] : date("Y-m-d H:i:s")), 'class="form-control input-tip datetime" id="redate" required="required"'); ?>
                                </div>
                            </div>
                        <?php
                } ?>

                        <div class="col-md-4">
                            <div class="form-group">
                                <?= lang('reference_no', 'reref'); ?>
                                <?php echo form_input('reference_no', (isset($_POST['reference_no']) ? $_POST['reference_no'] : ''), 'class="form-control input-tip" id="reref" readonly'); ?>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div class="form-group">
                                <?= lang('customer', 'recustomer'); ?>
                                <?php
                                    echo form_input('customer_name', ($header->customer ?? ''), 'id="recustomer" required="required" class="form-control input-tip" style="width:100%;" readonly');
                                ?>
                                <input type="hidden" name="biller" value="<?=$sale_hdr->biller_id?>">
                                <input type="hidden" name="customer" value="<?=$sale_hdr->customer_id?>">
                                <input type="hidden" name="delv_id" value="<?=$header->id?>">
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div class="form-group">
                                <?= lang('warehouse', 'rewarehouse'); ?>
                                <?php
                                $wh[''] = '';
                                foreach ($warehouses as $warehouse) {
                                    $wh[$warehouse->id] = $warehouse->name;
                                }
                                echo form_dropdown('warehouse', $wh, (isset($_POST['warehouse']) ? $_POST['warehouse'] : $Settings->default_warehouse), 'id="rewarehouse" class="form-control input-tip select" data-placeholder="' . lang('select') . ' ' . lang('warehouse') . '" required="required" style="width:100%;" '); ?>
                            </div>
                        </div>

                        <?php if ($Settings->tax2) {
                                    ?>
                            <!-- <div class="col-md-4">
                                <div class="form-group">
                                    <?= lang('order_tax', 'retax2'); ?>
                                    <?php
                                    $tr[''] = '';
                                    foreach ($tax_rates as $tax) {
                                        $tr[$tax->id] = $tax->name;
                                    }
                                    echo form_dropdown('order_tax', $tr, (isset($_POST['order_tax']) ? $_POST['order_tax'] : $Settings->default_tax_rate2), 'id="retax2" data-placeholder="' . lang('select') . ' ' . lang('order_tax') . '" class="form-control input-tip select" style="width:100%;"'); ?>
                                </div>
                            </div> -->
                        <?php
                                } ?>

                        <?php if ($Owner || $Admin || $this->session->userdata('allow_discount')) {
                                    ?>
                            <!-- <div class="col-md-4">
                                <div class="form-group">
                                    <?= lang('order_discount', 'rediscount'); ?>
                                    <?php echo form_input('order_discount', '', 'class="form-control input-tip" id="rediscount"'); ?>
                                </div>
                            </div> -->
                        <?php
                                } ?>
                        <div class="col-md-4">
                            <div class="form-group">
                                <label>Biaya Pengiriman</label>
                                <?php echo form_input('shipping', '', 'class="form-control input-tip" id="reshipping"'); ?>
                            </div>
                        </div>

                        <div class="col-md-4">
                            <div class="form-group">
                                <label>Divisi</label>
                                <?php echo form_input('division', $sale_hdr->division, 'class="form-control input-tip" id="division" readonly'); ?>
                            </div>
                        </div>

                        <div class="col-md-4">
                            <div class="form-group">
                                <?= lang('document', 'document') ?>
                                <input id="document" type="file" data-browse-label="<?= lang('browse'); ?>" name="document" data-show-upload="false"
                                       data-show-preview="false" class="form-control file">
                            </div>
                        </div>
                        <div class="clearfix"></div>

                        <div class="col-md-12" id="sticker">
                            <!-- <div class="well well-sm">
                                <div class="form-group" style="margin-bottom:0;">
                                    <div class="input-group wide-tip">
                                        <div class="input-group-addon" style="padding-left: 10px; padding-right: 10px;">
                                            <i class="fa fa-2x fa-barcode addIcon"></i></a></div>
                                        <?php echo form_input('add_item', '', 'class="form-control input-lg" id="add_item" placeholder="' . lang('add_product_to_order') . '"'); ?>
                                        <?php if ($Owner || $Admin || $GP['products-add']) {
                                    ?>
                                        <div class="input-group-addon" style="padding-left: 10px; padding-right: 10px;">
                                            <a href="#" id="addManually" class="tip" title="<?= lang('add_product_manually') ?>">
                                                <i class="fa fa-2x fa-plus-circle addIcon" id="addIcon"></i>
                                            </a>
                                        </div>
                                        <?php
                                } ?>
                                    </div>
                                </div>
                                <div class="clearfix"></div>
                            </div> -->
                        </div>

                        <div class="col-md-12">
                            <div class="control-group table-group">
                                <label class="table-label"><?= lang('order_items'); ?> *</label>

                                <div class="controls table-controls">
                                    <table id="reTable" class="table items table-striped table-bordered table-condensed table-hover sortable_table">
                                        <thead>
                                        <tr>
                                            <th class="col-md-4"><?= lang('product') . ' (' . lang('code') . ' - ' . lang('name') . ')'; ?></th>
                                            <th class="col-md-2">Batch Produk</th>
                                            <th class="col-md-2"><?= lang('unit_price'); ?></th>
                                            <th class="col-md-1"><?= lang('discount'); ?></th>
                                            <th class="col-md-1">UoM</th>
                                            <th class="col-md-1">Qty Delv</th>
                                            <th class="col-md-1">Qty Retur</th>
                                            <?php
                                            // if ($Settings->product_discount && ($Owner || $Admin || $this->session->userdata('allow_discount'))) {
                                            //     echo '<th class="col-md-1">' . lang('discount') . '</th>';
                                            // }
                                            ?>
                                            <?php
                                            // if ($Settings->tax1) {
                                            //     echo '<th class="col-md-1">' . lang('product_tax') . '</th>';
                                            // }
                                            ?>
                                            <!-- <th>
                                                <?= lang('subtotal'); ?>
                                                (<span class="currency"><?= $default_currency->code ?></span>)
                                            </th> -->
                                            <th style="width: 30px;">
                                                <i class="fa fa-trash-o" style="opacity:0.5; filter:alpha(opacity=50);"></i>
                                            </th>
                                        </tr>
                                        </thead>
                                        <tbody>
                                            <?php 
                                            $total_qty = 0;
                                            foreach($detail as $dtl){ 
                                            ?>
                                            <?php
                                                $total_qty = $dtl->qty;
                                                $qty = $dtl->qty;
                                                if(isset($return_dtl_hist[$dtl->product_id."#".$dtl->product_batch])){
                                                    foreach($return_dtl_hist[$dtl->product_id."#".$dtl->product_batch] as $hist){
                                                        $qty -= $hist->quantity;
                                                    }
                                                }
                                            ?>
                                                <tr>
                                                    <td>
                                                        <?=$dtl->product_code?> - <?=$dtl->product_desc?>
                                                        <input type="hidden" name="product_id[]" value="<?=$dtl->product_id?>" />
                                                        <input type="hidden" name="product_code[]" value="<?=$dtl->product_code?>" />
                                                        <input type="hidden" name="product_name[]" value="<?=$dtl->product_desc?>" />
                                                        <input type="hidden" name="product_type[]" value="<?=$sale_dtl[$dtl->product_id]->product_type?>" />
                                                    </td>
                                                    <td>
                                                        <input type="text" class="form-control" name="product_batch[]" value="<?=$dtl->product_batch?>" readonly/>
                                                    </td>
                                                    <td>
                                                        <input type="text" class="form-control" name="unit_price[]" value="<?=number_format($sale_dtl[$dtl->product_id]->real_unit_price)?>" readonly/>
                                                        <input type="hidden" class="form-control" name="real_unit_price[]" value="<?=$sale_dtl[$dtl->product_id]->real_unit_price?>" readonly/>
                                                    </td>
                                                    <td>
                                                        <input type="text" class="form-control" value="<?=number_format($sale_dtl[$dtl->product_id]->discount)?>" readonly/>
                                                        <input type="hidden" class="form-control" name="product_discount[]" value="<?=$sale_dtl[$dtl->product_id]->discount?>" readonly/>
                                                    </td>
                                                    <td>
                                                        <input type="text" class="form-control" name="unit_code[]" value="<?=$dtl->unit_code?>" readonly/>
                                                        <input type="hidden" class="form-control" name="product_unit[]" value="<?=$dtl->unit_id?>" readonly/>
                                                    </td>
                                                    <td><input type="text" class="form-control dqty" name="qty_delv[]" value="<?=number_format($qty)?>" readonly/></td>
                                                    <td><input type="text" class="form-control rqty" name="quantity[]" value=""/></td>
                                                    <td>
                                                        <i class="fa fa-trash-o" style="opacity:0.5; filter:alpha(opacity=50); cursor:pointer;" onclick="deleteRow(this)"></i>
                                                    </td>
                                                    <?php
                                                    // if ($Settings->product_discount && ($Owner || $Admin || $this->session->userdata('allow_discount'))) {
                                                    //     echo '<td>' . lang('discount') . '</td>';
                                                    // }
                                                    ?>
                                                    <?php
                                                    // if ($Settings->tax1) {
                                                    //     echo '<td>' . lang('product_tax') . '</td>';
                                                    // }
                                                    ?>
                                                </tr>
                                            <?php } ?>
                                        </tbody>
                                        <tfoot></tfoot>
                                    </table>
                                </div>
                            </div>
                        </div>
                        <div class="clearfix"></div>
                        <input type="hidden" name="total_items" value="" id="total_items" required="required"/>

                        <div class="row" id="bt">
                            <div class="col-md-12">
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <?= lang('tax', 'tax') ?>
                                        <?php
                                        $tr[''] = '';
                                        foreach ($tax_rates as $tax) {
                                            $tr[$tax->id] = $tax->name;
                                        }
                                        echo form_dropdown('order_tax_id', $tr, $sale_hdr->order_tax_id, 'id="order_tax_id" class="form-control input-tip" style="width:100%;" disabled'); 
                                        ?>
                                        <input type="hidden" name="order_tax" value="<?=$sale_hdr->order_tax_id?>">
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <?= lang('order_discount', 'order_discount') ?>
                                        <?php echo form_input('order_discount_disp', number_format($header->discount), 'class="form-control input-tip" id="rediscount" readonly'); ?>
                                        <input type="hidden" name="order_discount" value="<?=$header->discount?>">
                                        <input type="hidden" name="total_all_qty" value="<?=$total_qty?>">
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-12">
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <?= lang('return_note', 'renote'); ?>
                                        <?php echo form_textarea('note', (isset($_POST['note']) ? $_POST['note'] : ''), 'class="form-control" id="renote" style="margin-top: 10px; height: 100px;"'); ?>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <?= lang('staff_note', 'reinnote'); ?>
                                        <?php echo form_textarea('staff_note', (isset($_POST['staff_note']) ? $_POST['staff_note'] : ''), 'class="form-control" id="reinnote" style="margin-top: 10px; height: 100px;"'); ?>

                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-12">
                            <div
                                class="fprom-group"><?php echo form_submit('add_return', lang('submit'), 'id="add_return" class="btn btn-primary" style="padding: 6px 15px; margin:15px 0;"'); ?>
                                <button type="button" class="btn btn-danger" id="reset"><?= lang('reset') ?></div>
                        </div>
                    </div>
                </div>
                <!-- <div id="bottom-total" class="well well-sm" style="margin-bottom: 0;">
                    <table class="table table-bordered table-condensed totals" style="margin-bottom:0;">
                        <tr class="warning">
                            <td><?= lang('items') ?> <span class="totals_val pull-right" id="titems">0</span></td>
                            <td><?= lang('total') ?> <span class="totals_val pull-right" id="total">0.00</span></td>
                            <?php if ($Owner || $Admin || $this->session->userdata('allow_discount')) {
                                                ?>
                            <td><?= lang('order_discount') ?> <span class="totals_val pull-right" id="tds">0.00</span></td>
                            <?php
                                            }?>
                            <?php if ($Settings->tax2) {
                                                ?>
                                <td><?= lang('order_tax') ?> <span class="totals_val pull-right" id="ttax2">0.00</span></td>
                            <?php
                                            } ?>
                            <td><?= lang('grand_total') ?> <span class="totals_val pull-right" id="gtotal">0.00</span></td>
                        </tr>
                    </table>
                </div> -->

                <?php echo form_close(); ?>

            </div>

        </div>
    </div>
</div>

<div class="modal" id="prModal" tabindex="-1" role="dialog" aria-labelledby="prModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true"><i
                            class="fa fa-2x">&times;</i></span><span class="sr-only"><?=lang('close');?></span></button>
                <h4 class="modal-title" id="prModalLabel"></h4>
            </div>
            <div class="modal-body" id="pr_popover_content">
                <form class="form-horizontal" role="form">
                    <?php if ($Settings->tax1) {
                                                ?>
                        <div class="form-group">
                            <label class="col-sm-4 control-label"><?= lang('product_tax') ?></label>
                            <div class="col-sm-8">
                                <?php
                                $tr[''] = '';
                                                foreach ($tax_rates as $tax) {
                                                    $tr[$tax->id] = $tax->name;
                                                }
                                                echo form_dropdown('ptax', $tr, '', 'id="ptax" class="form-control pos-input-tip" style="width:100%;"'); ?>
                            </div>
                        </div>
                    <?php
                                            } ?>
                    <?php if ($Settings->product_serial) {
                                                ?>
                        <div class="form-group">
                            <label for="pserial" class="col-sm-4 control-label"><?= lang('serial_no') ?></label>

                            <div class="col-sm-8">
                                <input type="text" class="form-control" id="pserial">
                            </div>
                        </div>
                    <?php
                                            } ?>
                    <div class="form-group">
                        <label for="pquantity" class="col-sm-4 control-label"><?= lang('quantity') ?></label>

                        <div class="col-sm-8">
                            <input type="text" class="form-control" id="pquantity">
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="punit" class="col-sm-4 control-label"><?= lang('product_unit') ?></label>
                        <div class="col-sm-8">
                            <div id="punits-div"></div>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="poption" class="col-sm-4 control-label"><?= lang('product_option') ?></label>
                        <div class="col-sm-8">
                            <div id="poptions-div"></div>
                        </div>
                    </div>
                    <?php if ($Settings->product_discount && ($Owner || $Admin || $this->session->userdata('allow_discount'))) {
                                                ?>
                        <div class="form-group">
                            <label for="pdiscount"
                                   class="col-sm-4 control-label"><?= lang('product_discount') ?></label>

                            <div class="col-sm-8">
                                <input type="text" class="form-control" id="pdiscount">
                            </div>
                        </div>
                    <?php
                                            } ?>
                    <div class="form-group">
                        <label for="pprice" class="col-sm-4 control-label"><?= lang('unit_price') ?></label>

                        <div class="col-sm-8">
                            <input type="text" class="form-control" id="pprice" <?= ($Owner || $Admin || $GP['edit_price']) ? '' : 'readonly'; ?>>
                        </div>
                    </div>
                    <table class="table table-bordered table-striped">
                        <tr>
                            <th style="width:25%;"><?= lang('net_unit_price'); ?></th>
                            <th style="width:25%;"><span id="net_price"></span></th>
                            <th style="width:25%;"><?= lang('product_tax'); ?></th>
                            <th style="width:25%;"><span id="pro_tax"></span></th>
                        </tr>
                    </table>
                    <input type="hidden" id="punit_price" value=""/>
                    <input type="hidden" id="old_tax" value=""/>
                    <input type="hidden" id="old_qty" value=""/>
                    <input type="hidden" id="old_price" value=""/>
                    <input type="hidden" id="row_id" value=""/>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-primary" id="editItem"><?= lang('submit') ?></button>
            </div>
        </div>
    </div>
</div>

<div class="modal" id="mModal" tabindex="-1" role="dialog" aria-labelledby="mModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true"><i
                            class="fa fa-2x">&times;</i></span><span class="sr-only"><?=lang('close');?></span></button>
                <h4 class="modal-title" id="mModalLabel"><?= lang('add_product_manually') ?></h4>
            </div>
            <div class="modal-body" id="pr_popover_content">
                <form class="form-horizontal" role="form">
                    <div class="form-group">
                        <label for="mcode" class="col-sm-4 control-label"><?= lang('product_code') ?> *</label>

                        <div class="col-sm-8">
                            <input type="text" class="form-control" id="mcode">
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="mname" class="col-sm-4 control-label"><?= lang('product_name') ?> *</label>

                        <div class="col-sm-8">
                            <input type="text" class="form-control" id="mname">
                        </div>
                    </div>
                    <?php if ($Settings->tax1) {
                                                ?>
                        <div class="form-group">
                            <label for="mtax" class="col-sm-4 control-label"><?= lang('product_tax') ?> *</label>

                            <div class="col-sm-8">
                                <?php
                                $tr[''] = '';
                                                foreach ($tax_rates as $tax) {
                                                    $tr[$tax->id] = $tax->name;
                                                }
                                                echo form_dropdown('mtax', $tr, '', 'id="mtax" class="form-control input-tip select" style="width:100%;"'); ?>
                            </div>
                        </div>
                    <?php
                                            } ?>
                    <div class="form-group">
                        <label for="mquantity" class="col-sm-4 control-label"><?= lang('quantity') ?> *</label>

                        <div class="col-sm-8">
                            <input type="text" class="form-control" id="mquantity">
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="munit" class="col-sm-4 control-label"><?= lang('unit') ?> *</label>

                        <div class="col-sm-8">
                            <?php
                            $uts[''] = '';
                            foreach ($units as $unit) {
                                $uts[$unit->id] = $unit->name;
                            }
                            echo form_dropdown('munit', $uts, '', 'id="munit" class="form-control input-tip select" style="width:100%;"');
                            ?>
                        </div>
                    </div>
                    <?php if ($Settings->product_discount && ($Owner || $Admin || $this->session->userdata('allow_discount'))) {
                                ?>
                        <div class="form-group">
                            <label for="mdiscount"
                                   class="col-sm-4 control-label"><?= lang('product_discount') ?></label>

                            <div class="col-sm-8">
                                <input type="text" class="form-control" id="mdiscount">
                            </div>
                        </div>
                    <?php
                            } ?>
                    <div class="form-group">
                        <label for="mprice" class="col-sm-4 control-label"><?= lang('unit_price') ?> *</label>

                        <div class="col-sm-8">
                            <input type="text" class="form-control" id="mprice">
                        </div>
                    </div>
                    <table class="table table-bordered table-striped">
                        <tr>
                            <th style="width:25%;"><?= lang('net_unit_price'); ?></th>
                            <th style="width:25%;"><span id="mnet_price"></span></th>
                            <th style="width:25%;"><?= lang('product_tax'); ?></th>
                            <th style="width:25%;"><span id="mpro_tax"></span></th>
                        </tr>
                    </table>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-primary" id="addItemManually"><?= lang('submit') ?></button>
            </div>
        </div>
    </div>
</div>
