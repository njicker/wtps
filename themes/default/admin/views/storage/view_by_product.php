<?php defined('BASEPATH') or exit('No direct script access allowed'); ?>
<style type="text/css" media="screen">
    #PRData td:nth-child(7) {
        text-align: right;
    }
    <?php if ($Owner || $Admin || $this->session->userdata('show_cost')) {
    ?>
    #PRData td:nth-child(9) {
        text-align: right;
    }
    <?php
    } if ($Owner || $Admin || $this->session->userdata('show_price')) {
        ?>
    #PRData td:nth-child(8) {
        text-align: right;
    }
    <?php
    } ?>
</style>
<script>
    var oTable;
    $(document).ready(function () {
        // oTable = $('#PRData').dataTable({
        //     "aaSorting": [[4, "desc"], [0, "desc"]],
        //     "aLengthMenu": [[10, 25, 50, 100, -1], [10, 25, 50, 100, "<?= lang('all') ?>"]],
        //     "iDisplayLength": <?= $Settings->rows_per_page ?>,
        //     'bProcessing': true, 'bServerSide': true,
        //     'sAjaxSource': '<?= admin_url('production/get_production') ?>',
        //     'fnServerData': function (sSource, aoData, fnCallback) {
        //         aoData.push({
        //             "name": "<?= $this->security->get_csrf_token_name() ?>",
        //             "value": "<?= $this->security->get_csrf_hash() ?>"
        //         });
        //         $.ajax({'dataType': 'json', 'type': 'POST', 'url': sSource, 'data': aoData, 'success': fnCallback});
        //     },
        //     'fnRowCallback': function (nRow, aData, iDisplayIndex) {
        //         var oSettings = oTable.fnSettings();
        //         nRow.id = aData[0];
        //         nRow.className = "production_link";
        //         //if(aData[7] > aData[9]){ nRow.className = "product_link warning"; } else { nRow.className = "product_link"; }
        //         return nRow;
        //     },
        //     "aoColumns": [null,null,{"mRender": currencyFormat},null,null,null,null]
        // });
    });
</script>
<div class="box">
    <div class="box-header">
        <h2 class="blue">
            <i class="fa-fw fa fa-building"></i> Stock by Product (<?=$products[$_GET['product_id']]->code?> - <?=$products[$_GET['product_id']]->name?>)
        </h2>
        <div class="box-icon">
            <ul class="btn-tasks">
                <li class="dropdown">
                    <a data-toggle="dropdown" class="dropdown-toggle" href="#">
                        <i class="icon fa fa-tasks tip" data-placement="left" title="<?= lang('actions') ?>"></i>
                    </a>
                </li>
            </ul>
        </div>
    </div>
    <div class="box-content">
        <div class="row">
            <div class="col-lg-12">
                <p class="introtext">Stock at <?=date("d F Y H:i:s")?></p>

                <?php foreach($header as $prod){ 
                    if($prod->quantity <= 0){ continue; }
                ?>
                <div class="col-md-6">
                    <div class="table-responsive">
                        <h3 style="font-weight: 600;"><?=$warehouses[$prod->warehouse_id]->name?></h3>
                        <table id="PRData" class="table table-bordered table-condensed table-hover table-striped">
                            <thead>
                                <tr class="primary">
                                    <th>Batch Produksi</th>
                                    <th>Qty</th>
                                    <th>Unit</th>
                                </tr>
                            </thead>
                            <tbody>
                                <?php 
                                $total = 0;
                                foreach($batch as $bat){ 
                                    if($bat->warehouse_id != $prod->warehouse_id){ continue; }
                                    if($bat->quantity <= 0){ continue; }
                                ?>
                                    <tr>
                                        <td><?=$bat->product_batch == "" ? "-" : $bat->product_batch?></td>
                                        <td style="text-align:right;"><?=number_format($bat->quantity, 2)?></td>
                                        <td><?=$units[$products[$prod->product_id]->unit]->code?></td>
                                    </tr>
                                <?php $total += $bat->quantity; } ?>
                            </tbody>
                            <tfooter>
                                <tr>
                                    <td>Total</td>
                                    <td colspan="2" style="text-align: right; font-weight: 700;"><?=number_format($total, 2)?></td>
                                </tr>
                            <tfooter>
                        </table>
                    </div>
                </div>
                <?php } ?>
            </div>
        </div>
    </div>
</div>