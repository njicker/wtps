<?php defined('BASEPATH') or exit('No direct script access allowed'); ?>
<script>
    $(document).ready(function () {
        oTable = $('#POData').dataTable({
            "aaSorting": [[1, "desc"], [2, "desc"]],
            "aLengthMenu": [[10, 25, 50, 100, -1], [10, 25, 50, 100, "<?=lang('all')?>"]],
            "iDisplayLength": <?=$Settings->rows_per_page?>,
            'bProcessing': true, 'bServerSide': true,
            'sAjaxSource': '<?=admin_url('accounting/getJournal' . ($status ? '/' . $status : ''))?>',
            'fnServerData': function (sSource, aoData, fnCallback) {
                aoData.push({
                    "name": "<?=$this->security->get_csrf_token_name()?>",
                    "value": "<?=$this->security->get_csrf_hash()?>"
                });
                $.ajax({'dataType': 'json', 'type': 'POST', 'url': sSource, 'data': aoData, 'success': fnCallback});
            },
            "aoColumns": [{"mRender": fsd}, null, null, null, null, {"mRender": currencyFormat}, {"mRender": currencyFormat}, null, null],
            "fnFooterCallback": function (nRow, aaData, iStart, iEnd, aiDisplay) {
                var debit = 0, credit = 0;
                for (var i = 0; i < aaData.length; i++) {
                    debit += parseFloat(aaData[aiDisplay[i]][5]);
                    credit += parseFloat(aaData[aiDisplay[i]][6]);
                }
                var nCells = nRow.getElementsByTagName('th');
                nCells[5].innerHTML = currencyFormat(debit);
                nCells[6].innerHTML = currencyFormat(credit);
            }
        }).fnSetFilteringDelay().dtFilter([
            {column_number: 0, filter_default_label: "[<?=lang('date');?> (yyyy-mm-dd)]", filter_type: "text", data: []},
            {column_number: 1, filter_default_label: "[<?=lang('no_journal');?>]", filter_type: "text", data: []},
            {column_number: 2, filter_default_label: "[<?=lang('type_reff');?>]", filter_type: "text", data: []},
            {column_number: 3, filter_default_label: "[<?=lang('note');?>]", filter_type: "text", data: []},
            {column_number: 4, filter_default_label: "[<?=lang('division');?>]", filter_type: "text", data: []},
            {column_number: 7, filter_default_label: "[<?=lang('doc_status');?>]", filter_type: "text", data: []},
        ], "footer");
    });

</script>

<div class="box">
    <div class="box-header">
        <h2 class="blue"><i
                class="fa-fw fa fa-money"></i><?=lang('journal') . ' (' . ($status ? $status : lang('all_status')) . ')';?>
        </h2>

        <div class="box-icon">
            <ul class="btn-tasks">
                <li class="dropdown">
                    <a data-toggle="dropdown" class="dropdown-toggle" href="#"><i class="icon fa fa-tasks tip" data-placement="left" title="<?=lang('actions')?>"></i></a>
                    <ul class="dropdown-menu pull-right tasks-menus" role="menu" aria-labelledby="dLabel">
                        <li>
                            <a href="<?=admin_url('accounting/add_journal')?>">
                                <i class="fa fa-plus-circle"></i> <?=lang('add_journal')?>
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

                <p class="introtext"><?=lang('list_results');?></p>

                <div class="table-responsive">
                    <table id="POData" cellpadding="0" cellspacing="0" border="0"
                           class="table table-bordered table-hover table-striped">
                        <thead>
                        <tr class="active">
                            <!-- <th style="min-width:30px; width: 30px; text-align: center;">
                                <input class="checkbox checkft" type="checkbox" name="check"/>
                            </th> -->
                            <th><?= lang('doc_date'); ?></th>
                            <th><?= lang('no_journal'); ?></th>
                            <th><?= lang('type_reff'); ?></th>
                            <th><?= lang('note'); ?></th>
                            <th><?= lang('division'); ?></th>
                            <th><?= lang('total_debit'); ?></th>
                            <th><?= lang('total_credit'); ?></th>
                            <th><?= lang('doc_status'); ?></th>
                            <th style="width:100px;"><?= lang('actions'); ?></th>
                        </tr>
                        </thead>
                        <tbody>
                        <tr>
                            <td colspan="8" class="dataTables_empty"><?=lang('loading_data_from_server');?></td>
                        </tr>
                        </tbody>
                        <tfoot class="dtFilter">
                        <tr class="active">
                            <!-- <th style="min-width:30px; width: 30px; text-align: center;">
                                <input class="checkbox checkft" type="checkbox" name="check"/>
                            </th> -->
                            <th></th>
                            <th></th>
                            <th></th>
                            <th></th>
                            <th></th>
                            <th><?= lang('total_debit'); ?></th>
                            <th><?= lang('total_credit'); ?></th>
                            <th></th>
                            <th style="width:100px; text-align: center;"><?= lang('actions'); ?></th>
                        </tr>
                        </tfoot>
                    </table>
                </div>
            </div>
        </div>
    </div>
</div>