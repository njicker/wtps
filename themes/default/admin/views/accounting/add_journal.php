<?php defined('BASEPATH') or exit('No direct script access allowed'); ?>
<style>
    #indicator_status{
        color: red;
    }
</style>
<div class="box">
    <div class="box-header">
        <h2 class="blue"><i class="fa-fw fa fa-plus"></i><?= lang('add_journal') ?></h2>
    </div>
    <div class="box-content">
        <?php $attrib = ['data-toggle' => 'validator', 'role' => 'form', 'id' => 'form_submit'];
            echo admin_form_open_multipart('accounting/add_journal', $attrib); 
        ?>
        <p><?= lang('enter_info'); ?></p>
        <div class="row">
            <div class="col-md-6">
                <?php if ($Owner || $Admin) {
                ?>
                    <div class="form-group">
                        <?= lang('doc_date', 'date'); ?>
                        <?= form_input('doc_date', (isset($_POST['doc_date']) ? $_POST['doc_date'] : date('Y-m-d')), 'class="form-control date" id="doc_date" required="required"'); ?>
                    </div>
                <?php
                } ?>
                <div class="form-group">
                    <label><?= lang('no_journal', 'journal'); ?></label>
                    <?= form_input('no_journal', 'XXXX/RFP/WTPS/XX/XXXX', 'class="form-control tip" id="no_journal" required="required" readonly'); ?>
                </div>

                <div class="form-group">
                    <?= lang('division', 'division'); ?>
                    <?php
                    // $dv['All'] = 'All';
                    $dv['mie'] = 'Mie';
                    $dv['kerupuk'] = 'Kerupuk';
                    echo form_dropdown('division', $dv, (isset($_POST['division']) ? $_POST['division'] : ''), 'id="division" class="form-control input-tip select" style="width:100%;" required="required"');
                    ?>
                </div>

                <div class="form-group">
                    <?= lang('attachment', 'attachment') ?>
                    <input id="attachment" type="file" data-browse-label="<?= lang('browse'); ?>" name="userfile" data-show-upload="false" data-show-preview="false"
                        class="form-control file">
                </div>

                <div class="form-group">
                    <?= lang('doc_status', 'doc_status'); ?>&nbsp;&nbsp;
                    <span class="fa fa-square" id="indicator_status"></span>
                    <input type="hidden" name="doc_status" value="Active">
                    <input type="hidden" id="doc_submit_status" value="">
                </div>
            </div>

            <div class="col-md-6">
                <div class="form-group">
                    <?= lang('total_debit', 'debit'); ?>
                    <?php echo form_input('total_debit', 0, 'class="form-control" required="required" id="total_debit" readonly'); ?>
                </div>

                <div class="form-group">
                    <?= lang('total_credit', 'credit'); ?>
                    <?php echo form_input('total_credit', 0, 'class="form-control" required="required" id="total_credit" readonly'); ?>
                </div>

                <div class="form-group">
                    <?= lang('note', 'note'); ?>
                    <?php
                    echo form_textarea('note', '', 'class="form-control" id="note"'); ?>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-md-12">
                <table class="table table-bordered table-condensed">
                    <thead>
                        <tr>
                            <th style="width: 300px;"><?= lang('no_account') ?></th>
                            <th><?= lang('type_amount') ?></th>
                            <th><?= lang('amount') ?></th>
                            <th><?= lang('note') ?></th>
                        </tr>
                    </thead>
                    <tbody>
                        <?php
                        $no_acc[''] = '';
                        foreach($account_journal as $acc){
                            $no_acc[$acc->no_account] = $acc->no_account." - ".$acc->account_desc;
                        }
                        $type[''] = '';
                        $type['debit'] = 'Debit';
                        $type['credit'] = 'Kredit';
                        $row = 10;
                        for($i = 0; $i < $row; $i++){
                        ?>
                        <tr>
                            <td>
                                <?php
                                    echo form_dropdown('no_account[]', $no_acc, (isset($_POST['no_account'][$i]) ? $_POST['no_account'][$i] : ''), 'class="form-control input-tip select" style="width:100%;" ');
                                ?>
                            </td>
                            <td>
                                <?php
                                    echo form_dropdown('type_amount[]', $type, (isset($_POST['type_amount'][$i]) ? $_POST['type_amount'][$i] : ''), 'class="form-control input-tip select type_amount" onchange="changeAmount(this)" style="width:100%;" ');
                                ?>
                            </td>
                            <td>
                                <?php echo form_input('amount[]', '', 'class="form-control amount" onchange="changeAmount(this)"'); ?>
                            </td>
                            <td>
                                <?php echo form_input('note_item[]', '', 'class="form-control"'); ?>
                            </td>
                        </tr>
                        <?php
                        }
                        ?>
                    </tbody>
                </table>
            </div>
            <div class="col-md-12">
                <div class="from-group">
                    <?php echo form_submit('add_journal', lang('submit'), 'id="add_journal" class="btn btn-primary" style="padding: 6px 15px; margin:15px 0;"'); ?>
                </div>
            </div>
        </div>
    </div>
    <?php echo form_close(); ?>
</div>
<script type="text/javascript" charset="UTF-8">
    $(document).ready(function () {
        $.fn.datetimepicker.dates['sma'] = <?=$dp_lang?>;
        $(".date").datetimepicker({
            format: 'dd-mm-yyyy',
            fontAwesome: true,
            language: 'sma',
            weekStart: 1,
            todayBtn: 1,
            autoclose: 1,
            todayHighlight: 1,
            startView: 2,
            forceParse: 0,
            minView: 2
        }).datetimepicker('update', new Date());

        $('select').select2('destroy');

        $("#add_journal").click(function(e){
            e.preventDefault();
            let stats = $("#doc_submit_status").val();
            if(stats != "ok"){
                $.alert({
                    title: 'Gagal submit!',
                    content: 'Total debit dan kredit harus berjumlah sama',
                    type: 'red',
                });
                return false;
            }
            else {
                $("#form_submit").submit();
            }
        });
    });

    function changeAmount(elm){
        let tr = $(elm).closest("tr");
        let type = tr.find(".type_amount").select2('val');
        let amount = tr.find(".amount").val();
        if(type != "" && amount != "" && amount != 0){
            let total_debit = 0;
            let total_credit = 0;
            $(".amount").each(function(){
                let isi = $(this).closest("tr").find(".type_amount").select2('val');
                let value = $(this).val();
                console.log(isi, value);
                if(isi != "" && value != ""){
                    if(isi == 'debit'){
                        total_debit += parseInt(value);
                    }
                    else {
                        total_credit += parseInt(value);
                    }
                }
            });
            $("#total_debit").val(total_debit);
            $("#total_credit").val(total_credit);
            let offset = total_debit - total_credit;
            if(offset == 0){
                $("#indicator_status").css("color", "#34d707");
                $("#doc_submit_status").val("ok");
            }
            else {
                $("#indicator_status").css("color", "red");
                $("#doc_submit_status").val("nok");
            }
        }
    }
</script>
