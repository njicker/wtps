<?php

defined('BASEPATH') or exit('No direct script access allowed');

class Purchases_model extends CI_Model
{
    public function __construct()
    {
        parent::__construct();
    }

    public function addExpense($data = [])
    {
        if ($this->db->insert('expenses', $data)) {
            if ($this->site->getReference('ex') == $data['reference']) {
                $this->site->updateReference('ex');
            }
            return true;
        }
        return false;
    }

    public function addPayment($data = [])
    {
        if ($this->db->insert('payments', $data)) {
            $pay_id = $this->db->insert_id();
            if ($this->site->getReference('ppay') == $data['reference_no']) {
                $this->site->updateReference('ppay');
            }
            $this->site->syncPurchasePayments($data['purchase_id']);
            // Accounting
            $pur = $this->getPurchaseByID($data['purchase_id']);
            $dataAcc = array();
            $method = $this->site->getAccountByPaidMethod($data['paid_by']);
            $type_amount = "credit";
            $amount = $data['amount'];
            $type = "PAY";
            $acc = [
                'no_source' => $pur->reference_no,
                'doc_date' => date("Y-m-d", strtotime($data['date'])),
                'type_source' => $type,
                'loc_source' => 'header',
                'id_source' => $pay_id,
                'division' => $pur->division,
                'no_account' => $method->no_account,
                'type_amount' => $type_amount,
                'amount' => $amount,
                'note' => $data['reference_no'],
                'note_query' => 'field=amount',
                "created_by" => $this->session->userdata('user_id'),
            ];
            $dataAcc[] = $acc;
            $this->site->postAccounting($dataAcc, false);

            return true;
        }
        return false;
    }

    public function addProductOptionQuantity($option_id, $warehouse_id, $quantity, $product_id)
    {
        if ($option = $this->getProductWarehouseOptionQty($option_id, $warehouse_id)) {
            $nq = $option->quantity + $quantity;
            if ($this->db->update('warehouses_products_variants', ['quantity' => $nq], ['option_id' => $option_id, 'warehouse_id' => $warehouse_id])) {
                return true;
            }
        } else {
            if ($this->db->insert('warehouses_products_variants', ['option_id' => $option_id, 'product_id' => $product_id, 'warehouse_id' => $warehouse_id, 'quantity' => $quantity])) {
                return true;
            }
        }
        return false;
    }

