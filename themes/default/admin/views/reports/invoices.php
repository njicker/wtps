<?php defined('BASEPATH') or exit('No direct script access allowed'); ?>
<style>
    .rad-type{
        margin-right: 60px;
    }
</style>
<div class="box">
    <div class="box-header">
        <h2 class="blue"><i class="fa-fw fa fa-money"></i><?= lang('invoices_report'); ?> <?php
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
                    <?php echo admin_form_open('reports/invoices'); ?>
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
                        <div class="col-sm-12 col-xs-12">
                            <?php 
                                $rad = array();
                                $rad['all'] = "";
                                $rad['outstanding'] = "";
                                $rad['paid'] = "";
                                if(isset($_POST['type'])){
                                    $rad['all'] = $_POST['type'] == "all" ? "checked" : "";
                                    $rad['outstanding'] = $_POST['type'] == "outstanding" ? "checked" : "";
                                    $rad['paid'] = $_POST['type'] == "paid" ? "checked" : "";
                                }
                                else {
                                    $rad['all'] = "checked";
                                }
                            ?>
                            <div class="form-group">
                                <label>Tipe Laporan</label><br/>
                                <span class="rad-type">
                                    <input type="radio" name="type" value="all" <?=$rad['all']?>> Semua
                                </span>
                                <span class="rad-type">
                                    <input type="radio" name="type" value="outstanding" <?=$rad['outstanding']?>> Belum dibayar
                                </span>
                                <span class="rad-type">
                                    <input type="radio" name="type" value="paid" <?=$rad['paid']?>> Lunas
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
    let rowPivot = [
        {
            uniqueName: "customer",
            caption: "Customer"
        },
        {
            uniqueName: "reff_doc",
            caption: "No. Invoice"
        },
        {
            uniqueName: "doc_date",
            caption: "Tanggal Invoice"
        },
    ]
    let colPivot = {
        all : [
            {
                uniqueName: "status",
                caption: "Status"
            }
        ],
        paid : [],
        outstanding: [
            {
                uniqueName: "group_due",
                caption: "Umur Hutang (hari)"
            }
        ],
    }
    // console.log(showPivot);
    if(showPivot)
    {
        let dataPivot = JSON.parse('<?=$pivot?>');
        let data = [
            {
                customer: {
                    type: "string"
                },
                reff_doc: {
                    type: "string"
                },
                doc_date: {
                    type: "string"
                },
                status: {
                    type: "string"
                },
                group_due: {
                    type: "string"
                },
                total_amount: {
                    type: "number"
                },
            }
        ]
        if(dataPivot){
            data.push(...dataPivot);
        }
        // console.log(data);
        let start_date = '<?=$_POST['start_date'] != "" ? date("d-M-Y", strtotime($this->sma->fsd($_POST['start_date']))) : "" ?>';
        let end_date = '<?=$_POST['end_date'] != "" ? date("d-M-Y", strtotime($this->sma->fsd($_POST['end_date']))) : "" ?>';
        let type = "<?=$_POST['type'] != "" ? $_POST['type'] : ""?>";
        let title = "Laporan Tagihan Penjualan";
        if(type == "paid"){
            title += " Lunas";
        }
        else if(type == "outstanding") {
            title += " Belum Dibayar";
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
                    rows: rowPivot,
                    columns: colPivot[type],
                    expands: {
                        expandAll : true
                    },
                    measures: [
                        {
                            uniqueName: "total_amount",
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