<?php defined('BASEPATH') or exit('No direct script access allowed'); ?>
<div class="modal-dialog modal-lg" style="width: 90vw;">
    <div class="modal-content">
        <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                <i class="fa fa-2x">&times;</i>
            </button>
            <button type="button" class="btn btn-xs btn-default no-print pull-right" style="margin-right:15px;" onclick="window.print();">
                <i class="fa fa-print"></i> <?= lang('print'); ?>
            </button>
            <h4 class="modal-title" id="myModalLabel">Daftar Terima Barang
        </div>
        <div class="modal-body">
            <div class="well well-sm">
                <label>Supplier: </label> <?= $purchase->supplier; ?><br>
                <label>Referensi: </label> <?= $purchase->reference_no; ?><br>
            </div>
            <div class="table-responsive">
                <h2>Pesanan</h2>
                <table class="table table-striped table-bordered">
                    <thead>
                        <tr>
                            <th><?= lang('name'); ?></th>
                            <th><?= lang('quantity'); ?></th>
                            <th><?= lang('unit_cost'); ?></th>
                            <th><?= lang('price'); ?></th>
                        </tr>
                    </thead>
                    <tbody>
                    <?php 
                        $prod = array();
                        foreach ($rows as $item) {
                            echo '<tr>';
                            echo '<td>' . $item->product_code ." - ". $item->product_name . '</td>';
                            echo '<td>' . $this->sma->formatQuantity($item->quantity) . ' ' . $item->product_unit_code . '</td>';
                            echo '<td>' . number_format($item->unit_cost) . '</td>';
                            echo '<td>' . number_format($item->subtotal) . '</td>';
                            echo '</tr>';
                            $prod[$item->product_id] = $item;
                        } 
                    ?>
                    </tbody>
                </table>
            </div>
            <?php if(isset($item_movement) && $item_movement){ ?>
            <div class="table-responsive">
                <h2>Sudah Terima</h2>
                <table class="table table-striped table-bordered">
                    <thead>
                        <tr>
                            <th>Tanggal</th>
                            <th><?= lang('name'); ?></th>
                            <th><?= lang('quantity'); ?></th>
                            <th>Gudang</th>
                            <th>No Surat Jalan</th>
                            <th>Jatuh Tempo</th>
                            <th><?= lang('price'); ?></th>
                            <th><i class='fa fa-file'></i></th>
                            <th>Status</th>
                            <th></th>
                        </tr>
                    </thead>
                    <tbody>
                    <?php 
                        $saldo = $purchase->paid;
                        foreach ($item_movement as $item) {
                            $price = $item->quantity * $prod[$item->product_id]->unit_cost;
                            $status = "Belum dibayar";
                            if($saldo > 0){
                                if($saldo >= $price){
                                    $status = "Lunas";
                                    $saldo -= $price;
                                }
                                else {
                                    $status = "Sebagian";
                                    $saldo = 0;
                                }
                            }
                            echo '<tr>';
                            echo '<td>' . date("d-M-Y", strtotime($item->stock_date)) . '</td>';
                            echo '<td>' . $item->product_code ." - ". $item->product_desc .'</td>';
                            echo '<td>' . $this->sma->formatQuantity($item->quantity) . ' ' . $item->unit_code . '</td>';
                            echo '<td>' . $warehouses[$item->warehouse_id] . '</td>';
                            echo '<td class="no_sj">' . $item->supporting_reff_doc .'</td>';
                            echo '<td>' . date("d-M-Y", strtotime("+".$purchase->payment_term." day", strtotime($item->stock_date))) .'</td>';
                            echo '<td>' . number_format($price) .'</td>';
                            echo '<td class="fileAttach">' . $item->attachment .'</td>';
                            echo '<td>' . $status .'</td>';
                            echo '<td><button class="btn btn-sm btn-danger" onclick="itemDelete(\''.$item->id.'\', this)"><i class="fa fa-trash"></i></button></td>';
                            echo '</tr>';
                        } 
                    ?>
                    </tbody>
                </table>
            </div>
            <?php } ?>
        </div>
    </div>
</div>
<?php 
    $attrib = ['role' => 'form', 'id' => 'deleteForm'];
    echo admin_form_open_multipart('purchases/delete_received', $attrib); 
?>
    <input type="hidden" name="id_item" value="" id="id_item">
<?php echo form_close(); ?>
<script>
    $(".fileAttach").each(function(){
        let isi = $(this).html();
        if(isi != ""){
            let div = attachment(isi);
            $(this).html(div);
        }
    });

    function itemDelete(id, elm){
        let no_sj = $(elm).closest("tr").find(".no_sj").html();
        $.confirm({
            title: 'Hapus Penerimaan Barang',
            content: 'Apakah anda yakin untuk menghapus No Surat Jalan ' + no_sj + "?",
            type: 'orange',
            typeAnimated: true,
            buttons: {
                confirm: function () {
                    $("#id_item").val(id);
                    $("#deleteForm").submit();
                },
                cancel: function () {
                    // $.alert('Canceled!');
                },
            }
        });
    }
</script>