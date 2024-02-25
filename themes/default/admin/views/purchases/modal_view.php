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
    .hr_stamp_top{
        border-top:1px solid black !important;
        margin-top: 2px!important;
        margin-bottom: 20px!important;
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
            <div class="row">
                <div class="col-sm-2 col-xs-2">
                    <img src="<?=base_url('themes/default/admin/assets/images/icon_wtps.png')?>" width="200px" class="img-login" alt="logo">
                </div>
                <div class="col-sm-8 col-xs-8">
                    <p style="text-align:center;">
                        <b>PT. WIJAYA TUNGGAL PERKASA SEJAHTERA</b><br/>
                        Kp. Cipancuh, Padaasih, Kec. Cibogo<br/>
                        Kab. Subang
                    </p>
                </div>
            </div>
            <hr class="hr_stamp_top">
            <h3 class="modal-title">Order Sheet</h3>
            <div class="row">
                <div class="col-sm-6 col-xs-6">
                    <p>
                        Kepada Yth,<br/>
                        <b><?=$supplier->company?></b><br/>
                        <?= $supplier->address . '<br />' . $supplier->city . ' ' . $supplier->postal_code . '<br/>' . $supplier->state . ', ' . $supplier->country ?><br/>
                        Telp: <?= $supplier->phone ?>
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
                <div class="col-sm-12">
                    <p>
                        Dengan Hormat,<br/>
                        Bersama ini kami ingin memesan barang sebagai berikut:
                    </p>
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
                                <td style="text-align:center"><?= ($row->product_unit_code) ?></td>
                                <td style="text-align:right"><?= $this->sma->formatMoney(ceil($row->real_unit_cost)); ?></td>
                                <td style="text-align:right"><?= $row->discount > 0 ? $this->sma->formatMoney($row->discount) : '' ?></td>
                                <td style="text-align:right"><?= $this->sma->formatMoney($row->subtotal) ?></td>
                            </tr>
                        <?php $r++; $total_qty += $row->unit_quantity; $total_amount += ($row->unit_quantity * $row->real_unit_cost);} ?>
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
                <div class="col-sm-8 col-xs-8">
                    <p>
                        Catatan :<br/>
                        - Pengiriman segera ke Jl. Cipancuh RT.11/RW.05 Desa Padaasih, Kec. Cibogo Kab. Subang Jawa Barat.<br/>
                        - Nota dan Surat Jalan atas nama <b>PT. Wijaya Tunggal Perkasa Sejahtera.</b><br/>
                        - Untuk Faktur Pajak harap mencantumkan NPWP PT. Wijaya Tunggal Perkasa Sejahtera<br/>
                        &nbsp;&nbsp;<b>No. NPWP : 95.988.672.2-439.000</b><br/>
                        - <b>Pembayaran <?= $inv->payment_term == 0 ? 'Cash' : $inv->payment_term . ' hari'; ?> setelah barang diterima.</b><br/>
                    </p>
                </div>
                <div class="col-sm-4 col-xs-4">
                    <div class="col-sm-8 col-xs-8">
                        <p style="height:100px;"><?= lang('created_by'); ?>
                                :<br/> <?= $inv->created_by ? $created_by->first_name . ' ' . $created_by->last_name : ''; ?> </p>
                            <hr class="hr_stamp">
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