    public function addPurchase($data, $items)
    {
        $this->db->trans_start();
        $type = 'PO';
        if ($this->db->insert('purchases', $data)) {
            $dataAcc = array();
            $purchase_id = $this->db->insert_id();
            // if ($this->site->getReference('po') == $data['reference_no']) {
            //     $this->site->updateReference('po');
            // }
            // if ($this->site->getReference('rep') == $data['return_purchase_ref']) {
            //     $this->site->updateReference('rep');
            // }
            $item_movement = array();
            foreach ($items as $item) {
                $item['purchase_id'] = $purchase_id;
                $item['option_id']   = !empty($item['option_id']) && is_numeric($item['option_id']) ? $item['option_id'] : null;
                $this->db->insert('purchase_items', $item);
                $pur_item_id = $this->db->insert_id();
                if ($this->Settings->update_cost) {
                    $this->db->update('products', ['cost' => $item['base_unit_cost']], ['id' => $item['product_id']]);
                    if ($item['option_id']) {
                        $this->db->update('product_variants', ['cost' => $item['base_unit_cost']], ['id' => $item['option_id'], 'product_id' => $item['product_id']]);
                    }
                }
                if ($data['status'] == 'received' || $data['status'] == 'returned') {
                    $item_movement = [
                        "warehouse_id" => $item['warehouse_id'],
                        "product_id" => $item['product_id'],
                        "product_code" => $item['product_code'],
                        "product_desc" => $item['product_name'],
                        "quantity" => $item['quantity_balance'] * ($data['status'] == 'returned' ? -1 : 1),
                        "unit_code" => $item['product_unit_code'],
                        "movement_type" => $data['status'] == 'returned' ? 'out' : 'in',
                        "product_batch" => '',
                        "movement_status" => 'good',
                        "reff_type" => 'purchase',
                        "reff_no" => $data['reference_no'],
                        "stock_date" => date("Y-m-d", strtotime($data['date'])),
                        "created_by" => $this->session->userdata('user_id'),
                    ];
                    $this->site->submitMovementItem($item_movement, false);
                    $this->updateAVCO(['product_id' => $item['product_id'], 'warehouse_id' => $item['warehouse_id'], 'quantity' => $item['quantity'], 'cost' => $item['base_unit_cost'] ?? $item['real_unit_cost']]);
                }
                // $no_account = "2130101";
                // $type_amount = "debit";
                // $amount = $item['quantity'] * $item['real_unit_cost'];
                // $acc = [
                //     'no_source' => $data['reference_no'],
                //     'doc_date' => date("Y-m-d", strtotime($data['date'])),
                //     'type_source' => $type,
                //     'loc_source' => 'detail',
                //     'id_source' => $pur_item_id,
                //     'division' => $data['division'],
                //     'no_account' => $no_account,
                //     'type_amount' => $type_amount,
                //     'amount' => $amount,
                //     'note' => $item['product_code']." - ".$item['product_name'],
                //     'note_query' => 'calc=quantity*real_unit_cost',
                //     "created_by" => $this->session->userdata('user_id'),
                // ];
                // $dataAcc[] = $acc;
                // if($item['discount'] > 0){
                //     // add acc discount
                // }
            }

            if ($data['status'] == 'returned') {
                $this->db->update('purchases', ['return_purchase_ref' => $data['return_purchase_ref'], 'surcharge' => $data['surcharge'], 'return_purchase_total' => $data['grand_total'], 'return_id' => $purchase_id], ['id' => $data['purchase_id']]);
            }

            if ($data['status'] == 'received' || $data['status'] == 'returned') {
                $this->site->syncQuantity(null, $purchase_id);
            }
            // Referensi
            $this->site->updateReff($type, $data['date']);
            // Accounting
            $no_account = "2130101";
            $type_amount = "debit";
            $amount = $data['grand_total'];
            $acc = [
                'no_source' => $data['reference_no'],
                'doc_date' => date("Y-m-d", strtotime($data['date'])),
                'type_source' => $type,
                'loc_source' => 'header',
                'id_source' => $purchase_id,
                'division' => $data['division'],
                'no_account' => $no_account,
                'type_amount' => $type_amount,
                'amount' => $amount,
                'note' => 'Hutang Dagang',
                'note_query' => 'field=grand_total',
                "created_by" => $this->session->userdata('user_id'),
            ];
            $dataAcc[] = $acc;

            if($data['order_tax'] > 0){
                $no_account = "1170700";
                $type_amount = "debit";
                $amount = $data['order_tax'];

                $acc['loc_source'] = 'header';
                $acc['id_source'] = $purchase_id;
                $acc['no_account'] = $no_account;
                $acc['type_amount'] = $type_amount;
                $acc['amount'] = $amount;
                $acc['note'] = "Pajak Pembelian";
                $acc['note_query'] = "field=order_tax";
                $dataAcc[] = $acc;
            }
            // // Order Discount
            // if(isset($data['order_discount']) && $data['order_discount'] > 0){
            //     $no_account = "1170700";
            //     $type_amount = "debit";
            //     $amount = $data['order_discount'];

            //     $acc['loc_source'] = 'header';
            //     $acc['id_source'] = $purchase_id;
            //     $acc['no_account'] = $no_account;
            //     $acc['type_amount'] = $type_amount;
            //     $acc['amount'] = $amount;
            //     $acc['note'] = "Diskon Pembelian";
            //     $acc['note_query'] = "field=order_discount";
            //     $dataAcc[] = $acc;
            // }
            $this->site->postAccounting($dataAcc, null);
        }
        $this->db->trans_complete();
        if ($this->db->trans_status() === false) {
            log_message('error', 'An errors has been occurred while adding the sale (Add:Purchases_model.php)');
        } else {
            return true;
        }
        return false;
    }

