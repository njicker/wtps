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
        'sales' => 'Penjualan',
        'return' => 'Retur Penjualan',
    );
?>
<div class="box">
    <div class="box-header">
        <h2 class="blue">
            <i class="fa-fw fa fa-building"></i> Stock Card All Product
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
                                <th>No</th>
                                <th>Gudang</th>
                                <th>Code</th>
                                <th>Product Name</th>
                                <th>UOM</th>
                                <th>Qty</th>
                            </tr>
                        </thead>
                        <tbody>
                            <?php
                                $no = 1;
                                foreach($header as $hd){
                            ?>
                            <tr style="cursor: pointer;" onclick="window.location='<?=admin_url('storage/stock_card/'.$hd->product_id)?>'">
                                <td><?=$no?></td>
                                <td><?=$warehouses[$hd->warehouse_id]->name?></td>
                                <td><?=$products[$hd->product_id]->code?></td>
                                <td><?=$products[$hd->product_id]->name?></td>
                                <td><?=$unitsId[$products[$hd->product_id]->unit]->code?></td>
                                <td><?=number_format($hd->quantity, 0, ",", ".")?></td>
                            </tr>
                            <?php $no++; } ?>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
</div>