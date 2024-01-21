<?php defined('BASEPATH') or exit('No direct script access allowed'); ?>
<div class="modal-dialog modal-lg">
    <div class="modal-content">
        <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                <i class="fa fa-2x">&times;</i>
            </button>
            <button type="button" class="btn btn-xs btn-default no-print pull-right" style="margin-right:15px;" onclick="window.print();">
                <i class="fa fa-print"></i> <?= lang('print'); ?>
            </button>
            <h4 class="modal-title" id="myModalLabel">Daftar Terima Barang
        </div>
        <div class="modal-body">
            <div class="well well-sm">
                <label>Supplier: </label> <?= $purchase->supplier; ?><br>
                <label>Referensi: </label> <?= $purchase->reference_no; ?><br>
            </div>
            <div class="table-responsive">
                <h2>Pesanan</h2>
                <table class="table table-striped table-bordered">
                    <thead>
                        <tr>
                            <th><?= lang('name'); ?></th>
                            <th><?= lang('quantity'); ?></th>
                            <!-- <th><?= lang('rack'); ?></th> -->
                        </tr>
                    </thead>
                    <tbody>
                    <?php foreach ($rows as $item) {
                        echo '<tr>';
                        echo '<td>' . $item->product_code ." - ". $item->product_name . '</td>';
                        echo '<td>' . $this->sma->formatQuantity($item->quantity) . ' ' . $item->product_unit_code . '</td>';
                        // echo '<td>' . $item['rack'] . '</td>';
                        echo '</tr>';
                    } ?>
                    </tbody>
                </table>
            </div>
            <div class="table-responsive">
                <h2>Sudah Terima</h2>
                <table class="table table-striped table-bordered">
                    <thead>
                        <tr>
                            <th>Tanggal</th>
                            <th><?= lang('name'); ?></th>
                            <th><?= lang('quantity'); ?></th>
                            <th>Gudang</th>
                            <th>No Surat Jalan</th>
                            <th>Lampiran</th>
                        </tr>
                    </thead>
                    <tbody>
                    <?php foreach ($item_movement as $item) {
                        echo '<tr>';
                        echo '<td>' . date("d-M-Y", strtotime($item->stock_date)) . '</td>';
                        echo '<td>' . $item->product_code ." - ". $item->product_desc .'</td>';
                        echo '<td>' . $this->sma->formatQuantity($item->quantity) . ' ' . $item->unit_code . '</td>';
                        echo '<td>' . $warehouses[$item->warehouse_id] . '</td>';
                        echo '<td>' . $item->supporting_reff_doc .'</td>';
                        echo '<td class="fileAttach">' . $item->attachment .'</td>';
                        echo '</tr>';
                    } ?>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>
<script>
    $(".fileAttach").each(function(){
        let isi = $(this).html();
        if(isi != ""){
            let div = attachment(isi);
            $(this).html(div);
        }
    });
</script>