<?php

defined('BASEPATH') or exit('No direct script access allowed');

class Products_model extends CI_Model
{
    public function __construct()
    {
        parent::__construct();
    }

    public function add_products($products = [])
    {
        if (!empty($products)) {
            foreach ($products as $product) {
                $variants = explode('|', $product['variants']);
                unset($product['variants']);
                if ($this->db->insert('products', $product)) {
                    $product_id = $this->db->insert_id();
                    foreach ($variants as $variant) {
                        if ($variant && trim($variant) != '') {
                            $vat = ['product_id' => $product_id, 'name' => trim($variant)];
                            $this->db->insert('product_variants', $vat);
                        }
                    }
                }
            }
            return true;
        }
        return false;
    }

    public function addAdjustment($data, $products)
    {
        $this->db->trans_start();
        $type = 'ADJ';
        if ($this->db->insert('adjustments', $data)) {
            $dataAcc = array();
            $adjustment_id = $this->db->insert_id();
            foreach ($products as $product) {
                $product['adjustment_id'] = $adjustment_id;
                $this->db->insert('adjustment_items', $product);
                $this->syncAdjustment($product);

                $prod_items = $this->getProductByID($product['product_id']);
                $prod_units = $this->site->getUnitByID($prod_items->unit);
                $clause = array(
                    'product_id' => $product['product_id'],
                    'product_batch' => $product['product_batch'],
                );
                $pur_dtl = $this->site->getPurchasedItem($clause);
                // Item movement
                $item_movement = [
                    "warehouse_id" => $data['warehouse_id'],
                    "product_id" => $product['product_id'],
                    "product_code" => $prod_items->code,
                    "product_desc" => $prod_items->name,
                    "quantity" => $product['quantity'] * ($product['type'] == 'subtraction' ? -1 : 1),
                    "unit_code" => $prod_units->code,
                    "movement_type" => $data['subtraction'] == 'returned' ? 'out' : 'in',
                    "product_batch" => $product['product_batch'],
                    "movement_status" => 'good',
                    "reff_type" => 'adjustment',
                    "reff_no" => $data['reference_no'],
                    "stock_date" => date("Y-m-d", strtotime($data['date'])),
                    "created_by" => $this->session->userdata('user_id'),
                    "supporting_reff_doc" => '',
                    "attachment" => '',
                ];
                $this->site->submitMovementItem($item_movement, false);

                // Accounting
                $no_account = "5110000";
                $type_amount = ($product['type'] == 'subtraction' ? "debit" : "credit");
                $amount = $product['quantity'] * $pur_dtl->real_unit_cost;
                $note_query = 'calc=quantity*real_unit_cost';
                $note = $prod_items->code." - ".$prod_items->name;

                $acc = [
                    'no_source' => $data['reference_no'],
                    'doc_date' => date("Y-m-d", strtotime($data['date'])),
                    'type_source' => $type,
                    'loc_source' => 'detail',
                    'id_source' => $adjustment_id,
                    'division' => $data['division'],
                    'no_account' => $no_account,
                    'type_amount' => $type_amount,
                    'amount' => $amount,
                    'note' => $note,
                    'note_query' => $note_query,
                    "created_by" => $this->session->userdata('user_id'),
                ];
                $dataAcc[] = $acc;

                $acc['no_account'] = "1150100";
                $acc['type_amount'] = ($product['type'] == 'subtraction' ? "credit" : "debit");
                $dataAcc[] = $acc;
            }

            // if ($this->site->getReference('qa') == $data['reference_no']) {
            //     $this->site->updateReference('qa');
            // }
            $this->site->updateReff($type, $data['date']);
            
            // Accounting
            $this->site->postAccounting($dataAcc, false);
            $this->db->trans_complete();
            if ($this->db->trans_status() === false) {
                log_message('error', 'An errors has been occurred while adding the sale (Add:Purchases_model.php)');
            } else {
                return true;
            }
        }
        return false;
    }

    public function addAjaxProduct($data)
    {
        if ($this->db->insert('products', $data)) {
            $product_id = $this->db->insert_id();
            return $this->getProductByID($product_id);
        }
        return false;
    }

