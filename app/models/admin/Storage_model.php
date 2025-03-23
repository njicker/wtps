<?php

defined('BASEPATH') or exit('No direct script access allowed');

class Storage_model extends CI_Model
{
    public function __construct()
    {
        parent::__construct();
    }

    public function getListWarehousesProducts($param = []){
        $data = [];

        $this->db->where($param);
        $q = $this->db->get("warehouses_products");

        if ($q->num_rows() > 0) {
            foreach (($q->result()) as $row) {
                $data[] = $row;
            }
        }
        return $data;
    }

    public function getListProducts($param = []){
        $data = [];

        $this->db->where($param);
        $q = $this->db->get("products");

        if ($q->num_rows() > 0) {
            foreach (($q->result()) as $row) {
                $data[$row->id] = $row;
            }
        }
        return $data;
    }

    public function getListWarehouses($param = []){
        $data = [];

        $this->db->where($param);
        $q = $this->db->get("warehouses");

        if ($q->num_rows() > 0) {
            foreach (($q->result()) as $row) {
                $data[$row->id] = $row;
            }
        }
        return $data;
    }

    public function getListUnits($param = []){
        $data = [];

        $this->db->where($param);
        $q = $this->db->get("units");

        if ($q->num_rows() > 0) {
            foreach (($q->result()) as $row) {
                $data[$row->id] = $row;
            }
        }
        return $data;
    }

    public function getListUnitsByCode($param = []){
        $data = [];

        $this->db->where($param);
        $q = $this->db->get("units");

        if ($q->num_rows() > 0) {
            foreach (($q->result()) as $row) {
                $data[$row->code] = $row;
            }
        }
        return $data;
    }

    public function getListWarehousesProductsGrouping($param = [], $group_by = []){
        $data = [];

        $this->db->where($param);
        $this->db->group_by($group_by);
        $q = $this->db->get("warehouses_products");

        if ($q->num_rows() > 0) {
            foreach (($q->result()) as $row) {
                $data[] = $row;
            }
        }
        return $data;
    }

    public function getListWarehousesProductsGroupingSum($param = [], $group_by = []){
        $data = [];

        $this->db->select('SUM(quantity) as quantity,
            product_id,
            warehouse_id');
        $this->db->where($param);
        $this->db->order_by('warehouse_id', 'ASC');
        $this->db->group_by($group_by);
        $q = $this->db->get("warehouses_products");

        if ($q->num_rows() > 0) {
            foreach (($q->result()) as $row) {
                $data[] = $row;
            }
        }
        return $data;
    }

    public function addDamage($header, $detail){
        $this->db->trans_start();
        // var_dump($header);exit;
        if($this->db->insert('damage', $header)){
            $dmg_id = $this->db->insert_id();
            foreach($detail as $dtl){
                $dtl['damage_id'] = $dmg_id;
                if($this->db->insert('damage_items', $dtl)){
                    if(!$this->site->syncPurchaseQty($dtl, false, "damage")){
                        $this->session->set_flashdata('error', 'Stock '.$dtl['product_code'].' tidak mencukupi');
                        $err = true;
                        break;
                    }
                }
            }
        }

        if($err){
            return false;
        }

        $this->db->trans_complete();
        if ($this->db->trans_status() === false) {
            log_message('error', 'An errors has been occurred while adding the damage (Update:storage_model.php)');
        } else {
            return true;
        }
        return false;
    }

    public function getCountForReff($year)
    {
        $q = $this->db->get_where('damage', ['year(`created_at`)' => $year]);
        return $q->num_rows();
    }

    public function getDamage($param = []){
        $data = [];

        $this->db->where($param);
        $this->db->limit(1);
        $q = $this->db->get("damage");

        if ($q->num_rows() > 0) {
            foreach (($q->result()) as $row) {
                $data = $row;
            }
        }
        return $data;
    }

    public function getListDamageItems($param = []){
        $data = [];

        $this->db->where($param);
        $q = $this->db->get("damage_items");

        if ($q->num_rows() > 0) {
            foreach (($q->result()) as $row) {
                $data[] = $row;
            }
        }
        return $data;
    }

    public function getStockCard($param = []){
        $data = [];

        $this->db->where($param);
        $this->db->order_by('stock_date', 'ASC');
        $this->db->order_by('id', 'ASC');
        $q = $this->db->get("item_movement");

        if ($q->num_rows() > 0) {
            foreach (($q->result()) as $row) {
                $data[] = $row;
            }
        }
        return $data;
    }
}

?>