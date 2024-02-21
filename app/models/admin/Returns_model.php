<?php

defined('BASEPATH') or exit('No direct script access allowed');

class Returns_model extends CI_Model
{
    public function __construct()
    {
        parent::__construct();
    }

    public function addReturn($data = [], $items = [])
    {
        $this->db->trans_start();
        if ($this->db->insert('returns', $data)) {
            $return_id = $this->db->insert_id();
            if ($this->site->getReference('re') == $data['reference_no']) {
                $this->site->updateReference('re');
            }

            $pur_header = [
                "reference_no" => $data["reference_no"],
                "date" => date("Y-m-d H:i:s"),
                "supplier_id" => "999",
                "supplier" => "own",
                "warehouse_id" => "999",
                "total" => $data['total'],
                "order_tax_id" => 1,
                "grand_total" => $data['total'],
                "paid" => $data['total'],
                "status" => "received",
                "payment_status" => "paid",
                "created_by" => $this->session->userdata('user_id'),
                "payment_term" => "0",
            ];

            if($this->db->insert('purchases', $pur_header)){
                $pur_id = $this->db->insert_id();

                $dataAcc = array();
                foreach ($items as $dtl) {
                    $pur_dtl = [
                        "purchase_id" => $pur_id,
                        "product_id" => $dtl["product_id"],
                        "product_code" => $dtl["product_code"],
                        "product_name" => $dtl["product_name"],
                        "net_unit_cost" => $dtl["net_unit_price"],
                        "unit_cost" => $dtl["unit_price"],
                        "real_unit_cost" => $dtl["net_unit_price"],
                        "base_unit_cost" => $dtl["net_unit_price"],
                        "quantity" => $dtl["quantity"],
                        "quantity_balance" => $dtl["quantity"],
                        "quantity_received" => $dtl["quantity"],
                        "unit_quantity" => $dtl["quantity"],
                        "warehouse_id" => $data["warehouse_id"],
                        "tax_rate_id" => "1",
                        "subtotal" => $dtl["subtotal"],
                        "date" => date("Y-m-d"),
                        "status" => "received",
                        "product_unit_id" => $dtl["product_unit_id"],
                        "product_unit_code" => $dtl["product_unit_code"],
                        "product_batch" => $dtl["product_batch"]
                    ];
                    if($this->db->insert('purchase_items', $pur_dtl)){
                        $dtl['return_id'] = $return_id;
                        $this->db->insert('return_items', $dtl);
                        $dtl_id = $this->db->insert_id();
                        $this->site->syncQuantityBatch($dtl['product_id'], $dtl['product_batch']);
                        $item_movement = [
                            "warehouse_id" => $dtl['warehouse_id'],
                            "product_id" => $dtl['product_id'],
                            "product_code" => $dtl['product_code'],
                            "product_desc" => $dtl['product_name'],
                            "quantity" => $dtl['quantity'],
                            "unit_code" => $dtl['product_unit_code'],
                            "movement_type" => 'in',
                            "product_batch" => $dtl["product_batch"],
                            "movement_status" => 'bad',
                            "reff_type" => 'return_delivery',
                            "reff_no" => $data['reference_no'],
                            "stock_date" => date("Y-m-d"),
                            "created_by" => $this->session->userdata('user_id'),
                        ];
                        $this->site->submitMovementItem($item_movement, false);

                        $no_account = "1150100";
                        $type_amount = "debit";
                        $amount = $dtl["quantity"] * $dtl['net_unit_price'];
                        $acc = [
                            'no_source' => $data['reference_no'],
                            'type_source' => 'RET',
                            'loc_source' => 'detail',
                            'id_source' => $dtl_id,
                            'division' => $data['division'],
                            'no_account' => $no_account,
                            'type_amount' => $type_amount,
                            'amount' => $amount,
                            'note' => $dtl['product_code']." - ".$dtl['product_name'],
                            'note_query' => 'calc=quantity*net_unit_price',
                            "created_by" => $this->session->userdata('user_id'),
                        ];
                        $dataAcc[] = $acc;
                        if($data['item_discount'] > 0){
                            $no_account = "6190102";
                            $type_amount = "credit";
                            $amount = $data['item_discount'];

                            $acc['no_account'] = $no_account;
                            $acc['type_amount'] = $type_amount;
                            $acc['amount'] = $amount;
                            $acc['note_query'] = 'field=item_discount';
                            $dataAcc[] = $acc;
                        }
                    }
                }

                $this->site->postAccounting($dataAcc, false);
            }

            // foreach ($items as $item) {
            //     $item['return_id'] = $return_id;
            //     $this->db->insert('return_items', $item);
            //     // if ($item['product_type'] == 'standard') {
            //         $clause = ['product_id' => $item['product_id'], 'warehouse_id' => $item['warehouse_id'], 'purchase_id' => null, 'transfer_id' => null, 'option_id' => $item['option_id']];
            //         $this->site->setPurchaseItem($clause, $item['quantity']);
            //         // $this->site->syncQuantity(null, null, null, $item['product_id']);
            //         $this->site->syncQuantityBatch($item['product_id'], $item['product_batch']);
            //     // } elseif ($item['product_type'] == 'combo') {
            //     //     $combo_items = $this->site->getProductComboItems($item['product_id']);
            //     //     foreach ($combo_items as $combo_item) {
            //     //         $clause = ['product_id' => $combo_item->id, 'purchase_id' => null, 'transfer_id' => null, 'option_id' => null];
            //     //         $this->site->setPurchaseItem($clause, ($combo_item->qty * $item['quantity']));
            //     //         $this->site->syncQuantity(null, null, null, $combo_item->id);
            //     //     }
            //     // }
            // }
            $this->sma->update_award_points($data['grand_total'], $data['customer_id'], $data['created_by'], true);

            $type = 'RET';
            $this->site->updateReff($type, $data['date']);
        }
        else {
            return false;
        }
        $this->db->trans_complete();
        if ($this->db->trans_status() === false) {
            log_message('error', 'An errors has been occurred while adding the sale (Add:Returns_model.php)');
        } else {
            return true;
        }

        return false;
    }