    public function addProduct($data, $items, $warehouse_qty, $product_attributes, $photos)
    {
        if ($this->db->insert('products', $data)) {
            $product_id = $this->db->insert_id();

            if ($items) {
                foreach ($items as $item) {
                    $item['product_id'] = $product_id;
                    $this->db->insert('combo_items', $item);
                }
            }

            $warehouses = $this->site->getAllWarehouses();
            if ($data['type'] != 'standard') {
              
                foreach ($warehouses as $warehouse) {
                    $this->db->insert('warehouses_products', ['product_id' => $product_id, 'warehouse_id' => $warehouse->id, 'quantity' => 0]);
                }
            }

            $tax_rate = $this->site->getTaxRateByID($data['tax_rate']);

            if ($warehouse_qty && !empty($warehouse_qty)) {
                foreach ($warehouse_qty as $wh_qty) {
                    if (isset($wh_qty['quantity']) && !empty($wh_qty['quantity'])) {
                        $this->db->insert('warehouses_products', ['product_id' => $product_id, 'warehouse_id' => $wh_qty['warehouse_id'], 'quantity' => $wh_qty['quantity'], 'rack' => $wh_qty['rack'], 'avg_cost' => $data['cost']]);

                        if (!$product_attributes) {
                            $tax_rate_id = $tax_rate ? $tax_rate->id : null;
                            $tax         = $tax_rate ? (($tax_rate->type == 1) ? $tax_rate->rate . '%' : $tax_rate->rate) : null;
                            $unit_cost   = $data['cost'];
                            if ($tax_rate) {
                                if ($tax_rate->type == 1 && $tax_rate->rate != 0) {
                                    if ($data['tax_method'] == '0') {
                                        $pr_tax_val    = ($data['cost'] * $tax_rate->rate) / (100 + $tax_rate->rate);
                                        $net_item_cost = $data['cost'] - $pr_tax_val;
                                        $item_tax      = $pr_tax_val * $wh_qty['quantity'];
                                    } else {
                                        $net_item_cost = $data['cost'];
                                        $pr_tax_val    = ($data['cost'] * $tax_rate->rate) / 100;
                                        $unit_cost     = $data['cost'] + $pr_tax_val;
                                        $item_tax      = $pr_tax_val * $wh_qty['quantity'];
                                    }
                                } else {
                                    $net_item_cost = $data['cost'];
                                    $item_tax      = $tax_rate->rate;
                                }
                            } else {
                                $net_item_cost = $data['cost'];
                                $item_tax      = 0;
                            }

                            $subtotal = (($net_item_cost * $wh_qty['quantity']) + $item_tax);

                            $item = [
                                'product_id'        => $product_id,
                                'product_code'      => $data['code'],
                                'product_name'      => $data['name'],
                                'net_unit_cost'     => $net_item_cost,
                                'unit_cost'         => $unit_cost,
                                'real_unit_cost'    => $unit_cost,
                                'quantity'          => $wh_qty['quantity'],
                                'quantity_balance'  => $wh_qty['quantity'],
                                'quantity_received' => $wh_qty['quantity'],
                                'item_tax'          => $item_tax,
                                'tax_rate_id'       => $tax_rate_id,
                                'tax'               => $tax,
                                'subtotal'          => $subtotal,
                                'warehouse_id'      => $wh_qty['warehouse_id'],
                                'date'              => date('Y-m-d'),
                                'status'            => 'received',
                            ];
                            $this->db->insert('purchase_items', $item);
                            $this->site->syncProductQty($product_id, $wh_qty['warehouse_id']);
                        }
                    }
                }
            }

            if ($product_attributes) {
                foreach ($product_attributes as $pr_attr) {
                    $pr_attr_details = $this->getPrductVariantByPIDandName($product_id, $pr_attr['name']);

                    $pr_attr['product_id'] = $product_id;
                    $variant_warehouse_id  = $pr_attr['warehouse_id'];
                    unset($pr_attr['warehouse_id']);
                    if ($pr_attr_details) {
                        $option_id = $pr_attr_details->id;
                    } else {
                        $this->db->insert('product_variants', $pr_attr);
                        $option_id = $this->db->insert_id();
                    }
                    if ($pr_attr['quantity'] != 0) {
                        $this->db->insert('warehouses_products_variants', ['option_id' => $option_id, 'product_id' => $product_id, 'warehouse_id' => $variant_warehouse_id, 'quantity' => $pr_attr['quantity']]);

                        $tax_rate_id = $tax_rate ? $tax_rate->id : null;
                        $tax         = $tax_rate ? (($tax_rate->type == 1) ? $tax_rate->rate . '%' : $tax_rate->rate) : null;
                        $unit_cost   = $data['cost'];
                        if ($tax_rate) {
                            if ($tax_rate->type == 1 && $tax_rate->rate != 0) {
                                if ($data['tax_method'] == '0') {
                                    $pr_tax_val    = ($data['cost'] * $tax_rate->rate) / (100 + $tax_rate->rate);
                                    $net_item_cost = $data['cost'] - $pr_tax_val;
                                    $item_tax      = $pr_tax_val * $pr_attr['quantity'];
                                } else {
                                    $net_item_cost = $data['cost'];
                                    $pr_tax_val    = ($data['cost'] * $tax_rate->rate) / 100;
                                    $unit_cost     = $data['cost'] + $pr_tax_val;
                                    $item_tax      = $pr_tax_val * $pr_attr['quantity'];
                                }
                            } else {
                                $net_item_cost = $data['cost'];
                                $item_tax      = $tax_rate->rate;
                            }
                        } else {
                            $net_item_cost = $data['cost'];
                            $item_tax      = 0;
                        }

                        $subtotal = (($net_item_cost * $pr_attr['quantity']) + $item_tax);
                        $item     = [
                            'product_id'        => $product_id,
                            'product_code'      => $data['code'],
                            'product_name'      => $data['name'],
                            'net_unit_cost'     => $net_item_cost,
                            'unit_cost'         => $unit_cost,
                            'quantity'          => $pr_attr['quantity'],
                            'option_id'         => $option_id,
                            'quantity_balance'  => $pr_attr['quantity'],
                            'quantity_received' => $pr_attr['quantity'],
                            'item_tax'          => $item_tax,
                            'tax_rate_id'       => $tax_rate_id,
                            'tax'               => $tax,
                            'subtotal'          => $subtotal,
                            'warehouse_id'      => $variant_warehouse_id,
                            'date'              => date('Y-m-d'),
                            'status'            => 'received',
                        ];
                        $item['option_id'] = !empty($item['option_id']) && is_numeric($item['option_id']) ? $item['option_id'] : null;
                        $this->db->insert('purchase_items', $item);
                    }

                    foreach ($warehouses as $warehouse) {
                        if (!$this->getWarehouseProductVariant($warehouse->id, $product_id, $option_id)) {
                            $this->db->insert('warehouses_products_variants', ['option_id' => $option_id, 'product_id' => $product_id, 'warehouse_id' => $warehouse->id, 'quantity' => 0]);
                        }
                    }

                    $this->site->syncVariantQty($option_id, $variant_warehouse_id);
                }
            }

            if ($photos) {
                foreach ($photos as $photo) {
                    $this->db->insert('product_photos', ['product_id' => $product_id, 'photo' => $photo]);
                }
            }

            if ($data['type'] != 'combo') {
              $this->site->syncQuantity(null, null, null, $product_id);
            }
            return true;
        }
        return false;
    }

    public function addQuantity($product_id, $warehouse_id, $quantity, $rack = null)
    {
        if ($this->getProductQuantity($product_id, $warehouse_id)) {
            if ($this->updateQuantity($product_id, $warehouse_id, $quantity, $rack)) {
                return true;
            }
        } else {
            if ($this->insertQuantity($product_id, $warehouse_id, $quantity, $rack)) {
                return true;
            }
        }

        return false;
    }

    public function addStockCount($data)
    {
        if ($this->db->insert('stock_counts', $data)) {
            return true;
        }
        return false;
    }

    public function deleteAdjustment($id)
    {
        $this->reverseAdjustment($id);
        $this->site->log('Quantity adjustment', ['model' => $this->getAdjustmentByID($id), 'items' => $this->getAdjustmentItems($id)]);
        if ($this->db->delete('adjustments', ['id' => $id]) && $this->db->delete('adjustment_items', ['adjustment_id' => $id])) {
            return true;
        }
        return false;
    }

    public function deleteProduct($id)
    {
        $this->site->log('Product', ['model' => $this->getProductByID($id)]);
        // if ($this->db->delete('products', ['id' => $id]) && $this->db->delete('warehouses_products', ['product_id' => $id])) {
        //     $this->db->delete('warehouses_products_variants', ['product_id' => $id]);
        //     $this->db->delete('product_variants', ['product_id' => $id]);
        //     $this->db->delete('product_photos', ['product_id' => $id]);
        //     $this->db->delete('product_prices', ['product_id' => $id]);
        //     return true;
        // }
        if($this->db->update('products', ['flag_delete' => 'X'], ['id' => $id])){
            return true;
        }
        return false;
    }

    public function fetch_products($category_id, $limit, $start, $subcategory_id = null)
    {
        $this->db->limit($limit, $start);
        if ($category_id) {
            $this->db->where('category_id', $category_id);
        }
        if ($subcategory_id) {
            $this->db->where('subcategory_id', $subcategory_id);
        }
        $this->db->order_by('id', 'asc');
        $query = $this->db->get('products');

        if ($query->num_rows() > 0) {
            foreach ($query->result() as $row) {
                $data[] = $row;
            }
            return $data;
        }
        return false;
    }

    public function finalizeStockCount($id, $data, $products)
    {
        if ($this->db->update('stock_counts', $data, ['id' => $id])) {
            foreach ($products as $product) {
                $this->db->insert('stock_count_items', $product);
            }
            return true;
        }
        return false;
    }

    public function getAdjustmentByCountID($count_id)
    {
        $q = $this->db->get_where('adjustments', ['count_id' => $count_id], 1);
        if ($q->num_rows() > 0) {
            return $q->row();
        }
        return false;
    }

    public function getAdjustmentByID($id)
    {
        $q = $this->db->get_where('adjustments', ['id' => $id], 1);
        if ($q->num_rows() > 0) {
            return $q->row();
        }
        return false;
    }

