<?php defined('BASEPATH') or exit('No direct script access allowed'); ?>
<style>
    .modal-title{
        font-size: 20px;
        text-decoration: underline;
        text-align: center;
        margin-bottom: 20px;
    }
    .table-info td{
        border-top: 0px!important;
        padding-top: 3px!important;
        padding-bottom: 3px!important;
    }
    .table-info{
        margin-bottom: 10px!important;
    }
    .modal-dialog{
        font-size: 12px!important;
    }
    .table-detail tfoot{
        font-weight: bold;
    }
    .hr_stamp{
        border-top:1px solid black !important;
    }
    .label-reff{
        font-size: 14px;
        font-weight: bold;
    }
</style>
<div class="modal-dialog modal-lg no-modal-header">
    <div class="modal-content">
        <div class="modal-body">
            <div class="row">
                <div class="col-sm-12">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                        <i class="fa fa-2x">&times;</i>
                    </button>
                    <button type="button" class="btn btn-xs btn-default no-print pull-right" style="margin-right:15px;" onclick="window.print();">
                        <i class="fa fa-print"></i> <?= lang('print'); ?>
                    </button>
                </div>
            </div>
            <h3 class="modal-title">Pesanan Penjualan</h3>
            <div class="row">
                <div class="col-sm-6 col-xs-6">
                    <img src="<?=base_url('themes/default/admin/assets/images/icon_wtps.png')?>" width="200px" class="img-login" alt="logo">
                    <p>
                        <b>PT. WIJAYA TUNGGAL PERKASA SEJAHTERA</b><br/>
                        Kp. Cipancuh, Padaasih, Kec. Cibogo<br/>
                        Kab. Subang
                    </p>
                </div>
                <div class="col-sm-6 col-xs-6">
                    <table class="table table-info">
                        <tbody>
                            <tr>
                                <td>No. Faktur</td>
                                <td>:</td>
                                <td><span class="label-reff"><?= $inv->reference_no; ?></span></td>
                            </tr>
                            <tr>
                                <td>Tanggal</td>
                                <td>:</td>
                                <td><?= date("d-M-Y", strtotime($inv->date)); ?></td>
                            </tr>
                            <tr>
                                <td>TOP</td>
                                <td>:</td>
                                <td><?= $inv->payment_term == 0 ? 'Cash' : $inv->payment_term . ' hari'; ?></td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>
            <div class="row">
                <div class="col-sm-6 col-xs-6">
                    <table class="table table-info">
                        <tbody>
                            <tr>
                                <td style="width: 100px;">Dikirim ke</td>
                                <td style="width: 10px;">:</td>
                                <td><b><?= $customer->company; ?></b></td>
                            </tr>
                            <tr>
                                <td></td>
                                <td></td>
                                <td><?= $customer->address . '<br>' . $customer->city . ' ' . $customer->postal_code . ' ' . $customer->state . '<br>' . $customer->country; ?></td>
                            </tr>
                            <tr>
                                <td></td>
                                <td></td>
                                <td><?= $customer->phone; ?></td>
                            </tr>
                        </tbody>
                    </table>
                </div>
                <div class="col-sm-6 col-xs-6">
                    <table class="table table-info">
                        <tbody>
                            <tr>
                                <td style="width: 100px;">Ditagihkan ke</td>
                                <td style="width: 10px;">:</td>
                                <td><b><?= $biller->company; ?></b></td>
                            </tr>
                            <tr>
                                <td></td>
                                <td></td>
                                <td><?= $biller->address . '<br>' . $biller->city . ' ' . $biller->postal_code . ' ' . $biller->state . '<br>' . $biller->country; ?></td>
                            </tr>
                            <tr>
                                <td></td>
                                <td></td>
                                <td><?= $biller->phone; ?></td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>
            <div class="row">
                <div class="col-sm-12 col-xs-12">
                    <table class="table table-detail">
                        <thead>
                            <tr>
                                <th>No</th>
                                <th>Deskripsi</th>
                                <th>Qty</th>
                                <th>Satuan</th>
                                <th>Harga</th>
                                <th>Diskon</th>
                                <th>Sub Total</th>
                            </tr>
                        </thead>
                        <tbody>
                        <?php $r = 1; $total_qty = 0; $total_amount = 0;
                            foreach ($rows as $row){
                        ?>
                            <tr>
                                <td style="text-align:center; width:40px; vertical-align:middle;"><?= $r; ?></td>
                                <td><?= $row->product_code . ' - ' . $row->product_name ?></td>
                                <td style="text-align:center"><?= $this->sma->formatQuantity($row->unit_quantity); ?></td>
                                <td style="text-align:center"><?= ($inv->sale_status == 'returned' ? $row->base_unit_code : $row->product_unit_code) ?></td>
                                <td style="text-align:right"><?= $this->sma->formatMoney(ceil($row->unit_price)); ?></td>
                                <td style="text-align:right"><?= $row->discount > 0 ? $this->sma->formatMoney($row->discount) : '' ?></td>
                                <td style="text-align:right"><?= $this->sma->formatMoney($row->subtotal) ?></td>
                            </tr>
                        <?php $r++; $total_qty += $row->unit_quantity; $total_amount += ($row->unit_quantity * $row->unit_price);} ?>
                        </tbody>
                        <tfoot>
                            <tr>
                                <td colspan="2">Total</td>
                                <td style="text-align:center"><?=$this->sma->formatQuantity($total_qty)?></td>
                                <td></td>
                                <td></td>
                                <td></td>
                                <td style="text-align:right"><?=$this->sma->formatMoney($total_amount)?></td>
                            </tr>
                            <?php if($inv->order_discount > 0){ ?>
                            <tr>
                                <td colspan="6" style="text-align:right">Order Diskon</td>
                                <td style="text-align:right"><?=$this->sma->formatMoney($inv->order_discount)?></td>
                            </tr>
                            <?php } ?>
                            <?php if($inv->order_tax > 0){ ?>
                            <tr>
                                <td colspan="6" style="text-align:right">PPN</td>
                                <td style="text-align:right"><?=$this->sma->formatMoney($inv->order_tax)?></td>
                            </tr>
                            <?php } ?>
                            <tr>
                                <td colspan="6" style="text-align:right">Grand Total</td>
                                <td style="text-align:right"><?=$this->sma->formatMoney($inv->grand_total)?></td>
                            </tr>
                        </tfoot>
                    </table>
                </div>
            </div>
            <div class="row">
                <div class="col-sm-6 col-xs-6">
                    <p>
                        Catatan :<br/>
                        - Barang telah diterima dengan baik dan sesuai jumlah.<br/>
                        - Pembayaran transfer  ke rekening <b>Bank Mandiri an. PT. Wijaya Tunggal Perkasa Sejahtera (1730080080808)</b><br/>
                        - Pembayaran diterima secara penuh tanpa potongan biaya transaksi / admin bank<br/>
                        - Konfirmasi pembayaran Telp (WA). 085624877881<br/>
                    </p>
                </div>
                <div class="col-sm-6 col-xs-6">
                    <div class="col-sm-4 col-xs-4">
                        <p style="height:100px;"><?= lang('created_by'); ?>
                                :<br/> <?= $inv->created_by ? $created_by->first_name . ' ' . $created_by->last_name : ''; ?> </p>
                            <hr class="hr_stamp">
                        <!-- <p><?= lang('stamp_sign'); ?></p> -->
                    </div>
                    <div class="col-sm-4 col-xs-4">
                        <p style="height:100px;"><?= lang('delivered_by'); ?>
                                :</p>
                            <hr class="hr_stamp">
                        <!-- <p><?= lang('stamp_sign'); ?></p> -->
                    </div>
                    <div class="col-sm-4 col-xs-4">
                        <p style="height:100px;"><?= lang('received_by'); ?>
                                :</p>
                            <hr class="hr_stamp">
                        <!-- <p><?= lang('stamp_sign'); ?></p> -->
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<script type="text/javascript">
    $(document).ready( function() {
        $('.tip').tooltip();
    });
</script>
