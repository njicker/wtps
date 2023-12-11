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
<div class="box">
    <div class="box-header">
        <h2 class="blue">
            <i class="fa-fw fa fa-building"></i> Stock Gudang
        </h2>
        <div class="box-icon">
            <ul class="btn-tasks">
                <li class="dropdown">
                    <a data-toggle="dropdown" class="dropdown-toggle" href="#">
                        <i class="icon fa fa-tasks tip" data-placement="left" title="<?= lang('actions') ?>"></i>
                    </a>
                    <ul class="dropdown-menu pull-right tasks-menus" role="menu" aria-labelledby="dLabel">
                        <li>
                            <a href="<?= admin_url('storage/add_production') ?>">
                                <i class="fa fa-plus-circle"></i> Transfer Stock
                            </a>
                        </li>
                    </ul>
                </li>
            </ul>
        </div>
    </div>
    <div class="box-content">
        <div class="row">
            <div class="col-lg-12">
                <p class="introtext">Pilih tampilan stock berdasarkan kategori</p>

                <?php
                $attrib = ['data-toggle' => 'validator', 'role' => 'form', 'method' => 'get'];
                echo admin_form_open_multipart('storage/view_stock', $attrib);
                ?>
                <div class="row">
                    <div class="col-md-5">
                        <div class="form-group">
                            <div class="col-md-6">
                                <input type="radio" name="view_type" value="warehouse" class="view_type" checked> By Gudang
                            </div>
                            <div class="col-md-6">
                                <input type="radio" name="view_type" value="product" class="view_type"> By Produk
                            </div>
                        </div>
                    </div>
                    <div class="col-md-5"></div>
                </div>
                <div class="row" style="margin-top: 20px;">
                    <div class="col-md-5">
                        <div class="form-group warehouse param-select">
                            <?php
                                $wh = array();
                                foreach($warehouses as $w){
                                    $wh[$w->id] = $w->name;
                                }
                                echo form_dropdown('warehouse_id', $wh, '', 'id="wh" class="form-control input-tip select" style="width:100%;"');
                            ?>
                        </div>
                        <div class="form-group product param-select" style="display:none;">
                            <?php
                                $pr = array();
                                foreach($products as $p){
                                    $pr[$p->id] = $p->name;
                                }
                                echo form_dropdown('product_id', $pr, '', 'id="ph" class="form-control input-tip select" style="width:100%;"');
                            ?>
                        </div>
                    </div>
                </div>
                
                <div class="col-md-12">
                    <div
                        class="from-group"><?php echo form_submit('view_stock', $this->lang->line('submit'), 'id="" class="btn btn-primary" style="padding: 6px 15px; margin:15px 0;"'); ?>
                    </div>
                </div>
                <?= form_close(); ?>
            </div>
        </div>
    </div>
</div>