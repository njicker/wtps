<?php defined('BASEPATH') or exit('No direct script access allowed'); ?>
<style>
    .modal-title{
        font-size: 20px;
        text-decoration: underline;
        text-align: center;
        margin-bottom: 20px;
    }
    .table-info{
        margin-bottom: 10px!important;
    }
    .table-info td{
        border-top: 0px!important;
        padding-top: 3px!important;
        padding-bottom: 3px!important;
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
    .img-logo{
        margin-bottom: 20px;
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
            <h3 class="modal-title">Surat Jalan</h3>
            <div class="row">
                <div class="col-sm-6 col-xs-6">
                    <img src="<?=base_url('themes/default/admin/assets/images/icon_wtps.png')?>" width="240px" class="img-logo" alt="logo">
                    <p>
                        <b>PT. WIJAYA TUNGGAL PERKASA SEJAHTERA</b><br/>
                        Kp. Cipancuh, Padaasih, Kec. Cibogo<br/>
                        Kab. Subang<br/>
                        Telp (WA) : 085624877881
                    </p>
                </div>
                <div class="col-sm-6 col-xs-6">
                    <table class="table table-info">
                        <tbody>
                            <tr>
                                <td>No. Surat Jalan</td>
                                <td>:</td>
                                <td><span class="label-reff"><?= $delivery->do_reference_no; ?></span></td>
                            </tr>
                            <tr>
                                <td>No. SO</td>
                                <td>:</td>
                                <td><?= $delivery->sale_reference_no; ?></td>
                            </tr>
                            <tr>
                                <td>Tanggal</td>
                                <td>:</td>
                                <td><?= date("d-M-Y", strtotime($delivery->date)); ?></td>
                            </tr>
                            <tr>
                                <td>No. Kendaraan</td>
                                <td>:</td>
                                <td><?= $delivery->no_vehicle; ?></td>
                            </tr>
                        </tbody>
                    </table>
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
                                <td><?= $delivery->address; ?></td>
                            </tr>
                            <?php if ($delivery->note) { ?>
                            <tr>
                                <td></td>
                                <td></td>
                                <td><?= $delivery->note; ?></td>
                            </tr>
                            <?php } ?>
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
                                <th>Batch</th>
                            </tr>
                        </thead>
                        <tbody>
                        <?php $r = 1; $total_qty = 0;
                            foreach ($rows as $row){
                        ?>
                            <tr>
                                <td style="text-align:center; width:40px; vertical-align:middle;"><?= $r; ?></td>
                                <td><?= $row->product_code . ' - ' . $row->product_desc ?></td>
                                <td style="text-align:center"><?= $this->sma->formatQuantity($row->qty); ?></td>
                                <td style="text-align:center"><?= $units[$row->unit_code] ?></td>
                                <td style="text-align:center"><?= $row->product_batch; ?></td>
                            </tr>
                        <?php $r++; $total_qty += $row->qty; } ?>
                        </tbody>
                        <tfoot>
                            <tr>
                                <td colspan="2">Total</td>
                                <td style="text-align:center"><?=$this->sma->formatQuantity($total_qty)?></td>
                                <td></td>
                                <td></td>
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
                        - Mohon dikirimkan surat jalan yang sudah ditanda tangani dan dicap basah ke PT. Wijaya Tunggal Perkasa Sejahtera<br/>
                        - Kirimkan ke no yang tertera atau email dibawah ini<br/>
                        - Email : pt.wtp.sejahtera@gmail.com<br/>
                        - Telp (WA). 085624877881<br/>
                    </p>
                </div>
                <div class="col-sm-6 col-xs-6">
                    <div class="col-sm-4 col-xs-4">
                        <p style="height:100px;"><?= lang('created_by'); ?>
                                :<br/> <?= $user->first_name . ' ' . $user->last_name?> </p>
                            <hr class="hr_stamp">
                        <!-- <p><?= lang('stamp_sign'); ?></p> -->
                    </div>
                    <div class="col-sm-4 col-xs-4">
                        <p style="height:100px;"><?= lang('delivered_by'); ?>
                                :<br/> <?= $delivery->delivered_by; ?></p>
                            <hr class="hr_stamp">
                        <!-- <p><?= lang('stamp_sign'); ?></p> -->
                    </div>
                    <div class="col-sm-4 col-xs-4">
                        <p style="height:100px;"><?= lang('received_by'); ?>
                                :<br> <?= $delivery->received_by; ?></p>
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
