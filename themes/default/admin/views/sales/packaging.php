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
            <h4 class="modal-title" id="myModalLabel">Daftar Pengiriman
        </div>
        <div class="modal-body">
            <div class="well well-sm">
                <?= lang('biller') . ': ' . $sale->biller; ?><br>
                <?= lang('reference') . ': ' . $sale->reference_no; ?><br>
                <!-- <?= lang('warehouse') . ': ' . $warehouse->name . ' (' . $warehouse->code . ')'; ?> -->
            </div>
            <div class="table-responsive">
                <h2>Order</h2>
                <table class="table table-striped table-bordered">
                    <thead>
                        <tr>
                            <th><?= lang('name'); ?></th>
                            <th><?= lang('quantity'); ?></th>
                            <!-- <th><?= lang('rack'); ?></th> -->
                        </tr>
                    </thead>
                    <tbody>
                    <?php foreach ($packaging as $item) {
                        echo '<tr>';
                        echo '<td>' . $item['name'] . '</td>';
                        echo '<td>' . $this->sma->formatQuantity($item['quantity']) . ' ' . $item['unit'] . '</td>';
                        // echo '<td>' . $item['rack'] . '</td>';
                        echo '</tr>';
                    } ?>
                    </tbody>
                </table>
            </div>
            <?php foreach($delivery as $delv){ ?>
            <div class="table-responsive">
                <h2>Delivery <?=$delv->do_reference_no?></h2>
                <table class="table table-striped table-bordered">
                    <thead>
                        <tr>
                            <th><?= lang('name'); ?></th>
                            <th><?= lang('quantity'); ?></th>
                            <th>Batch Product</th>
                            <th>Gudang</th>
                        </tr>
                    </thead>
                    <tbody>
                    <?php foreach ($delivery_item[$delv->id] as $item) {
                        echo '<tr>';
                        echo '<td>' . $item->product_code ." - ". $item->product_desc .'</td>';
                        echo '<td>' . $this->sma->formatQuantity($item->qty) . ' ' . $item->unit_code . '</td>';
                        echo '<td>' . $item->product_batch . '</td>';
                        echo '<td>' . $warehouses[$item->warehouse_id] . '</td>';
                        echo '</tr>';
                    } ?>
                    </tbody>
                </table>
            </div>
            <?php }?>
        </div>
    </div>
</div>
