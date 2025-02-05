<?php defined('BASEPATH') or exit('No direct script access allowed'); ?>
<style>
    .rad-type{
        margin-right: 60px;
    }
</style>
<div class="box">
    <div class="box-header">
        <h2 class="blue"><i class="fa-fw fa fa-heart"></i><?= lang('purchases_report'); ?> <?php
            if ($this->input->post('start_date')) {
                echo 'Dari ' . $this->input->post('start_date') . ' sampai ' . $this->input->post('end_date');
            }
            ?>
        </h2>
    </div>
    <div class="box-content">
        <div class="row">
            <div class="col-lg-12">

                <p class="introtext"><?= lang('customize_report'); ?></p>

                <div id="form">
                    <?php echo admin_form_open('reports/purchases'); ?>
                    <div class="row">
                        <div class="col-sm-4">
                            <div class="form-group">
                                <?= lang('start_date', 'start_date'); ?>
                                <?php echo form_input('start_date', (isset($_POST['start_date']) ? $_POST['start_date'] : ''), 'class="form-control date" id="start_date"'); ?>
                            </div>
                        </div>
                        <div class="col-sm-4">
                            <div class="form-group">
                                <?= lang('end_date', 'end_date'); ?>
                                <?php echo form_input('end_date', (isset($_POST['end_date']) ? $_POST['end_date'] : ''), 'class="form-control date" id="end_date"'); ?>
                            </div>
                        </div>
                        <div class="col-sm-4">
                            <div class="form-group">
                                <label>Divisi</label>
                                <?php 
                                    $div['mie'] = 'Mie';
                                    $div['kerupuk'] = 'Kerupuk';
                                    echo form_dropdown('division', $div, ($_POST['division'] ?? ''), 'id="sldivision" required="required" class="form-control input-tip select" style="width:100%;"');
                                ?>
                            </div>
                        </div>
                        <div class="col-sm-12 col-xs-12">
                            <?php 
                                $rad = array();
                                $rad['supplier'] = "";
                                $rad['detail'] = "";
                                if(isset($_POST['type'])){
                                    $rad['supplier'] = $_POST['type'] == "supplier" ? "checked" : "";
                                    $rad['detail'] = $_POST['type'] == "detail" ? "checked" : "";
                                }
                                else {
                                    $rad['supplier'] = "checked";
                                }
                            ?>
                            <div class="form-group">
                                <label>Tipe Laporan</label><br/>
                                <span class="rad-type">
                                    <input type="radio" name="type" value="supplier" <?=$rad['supplier']?>> Per Supplier
                                </span>
                                <span class="rad-type">
                                    <input type="radio" name="type" value="detail" <?=$rad['detail']?>> Detail Pembelian
                                </span>
                            </div>
                        </div>
                    </div>
                    <div class="form-group">
                        <div
                            class="controls"> <?php echo form_submit('submit_report', $this->lang->line('submit'), 'class="btn btn-primary"'); ?> </div>
                    </div>
                    <?php echo form_close(); ?>

                </div>
                <div class="clearfix"></div>

                <div class="col-sm-12 col-xs-12" id="show-data">
                    <div id="wdr-component"></div>
                </div>
            </div>
        </div>
    </div>
</div>
<script>
    let showPivot = <?=$pivot ? 1 : 0?>;
    let type = "<?=!isset($_POST['type']) ? "" : $_POST['type']?>";
    let rowPivot = {
        supplier : [
            {
                uniqueName: "company",
                caption: "Supplier"
            },
            {
                uniqueName: "product_full",
                caption: "Produk"
            },
            {
                uniqueName: "net_unit_cost",
                caption: "Harga"
            }
        ],
        detail : [
            {
                uniqueName: "date",
                caption: "Tanggal"
            },
            {
                uniqueName: "reference_no",
                caption: "Nomer Faktur"
            },
            {
                uniqueName: "company",
                caption: "Supplier"
            },
            {
                uniqueName: "product_full",
                caption: "Produk"
            },
            {
                uniqueName: "net_unit_cost",
                caption: "Harga"
            }
        ],
    }
    // console.log(showPivot);
    if(showPivot)
    {
        let dataPivot = JSON.parse('<?=$pivot?>');
        let data = [
            {
                company: {
                    type: "string"
                },
                reference_no: {
                    type: "string"
                },
                date: {
                    type: "date string"
                },
                product_full: {
                    type: "string"
                },
                net_unit_cost: {
                    type: "number"
                },
                quantity: {
                    type: "number"
                },
                subtotal: {
                    type: "number"
                }
            }
        ];
        data.push(...dataPivot);
        // console.log(data);
        let title = "Laporan Tagihan Pembelian";
        let start_date = '<?=$_POST['start_date'] != "" ? date("d-M-Y", strtotime($this->sma->fsd($_POST['start_date']))) : "" ?>';
        let end_date = '<?=$_POST['end_date'] != "" ? date("d-M-Y", strtotime($this->sma->fsd($_POST['end_date']))) : "" ?>';
        let type = "<?=$_POST['type'] != "" ? $_POST['type'] : ""?>";
        if(type == "supplier"){
            title += " per Supplier";
        }
        else if(type == "detail") {
            title += " Detail";
        }
        if(start_date != "" && end_date != ""){
            title += " Periode " + start_date + " s/d " + end_date;
        }
        else if(start_date != ""){
            title += " Tanggal " + start_date;
        }
        else if(end_date != ""){
            title += " Tanggal " + end_date;
        }
        const pivot = new WebDataRocks({
            container: "#wdr-component",
            beforetoolbarcreated: customizeToolbar,
            toolbar: true,
            width: '100%',            
            report: {
                dataSource: {
                    data: data
                },
                slice: {
                    rows: rowPivot[type],
                    expands: {
                        expandAll : true
                    },
                    measures: [
                        {
                            uniqueName: "quantity",
                            aggregation: "sum",
                            format: "sum_qty",
                            caption: "Qty"
                        },
                        {
                            uniqueName: "subtotal",
                            aggregation: "sum",
                            format: "sum_price",
                            caption: "Amount"
                        }
                    ]
                },
                formats: [
                    {
                        name: "sum_qty",
                        decimalPlaces: 0,
                        thousandsSeparator: "."
                    },
                    {
                        name: "sum_price",
                        decimalPlaces: 0,
                        thousandsSeparator: ".",
                        currencySymbol: "Rp. "
                    }
                ],
                options: {
                    grid: {
                        type: "classic",
                        title: title
                    }
                }
            }
        });
        $("#show-data").show();
    }
    else {
        $("#show-data").hide();
    }

    function customizeToolbar(toolbar) {
        // Get all tabs from the toolbar
        const tabs = toolbar.getTabs();
        toolbar.getTabs = function() {
            // Delete the first tab
            delete tabs[0];
            delete tabs[1];
            delete tabs[2];
            return tabs;
        }
    }
</script>