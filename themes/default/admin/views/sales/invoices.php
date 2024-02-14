<?php defined('BASEPATH') or exit('No direct script access allowed'); ?>
<script>
    $(document).ready(function () {
        var dss = <?= json_encode(['packing' => lang('packing'), 'delivering' => lang('delivering'), 'delivered' => lang('delivered')]); ?>;
        function ds(x) {
            if (x == 'delivered') {
                return '<div class="text-center"><span class="label label-success">'+(dss[x] ? dss[x] : x)+'</span></div>';
            } else if (x == 'delivering') {
                return '<div class="text-center"><span class="label label-primary">'+(dss[x] ? dss[x] : x)+'</span></div>';
            } else if (x == 'packing') {
                return '<div class="text-center"><span class="label label-warning">'+(dss[x] ? dss[x] : x)+'</span></div>';
            }
            return x;
            return (x != null) ? (dss[x] ? dss[x] : x) : x;
        }

        function due(obj){
            let rtn = "";
            let dt = moment(obj);
            let formDt = formatDate(obj);
            let due = false;
            if(obj != moment().format("YYYY-MM-DD")){
                if(dt < moment()){
                    due = true;
                }
            }
            if(due){
                rtn = '<div class="text-center"><span class="label label-danger">' + formDt + '</span></div>';
            }
            else {
                rtn = formDt;
            }
            return rtn;
        }

        function formatDate(oObj) {
            if (oObj != null) {
                var aDate = oObj.split('-');
                if (site.dateFormats.js_sdate == 'dd-mm-yyyy') return aDate[2] + '-' + aDate[1] + '-' + aDate[0];
                else if (site.dateFormats.js_sdate === 'dd/mm/yyyy') return aDate[2] + '/' + aDate[1] + '/' + aDate[0];
                else if (site.dateFormats.js_sdate == 'dd.mm.yyyy') return aDate[2] + '.' + aDate[1] + '.' + aDate[0];
                else if (site.dateFormats.js_sdate == 'mm/dd/yyyy') return aDate[1] + '/' + aDate[2] + '/' + aDate[0];
                else if (site.dateFormats.js_sdate == 'mm-dd-yyyy') return aDate[1] + '-' + aDate[2] + '-' + aDate[0];
                else if (site.dateFormats.js_sdate == 'mm.dd.yyyy') return aDate[1] + '.' + aDate[2] + '.' + aDate[0];
                else return oObj;
            } else {
                return '';
            }
        }
        oTable = $('#DOData').dataTable({
            "aaSorting": [[1, "desc"]],
            "aLengthMenu": [[10, 25, 50, 100, -1], [10, 25, 50, 100, "<?= lang('all') ?>"]],
            "iDisplayLength": <?= $Settings->rows_per_page ?>,
            'bProcessing': true, 'bServerSide': true,
            'sAjaxSource': '<?= admin_url('sales/getInvoices') ?>',
            'fnServerData': function (sSource, aoData, fnCallback) {
                aoData.push({
                    "name": "<?= $this->security->get_csrf_token_name() ?>",
                    "value": "<?= $this->security->get_csrf_hash() ?>"
                });
                $.ajax({'dataType': 'json', 'type': 'POST', 'url': sSource, 'data': aoData, 'success': fnCallback});
            },
            'fnRowCallback': function (nRow, aData, iDisplayIndex) {
                var oSettings = oTable.fnSettings();
                nRow.id = aData[0];
                nRow.className = "invoice_link_new";
                return nRow;
            },
            "aoColumns": [{"bSortable": false,"mRender": checkbox}, {"mRender": fsd}, null, null, null, {"mRender": currencyFormat}, {"mRender": currencyFormat}, {"mRender": pay_status}, {"mRender": due}, {"bSortable": false}]
        }).fnSetFilteringDelay().dtFilter([
        ], "footer");
    });
</script>
<?php if ($Owner) {
    ?><?= admin_form_open('sales/invoice_actions', 'id="action-form"') ?><?php
} ?>
<div class="box">
    <div class="box-header">
        <h2 class="blue"><i class="fa-fw fa fa-money"></i>Daftar Tagihan</h2>

        <div class="box-icon">
            <ul class="btn-tasks">
                <li class="dropdown">
                    <a data-toggle="dropdown" class="dropdown-toggle" href="#">
                        <i class="icon fa fa-tasks tip" data-placement="left" title="<?= lang('actions') ?>"></i>
                    </a>
                    <ul class="dropdown-menu pull-right tasks-menus" role="menu" aria-labelledby="dLabel">
                        <li><a href="#" id="excel" data-action="export_excel"><i class="fa fa-file-excel-o"></i> <?= lang('export_to_excel') ?></a></li>
                        <li class="divider"></li>
                        <li>
                            <a href="#" class="bpo" title="<b>Hapus Invoice</b>" 
                                data-content="<p><?= lang('r_u_sure') ?></p><button type='button' class='btn btn-danger' id='delete' data-action='delete'><?= lang('i_m_sure') ?></a> <button class='btn bpo-close'><?= lang('no') ?></button>" 
                                data-html="true" data-placement="left">
                                <i class="fa fa-trash-o"></i> Hapus Invoice
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
                <p class="introtext"><?= lang('list_results'); ?></p>

                <table id="DOData" class="table table-bordered table-hover table-striped table-condensed">
                    <thead>
                    <tr>
                        <th style="min-width:30px; width: 30px; text-align: center;">
                            <input class="checkbox checkft" type="checkbox" name="check"/>
                        </th>
                        <th><?= lang('date'); ?></th>
                        <th>No Invoice</th>
                        <th>No SO</th>
                        <th><?= lang('customer'); ?></th>
                        <th>Total Amount</th>
                        <th>Total Paid</th>
                        <th><?= lang('status'); ?></th>
                        <th>Jatuh Tempo</th>
                        <th style="width:100px; text-align:center;"><?= lang('actions'); ?></th>
                    </tr>
                    </thead>
                    <tbody>
                    <tr>
                        <td colspan="10" class="dataTables_empty"><?= lang('loading_data'); ?></td>
                    </tr>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>
<div style="display: none;">
    <input type="hidden" name="form_action" value="" id="form_action"/>
    <?= form_submit('perform_action', 'perform_action', 'id="action-form-submit"') ?>
</div>
<?= form_close() ?>
<script type="text/javascript" charset="utf-8">
    $(document).ready(function() {
        $(document).on('click', '#delete', function(e) {
            e.preventDefault();
            $('#form_action').val($(this).attr('data-action'));
            //$('#action-form').submit();
            $('#action-form-submit').click();
        });
    });
</script>