    public function calculatePurchaseTotals($id, $return_id, $surcharge)
    {
        $purchase = $this->getPurchaseByID($id);
        $items    = $this->getAllPurchaseItems($id);
        if (!empty($items)) {
            $total            = 0;
            $product_tax      = 0;
            $order_tax        = 0;
            $product_discount = 0;
            $order_discount   = 0;
            foreach ($items as $item) {
                $product_tax      += $item->item_tax;
                $product_discount += $item->item_discount;
                $total            += $item->net_unit_cost * $item->quantity;
            }
            if ($purchase->order_discount_id) {
                $percentage        = '%';
                $order_discount_id = $purchase->order_discount_id;
                $opos              = strpos($order_discount_id, $percentage);
                if ($opos !== false) {
                    $ods            = explode('%', $order_discount_id);
                    $order_discount = (($total + $product_tax) * (float)($ods[0])) / 100;
                } else {
                    $order_discount = $order_discount_id;
                }
            }
            if ($purchase->order_tax_id) {
                $order_tax_id = $purchase->order_tax_id;
                if ($order_tax_details = $this->site->getTaxRateByID($order_tax_id)) {
                    if ($order_tax_details->type == 2) {
                        $order_tax = $order_tax_details->rate;
                    }
                    if ($order_tax_details->type == 1) {
                        $order_tax = (($total + $product_tax - $order_discount) * $order_tax_details->rate) / 100;
                    }
                }
            }
            $total_discount = $order_discount + $product_discount;
            $total_tax      = $product_tax    + $order_tax;
            $grand_total    = $total          + $total_tax          + $purchase->shipping - $order_discount          + $surcharge;
            $data           = [
                'total'            => $total,
                'product_discount' => $product_discount,
                'order_discount'   => $order_discount,
                'total_discount'   => $total_discount,
                'product_tax'      => $product_tax,
                'order_tax'        => $order_tax,
                'total_tax'        => $total_tax,
                'grand_total'      => $grand_total,
                'return_id'        => $return_id,
                'surcharge'        => $surcharge,
            ];

            if ($this->db->update('purchases', $data, ['id' => $id])) {
                return true;
            }
        } else {
            $this->db->delete('purchases', ['id' => $id]);
        }
        return false;
    }

    public function deleteExpense($id)
    {
        $this->site->log('Expense', ['model' => $this->getExpenseByID($id)]);
        if ($this->db->delete('expenses', ['id' => $id])) {
            return true;
        }
        return false;
    }

    public function deletePayment($id)
    {
        $opay = $this->getPaymentByID($id);
        $this->site->log('Payment', ['model' => $opay]);
        if ($this->db->delete('payments', ['id' => $id])) {
            $this->site->syncPurchasePayments($opay->purchase_id);

            // Accounting
            $edit['type_source'] = 'PAY';
            $edit['loc_source'] = 'header';
            $edit['id_source'] = $id;
            $dataAcc = array();
            $this->site->postAccounting($dataAcc, $edit);

            return true;
        }
        return false;
    }

    public function deletePurchase($id)
    {
        $this->db->trans_start();
        $purchase       = $this->getPurchaseByID($id);
        $purchase_items = $this->site->getAllPurchaseItems($id);
        $this->site->log('Purchase', ['model' => $purchase, 'items' => $purchase_items]);
        if ($this->db->delete('purchase_items', ['purchase_id' => $id]) && $this->db->delete('purchases', ['id' => $id])) {
            $this->db->delete('payments', ['purchase_id' => $id]);
            if ($purchase->status == 'received' || $purchase->status == 'partial') {
                foreach ($purchase_items as $oitem) {
                    $this->updateAVCO(['product_id' => $oitem->product_id, 'warehouse_id' => $oitem->warehouse_id, 'quantity' => (0 - $oitem->quantity), 'cost' => $oitem->real_unit_cost]);
                    $received = $oitem->quantity_received ? $oitem->quantity_received : $oitem->quantity;
                    if ($oitem->quantity_balance < $received) {
                        $clause = ['purchase_id' => null, 'transfer_id' => null, 'product_id' => $oitem->product_id, 'warehouse_id' => $oitem->warehouse_id, 'option_id' => $oitem->option_id];
                        $this->site->setPurchaseItem($clause, ($oitem->quantity_balance - $received));
                    }
                }
            }
            $this->site->syncQuantity(null, null, $purchase_items);
        }
        // Accounting
        $dataAcc = array();
        $edit['no_source'] = $purchase->reference_no;
        $this->site->postAccounting($dataAcc, $edit);
        $this->db->trans_complete();
        if ($this->db->trans_status() === false) {
            log_message('error', 'An errors has been occurred while adding the sale (Delete:Purchases_model.php)');
        } else {
            return true;
        }
        return false;
    }

    public function getAllProducts()
    {
        $q = $this->db->get('products');
        if ($q->num_rows() > 0) {
            foreach (($q->result()) as $row) {
                $data[] = $row;
            }
            return $data;
        }
        return false;
    }