    public function deleteReturn($id)
    {
        $this->db->trans_start();
        $this->resetSaleActions($id);
        $ret = $this->getReturnByID($id);
        $this->site->log('Return', ['model' => $ret, 'items' => $this->getReturnItems($id)]);
        $this->db->delete('return_items', ['return_id' => $id]);
        $this->db->delete('returns', ['id' => $id]);
        $editAcc['no_source'] = $ret->reference_no;
        $dataAcc = array();
        $this->site->postAccounting($dataAcc, $editAcc);
        $this->db->trans_complete();
        if ($this->db->trans_status() === false) {
            log_message('error', 'An errors has been occurred while adding the sale (Delete:Returns_model.php)');
        } else {
            return true;
        }
        return false;
    }

    public function getProductNames($term, $limit = 5)
    {
        $this->db->where("(name LIKE '%" . $term . "%' OR code LIKE '%" . $term . "%' OR  concat(name, ' (', code, ')') LIKE '%" . $term . "%')");
        $this->db->limit($limit);
        $q = $this->db->get('products');
        if ($q->num_rows() > 0) {
            foreach (($q->result()) as $row) {
                $data[] = $row;
            }
            return $data;
        }
        return false;
    }

    public function getProductOptionByID($id)
    {
        $q = $this->db->get_where('product_variants', ['id' => $id], 1);
        if ($q->num_rows() > 0) {
            return $q->row();
        }
        return false;
    }

    public function getProductOptions($product_id)
    {
        $q = $this->db->get_where('product_variants', ['product_id' => $product_id]);
        if ($q->num_rows() > 0) {
            foreach (($q->result()) as $row) {
                $data[] = $row;
            }
            return $data;
        }
        return false;
    }

    public function getReturnByID($id)
    {
        $q = $this->db->get_where('returns', ['id' => $id], 1);
        if ($q->num_rows() > 0) {
            return $q->row();
        }
        return false;
    }

