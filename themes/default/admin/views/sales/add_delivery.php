<?php defined('BASEPATH') or exit('No direct script access allowed'); ?>
<div class="modal-dialog modal-lg">
    <div class="modal-content">
        <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true"><i class="fa fa-2x">&times;</i>
            </button>
            <h4 class="modal-title" id="myModalLabel"><?php echo lang('add_delivery'); ?></h4>
        </div>
        <?php $attrib = ['data-toggle' => 'validator', 'role' => 'form'];
        echo admin_form_open_multipart('sales/add_delivery/' . $inv->id, $attrib); ?>
        <div class="modal-body">
            <p><?= lang('enter_info'); ?></p>

            <div class="row">
                <div class="col-md-6">
                    <?php if ($Owner || $Admin) {
            ?>
                        <div class="form-group">
                            <?= lang('date', 'date'); ?>
                            <?= form_input('date', (isset($_POST['date']) ? $_POST['date'] : ''), 'class="form-control datetime" id="date" required="required"'); ?>
                        </div>
                    <?php
        } ?>
                    <div class="form-group">
                        <?= lang('do_reference_no', 'do_reference_no'); ?>
                        <?= form_input('do_reference_no', (isset($_POST['do_reference_no']) ? $_POST['do_reference_no'] : $do_reference_no), 'class="form-control tip" id="do_reference_no" readonly'); ?>
                    </div>

                    <div class="form-group">
                        <?= lang('sale_reference_no', 'sale_reference_no'); ?>
                        <?= form_input('sale_reference_no', (isset($_POST['sale_reference_no']) ? $_POST['sale_reference_no'] : $inv->reference_no), 'class="form-control tip" id="sale_reference_no" required="required" readonly'); ?>
                    </div>
                    <input type="hidden" value="<?php echo $inv->id; ?>" name="sale_id"/>

                    <div class="form-group">
                        <?= lang('customer', 'customer'); ?>
                        <?php echo form_input('customer', (isset($_POST['customer']) ? $_POST['customer'] : $customer->company), 'class="form-control" id="customer" required="required" readonly'); ?>
                    </div>

                    <div class="form-group">
                        <?= lang('no_vehicle', 'no_vehicle'); ?>
                        <?php echo form_input('no_vehicle', '', 'class="form-control" id="no_vehicle" required="required" '); ?>
                    </div>

                    <div class="form-group">
                        <label>Biaya Pengiriman</label>
                        <?= form_input('shipping_amount', '', 'class="form-control" name="shipping_amount"'); ?>
                    </div>

                    <div class="form-group">
                        <?= lang('address', 'address'); ?>
                        <?php
                        $av = (
            isset($_POST['address']) ? $_POST['address']
                            : (
                                empty($address)
                                ? ($customer->address . ' ' . $customer->city . ' ' . $customer->state . ' ' . $customer->postal_code . ' ' . $customer->country . '<br>' . lang('tel') . ': ' . $customer->phone . ' Email: ' . $customer->email)
                                : ($address->line1 . '<br>' . $address->line2 . '<br>' . $address->city . ' ' . $address->city . '<br>' . $address->postal_code . ' ' . $address->country . '<br>' . lang('tel') . ': ' . $address->phone)
                                )
                            );
                        echo form_textarea('address', $av, 'class="form-control" id="address" required="required"'); ?>
                    </div>
                </div>

                <div class="col-md-6">
                    <div class="form-group">
                        <?= lang('status', 'status'); ?>
                        <?php
                        $opts = ['delivering' => lang('delivering'), 'delivered' => lang('delivered')];
                        ?>
                        <?= form_dropdown('status', $opts, '', 'class="form-control" id="status" required="required" style="width:100%;"'); ?>
                    </div>

                    <div class="form-group">
                        <?= lang('delivered_by', 'delivered_by'); ?>
                        <?= form_input('delivered_by', (isset($_POST['delivered_by']) ? $_POST['delivered_by'] : ''), 'class="form-control" id="delivered_by"'); ?>
                    </div>

                    <div class="form-group">
                        <?= lang('received_by', 'received_by'); ?>
                        <?= form_input('received_by', (isset($_POST['received_by']) ? $_POST['received_by'] : ''), 'class="form-control" id="received_by"'); ?>
                    </div>

                    <div class="form-group">
                        <?= lang('attachment', 'attachment') ?>
                        <input id="attachment" type="file" data-browse-label="<?= lang('browse'); ?>" name="document" data-show-upload="false" data-show-preview="false" class="form-control file">
                    </div>

                    <div class="form-group">
                        <?= lang('note', 'note'); ?>
                        <?php echo form_textarea('note', (isset($_POST['note']) ? $_POST['note'] : ''), 'class="form-control" id="note"'); ?>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-md-12">
                    <table class="table table-bordered table-condensed">
                        <thead>
                            <tr>
                                <th>Produk (Code - Nama)</th>
                                <th style="width: 100px;">Qty Sisa</th>
                                <th style="width: 100px;">Qty</th>
                                <th>UOM</th>
                                <th style="width: 150px;">Batch Produksi</th>
                                <th>Gudang</th>
                                <th>Action</th>
                            </tr>
                        </thead>
                        <tbody>
                            <?php
                            foreach($inv_detail as $dtl){
                                $qty_sisa = $dtl->quantity;
                                foreach($delv_detail as $delv){
                                    if($dtl->product_id == $delv->product_id){
                                        $qty_sisa -= $delv->qty;
                                    }
                                }
                            ?>
                            <tr>
                                <td><?=$dtl->product_code?> - <?=$dtl->product_name?></td>
                                <td>
                                    <?= form_input('qty_order[]', number_format($qty_sisa, 0), 'class="form-control" disabled'); ?>
                                </td>
                                <td>
                                    <?= form_input('product_id[]', $dtl->product_id, 'class="form-control" style="display:none;" required="required"'); ?>
                                    <?= form_input('product_code[]', $dtl->product_code, 'class="form-control" style="display:none;" required="required"'); ?>
                                    <?= form_input('product_desc[]', $dtl->product_name, 'class="form-control" style="display:none;" required="required"'); ?>
                                    <?= form_input('qty[]', number_format($qty_sisa, 0), 'class="form-control"'); ?>
                                </td>
                                <td>
                                    <?=$dtl->product_unit_code?>
                                    <?= form_input('unit_code[]', $dtl->product_unit_code, 'class="form-control" style="display:none;"'); ?>
                                    <?= form_input('unit_id[]', $dtl->product_unit_id, 'class="form-control" style="display:none;"'); ?>
                                </td>
                                <td>
                                    <?= form_input('product_batch[]', $dtl->serial_no, 'class="form-control"'); ?>
                                </td>
                                <td>
                                    <?php
                                    foreach ($warehouse as $ws) {
                                        $wh[$ws->id] = $ws->name;
                                    }
                                    echo form_dropdown('warehouse_id[]', $wh, $dtl->warehouse_id, 'class="form-control" data-placeholder="' . lang('select') . ' ' . lang('warehouse') . '" style="width:100%;" '); 
                                    ?>
                                </td>
                                <td>
                                    <button class="btn btn-success btn-sm" onclick="tambahBatch(this)">
                                        <span class="fa fa-plus"></span>
                                    </button>
                                    <button class="btn btn-danger btn-sm" onclick="hapusBatch(this)">
                                        <span class="fa fa-close"></span>
                                    </button>
                                </td>
                            </tr>
                            <?php
                            }
                            ?>
                        </tbody>
                    </table>
                </div>
            </div>

        </div>
        <div class="modal-footer">
            <?php echo form_submit('add_delivery', lang('add_delivery'), 'class="btn btn-primary"'); ?>
        </div>
    </div>
    <?php echo form_close(); ?>
</div>
<script type="text/javascript" src="<?= $assets ?>js/custom.js"></script>
<script type="text/javascript" charset="UTF-8">
    $.fn.datetimepicker.dates['sma'] = <?=$dp_lang?>;
</script>
<?= $modal_js ?>
<script type="text/javascript" charset="UTF-8">
    $(document).ready(function () {
        $.fn.datetimepicker.dates['sma'] = <?=$dp_lang?>;
        $("#date").datetimepicker({
            format: site.dateFormats.js_ldate,
            fontAwesome: true,
            language: 'sma',
            weekStart: 1,
            todayBtn: 1,
            autoclose: 1,
            todayHighlight: 1,
            startView: 2,
            forceParse: 0
        }).datetimepicker('update', new Date());

        $('select').select2('destroy');
    });
</script>
