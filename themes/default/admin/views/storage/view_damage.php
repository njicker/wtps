<?php defined('BASEPATH') or exit('No direct script access allowed'); ?>
<script>
    $(document).ready(function () {
        $('.gen_slug').change(function(e) {
            console.log($(this).val());
            getSlug($(this).val(), 'damage');
        });
    });
</script>
<div class="box">
    <div class="box-header">
        <h2 class="blue"><i class="fa-fw fa fa-plus"></i><?= $title ?></h2>
    </div>
    <div class="box-content">
        <div class="row">
            <div class="col-md-12">

                <p class="introtext"><?php echo lang('enter_info'); ?></p>

                <div class="row">
                    <div class="col-md-5">
                        <div class="form-group">
                            <div class="form-group all">
                                <label>No. Referensi</label>
                                <?= form_input('reference', $header->reference, 'class="form-control" id="reference" readonly'); ?>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-5">
                        <div class="form-group">
                            <div class="form-group all">
                                <label>Reason</label>
                                <?= form_input('reason', $header->reason, 'class="form-control" id="reason" readonly'); ?>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-5">
                        <div class="form-group">
                            <div class="form-group all">
                                <label>Total Amount</label>
                                <?= form_input('total_amount', number_format($header->total_amount), 'class="form-control" id="reason" readonly'); ?>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- <div class="row">
                    <div class="col-md-12" id="sticker">
                        <div class="well well-sm">
                            <div class="form-group" style="margin-bottom:0;">
                                <div class="input-group wide-tip">
                                    <div class="input-group-addon" style="padding-left: 10px; padding-right: 10px;">
                                        <i class="fa fa-2x fa-barcode addIcon"></i></a></div>
                                    <?php echo form_input('add_item', '', 'class="form-control input-lg" id="add_item" placeholder="' . $this->lang->line('add_product_to_order') . '"'); ?>
                                    <?php if ($Owner || $Admin || $GP['products-add']) {
                                ?>
                                    <div class="input-group-addon" style="padding-left: 10px; padding-right: 10px;">
                                        <a href="<?= admin_url('products/add') ?>" id="addManually1"><i
                                                class="fa fa-2x fa-plus-circle addIcon" id="addIcon"></i></a></div>
                                    <?php
                            } ?>
                                </div>
                            </div>
                            <div class="clearfix"></div>
                        </div>
                    </div>
                </div> -->
                <div class="row">
                    <div class="col-md-12">
                        <div class="control-group table-group">
                            <label class="table-label">Produk</label>

                            <div class="controls table-controls">
                                <table id="poTable"
                                    class="table items table-striped table-bordered table-condensed table-hover sortable_table">
                                    <thead>
                                        <tr>
                                            <th>Produk (Code - Nama)</th>
                                            <th>Batch Produk</th>
                                            <th>Qty</th>
                                            <th>UOM</th>
                                            <th>Gudang</th>
                                            <th>Notes</th>
                                            <th>Net Amount</th>
                                            <th>Total Amount</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                    <?php foreach($detail as $dtl){ ?>
                                        <tr>
                                            <td><?=$dtl->product_code?> - <?=$dtl->product_desc?></td>
                                            <td><?=$dtl->product_batch?></td>
                                            <td><?=$dtl->qty?></td>
                                            <td><?=$dtl->unit_code?></td>
                                            <td><?=$warehouses[$dtl->warehouse_id]?></td>
                                            <td><?=$dtl->note?></td>
                                            <td><?=number_format($dtl->unit_amount)?></td>
                                            <td><?=number_format($dtl->total_amount)?></td>
                                        </tr>
                                    <?php } ?>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="row">
            </div>
        </div>
    </div>
</div>