    public function getReturnItems($return_id)
    {
        $this->db->select('return_items.*, tax_rates.code as tax_code, tax_rates.name as tax_name, tax_rates.rate as tax_rate, products.image, products.details as details, product_variants.name as variant, products.hsn_code as hsn_code, products.second_name as second_name')
            ->join('products', 'products.id=return_items.product_id', 'left')
            ->join('product_variants', 'product_variants.id=return_items.option_id', 'left')
            ->join('tax_rates', 'tax_rates.id=return_items.tax_rate_id', 'left')
            ->where('return_id', $return_id)
            ->group_by('return_items.id')
            ->order_by('id', 'asc');

        $q = $this->db->get('return_items');
        if ($q->num_rows() > 0) {
            foreach (($q->result()) as $row) {
                $data[] = $row;
            }
            return $data;
        }
        return false;
    }

    public function getReturnItemsByReturnId($return_id)
    {
        $this->db->where("return_id", $return_id);
        $q = $this->db->get('return_items');
        if ($q->num_rows() > 0) {
            foreach (($q->result()) as $row) {
                $data[] = $row;
            }
            return $data;
        }
        return false;
    }

    public function resetSaleActions($id)
    {
        if ($items = $this->getReturnItems($id)) {
            foreach ($items as $item) {
                if ($item->product_type == 'standard') {
                    $clause = ['product_id' => $item->product_id, 'purchase_id' => null, 'transfer_id' => null, 'option_id' => $item->option_id];
                    $this->site->setPurchaseItem($clause, (0 - $item->quantity));
                    $this->site->syncQuantity(null, null, null, $item->product_id);
                } elseif ($item->product_type == 'combo') {
                    $combo_items = $this->site->getProductComboItems($item->product_id);
                    foreach ($combo_items as $combo_item) {
                        $clause = ['product_id' => $combo_item->id, 'purchase_id' => null, 'transfer_id' => null, 'option_id' => null];
                        $this->site->setPurchaseItem($clause, (0 - ($combo_item->qty * $item->quantity)));
                        $this->site->syncQuantity(null, null, null, $combo_item->id);
                    }
                }
            }
        }
    }

    public function updateReturn($id, $data = [], $items = [])
    {
        $this->db->trans_start();
        $this->resetSaleActions($id);
        if ($this->db->update('returns', $data, ['id' => $id]) && $this->db->delete('return_items', ['return_id' => $id])) {
            // $return_id = $id;
            foreach ($items as $item) {
                // $item['return_id'] = $return_id;
                $this->db->insert('return_items', $item);
                if ($item['product_type'] == 'standard') {
                    $clause = ['product_id' => $item['product_id'], 'purchase_id' => null, 'transfer_id' => null, 'option_id' => $item['option_id']];
                    $this->site->setPurchaseItem($clause, $item['quantity']);
                    $this->site->syncQuantity(null, null, null, $item['product_id']);
                } elseif ($item['product_type'] == 'combo') {
                    $combo_items = $this->site->getProductComboItems($item['product_id']);
                    foreach ($combo_items as $combo_item) {
                        $clause = ['product_id' => $combo_item->id, 'purchase_id' => null, 'transfer_id' => null, 'option_id' => null];
                        $this->site->setPurchaseItem($clause, ($combo_item->qty * $item['quantity']));
                        $this->site->syncQuantity(null, null, null, $combo_item->id);
                    }
                }
            }
        }
        $this->db->trans_complete();
        if ($this->db->trans_status() === false) {
            log_message('error', 'An errors has been occurred while adding the sale (Update:Returns_model.php)');
        } else {
            return true;
        }

        return false;
    }

    public function getReturnByDelvId($delv_id)
    {
        $q = $this->db->get_where('returns', ['delv_id' => $delv_id]);
        if ($q->num_rows() > 0) {
            foreach (($q->result()) as $row) {
                $data[] = $row;
            }
            return $data;
        }
        return false;
    }

    public function getCountForReff($year)
    {
        $q = $this->db->get_where('returns', ['year(`date`)' => $year]);
        return $q->num_rows();
    }
}
