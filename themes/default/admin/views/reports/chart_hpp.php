<?php defined('BASEPATH') or exit('No direct script access allowed'); ?>
<style type="text/css" media="screen">
    .tooltip-inner {
        max-width: 500px;
    }
</style>
<div class="box">
    <div class="box-header">
        <h2 class="blue"><i class="fa-fw fa fa-heart"></i><?= lang('chart_hpp_report'); ?> <?php
            if ($this->input->post('start_date')) {
                echo 'Dari ' . $this->input->post('start_date') . ' sampai ' . $this->input->post('end_date');
            }
            ?>
        </h2>
    </div>
    <div class="box-content">
        <div class="row">
            <div class="col-lg-12">

                <p class="introtext">Grafik Harga Pokok Produksi (HPP)</p>

                <div id="form">
                    <?php echo admin_form_open('reports/chart_hpp'); ?>
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
                        <div class="col-sm-8">
                            <div class="form-group">
                                <label>Produk</label>
                                <?php
                                    $pr = array();
                                    foreach($products as $p){
                                        $pr[$p->id] = $p->name;
                                    }
                                    echo form_dropdown('product_id', $pr, (isset($_POST['product_id']) ? $_POST['product_id'] : ''), 'id="ph" class="form-control input-tip select" style="width:100%;"');
                                ?>
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
                    <div id="ov-chart" style="width:100%; height:450px;"></div>
                </div>
            </div>
        </div>
    </div>
</div>

<script src="<?= $assets; ?>js/hc/highcharts.js"></script>
<script>
    let showData = <?= $chart ? 1 : 0 ?>;
    if(showData){
        let data = JSON.parse('<?= $chart ?>');
        $('#ov-chart').highcharts({
            chart: {},
            credits: {enabled: false},
            title: {text: ''},
            xAxis: {categories: data.day},
            yAxis: {min: data.min, max: data.max, title: ""},
            tooltip: {
                shared: true,
                followPointer: true,
                formatter: function () {
                    // console.log(this);
                    if (this.key) {
                        return '<div class="tooltip-inner hc-tip" style="margin-bottom:0;">' + this.key + '<br><strong>' + currencyFormat(this.y) + '</strong> (' + formatNumber(this.percentage) + '%)';
                    } else {
                        var s = '<div class="well well-sm hc-tip" style="margin-bottom:0;"><h2 style="margin-top:0;">' + this.x + '</h2><table class="table table-striped"  style="margin-bottom:0;">';
                        $.each(this.points, function () {
                            s += '<tr><td style="color:{series.color};padding:0">' + this.series.name + ': </td><td style="color:{series.color};padding-lefy:80px;text-align:right;"> <b>' +
                            currencyFormat(this.y) + '</b></td></tr>';
                        });
                        s += '</table></div>';
                        return s;
                    }
                },
                useHTML: true, borderWidth: 0, shadow: false, valueDecimals: 0,
                style: {fontSize: '14px', padding: '0', color: '#000000'}
            },
            series: [
                {
                    type: 'spline',
                    name: 'Harga Pokok Produksi',
                    data: data.cost,
                    marker: {
                        lineWidth: 2,
                        states: {
                            hover: {
                                lineWidth: 4
                            }
                        },
                        lineColor: Highcharts.getOptions().colors[7],
                        fillColor: 'white'
                    }
                },
                {
                    type: 'spline',
                    name: 'Rata-rata',
                    data: data.avg,
                    color: Highcharts.getOptions().colors[3],
                    marker: {
                        lineWidth: 1,
                        // states: {
                        //     hover: {
                        //         lineWidth: 4
                        //     }
                        // },
                        // lineColor: 'red',
                        // fillColor: 'white'
                    }
                }
            ]
        });
        $("#show-data").show();
    }
    else {
        $("#show-data").hide();
    }
</script>