    public function getAllPurchaseItems($purchase_id)
    {
        $this->db->select('purchase_items.*, tax_rates.code as tax_code, tax_rates.name as tax_name, tax_rates.rate as tax_rate, products.unit, products.details as details, product_variants.name as variant, products.hsn_code as hsn_code, products.second_name as second_name')
            ->join('products', 'products.id=purchase_items.product_id', 'left')
            ->join('product_variants', 'product_variants.id=purchase_items.option_id', 'left')
            ->join('tax_rates', 'tax_rates.id=purchase_items.tax_rate_id', 'left')
            ->group_by('purchase_items.id')
            ->order_by('id', 'asc');
        $q = $this->db->get_where('purchase_items', ['purchase_id' => $purchase_id]);
        if ($q->num_rows() > 0) {
            foreach (($q->result()) as $row) {
                $data[] = $row;
            }
            return $data;
        }
        return false;
    }

    public function getAllPurchases()
    {
        $q = $this->db->get('purchases');
        if ($q->num_rows() > 0) {
            foreach (($q->result()) as $row) {
                $data[] = $row;
            }
            return $data;
        }
    }

    public function getAllQuoteItems($quote_id)
    {
        $q = $this->db->get_where('quote_items', ['quote_id' => $quote_id]);
        if ($q->num_rows() > 0) {
            foreach (($q->result()) as $row) {
                $data[] = $row;
            }
            return $data;
        }
        return false;
    }

    public function getAllReturnItems($return_id)
    {
        $this->db->select('return_purchase_items.*, products.details as details, product_variants.name as variant, products.hsn_code as hsn_code, products.second_name as second_name')
            ->join('products', 'products.id=return_purchase_items.product_id', 'left')
            ->join('product_variants', 'product_variants.id=return_purchase_items.option_id', 'left')
            ->group_by('return_purchase_items.id')
            ->order_by('id', 'asc');
        $q = $this->db->get_where('return_purchase_items', ['return_id' => $return_id]);
        if ($q->num_rows() > 0) {
            foreach (($q->result()) as $row) {
                $data[] = $row;
            }
            return $data;
        }
    }

    public function getExpenseByID($id)
    {
        $q = $this->db->get_where('expenses', ['id' => $id], 1);
        if ($q->num_rows() > 0) {
            return $q->row();
        }
        return false;
    }

    public function getExpenseCategories()
    {
        $q = $this->db->get('expense_categories');
        if ($q->num_rows() > 0) {
            foreach (($q->result()) as $row) {
                $data[] = $row;
            }
            return $data;
        }
        return false;
    }

    public function getExpenseCategoryByID($id)
    {
        $q = $this->db->get_where('expense_categories', ['id' => $id], 1);
        if ($q->num_rows() > 0) {
            return $q->row();
        }
        return false;
    }

    public function getItemByID($id)
    {
        $q = $this->db->get_where('purchase_items', ['id' => $id], 1);
        if ($q->num_rows() > 0) {
            return $q->row();
        }
        return false;
    }

    public function getOverSoldCosting($product_id)
    {
        $q = $this->db->get_where('costing', ['overselling' => 1]);
        if ($q->num_rows() > 0) {
            foreach (($q->result()) as $row) {
                $data[] = $row;
            }
            return $data;
        }
        return false;
    }

    public function getPaymentByID($id)
    {
        $q = $this->db->get_where('payments', ['id' => $id], 1);
        if ($q->num_rows() > 0) {
            return $q->row();
        }

        return false;
    }

    public function getPaymentsForPurchase($purchase_id)
    {
        $this->db->select('payments.date, payments.paid_by, payments.amount, payments.reference_no, users.first_name, users.last_name, type')
            ->join('users', 'users.id=payments.created_by', 'left');
        $q = $this->db->get_where('payments', ['purchase_id' => $purchase_id]);
        if ($q->num_rows() > 0) {
            foreach (($q->result()) as $row) {
                $data[] = $row;
            }
            return $data;
        }
        return false;
    }

    public function getProductByCode($code)
    {
        $q = $this->db->get_where('products', ['code' => $code], 1);
        if ($q->num_rows() > 0) {
            return $q->row();
        }
        return false;
    }

    public function getProductByID($id)
    {
        $q = $this->db->get_where('products', ['id' => $id], 1);
        if ($q->num_rows() > 0) {
            return $q->row();
        }
        return false;
    }

    public function getProductByName($name)
    {
        $q = $this->db->get_where('products', ['name' => $name], 1);
        if ($q->num_rows() > 0) {
            return $q->row();
        }
        return false;
    }

