<?php defined('BASEPATH') or exit('No direct script access allowed'); ?>
<div class="box">
    <div class="box-header">
        <h2 class="blue"><i class="fa-fw fa fa-plus"></i>Tambah Invoice</h2>
    </div>
    <div class="box-content">
        <?php $attrib = ['data-toggle' => 'validator', 'role' => 'form'];
            echo admin_form_open_multipart('sales/add_invoice'); 
        ?>
        <p><?= lang('enter_info'); ?></p>
        <?php
            $hdr = array();
            $delv = array();
            $amount = 0;
            $discount = 0;
            $shipping_amount = 0;
            foreach($header as $h){
                $hdr = $h;
                $amount += $h->amount;
                $discount += $h->discount + $h->product_discount;
                $shipping_amount += $h->shipping_amount;
                $delv[$h->id] = $h;
            }
            $product_tax = round(($amount - $discount) * ($tax->rate / 100));
            $total_amount = $amount - $discount + $product_tax + $shipping_amount;
        ?>
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
                    <label>No. Invoice</label>
                    <?= form_input('reff_doc', 'XXXX/INV/WTPS/XX/XXXX', 'class="form-control tip" id="reff_doc" readonly'); ?>
                </div>

                <div class="form-group">
                    <?= lang('sale_reference_no', 'sale_reference_no'); ?>
                    <?= form_input('sale_reference_no', $hdr->sale_reference_no, 'class="form-control tip" id="sale_reference_no" required="required" readonly'); ?>
                </div>
                <input type="hidden" value="<?php echo $hdr->sale_id; ?>" name="sale_id"/>

                <div class="form-group">
                    <label>Amount</label>
                    <?php echo form_input('amount_disp', number_format($amount), 'class="form-control" required="required" readonly'); ?>
                    <input type="hidden" name="amount" value="<?=$amount?>">
                </div>

                <div class="form-group">
                    <label>Total Discount</label>
                    <?php echo form_input('discount_disp', number_format($discount), 'class="form-control" required="required" readonly'); ?>
                    <input type="hidden" name="discount" value="<?=$discount?>">
                </div>

                <div class="form-group">
                    <label>Tax (<?=$tax->name?>)</label>
                    <?php echo form_input('product_tax_disp', number_format($product_tax), 'class="form-control" required="required" readonly'); ?>
                    <input type="hidden" name="product_tax" value="<?=$product_tax?>">
                </div>

                <div class="form-group">
                    <label>Total Biaya Pengiriman</label>
                    <?php echo form_input('shipping_amount_disp', number_format($shipping_amount), 'class="form-control" required="required" readonly'); ?>
                    <input type="hidden" name="shipping_amount" value="<?=$shipping_amount?>">
                </div>

                <div class="form-group">
                    <label>Net Amount</label>
                    <?php echo form_input('total_amount_disp', number_format($total_amount), 'class="form-control" required="required" readonly'); ?>
                    <input type="hidden" name="total_amount" value="<?=$total_amount?>">
                </div>
            </div>

            <div class="col-md-6">
                <div class="form-group">
                    <?= lang('customer', 'customer'); ?>
                    <?php echo form_input('customer', $sale->customer, 'class="form-control" required="required" readonly'); ?>
                </div>

                <div class="form-group">
                    <?= lang('biller', 'biller'); ?>
                    <?php echo form_input('biller', $sale->biller, 'class="form-control" required="required" readonly'); ?>
                </div>

                <div class="form-group">
                    <label>Terms Of Payment</label>
                    <?php echo form_input('payment_term', $hdr->payment_term, 'class="form-control" id="no_vehicle" required="required" readonly'); ?>
                </div>

                <div class="form-group">
                    <label>Due Date</label>
                    <?php echo form_input('due_date', date("d-M-Y", strtotime("+" . $hdr->payment_term . " days")), 'class="form-control" id="due_date" required="required" readonly'); ?>
                </div>

                <div class="form-group">
                    <?= lang('sale_status', 'slsale_status'); ?>
                    <?php $sst = ['pending' => 'Belum dibayar'];
                    echo form_dropdown('status_payment', $sst, '', 'class="form-control input-tip" required="required" id="status_payment"'); ?>

                </div>

                <div class="form-group">
                    <label>Note</label>
                    <?php
                    echo form_textarea('note', '', 'class="form-control" id="note"'); ?>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-md-12">
                <table class="table table-bordered table-condensed">
                    <thead>
                        <tr>
                            <th>Produk (Code - Nama)</th>
                            <th style="width: 100px;">Qty</th>
                            <th>UOM</th>
                            <th>Unit Price</th>
                            <th>Amount</th>
                            <th>Disc. Price</th>
                            <th>Total Price</th>
                            <th>Order Discount</th>
                            <th>Net Amount</th>
                            <th>No. Delivery</th>
                        </tr>
                    </thead>
                    <tbody>
                        <?php
                        $ttl_amount = 0;
                        $ttl_discp = 0;
                        $ttl_price = 0;
                        $ttl_ordis = 0;
                        $ttl_netamt = 0;
                        foreach($detail as $dtl){
                            $ttl_amount += $dtl->unit_price * $dtl->qty;
                            $ttl_discp += $dtl->product_discount * $dtl->qty;
                            $ttl_price += $dtl->total_price;
                            $ttl_ordis += $dtl->discount;
                            $ttl_netamt += $dtl->net_amount;
                        ?>
                        <tr>
                            <td>
                                <?=$dtl->product_code?> - <?=$dtl->product_desc?>
                                <input type="hidden" name="delv_id[]" value="<?=$dtl->delivery_id?>"/>
                            </td>
                            <td>
                                <?=number_format($dtl->qty)?>
                            </td>
                            <td>
                                <?=$dtl->unit_code?>
                            </td>
                            <td>
                                <?=number_format($dtl->unit_price)?>
                            </td>
                            <td>
                                <?=number_format($dtl->unit_price * $dtl->qty)?>
                            </td>
                            <td>
                                <?=number_format($dtl->product_discount * $dtl->qty)?>
                            </td>
                            <td>
                                <?=number_format($dtl->total_price)?>
                            </td>
                            <td>
                                <?=number_format($dtl->discount)?>
                            </td>
                            <td>
                                <?=number_format($dtl->net_amount)?>
                            </td>
                            <td>
                                <?=$delv[$dtl->delivery_id]->do_reference_no?>
                            </td>
                        </tr>
                        <?php
                        }
                        ?>
                    </tbody>
                    <tfoot style="font-weight: bold;">
                        <tr>
                            <td colspan="4">Total</td>
                            <td><?=number_format($ttl_amount)?></td>
                            <td><?=number_format($ttl_discp)?></td>
                            <td><?=number_format($ttl_price)?></td>
                            <td><?=number_format($ttl_ordis)?></td>
                            <td><?=number_format($ttl_netamt)?></td>
                            <td></td>
                        </tr>
                    </tfoot>
                </table>
            </div>
            <div class="col-md-12">
                <div class="from-group">
                    <?php echo form_submit('add_invoice', lang('submit'), 'id="add_sale" class="btn btn-primary" style="padding: 6px 15px; margin:15px 0;"'); ?>
                </div>
            </div>
        </div>
    </div>
    <?php echo form_close(); ?>
</div>
<script type="text/javascript" charset="UTF-8">
    $(document).ready(function () {
        $.fn.datetimepicker.dates['sma'] = <?=$dp_lang?>;
        $("#date").datetimepicker({
            format: 'dd-M-yyyy',
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
