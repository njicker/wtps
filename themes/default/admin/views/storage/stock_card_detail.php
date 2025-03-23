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
    $(document).ready(function(){
        $('.view_type').on('ifChecked', function (event) {
            var isi = $(this).val();
            $(".param-select").hide();
            $("." + isi).show();
        });
        // $('.view_type').on('ifUnchecked', function (event) {
        //     console.log($(this).val());
        // });
    });
</script>
<?php
    $docType = array(
        'purchase' => 'Pembelian',
        'production' => 'Produksi',
        'transfer' => 'Transfer',
        'adjustment' => 'Penyesuaian',
        'delivery' => 'Penjualan',
        'return' => 'Retur Penjualan',
    );
?>
<div class="box">
    <div class="box-header">
        <h2 class="blue">
            <i class="fa-fw fa fa-building"></i> Stock Card by Product (<?=$products[$id]->code?> - <?=$products[$id]->name?>)
        </h2>
        <div class="box-icon">
            <ul class="btn-tasks">
                <li class="dropdown">
                    <a data-toggle="dropdown" class="dropdown-toggle" href="#">
                        <i class="icon fa fa-tasks tip" data-placement="left" title="<?= lang('actions') ?>"></i>
                        <ul class="dropdown-menu pull-right tasks-menus" role="menu" aria-labelledby="dLabel">
                            <li>
                                <a onclick="window.print();" style="cursor: pointer;">
                                    <i class="fa fa-print"></i> Print
                                </a>
                            </li>
                        </ul>
                    </a>
                </li>
            </ul>
        </div>
    </div>
    <div class="box-content">
        <div class="row">
            <div class="col-lg-12">
                <p class="introtext">Stock at <?=date("d F Y H:i:s")?></p>
                <div class="container">
                    <table class="table">
                        <thead>
                            <tr>
                                <th>Date</th>
                                <th>Doc No</th>
                                <th>Doc Type</th>
                                <th>UOM</th>
                                <th>In</th>
                                <th>Out</th>
                                <th>Balance</th>
                            </tr>
                        </thead>
                        <tbody>
                            <?php $total = 0; $totalIn = 0; $totalOut = 0; ?>
                            <?php 
                                foreach($stock as $st){
                                    $qty = $st->quantity;
                                    if($unitsId[$products[$id]->unit]->code != $st->unit_code){
                                        $qty = $this->site->convertToBase($unitsId[$products[$id]->unit], $qty);
                                    }
                            ?>
                            <tr>
                                <td><?=$st->stock_date?></td>
                                <td><?=$st->reff_no?></td>
                                <td><?=$docType[$st->reff_type]?></td>
                                <td><?=$unitsId[$products[$id]->unit]->name?></td>
                                <td><?=$st->movement_type == "in" ? $qty : "-" ?></td>
                                <td><?=$st->movement_type == "out" ? $qty : "-" ?></td>
                                <td><?=$qty?></td>
                            </tr>
                            <?php $total += $qty; $totalIn += $st->movement_type == "in" ? $qty : 0; $totalOut += $st->movement_type == "out" ? $qty : 0;  ?>
                            <?php } ?>
                        </tbody>
                        <tfoot>
                            <tr style="font-weight: 700;">
                                <td colspan="4" style="text-align: center;">Total</td>
                                <td><?=number_format($totalIn, 2, ",", ".")?></td>
                                <td><?=number_format($totalOut, 2, ",", ".")?></td>
                                <td><?=number_format($total, 2, ",", ".")?></td>
                            </tr>
                        </tfoot>
                    </table>
                </div>
            </div>
        </div>
    </div>
</div>