    public function getProductNames($term, $limit = 5, $type, $cf1 = "", $cf2 = "")
    {
        if($type != ""){
            $this->db->where('type', $type);
        }
        if($cf1 != ""){
            $this->db->where('cf1', $cf1);
        }
        if($cf2 != ""){
            $this->db->where('cf2', $cf2);
        }
        $this->db->where('flag_delete', '');
        $this->db->where("(name LIKE '%" . $term . "%' OR code LIKE '%" . $term . "%' OR supplier1_part_no LIKE '%" . $term . "%' OR supplier2_part_no LIKE '%" . $term . "%' OR supplier3_part_no LIKE '%" . $term . "%' OR supplier4_part_no LIKE '%" . $term . "%' OR supplier5_part_no LIKE '%" . $term . "%' OR  concat(name, ' (', code, ')') LIKE '%" . $term . "%')");
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

    public function getProductsByCode($code)
    {
        $this->db->select('*')->from('products')->like('code', $code, 'both');
        $q = $this->db->get();
        if ($q->num_rows() > 0) {
            foreach (($q->result()) as $row) {
                $data[] = $row;
            }
            return $data;
        }
    }

    public function getProductVariantByName($name, $product_id)
    {
        $q = $this->db->get_where('product_variants', ['name' => $name, 'product_id' => $product_id], 1);
        if ($q->num_rows() > 0) {
            return $q->row();
        }
        return false;
    }

    public function getProductWarehouseOptionQty($option_id, $warehouse_id)
    {
        $q = $this->db->get_where('warehouses_products_variants', ['option_id' => $option_id, 'warehouse_id' => $warehouse_id], 1);
        if ($q->num_rows() > 0) {
            return $q->row();
        }
        return false;
    }

    public function getPurchaseItemByID($id)
    {
        $q = $this->db->get_where('purchase_items', ['id' => $id], 1);
        if ($q->num_rows() > 0) {
            return $q->row();
        }
        return false;
    }

    public function getPurchaseItemByKey($purchase_id, $product_id)
    {
        $q = $this->db->get_where('purchase_items', ['purchase_id' => $purchase_id, 'product_id' => $product_id], 1);
        if ($q->num_rows() > 0) {
            return $q->row();
        }
        return false;
    }

    public function getPurchaseItemByPurchaseID($purchase_id)
    {
        $q = $this->db->get_where('purchase_items', ['purchase_id' => $purchase_id]);
        if ($q->num_rows() > 0) {
            foreach (($q->result()) as $row) {
                $data[] = $row;
            }
            return $data;
        }
    }

    public function getPurchaseByID($id)
    {
        $q = $this->db->get_where('purchases', ['id' => $id], 1);
        if ($q->num_rows() > 0) {
            return $q->row();
        }
        return false;
    }

    public function getPurchaseByParam($param)
    {
        $q = $this->db->get_where('purchases', $param, 1);
        if ($q->num_rows() > 0) {
            return $q->row();
        }
        return false;
    }

    public function getPurchasePayments($purchase_id)
    {
        $this->db->order_by('id', 'asc');
        $q = $this->db->get_where('payments', ['purchase_id' => $purchase_id]);
        if ($q->num_rows() > 0) {
            foreach (($q->result()) as $row) {
                $data[] = $row;
            }
            return $data;
        }
    }

    public function getQuoteByID($id)
    {
        $q = $this->db->get_where('quotes', ['id' => $id], 1);
        if ($q->num_rows() > 0) {
            return $q->row();
        }
        return false;
    }

    public function getReturnByID($id)
    {
        $q = $this->db->get_where('return_purchases', ['id' => $id], 1);
        if ($q->num_rows() > 0) {
            return $q->row();
        }
        return false;
    }

    public function getTaxRateByName($name)
    {
        $q = $this->db->get_where('tax_rates', ['name' => $name], 1);
        if ($q->num_rows() > 0) {
            return $q->row();
        }
        return false;
    }

    public function getWarehouseProductQuantity($warehouse_id, $product_id)
    {
        $q = $this->db->get_where('warehouses_products', ['warehouse_id' => $warehouse_id, 'product_id' => $product_id], 1);
        if ($q->num_rows() > 0) {
            return $q->row();
        }
        return false;
    }

    public function resetProductOptionQuantity($option_id, $warehouse_id, $quantity, $product_id)
    {
        if ($option = $this->getProductWarehouseOptionQty($option_id, $warehouse_id)) {
            $nq = $option->quantity - $quantity;
            if ($this->db->update('warehouses_products_variants', ['quantity' => $nq], ['option_id' => $option_id, 'warehouse_id' => $warehouse_id])) {
                return true;
            }
        } else {
            $nq = 0 - $quantity;
            if ($this->db->insert('warehouses_products_variants', ['option_id' => $option_id, 'product_id' => $product_id, 'warehouse_id' => $warehouse_id, 'quantity' => $nq])) {
                return true;
            }
        }
        return false;
    }

    public function returnPurchase($data = [], $items = [])
    {
        $purchase_items = $this->site->getAllPurchaseItems($data['purchase_id']);

        if ($this->db->insert('return_purchases', $data)) {
            $return_id = $this->db->insert_id();
            if ($this->site->getReference('rep') == $data['reference_no']) {
                $this->site->updateReference('rep');
            }
            foreach ($items as $item) {
                $item['return_id'] = $return_id;
                $this->db->insert('return_purchase_items', $item);

                if ($purchase_item = $this->getPurchaseItemByID($item['purchase_item_id'])) {
                    if ($purchase_item->quantity == $item['quantity']) {
                        $this->db->delete('purchase_items', ['id' => $item['purchase_item_id']]);
                    } else {
                        $nqty          = $purchase_item->quantity          - $item['quantity'];
                        $bqty          = $purchase_item->quantity_balance  - $item['quantity'];
                        $rqty          = $purchase_item->quantity_received - $item['quantity'];
                        $tax           = $purchase_item->unit_cost         - $purchase_item->net_unit_cost;
                        $discount      = $purchase_item->item_discount / $purchase_item->quantity;
                        $item_tax      = $tax                      * $nqty;
                        $item_discount = $discount                 * $nqty;
                        $subtotal      = $purchase_item->unit_cost * $nqty;
                        $this->db->update('purchase_items', ['quantity' => $nqty, 'quantity_balance' => $bqty, 'quantity_received' => $rqty, 'item_tax' => $item_tax, 'item_discount' => $item_discount, 'subtotal' => $subtotal], ['id' => $item['purchase_item_id']]);
                    }
                }
            }
            $this->calculatePurchaseTotals($data['purchase_id'], $return_id, $data['surcharge']);
            $this->site->syncQuantity(null, null, $purchase_items);
            $this->site->syncQuantity(null, $data['purchase_id']);
            return true;
        }
        return false;
    }

    public function updateAVCO($data)
    {
        if ($wp_details = $this->getWarehouseProductQuantity($data['warehouse_id'], $data['product_id'])) {
            $total_cost     = (($wp_details->quantity * $wp_details->avg_cost) + ($data['quantity'] * $data['cost']));
            $total_quantity = $wp_details->quantity + $data['quantity'];
            if (!empty($total_quantity)) {
                $avg_cost = ($total_cost / $total_quantity);
                $this->db->update('warehouses_products', ['avg_cost' => $avg_cost], ['product_id' => $data['product_id'], 'warehouse_id' => $data['warehouse_id']]);
            }
        } else {
            $this->db->insert('warehouses_products', ['product_id' => $data['product_id'], 'warehouse_id' => $data['warehouse_id'], 'avg_cost' => $data['cost'], 'quantity' => 0]);
        }
    }

    public function updateExpense($id, $data = [])
    {
        if ($this->db->update('expenses', $data, ['id' => $id])) {
            return true;
        }
        return false;
    }

    public function updatePayment($id, $data = [])
    {
        if ($this->db->update('payments', $data, ['id' => $id])) {
            $this->site->syncPurchasePayments($data['purchase_id']);
            return true;
        }
        return false;
    }

    public function updatePurchase($id, $data, $items = [], $mode = "")
    {
        $this->db->trans_start();
        $type = 'PO';
        $opurchase = $this->getPurchaseByID($id);
        $oitems    = $this->getAllPurchaseItems($id);
        $receive_date = $data['receive_date'];
        unset($data['receive_date']);
        $supporting_reff_doc = $data['supporting_reff_doc'];
        unset($data['supporting_reff_doc']);
        $attachment = "";
        if($mode == "received" && isset($data['attachment'])){
            $attachment = $data['attachment'];
            unset($data['attachment']);
        }
        if ($this->db->update('purchases', $data, ['id' => $id]) && $this->db->delete('purchase_items', ['purchase_id' => $id])) {
            $dataAcc = array();
            $editAcc = false;
            $purchase_id = $id;
            foreach ($items as $item) {
                $receive_quantity = $item['receive_quantity'];
                unset($item['receive_quantity']);
                $item['purchase_id'] = $id;
                $item['option_id']   = !empty($item['option_id']) && is_numeric($item['option_id']) ? $item['option_id'] : null;
                $this->db->insert('purchase_items', $item);
                $pur_item_id = $this->db->insert_id();
                // if ($data['status'] == 'received' || $data['status'] == 'partial') {
                if($mode == "received"){
                    $this->updateAVCO(['product_id' => $item['product_id'], 'warehouse_id' => $item['warehouse_id'], 'quantity' => $item['quantity'], 'cost' => $item['real_unit_cost']]);
                    if($receive_quantity <= 0){
                        continue;
                    }
                    $item_movement = [
                        "warehouse_id" => $item['warehouse_id'],
                        "product_id" => $item['product_id'],
                        "product_code" => $item['product_code'],
                        "product_desc" => $item['product_name'],
                        "quantity" => $receive_quantity * ($data['status'] == 'returned' ? -1 : 1),
                        "unit_code" => $item['product_unit_code'],
                        "movement_type" => $data['status'] == 'returned' ? 'out' : 'in',
                        "product_batch" => '',
                        "movement_status" => 'good',
                        "reff_type" => 'purchase',
                        "reff_no" => $data['reference_no'],
                        "stock_date" => date("Y-m-d", strtotime($receive_date)),
                        "created_by" => $this->session->userdata('user_id'),
                        "supporting_reff_doc" => $supporting_reff_doc,
                        "attachment" => $attachment,
                    ];
                    $this->site->submitMovementItem($item_movement, false);

                    $no_account = "1150200";
                    $type_amount = "debit";
                    $amount = $receive_quantity * $item['real_unit_cost'];
                    $note_query = 'calc=receive_quantity*real_unit_cost#type=receive_purchase';
                    $note = $supporting_reff_doc;

                    $acc = [
                        'no_source' => $data['reference_no'],
                        'doc_date' => date("Y-m-d", strtotime($receive_date)),
                        'type_source' => $type,
                        'loc_source' => 'detail',
                        'id_source' => $pur_item_id,
                        'division' => $data['division'],
                        'no_account' => $no_account,
                        'type_amount' => $type_amount,
                        'amount' => $amount,
                        'note' => $note,
                        'note_query' => $note_query,
                        "created_by" => $this->session->userdata('user_id'),
                    ];
                    $dataAcc[] = $acc;
                }
                // else { // edit purchase
                //     $editAcc = true;
                //     $no_account = "2130101";
                //     $type_amount = "debit";
                //     $amount = $item['quantity'] * $item['real_unit_cost'];
                //     $note_query = 'calc=quantity*real_unit_cost';
                //     $note = $item['product_code']." - ".$item['product_name'];
                // }
                // if($editAcc && $item['discount'] > 0){
                //     // add acc discount
                // }
            }
            $this->site->syncQuantity(null, null, $oitems);
            if ($data['status'] == 'received' || $data['status'] == 'partial') {
                $this->site->syncQuantity(null, $id);
                foreach ($oitems as $oitem) {
                    $this->updateAVCO(['product_id' => $oitem->product_id, 'warehouse_id' => $oitem->warehouse_id, 'quantity' => (0 - $oitem->quantity), 'cost' => $oitem->real_unit_cost]);
                }
            }
            $this->site->syncPurchasePayments($id);
            //Accounting
            if($mode != "received"){
                $editAcc = true;
                $no_account = "2130101";
                $type_amount = "debit";
                $amount = $data['grand_total'];
                $acc = [
                    'no_source' => $data['reference_no'],
                    'doc_date' => date("Y-m-d", strtotime($data['date'])),
                    'type_source' => $type,
                    'loc_source' => 'header',
                    'id_source' => $purchase_id,
                    'division' => $data['division'],
                    'no_account' => $no_account,
                    'type_amount' => $type_amount,
                    'amount' => $amount,
                    'note' => 'Hutang Dagang',
                    'note_query' => 'field=grand_total',
                    "created_by" => $this->session->userdata('user_id'),
                ];
                $dataAcc[] = $acc;
            }
            $edit = false;
            if($editAcc){
                $edit['no_source'] = $data['reference_no'];
            }
            $this->site->postAccounting($dataAcc, $edit);
        }
        $this->db->trans_complete();
        if ($this->db->trans_status() === false) {
            log_message('error', 'An errors has been occurred while adding the sale (Update:Purchases_model.php)');
        } else {
            return true;
        }

        return false;
    }

    public function updateStatus($id, $status, $note)
    {
        $this->db->trans_start();
        $purchase = $this->getPurchaseByID($id);
        $items    = $this->site->getAllPurchaseItems($id);
        if ($this->db->update('purchases', ['status' => $status, 'note' => $note], ['id' => $id])) {
            if (($purchase->status != 'received' || $purchase->status != 'partial') && ($status == 'received' || $status == 'partial')) {
                foreach ($items as $item) {
                    $qb = $status == 'received' ? ($item->quantity_balance + ($item->quantity - $item->quantity_received)) : $item->quantity_balance;
                    $qr = $status == 'received' ? $item->quantity : $item->quantity_received;
                    $this->db->update('purchase_items', ['status' => $status, 'quantity_balance' => $qb, 'quantity_received' => $qr], ['id' => $item->id]);
                    $this->updateAVCO(['product_id' => $item->product_id, 'warehouse_id' => $item->warehouse_id, 'quantity' => $item->quantity, 'cost' => $item->real_unit_cost]);
                }
                $this->site->syncQuantity(null, null, $items);
            } elseif (($purchase->status == 'received' || $purchase->status == 'partial') && ($status == 'ordered' || $status == 'pending')) {
                foreach ($items as $item) {
                    $qb = 0;
                    $qr = 0;
                    $this->db->update('purchase_items', ['status' => $status, 'quantity_balance' => $qb, 'quantity_received' => $qr], ['id' => $item->id]);
                    $this->updateAVCO(['product_id' => $item->product_id, 'warehouse_id' => $item->warehouse_id, 'quantity' => $item->quantity, 'cost' => $item->real_unit_cost]);
                }
                $this->site->syncQuantity(null, null, $items);
            }
        }
        $this->db->trans_complete();
        if ($this->db->trans_status() === false) {
            log_message('error', 'An errors has been occurred while adding the sale (UpdateStatus:Purchases_model.php)');
        } else {
            return true;
        }
        return false;
    }

    public function getCountForReff($year)
    {
        $q = $this->db->get_where('purchases', ['year(`date`)' => $year]);
        return $q->num_rows();
    }

    public function deleteReceived($purchase_id, $items){
        $this->db->trans_begin();
        $err = false;
        $msg = "";
        // var_dump($items);exit;
        foreach($items as $itm){
            $pur = $this->getPurchaseItemByKey($purchase_id, $itm->product_id);
            if(!$pur){
                // error purchase item tidak ditemukan
                $err = true;
                $msg = 'Tidak ditemukan pembelian dengan produk '.$itm->product_code.' - '.$itm->product_desc;
                break;
            }
            if($pur->quantity_balance < $itm->quantity){
                // error qty kurang
                $err = true;
                $msg = 'Gagal hapus pembelian karena stock tidak mencukupi dengan produk '.$itm->product_code.' - '.$itm->product_desc;
                break;
            }
            $qty = $pur->quantity_balance - $itm->quantity;
            $qty_rcv = $pur->quantity_received - $itm->quantity;
            if($this->db->update('purchase_items', ['quantity_balance' => $qty, 'quantity_received' => $qty_rcv], ['id' => $pur->id])){
                $this->db->update('item_movement', ['flag_delete' => 'X'], ['id' => $itm->id]);
            }
            $edit['type_source'] = 'PO';
            $edit['no_account'] = '1150200';
            $edit['note'] = $itm->supporting_reff_doc;
            // var_dump($edit);exit;
            $dataAcc = array();
            $this->site->postAccounting($dataAcc, $edit);
        }
        // var_dump($err);exit;
        $rtn = (object)array(
            'success' => false,
            'msg' => $msg
        );
        if($err){
            $this->db->trans_rollback();
            return $rtn;
        }
        $this->site->syncQuantity(null, $purchase_id);

        $pur_item = $this->getPurchaseItemByPurchaseID($purchase_id);
        $quantity_received = 0;
        foreach($pur_item as $item){
            $quantity_received += $item->quantity_received;
        }
        $status = "partial";
        if($quantity_received == 0){
            $status = "pending";
        }
        $this->db->update('purchases', ['status' => $status], ['id' => $purchase_id]);
        // $this->db->trans_complete();
        if ($this->db->trans_status() === false) {
            $this->db->trans_rollback();
            log_message('error', 'An errors has been occurred while adding the sale (UpdateStatus:Purchases_model.php)');
        } else {
            $this->db->trans_commit();
            $rtn = (object)array(
                'success' => true,
                'msg' => $msg
            );
            return $rtn;
        }
        return $rtn;
    }
}