    public function getAdjustmentItems($adjustment_id)
    {
        $this->db->select('adjustment_items.*, products.code as product_code, products.name as product_name, products.image, products.details as details, product_variants.name as variant')
            ->join('products', 'products.id=adjustment_items.product_id', 'left')
            ->join('product_variants', 'product_variants.id=adjustment_items.option_id', 'left')
            ->group_by('adjustment_items.id')
            ->order_by('id', 'asc');

        $this->db->where('adjustment_id', $adjustment_id);

        $q = $this->db->get('adjustment_items');
        if ($q->num_rows() > 0) {
            foreach (($q->result()) as $row) {
                $data[] = $row;
            }
            return $data;
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

    public function getAllVariants()
    {
        $q = $this->db->get('variants');
        if ($q->num_rows() > 0) {
            foreach (($q->result()) as $row) {
                $data[] = $row;
            }
            return $data;
        }
        return false;
    }

    public function getAllWarehousesWithPQ($product_id)
    {
        $this->db->select('' . $this->db->dbprefix('warehouses') . '.*, ' . $this->db->dbprefix('warehouses_products') . '.quantity, ' . $this->db->dbprefix('warehouses_products') . '.rack, ' . $this->db->dbprefix('warehouses_products') . '.avg_cost')
            ->join('warehouses_products', 'warehouses_products.warehouse_id=warehouses.id', 'left')
            ->where('warehouses_products.product_id', $product_id)
            ->group_by('warehouses.id');
        $q = $this->db->get('warehouses');
        if ($q->num_rows() > 0) {
            foreach (($q->result()) as $row) {
                $data[] = $row;
            }
            return $data;
        }
        return false;
    }

    public function getBrandByName($name)
    {
        $q = $this->db->get_where('brands', ['name' => $name], 1);
        if ($q->num_rows() > 0) {
            return $q->row();
        }
        return false;
    }

    public function getCategoryByCode($code)
    {
        $q = $this->db->get_where('categories', ['code' => $code], 1);
        if ($q->num_rows() > 0) {
            return $q->row();
        }
        return false;
    }

    public function getCategoryProducts($category_id)
    {
        $q = $this->db->get_where('products', ['category_id' => $category_id]);
        if ($q->num_rows() > 0) {
            foreach (($q->result()) as $row) {
                $data[] = $row;
            }
            return $data;
        }
        return false;
    }

    public function getPrductVariantByPIDandName($product_id, $name)
    {
        $q = $this->db->get_where('product_variants', ['product_id' => $product_id, 'name' => $name], 1);
        if ($q->num_rows() > 0) {
            return $q->row();
        }
        return false;
    }

    public function getProductByCategoryID($id)
    {
        $q = $this->db->get_where('products', ['category_id' => $id], 1);
        if ($q->num_rows() > 0) {
            return true;
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

    public function getProductComboItems($pid)
    {
        $this->db->select($this->db->dbprefix('products') . '.id as id, ' . $this->db->dbprefix('products') . '.code as code, ' . $this->db->dbprefix('combo_items') . '.quantity as qty, ' . $this->db->dbprefix('products') . '.name as name, ' . $this->db->dbprefix('combo_items') . '.unit_price as price')->join('products', 'products.code=combo_items.item_code', 'left')->group_by('combo_items.id');
        $q = $this->db->get_where('combo_items', ['product_id' => $pid]);
        if ($q->num_rows() > 0) {
            foreach (($q->result()) as $row) {
                $data[] = $row;
            }

            return $data;
        }
        return false;
    }

    public function getProductByCategory($type, $wc)
    {
        $this->db->like('code', $wc);
        $this->db->like('name', $wc);
        $this->db->where('type', $type);
        $q = $this->db->get("products");
        if ($q->num_rows() > 0) {
            foreach (($q->result()) as $row) {
                $data[] = $row;
            }

            return $data;
        }
        return false;
    }

    public function getProductDetail($id)
    {
        $this->db->select($this->db->dbprefix('products') . '.*, ' . $this->db->dbprefix('tax_rates') . '.name as tax_rate_name, ' . $this->db->dbprefix('tax_rates') . '.code as tax_rate_code, c.code as category_code, sc.code as subcategory_code', false)
            ->join('tax_rates', 'tax_rates.id=products.tax_rate', 'left')
            ->join('categories c', 'c.id=products.category_id', 'left')
            ->join('categories sc', 'sc.id=products.subcategory_id', 'left');
        $q = $this->db->get_where('products', ['products.id' => $id], 1);
        if ($q->num_rows() > 0) {
            return $q->row();
        }
        return false;
    }

    public function getProductDetails($id)
    {
        $this->db->select($this->db->dbprefix('products') . '.code, ' . $this->db->dbprefix('products') . '.name, ' . $this->db->dbprefix('categories') . '.code as category_code, cost, price, quantity, alert_quantity')
            ->join('categories', 'categories.id=products.category_id', 'left');
        $q = $this->db->get_where('products', ['products.id' => $id], 1);
        if ($q->num_rows() > 0) {
            return $q->row();
        }
        return false;
    }

    public function getProductNames($term, $limit = 5)
    {
        $this->db->select('' . $this->db->dbprefix('products') . '.id, code, ' . $this->db->dbprefix('products') . '.name as name, ' . $this->db->dbprefix('products') . '.price as price, ' . $this->db->dbprefix('product_variants') . '.name as vname')
            ->where("type != 'combos' AND "
                . '(' . $this->db->dbprefix('products') . ".name LIKE '%" . $term . "%' OR code LIKE '%" . $term . "%' OR
                concat(" . $this->db->dbprefix('products') . ".name, ' (', code, ')') LIKE '%" . $term . "%')");
        $this->db->join('product_variants', 'product_variants.product_id=products.id', 'left')
            ->where('' . $this->db->dbprefix('product_variants') . '.name', null)
            ->group_by('products.id')->limit($limit);
        $q = $this->db->get('products');
        if ($q->num_rows() > 0) {
            foreach (($q->result()) as $row) {
                $data[] = $row;
            }
            return $data;
        }
        return false;
    }

    public function getProductOptions($pid)
    {
        $q = $this->db->get_where('product_variants', ['product_id' => $pid]);
        if ($q->num_rows() > 0) {
            foreach (($q->result()) as $row) {
                $data[] = $row;
            }
            return $data;
        }
        return false;
    }

    public function getProductOptionsWithWH($pid)
    {
        $this->db->select($this->db->dbprefix('product_variants') . '.*, ' . $this->db->dbprefix('warehouses') . '.name as wh_name, ' . $this->db->dbprefix('warehouses') . '.id as warehouse_id, ' . $this->db->dbprefix('warehouses_products_variants') . '.quantity as wh_qty')
            ->join('warehouses_products_variants', 'warehouses_products_variants.option_id=product_variants.id', 'left')
            ->join('warehouses', 'warehouses.id=warehouses_products_variants.warehouse_id', 'left')
            ->group_by(['' . $this->db->dbprefix('product_variants') . '.id', '' . $this->db->dbprefix('warehouses_products_variants') . '.warehouse_id'])
            ->order_by('product_variants.id');
        $q = $this->db->get_where('product_variants', ['product_variants.product_id' => $pid, 'warehouses_products_variants.quantity !=' => null]);
        if ($q->num_rows() > 0) {
            foreach (($q->result()) as $row) {
                $data[] = $row;
            }
            return $data;
        }
    }

    public function getProductPhotos($id)
    {
        $q = $this->db->get_where('product_photos', ['product_id' => $id]);
        if ($q->num_rows() > 0) {
            foreach (($q->result()) as $row) {
                $data[] = $row;
            }
            return $data;
        }
    }

    public function getProductQuantity($product_id, $warehouse)
    {
        $q = $this->db->get_where('warehouses_products', ['product_id' => $product_id, 'warehouse_id' => $warehouse], 1);
        if ($q->num_rows() > 0) {
            return $q->row_array();
        }
        return false;
    }

    public function getProductsForPrinting($term, $limit = 5)
    {
        $this->db->select('' . $this->db->dbprefix('products') . '.id, code, ' . $this->db->dbprefix('products') . '.name as name, ' . $this->db->dbprefix('products') . '.price as price')
            ->where('(' . $this->db->dbprefix('products') . ".name LIKE '%" . $term . "%' OR code LIKE '%" . $term . "%' OR
                concat(" . $this->db->dbprefix('products') . ".name, ' (', code, ')') LIKE '%" . $term . "%')")
            ->limit($limit);
        $q = $this->db->get('products');
        if ($q->num_rows() > 0) {
            foreach (($q->result()) as $row) {
                $data[] = $row;
            }
            return $data;
        }
        return false;
    }

    public function getProductVariantByID($product_id, $id)
    {
        $q = $this->db->get_where('product_variants', ['product_id' => $product_id, 'id' => $id], 1);
        if ($q->num_rows() > 0) {
            return $q->row();
        }
        return false;
    }

    public function getProductVariantByName($product_id, $name)
    {
        $q = $this->db->get_where('product_variants', ['product_id' => $product_id, 'name' => $name], 1);
        if ($q->num_rows() > 0) {
            return $q->row();
        }
        return false;
    }

    public function getProductVariantID($product_id, $name)
    {
        $q = $this->db->get_where('product_variants', ['product_id' => $product_id, 'name' => $name], 1);
        if ($q->num_rows() > 0) {
            $variant = $q->row();
            return $variant->id;
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

    public function getProductWarehouseOptions($option_id)
    {
        $q = $this->db->get_where('warehouses_products_variants', ['option_id' => $option_id]);
        if ($q->num_rows() > 0) {
            foreach (($q->result()) as $row) {
                $data[] = $row;
            }
            return $data;
        }
        return false;
    }

    public function getProductWithCategory($id)
    {
        $this->db->select($this->db->dbprefix('products') . '.*, ' . $this->db->dbprefix('categories') . '.name as category')
        ->join('categories', 'categories.id=products.category_id', 'left');
        $q = $this->db->get_where('products', ['products.id' => $id], 1);
        if ($q->num_rows() > 0) {
            return $q->row();
        }
        return false;
    }

    public function getPurchasedQty($id)
    {
        $this->db->select('date_format(' . $this->db->dbprefix('purchases') . ".date, '%Y-%M') month, SUM( " . $this->db->dbprefix('purchase_items') . '.quantity ) as purchased, SUM( ' . $this->db->dbprefix('purchase_items') . '.subtotal ) as amount')
            ->from('purchases')
            ->join('purchase_items', 'purchases.id=purchase_items.purchase_id', 'left')
            ->group_by('date_format(' . $this->db->dbprefix('purchases') . ".date, '%Y-%m')")
            ->where($this->db->dbprefix('purchase_items') . '.product_id', $id)
            //->where('DATE(NOW()) - INTERVAL 1 MONTH')
            ->where('DATE_ADD(curdate(), INTERVAL 1 MONTH)')
            ->order_by('date_format(' . $this->db->dbprefix('purchases') . ".date, '%Y-%m') desc")->limit(3);
        $q = $this->db->get();
        if ($q->num_rows() > 0) {
            foreach (($q->result()) as $row) {
                $data[] = $row;
            }
            return $data;
        }
        return false;
    }

    public function getPurchaseItems($purchase_id)
    {
        $q = $this->db->get_where('purchase_items', ['purchase_id' => $purchase_id]);
        if ($q->num_rows() > 0) {
            foreach (($q->result()) as $row) {
                $data[] = $row;
            }
            return $data;
        }
        return false;
    }

    public function getQASuggestions($term, $limit = 5)
    {
        $this->db->select('' . $this->db->dbprefix('products') . '.id, code, ' . $this->db->dbprefix('products') . '.name as name')
            ->where("type = 'combo' AND "
                . '(' . $this->db->dbprefix('products') . ".name LIKE '%" . $term . "%' OR code LIKE '%" . $term . "%' OR
                concat(" . $this->db->dbprefix('products') . ".name, ' (', code, ')') LIKE '%" . $term . "%')")
            ->limit($limit);
        $q = $this->db->get('products');
        if ($q->num_rows() > 0) {
            foreach (($q->result()) as $row) {
                $data[] = $row;
            }
            return $data;
        }
        return false;
    }

    // public function getQASuggestions($term, $limit = 5)
    // {
    //     $this->db->select('' . $this->db->dbprefix('products') . '.id, code, ' . $this->db->dbprefix('products') . '.name as name')
    //         ->where("type != 'combo' AND "
    //             . '(' . $this->db->dbprefix('products') . ".name LIKE '%" . $term . "%' OR code LIKE '%" . $term . "%' OR
    //             concat(" . $this->db->dbprefix('products') . ".name, ' (', code, ')') LIKE '%" . $term . "%')")
    //         ->limit($limit);
    //     $q = $this->db->get('products');
    //     if ($q->num_rows() > 0) {
    //         foreach (($q->result()) as $row) {
    //             $data[] = $row;
    //         }
    //         return $data;
    //     }
    //     return false;
    // }

    public function getSoldQty($id)
    {
        $this->db->select('date_format(' . $this->db->dbprefix('sales') . ".date, '%Y-%M') month, SUM( " . $this->db->dbprefix('sale_items') . '.quantity ) as sold, SUM( ' . $this->db->dbprefix('sale_items') . '.subtotal ) as amount')
            ->from('sales')
            ->join('sale_items', 'sales.id=sale_items.sale_id', 'left')
            ->group_by('date_format(' . $this->db->dbprefix('sales') . ".date, '%Y-%m')")
            ->where($this->db->dbprefix('sale_items') . '.product_id', $id)
            //->where('DATE(NOW()) - INTERVAL 1 MONTH')
            ->where('DATE_ADD(curdate(), INTERVAL 1 MONTH)')
            ->order_by('date_format(' . $this->db->dbprefix('sales') . ".date, '%Y-%m') desc")->limit(3);
        $q = $this->db->get();
        if ($q->num_rows() > 0) {
            foreach (($q->result()) as $row) {
                $data[] = $row;
            }
            return $data;
        }
        return false;
    }

    public function getStockCountItems($stock_count_id)
    {
        $q = $this->db->get_where('stock_count_items', ['stock_count_id' => $stock_count_id]);
        if ($q->num_rows() > 0) {
            foreach (($q->result()) as $row) {
                $data[] = $row;
            }
            return $data;
        }
        return null;
    }

    public function getStockCountProducts($warehouse_id, $type, $categories = null, $brands = null)
    {
        $this->db->select("{$this->db->dbprefix('products')}.id as id, {$this->db->dbprefix('products')}.code as code, {$this->db->dbprefix('products')}.name as name, {$this->db->dbprefix('warehouses_products')}.quantity as quantity")
        ->join('warehouses_products', 'warehouses_products.product_id=products.id', 'left')
        ->where('warehouses_products.warehouse_id', $warehouse_id)
        ->where('products.type', 'standard')
        ->order_by('products.code', 'asc');
        if ($categories) {
            $r = 1;
            $this->db->group_start();
            foreach ($categories as $category) {
                if ($r == 1) {
                    $this->db->where('products.category_id', $category);
                } else {
                    $this->db->or_where('products.category_id', $category);
                }
                $r++;
            }
            $this->db->group_end();
        }
        if ($brands) {
            $r = 1;
            $this->db->group_start();
            foreach ($brands as $brand) {
                if ($r == 1) {
                    $this->db->where('products.brand', $brand);
                } else {
                    $this->db->or_where('products.brand', $brand);
                }
                $r++;
            }
            $this->db->group_end();
        }

        $q = $this->db->get('products');
        if ($q->num_rows() > 0) {
            foreach (($q->result()) as $row) {
                $data[] = $row;
            }
            return $data;
        }
        return false;
    }

    public function getStockCountProductVariants($warehouse_id, $product_id)
    {
        $this->db->select("{$this->db->dbprefix('product_variants')}.name, {$this->db->dbprefix('warehouses_products_variants')}.quantity as quantity")
            ->join('warehouses_products_variants', 'warehouses_products_variants.option_id=product_variants.id', 'left');
        $q = $this->db->get_where('product_variants', ['product_variants.product_id' => $product_id, 'warehouses_products_variants.warehouse_id' => $warehouse_id]);
        if ($q->num_rows() > 0) {
            foreach (($q->result()) as $row) {
                $data[] = $row;
            }
            return $data;
        }
    }

    public function getStouckCountByID($id)
    {
        $q = $this->db->get_where('stock_counts', ['id' => $id], 1);
        if ($q->num_rows() > 0) {
            return $q->row();
        }
        return false;
    }

    public function getSubCategories($parent_id)
    {
        $this->db->select('id as id, name as text')
        ->where('parent_id', $parent_id)->order_by('name');
        $q = $this->db->get('categories');
        if ($q->num_rows() > 0) {
            foreach (($q->result()) as $row) {
                $data[] = $row;
            }
            return $data;
        }
        return false;
    }

    public function getSubCategoryProducts($subcategory_id)
    {
        $q = $this->db->get_where('products', ['subcategory_id' => $subcategory_id]);
        if ($q->num_rows() > 0) {
            foreach (($q->result()) as $row) {
                $data[] = $row;
            }
            return $data;
        }
        return false;
    }

    public function getSupplierByName($name)
    {
        $q = $this->db->get_where('companies', ['name' => $name, 'group_name' => 'supplier'], 1);
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

    public function getTransferItems($transfer_id)
    {
        $q = $this->db->get_where('purchase_items', ['transfer_id' => $transfer_id]);
        if ($q->num_rows() > 0) {
            foreach (($q->result()) as $row) {
                $data[] = $row;
            }
            return $data;
        }
        return false;
    }

    public function getUnitByCode($code)
    {
        $q = $this->db->get_where('units', ['code' => $code], 1);
        if ($q->num_rows() > 0) {
            return $q->row();
        }
        return false;
    }

    public function getWarehouseProductVariant($warehouse_id, $product_id, $option_id = null)
    {
        $q = $this->db->get_where('warehouses_products_variants', ['product_id' => $product_id, 'option_id' => $option_id, 'warehouse_id' => $warehouse_id], 1);
        if ($q->num_rows() > 0) {
            return $q->row();
        }
        return false;
    }

    public function has_purchase($product_id, $warehouse_id = null)
    {
        if ($warehouse_id) {
            $this->db->where('warehouse_id', $warehouse_id);
        }
        $q = $this->db->get_where('purchase_items', ['product_id' => $product_id], 1);
        if ($q->num_rows() > 0) {
            return true;
        }
        return false;
    }

    public function insertQuantity($product_id, $warehouse_id, $quantity, $rack = null)
    {
        $product = $this->site->getProductByID($product_id);
        if ($this->db->insert('warehouses_products', ['product_id' => $product_id, 'warehouse_id' => $warehouse_id, 'quantity' => $quantity, 'rack' => $rack, 'avg_cost' => $product->cost])) {
            $this->site->syncProductQty($product_id, $warehouse_id);
            return true;
        }
        return false;
    }

    public function products_count($category_id, $subcategory_id = null)
    {
        if ($category_id) {
            $this->db->where('category_id', $category_id);
        }
        if ($subcategory_id) {
            $this->db->where('subcategory_id', $subcategory_id);
        }
        $this->db->from('products');
        return $this->db->count_all_results();
    }

    public function reverseAdjustment($id)
    {
        if ($products = $this->getAdjustmentItems($id)) {
            foreach ($products as $adjustment) {
                $clause = ['product_id' => $adjustment->product_id, 'warehouse_id' => $adjustment->warehouse_id, 'option_id' => $adjustment->option_id, 'status' => 'received'];
                $qty    = $adjustment->type == 'subtraction' ? (0 + $adjustment->quantity) : (0 - $adjustment->quantity);
                $this->site->setPurchaseItem($clause, $qty);
                $this->site->syncProductQty($adjustment->product_id, $adjustment->warehouse_id);
                if ($adjustment->option_id) {
                    $this->site->syncVariantQty($adjustment->option_id, $adjustment->warehouse_id, $adjustment->product_id);
                }
            }
        }
    }

    public function setAvgCost($id)
    {
        $warehouses     = $this->db->select('id')->get('warehouses')->result();
        $purchase_items = $this->db->select('base_unit_cost, unit_cost, quantity_balance, warehouse_id, option_id, product_unit_id')->get_where('purchase_items', ['product_id' => $id, 'quantity_balance >' => 0])->result();
        foreach ($warehouses as $warehouse) {
            $total_cost     = 0;
            $total_quantity = 0;
            foreach ($purchase_items as $pi) {
                if ($pi->warehouse_id == $warehouse->id) {
                    $total_quantity += $pi->quantity_balance;
                    if ($pi->base_unit_cost) {
                        $total_cost += $pi->base_unit_cost * $pi->quantity_balance;
                    } elseif ($pi->product_unit_id) {
                        $unit      = $this->site->getUnitByID($pi->product_unit_id);
                        $base_cost = $this->site->convertToBase($unit, $pi->unit_cost);
                        $total_cost += $base_cost * $pi->quantity_balance;
                    } else {
                        $total_cost += $pi->unit_cost * $pi->quantity_balance;
                    }
                }
            }
            if ($total_cost && $total_quantity) {
                $avg_cost = $total_cost / $total_quantity;
                $this->db->update('warehouses_products', ['avg_cost' => $avg_cost], ['product_id' => $id, 'warehouse_id' => $warehouse->id]);
            }
        }
    }

    public function setRack($data)
    {
        if ($this->db->update('warehouses_products', ['rack' => $data['rack']], ['product_id' => $data['product_id'], 'warehouse_id' => $data['warehouse_id']])) {
            return true;
        }
        return false;
    }

    public function syncAdjustment($data = [])
    {
        if (!empty($data)) {
            $clause = ['product_id' => $data['product_id'], 'option_id' => $data['option_id'], 'warehouse_id' => $data['warehouse_id'], 'status' => 'received', 'product_batch' => $data['product_batch']];
            $qty    = $data['type'] == 'subtraction' ? 0 - $data['quantity'] : 0 + $data['quantity'];
            $this->site->setPurchaseItem($clause, $qty);

            $this->site->syncProductQty($data['product_id'], $data['warehouse_id'], $data['product_batch']);
            if ($data['option_id']) {
                $this->site->syncVariantQty($data['option_id'], $data['warehouse_id'], $data['product_id']);
            }
        }
    }

    public function syncVariantQty($option_id)
    {
        $wh_pr_vars = $this->getProductWarehouseOptions($option_id);
        $qty        = 0;
        foreach ($wh_pr_vars as $row) {
            $qty += $row->quantity;
        }
        if ($this->db->update('product_variants', ['quantity' => $qty], ['id' => $option_id])) {
            return true;
        }
        return false;
    }

    public function totalCategoryProducts($category_id)
    {
        $q = $this->db->get_where('products', ['category_id' => $category_id]);
        return $q->num_rows();
    }

    public function updateAdjustment($id, $data, $products)
    {
        $this->reverseAdjustment($id);
        if ($this->db->update('adjustments', $data, ['id' => $id]) && $this->db->delete('adjustment_items', ['adjustment_id' => $id])) {
            foreach ($products as $product) {
                $product['adjustment_id'] = $id;
                $this->db->insert('adjustment_items', $product);
                $this->syncAdjustment($product);
            }
            return true;
        }
        return false;
    }

    public function updatePrice($data = [])
    {
        if ($this->db->update_batch('products', $data, 'code')) {
            return true;
        }
        return false;
    }

     public function getCurrentStock($productId) {
        // Fetch the current stock from the database
        $this->db->select('quantity');
        $this->db->where('id', $productId);
        $query = $this->db->get('products');

        if ($query->num_rows() > 0) {
            $row = $query->row();
            return $row->quantity;
        } else {
            // Handle the case where the product is not found
            return false;
        }
    }

     public function updateStockAfterSale($productId, $quantitySold) {
        // Step 1: Retrieve current stock
        $currentStock = $this->getCurrentStock($productId);
        // $currentStock = 6;
// var_dump($productId);exit;
        // Step 2: Subtract quantity sold from current stock
        $updatedStock = $currentStock - $quantitySold;

        // Step 3: Update stock in the database
        $this->db->where('id', $productId);
        $this->db->update('products', array('quantity' => $updatedStock));

        // You can also add additional checks or error handling here

        return true; // or false if the update fails
    }

    public function updateProduct($id, $data, $items, $warehouse_qty, $product_attributes, $photos, $update_variants)
    {
        if ($this->db->update('products', $data, ['id' => $id])) {
            if ($items) {
                $this->db->delete('combo_items', ['product_id' => $id]);
                foreach ($items as $item) {
                    $item['product_id'] = $id;
                    $this->db->insert('combo_items', $item);
                }
            }

            $tax_rate = $this->site->getTaxRateByID($data['tax_rate']);

            if ($warehouse_qty && !empty($warehouse_qty)) {
                foreach ($warehouse_qty as $wh_qty) {
                    $this->db->update('warehouses_products', ['rack' => $wh_qty['rack']], ['product_id' => $id, 'warehouse_id' => $wh_qty['warehouse_id']]);
                }
            }

            if (!empty($update_variants)) {
                foreach ($update_variants as $variant) {
                    $vr = $this->getProductVariantByName($id, $variant['name']);
                    if ($vr) {
                        $this->db->update('product_variants', $variant, ['id' => $vr->id]);
                    } else {
                        if ($variant['id']) {
                            $this->db->delete('product_variants', ['id' => $variant['id']]);
                        } else {
                            $this->db->insert('product_variants', $variant);
                        }
                    }
                }
            }

            if ($photos) {
                foreach ($photos as $photo) {
                    $this->db->insert('product_photos', ['product_id' => $id, 'photo' => $photo]);
                }
            }

            // if ($product_attributes) {
            //     foreach ($product_attributes as $pr_attr) {
            //         $pr_attr['product_id'] = $id;
            //         $variant_warehouse_id  = $pr_attr['warehouse_id'];
            //         unset($pr_attr['warehouse_id']);
            //         $this->db->insert('product_variants', $pr_attr);
            //         $option_id = $this->db->insert_id();

            //         if ($pr_attr['quantity'] != 0) {
            //             $this->db->insert('warehouses_products_variants', ['option_id' => $option_id, 'product_id' => $id, 'warehouse_id' => $variant_warehouse_id, 'quantity' => $pr_attr['quantity']]);

            //             $tax_rate_id = $tax_rate ? $tax_rate->id : null;
            //             $tax         = $tax_rate ? (($tax_rate->type == 1) ? $tax_rate->rate . '%' : $tax_rate->rate) : null;
            //             $unit_cost   = $data['cost'];
            //             if ($tax_rate) {
            //                 if ($tax_rate->type == 1 && $tax_rate->rate != 0) {
            //                     if ($data['tax_method'] == '0') {
            //                         $pr_tax_val    = ($data['cost'] * $tax_rate->rate) / (100 + $tax_rate->rate);
            //                         $net_item_cost = $data['cost'] - $pr_tax_val;
            //                         $item_tax      = $pr_tax_val * $pr_attr['quantity'];
            //                     } else {
            //                         $net_item_cost = $data['cost'];
            //                         $pr_tax_val    = ($data['cost'] * $tax_rate->rate) / 100;
            //                         $unit_cost     = $data['cost'] + $pr_tax_val;
            //                         $item_tax      = $pr_tax_val * $pr_attr['quantity'];
            //                     }
            //                 } else {
            //                     $net_item_cost = $data['cost'];
            //                     $item_tax      = $tax_rate->rate;
            //                 }
            //             } else {
            //                 $net_item_cost = $data['cost'];
            //                 $item_tax      = 0;
            //             }

            //             $subtotal = (($net_item_cost * $pr_attr['quantity']) + $item_tax);
            //             $item     = [
            //                 'product_id'        => $id,
            //                 'product_code'      => $data['code'],
            //                 'product_name'      => $data['name'],
            //                 'net_unit_cost'     => $net_item_cost,
            //                 'unit_cost'         => $unit_cost,
            //                 'quantity'          => $pr_attr['quantity'],
            //                 'option_id'         => $option_id,
            //                 'quantity_balance'  => $pr_attr['quantity'],
            //                 'quantity_received' => $pr_attr['quantity'],
            //                 'item_tax'          => $item_tax,
            //                 'tax_rate_id'       => $tax_rate_id,
            //                 'tax'               => $tax,
            //                 'subtotal'          => $subtotal,
            //                 'warehouse_id'      => $variant_warehouse_id,
            //                 'date'              => date('Y-m-d'),
            //                 'status'            => 'received',
            //             ];
            //             $item['option_id'] = !empty($item['option_id']) && is_numeric($item['option_id']) ? $item['option_id'] : null;
            //             $this->db->insert('purchase_items', $item);
            //         }
            //     }
            // }

            // if ($data['type'] != 'combo') {
            //   $this->site->syncQuantity(null, null, null, $id);
            // }
            return true;
        }
        return false;
    }

    public function updateProductOptionQuantity($option_id, $warehouse_id, $quantity, $product_id)
    {
        if ($option = $this->getProductWarehouseOptionQty($option_id, $warehouse_id)) {
            if ($this->db->update('warehouses_products_variants', ['quantity' => $quantity], ['option_id' => $option_id, 'warehouse_id' => $warehouse_id])) {
                $this->site->syncVariantQty($option_id, $warehouse_id);
                return true;
            }
        } else {
            if ($this->db->insert('warehouses_products_variants', ['option_id' => $option_id, 'product_id' => $product_id, 'warehouse_id' => $warehouse_id, 'quantity' => $quantity])) {
                $this->site->syncVariantQty($option_id, $warehouse_id);
                return true;
            }
        }
        return false;
    }

    public function updateQuantity($product_id, $warehouse_id, $quantity, $rack = null)
    {
        $data = $rack ? ['quantity' => $quantity, 'rack' => $rack] : $data = ['quantity' => $quantity];
        if ($this->db->update('warehouses_products', $data, ['product_id' => $product_id, 'warehouse_id' => $warehouse_id])) {
            $this->site->syncProductQty($product_id, $warehouse_id);
            return true;
        }
        return false;
    }

    public function getCount($type)
    {
        $q = $this->db->get_where('products', ['type' => $type]);
        return $q->num_rows();
    }

    public function getCountProduction($reff)
    {
        $this->db->like("reff_doc", $reff, 'after');
        $q = $this->db->get("production");
        return $q->num_rows();
    }

    public function getListProductionHeader($param)
    {
        $this->db->where($param);
        $q = $this->db->get("production");
        if ($q->num_rows() > 0) {
            foreach (($q->result()) as $row) {
                $data[] = $row;
            }
            return $data;
        }
        return null;
    }

    public function getProductionHeader($param)
    {
        $this->db->where($param);
        $q = $this->db->get("production");
        if ($q->num_rows() > 0) {
            return $q->row();
        }
        return null;
    }

    public function getProductionDetail($param)
    {
        $this->db->select("production_items.*, products.name");
        $this->db->from("production_items");
        $this->db->join("products", "production_items.product_id = products.id");
        $this->db->where($param);
        $q = $this->db->get();
        // var_dump($q);exit;
        if ($q->num_rows() > 0) {
            foreach (($q->result()) as $row) {
                $data[] = $row;
            }
            return $data;
        }
        return false;
    }

    public function addProduction($header, $detail){
        $err = false;
        $this->db->trans_start();
        foreach($detail as $dtl){
            // $dtl["product_batch"] = null;
            // var_dump($dtl);exit;
            if(!$this->site->syncPurchaseQty($dtl, true, "production")){
                $this->session->set_flashdata('error', 'Stock '.$dtl['product_code'].' tidak mencukupi');
                $err = true;
                break;
            }
        }
        if(!$err){
            if($this->db->insert('production', $header)){
                // if($this->db->insert('production_items', $detail)){
                    foreach($detail as $dtl){
                        if($this->db->insert('production_items', $dtl)){
                            // $dtl["product_batch"] = null;
                            if(!$this->site->syncPurchaseQty($dtl, false, "production")){
                                $err = true;
                                break;
                            }
                            $item_movement = [
                                "warehouse_id" => $dtl['warehouse_id'],
                                "product_id" => $dtl['product_id'],
                                "product_code" => $dtl['product_code'],
                                "product_desc" => '',
                                "quantity" => $dtl['qty'] * ($dtl['type_item'] == 'raw' ? -1 : 1),
                                "unit_code" => $dtl['unit_code'],
                                "movement_type" => $dtl['type_item'] == 'raw' ? 'out' : 'in',
                                "product_batch" => $dtl['product_batch'],
                                "movement_status" => 'good',
                                "reff_type" => 'production',
                                "reff_no" => $dtl['reff_doc'],
                                "stock_date" => date("Y-m-d", strtotime($header['doc_date'])),
                                "created_by" => $this->session->userdata('user_id'),
                            ];
                            $this->site->submitMovementItem($item_movement, false);
                        }
                        else {
                            $err = false;
                            break;
                        }
                    }
                    
                    // if($err){
                    //     $this->db->where("reff_doc", $header['reff_doc']);
                    //     $this->db->delete("production");

                    //     $this->db->where("reff_doc", $header['reff_doc']);
                    //     $this->db->delete("production_items");
                    //     return false;
                    // }
                    // else {
                        $dataAcc = array();
                        $type = "PROD";
                        $raw_cost = 0;
                        $prm["reff_doc"] = $header["reff_doc"];
                        $hsl_dtl = $this->getProductionDetail($prm);
                        foreach($hsl_dtl as $dtl){
                            $raw_cost += $dtl->product_total_cost;

                            $no_account = "1150200";
                            $type_amount = "credit";
                            $amount = $dtl->product_total_cost;
                            $acc = [
                                'no_source' => $dtl->reff_doc,
                                'doc_date' => date("Y-m-d", strtotime($header['doc_date'])),
                                'type_source' => $type,
                                'loc_source' => 'detail',
                                'id_source' => $dtl->id,
                                'division' => $header['division'],
                                'no_account' => $no_account,
                                'type_amount' => $type_amount,
                                'amount' => $amount,
                                'note' => $dtl->product_code,
                                'note_query' => 'type=product_total_cost',
                                "created_by" => $this->session->userdata('user_id'),
                            ];
                            $dataAcc[] = $acc;
                        }
                        // get overahead cost
                        $overhead_cost = $this->site->calcExpenseCost('overhead', $header['division']);
                        // get labour cost
                        $labour_cost = $this->site->calcExpenseCost('labour', $header['division']);
                        $total_cost = $raw_cost + $overhead_cost + $labour_cost;
                        $upd = [
                            'total_cost' => $total_cost,
                            'overhead_cost' => $overhead_cost,
                            'labour_cost' => $labour_cost,
                            'raw_cost' => $raw_cost,
                        ];

                        $this->db->update("production", $upd, ["reff_doc" => $header["reff_doc"]]);
                        // Accounting
                        $this->site->postAccounting($dataAcc, false);
                        $this->db->trans_complete();
                        if ($this->db->trans_status() === false) {
                            log_message('error', 'An errors has been occurred while adding the sale (Add:Purchases_model.php)');
                        } else {
                            return true;
                        }
                    // }
                // }
            }
            return false;
        }
        return false;
    }

    public function finishProduction($header, $detail, $detail_raw){
        $err = false;
        $this->db->trans_start();
        $type = "PROD";
        if(count($detail_raw) > 0){
            foreach($detail_raw as $dtl){
                if(!$this->site->syncPurchaseQty($dtl, false, "production", "X")){
                    $err = true;
                    break;
                }
                $mov_type = 'out';
                if($dtl['qty'] < 0){
                    $mov_type = 'in';
                }
                $item_movement = [
                    "warehouse_id" => $dtl['warehouse_id'],
                    "product_id" => $dtl['product_id'],
                    "product_code" => $dtl['product_code'],
                    "product_desc" => '',
                    "quantity" => $dtl['qty'] * -1,
                    "unit_code" => $dtl['unit_code'],
                    "movement_type" => $mov_type,
                    "product_batch" => ($dtl['type_item'] == 'raw' ? $dtl["product_batch"] : $dtl["reff_doc"]),
                    "movement_status" => 'good',
                    "reff_type" => 'production',
                    "reff_no" => $dtl['reff_doc'],
                    "stock_date" => date("Y-m-d", strtotime($header['doc_date'])),
                    "created_by" => $this->session->userdata('user_id'),
                ];
                $a = $this->site->submitMovementItem($item_movement, false);
                // var_dump($a);exit;
            }
        }
        if($err){
            return false;
        }
        // update header
        if($this->db->update('production', ['status_doc' => $header['status_doc']], ['id' => $header["id"]])){
            unset($param);
            $param["reff_doc"] = $header["reff_doc"];
            $hdr = $this->getProductionHeader($param);
            // calculate cost
            $total_cost = 0;
            $raw_cost = 0;
            unset($param);
            $param["reff_doc"] = $header["reff_doc"];
            $raw = $this->getProductionDetail($param);
            foreach($raw as $raw){
                $raw_cost += $raw->product_total_cost;

                // Accounting
                $dataAcc = array();
                $no_account = "1150200";
                $type_amount = "credit";
                $amount = $raw->product_total_cost;
                $acc = [
                    'no_source' => $raw->reff_doc,
                    'doc_date' => date("Y-m-d", strtotime($header['doc_date'])),
                    'type_source' => $type,
                    'loc_source' => 'detail',
                    'id_source' => $raw->id,
                    'division' => $header['division'],
                    'no_account' => $no_account,
                    'type_amount' => $type_amount,
                    'amount' => $amount,
                    'note' => $raw->product_code,
                    'note_query' => 'type=product_total_cost',
                    "created_by" => $this->session->userdata('user_id'),
                ];
                $dataAcc[] = $acc;
                $edit = [
                    'no_source' => $raw->reff_doc,
                    'type_source' => $type,
                    'loc_source' => 'detail',
                    'id_source' => $raw->id,
                ];
                $this->site->postAccounting($dataAcc, $edit);
            }
            $total_cost = $raw_cost + $hdr->overhead_cost + $hdr->labour_cost;
            $this->db->update('production', ['raw_cost' => $raw_cost, 'total_cost' => $total_cost], ['reff_doc' => $header->reff_doc]);
            // var_dump($total_cost);exit;
            // insert header purchase_items
            $pur_header = [
                "reference_no" => $header["reff_doc"],
                "date" => date("Y-m-d H:i:s", strtotime($header['doc_date'])),
                "supplier_id" => "999",
                "supplier" => "own",
                "warehouse_id" => "999",
                "total" => $total_cost,
                "order_tax_id" => 1,
                "grand_total" => $total_cost,
                "paid" => $total_cost,
                "status" => "received",
                "payment_status" => "paid",
                "created_by" => $this->session->userdata('user_id'),
                "payment_term" => "0",
            ];

            if($this->db->insert('purchases', $pur_header)){
                $pur_id = $this->db->insert_id();

                $dataAcc = array();
                // insert purchase items
                $upd = 0;
                $total_product = 0;
                foreach($detail as $dtl){
                    $total_product += $dtl['qty'];
                }
                foreach($detail as $dtl){
                    // insert detail
                    $percentage = $dtl['qty'] / $total_product / $dtl['qty'];
                    $dtl["raw_cost"] = $raw_cost * $percentage;
                    $dtl["overhead_cost"] = $hdr->overhead_cost * $percentage;
                    $dtl["labour_cost"] = $hdr->labour_cost * $percentage;
                    $dtl["product_unit_cost"] = $dtl["raw_cost"] + $dtl["overhead_cost"] + $dtl["labour_cost"];
                    // $dtl["product_unit_cost"] = $total_cost * ($dtl['qty'] / $total_product) / $dtl['qty'];
                    $dtl["product_total_cost"] = $dtl["product_unit_cost"] * $dtl['qty'];
                    // $dtl["product_total_cost"] = $total_cost * ($dtl['qty'] / $total_product);

                    $produk = $this->getProductByID($dtl["product_id"]);
                    $pur_dtl = [
                        "purchase_id" => $pur_id,
                        "product_id" => $dtl["product_id"],
                        "product_code" => $dtl["product_code"],
                        "product_name" => $produk->name,
                        "net_unit_cost" => $dtl["product_unit_cost"],
                        "unit_cost" => $dtl["product_unit_cost"],
                        "real_unit_cost" => $dtl["product_unit_cost"],
                        "base_unit_cost" => $dtl["product_unit_cost"],
                        "quantity" => $dtl["qty"],
                        "quantity_balance" => $dtl["qty"],
                        "quantity_received" => $dtl["qty"],
                        "unit_quantity" => $dtl["qty"],
                        "warehouse_id" => $dtl["warehouse_id"],
                        "tax_rate_id" => "1",
                        "subtotal" => $dtl["product_total_cost"],
                        "date" => date("Y-m-d"),
                        "status" => "received",
                        "product_unit_id" => $dtl["unit_id"],
                        "product_unit_code" => $dtl["unit_code"],
                        "product_batch" => $dtl["reff_doc"]
                    ];
                    if($this->db->insert('purchase_items', $pur_dtl)){
                        $dtl_id = $this->db->insert_id();
                        $dtl["purchase_id"] = $dtl_id;
                        if($this->db->insert("production_items", $dtl)){
                            $prod_item_id = $this->db->insert_id();
                            if($this->site->syncProductQty($dtl['product_id'], $dtl['warehouse_id'], $dtl["reff_doc"])){
                                $upd++;
                                $item_movement = [
                                    "warehouse_id" => $dtl['warehouse_id'],
                                    "product_id" => $dtl['product_id'],
                                    "product_code" => $dtl['product_code'],
                                    "product_desc" => '',
                                    "quantity" => $dtl['qty'] * ($dtl['type_item'] == 'raw' ? -1 : 1),
                                    "unit_code" => $dtl['unit_code'],
                                    "movement_type" => $dtl['type_item'] == 'raw' ? 'out' : 'in',
                                    "product_batch" => ($dtl['type_item'] == 'raw' ? $dtl["product_batch"] : $dtl["reff_doc"]),
                                    "movement_status" => 'good',
                                    "reff_type" => 'production',
                                    "reff_no" => $dtl['reff_doc'],
                                    "stock_date" => date("Y-m-d", strtotime($header['doc_date'])),
                                    "created_by" => $this->session->userdata('user_id'),
                                ];
                                $this->site->submitMovementItem($item_movement, true);
                            }

                            $no_account = "1150100";
                            $type_amount = "debit";
                            $amount = $dtl["product_total_cost"];
                            $acc = [
                                'no_source' => $dtl["reff_doc"],
                                'doc_date' => date("Y-m-d", strtotime($header['doc_date'])),
                                'type_source' => $type,
                                'loc_source' => 'detail',
                                'id_source' => $prod_item_id,
                                'division' => $header['division'],
                                'no_account' => $no_account,
                                'type_amount' => $type_amount,
                                'amount' => $amount,
                                'note' => $dtl["product_code"],
                                'note_query' => 'type=product_total_cost',
                                "created_by" => $this->session->userdata('user_id'),
                            ];
                            $dataAcc[] = $acc;
                        }
                    }
                }
                // Accounting
                $this->site->postAccounting($dataAcc, false);

                // var_dump($upd);exit;
                if($upd != count($detail)){
                    $err = true;
                }
                else {
                    $this->db->trans_complete();
                    if ($this->db->trans_status() === false) {
                        log_message('error', 'An errors has been occurred while adding the sale (Add:Purchases_model.php)');
                    } else {
                        return true;
                    }
                }
            }
            else {
                $err = true;
            }
            
            if($err){
                $this->db->update('production', ['status_doc' => "On Production"], ['id' => $header["id"]]);

                $this->db->where("reff_doc", $header['reff_doc']);
                $this->db->where("type_item", "goods");
                $this->db->delete("production_items");

                if(isset($pur_id)){
                    $this->db->where("id", $pur_id);
                    $this->db->delete("purchases");

                    $this->db->where("purchase_id", $pur_id);
                    $this->db->delete("purchase_items");
                }

                foreach($detail as $dtl){
                    $this->site->syncProductQty($dtl['product_id'], $dtl['warehouse_id'], $dtl["reff_doc"]);
                }
            }

            return false;
        }

        return false;
    }

    public function rejectProduction($header, $detail){
        $err = false;
        $type = 'PROD';
        // update header
        if($this->db->update('production', ['status_doc' => $header['status_doc'], 'note' => $header['note']], ['id' => $header["id"]])){
            foreach($detail as $dtl){
                $purchase = array();
                $arr = explode(",", $dtl->purchase_id);
                for($i = 0; $i < count($arr); $i++){
                    $purchase[] = $this->site->getPurchaseItemsByID($arr[$i]);
                }
                // var_dump($dtl);
                // var_dump($purchase);exit;
                $sisa = $dtl->qty;
                $diff_unit = false;
                foreach($purchase as $pur){
                    // if($pur->quantity_balance < $pur->quantity){
                        // $pur_sisa = $pur->quantity - $pur->quantity_balance;
                        $unit = $this->site->getUnitByID($pur->product_unit_id);
                        if($pur->product_unit_id != $dtl->unit_id){
                            $diff_unit = true;
                            $sisa = $this->site->convertToBase($unit, $sisa);
                        }
                        else {
                            if($diff_unit){
                                $sisa = $this->site->convertToUnit($unit, $sisa);
                                $diff_unit = false;
                            }
                        }
                        // if($pur_sisa >= $sisa){
                            $pur->quantity_balance += $sisa;
                            $sisa = 0;
                        // }
                        // else {
                        //     $pur->quantity += $pur_sisa;
                        //     $sisa = $sisa - $pur_sisa;
                        // }
                        $this->db->update('purchase_items', ['quantity_balance' => $pur->quantity_balance], ['id' => $pur->id]);
                    // }
                    if($sisa == 0){
                        break;
                    }
                }
                $this->site->syncProductQty($dtl->product_id, $dtl->warehouse_id);
                $edit = [
                    'no_source' => $dtl->reff_doc,
                    'type_source' => $type,
                    'loc_source' => 'detail',
                    'id_source' => $dtl->id,
                ];
                $dataAcc = array();
                $this->site->postAccounting($dataAcc, $edit);
            }
            $data['reff_type'] = "production";
            $data['reff_no'] = $header['reff_doc'];
            $this->site->deleteMovementItemByDoc($data);
            return true;
        }
        return false;
    }

    public function getUser($param){
        $this->db->where($param);
        $q = $this->db->get("users");
        if($q->num_rows() > 0){
            return $q->row();
        }
        return false;
    }
}
