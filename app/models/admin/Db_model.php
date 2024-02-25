<?php

defined('BASEPATH') or exit('No direct script access allowed');

class Db_model extends CI_Model
{
    public function __construct()
    {
        parent::__construct();
    }

    public function getBestSeller($start_date = null, $end_date = null)
    {
        if (!$start_date) {
            $start_date = date('Y-m-d', strtotime('first day of this month')) . ' 00:00:00';
        }
        if (!$end_date) {
            $end_date = date('Y-m-d', strtotime('last day of this month')) . ' 23:59:59';
        }

        $this->db
            ->select('product_name, product_code')
            ->select_sum('quantity')
            ->from('sale_items')
            ->join('sales', 'sales.id = sale_items.sale_id', 'left')
            ->where('date >=', $start_date)
            ->where('date <', $end_date)
            ->group_by('product_name, product_code')
            ->order_by('sum(quantity)', 'desc')
            ->limit(10);
        $q = $this->db->get();
        if ($q->num_rows() > 0) {
            foreach (($q->result()) as $row) {
                $data[] = $row;
            }
            return $data;
        }
        return false;
    }

    public function getChartData()
    {
        $myQuery = "SELECT S.month,
        COALESCE(S.sales, 0) as sales,
        COALESCE( P.purchases, 0 ) as purchases,
        COALESCE(S.tax1, 0) as tax1,
        COALESCE(S.tax2, 0) as tax2,
        COALESCE( P.ptax, 0 ) as ptax
        FROM (  SELECT  date_format(date, '%Y-%m') Month,
                SUM(total) Sales,
                SUM(product_tax) tax1,
                SUM(order_tax) tax2
                FROM " . $this->db->dbprefix('sales') . "
                WHERE date >= date_sub( now( ) , INTERVAL 12 MONTH )
                GROUP BY date_format(date, '%Y-%m')) S
            LEFT JOIN ( SELECT  date_format(date, '%Y-%m') Month,
                        SUM(product_tax) ptax,
                        SUM(order_tax) otax,
                        SUM(total) purchases
                        FROM " . $this->db->dbprefix('purchases') . "
                        GROUP BY date_format(date, '%Y-%m')) P
            ON S.Month = P.Month
            ORDER BY S.Month";
        $q = $this->db->query($myQuery);
        if ($q->num_rows() > 0) {
            foreach (($q->result()) as $row) {
                $data[] = $row;
            }
            return $data;
        }
        return false;
    }

    public function getLastestQuotes()
    {
        if ($this->Settings->restrict_user && !$this->Owner && !$this->Admin) {
            $this->db->where('created_by', $this->session->userdata('user_id'));
        }
        $this->db->order_by('id', 'desc');
        $q = $this->db->get('quotes', 5);
        if ($q->num_rows() > 0) {
            foreach (($q->result()) as $row) {
                $data[] = $row;
            }
            return $data;
        }
    }

    public function getLatestCustomers()
    {
        $this->db->order_by('id', 'desc');
        $q = $this->db->get_where('companies', ['group_name' => 'customer'], 5);
        if ($q->num_rows() > 0) {
            foreach (($q->result()) as $row) {
                $data[] = $row;
            }
            return $data;
        }
    }

    public function getLatestPurchases()
    {
        if ($this->Settings->restrict_user && !$this->Owner && !$this->Admin) {
            $this->db->where('created_by', $this->session->userdata('user_id'));
        }
        $this->db->order_by('id', 'desc');
        $q = $this->db->get('purchases', 5);
        if ($q->num_rows() > 0) {
            foreach (($q->result()) as $row) {
                $data[] = $row;
            }
            return $data;
        }
    }

    public function getLatestSales()
    {
        if ($this->Settings->restrict_user && !$this->Owner && !$this->Admin) {
            $this->db->where('created_by', $this->session->userdata('user_id'));
        }
        $this->db->order_by('id', 'desc');
        $q = $this->db->get('sales', 5);
        if ($q->num_rows() > 0) {
            foreach (($q->result()) as $row) {
                $data[] = $row;
            }
            return $data;
        }
    }

    public function getLatestSuppliers()
    {
        $this->db->order_by('id', 'desc');
        $q = $this->db->get_where('companies', ['group_name' => 'supplier'], 5);
        if ($q->num_rows() > 0) {
            foreach (($q->result()) as $row) {
                $data[] = $row;
            }
            return $data;
        }
    }

    public function getLatestTransfers()
    {
        if ($this->Settings->restrict_user && !$this->Owner && !$this->Admin) {
            $this->db->where('created_by', $this->session->userdata('user_id'));
        }
        $this->db->order_by('id', 'desc');
        $q = $this->db->get('transfers', 5);
        if ($q->num_rows() > 0) {
            foreach (($q->result()) as $row) {
                $data[] = $row;
            }
            return $data;
        }
    }

    public function getStockValue()
    {
        $q = $this->db->query('SELECT SUM(qty*price) as stock_by_price, SUM(qty*cost) as stock_by_cost
        FROM (
            Select sum(COALESCE(' . $this->db->dbprefix('warehouses_products') . '.quantity, 0)) as qty, price, cost
            FROM ' . $this->db->dbprefix('products') . '
            JOIN ' . $this->db->dbprefix('warehouses_products') . ' ON ' . $this->db->dbprefix('warehouses_products') . '.product_id=' . $this->db->dbprefix('products') . '.id
            GROUP BY ' . $this->db->dbprefix('warehouses_products') . '.id ) a');
        if ($q->num_rows() > 0) {
            return $q->row();
        }
        return false;
    }

    public function getLatestDelivery($start_date, $end_date)
    {
        // $this->db
        //     ->select('date(deliveries.date), delivery_item.product_code, delivery_item.product_desc,
        //     sum(delivery_item.qty) as qty')
        //     ->join('delivery_item', 'deliveries.id = delivery_item.delivery_id', 'inner');
        $where = "";
        if($start_date != "" && $end_date != ""){
            // $this->db->where('deliveries.date >=', $start_date)->where('deliveries.date <=', $end_date);
            $where = "AND deliveries.date between '$start_date' and '$end_date'";
        }
        else if($start_date != ""){
            // $this->db->where('date(deliveries.date)', $start_date);
            $where = "AND date(deliveries.date) = '$start_date'";
        }
        else if($end_date != ""){
            // $this->db->where('date(deliveries.date)', $end_date);
            $where = "AND date(deliveries.date) = '$end_date'";
        }
        $que = "select date(deliveries.date) as date, delivery_item.product_code, delivery_item.product_desc,
        sum(delivery_item.qty) as qty
        from sma_deliveries as deliveries
        inner join sma_delivery_item as delivery_item on deliveries.id = delivery_item.delivery_id
        where 1=1 $where
        group by date(deliveries.date), delivery_item.product_code
        order by deliveries.date";
        // $this->db->group_by(array('date(deliveries.date)', 'delivery_item.product_code'));
        // $this->db->order_by('deliveries.date');
        // $q = $this->db->get('deliveries');
        $q = $this->db->query($que);
        if ($q->num_rows() > 0) {
            $all = array();
            $data_prod = array();
            $prod = array();
            $data = [
                'all' => [],
                'date' => [],
            ];
            foreach (($q->result()) as $row) {
                // var_dump($row);exit;
                // $row->product_full = $row->product_code." - ".$row->product_name;
                // $row->salesman = $row->first_name." ".$row->last_name;
                // $row->subtotal = $row->quantity * $row->net_unit_price;
                // $row->net_unit_price = number_format($row->net_unit_price, 0, ",", ".");
                $row->date = date("d-M-Y", strtotime($row->date));
                if(!isset($data_prod[$row->product_code."#".$row->date])){
                    $data_prod[$row->product_code."#".$row->date] = 0;
                }
                $data_prod[$row->product_code."#".$row->date] = +$row->qty;
                if(!in_array($row->date, $data['date'])){
                    $data['date'][] = $row->date;
                    $all[$row->date] = 0;
                }
                $all[$row->date] += $row->qty;
                if(!in_array($row->product_code, $prod)){
                    $prod[] = $row->product_code;
                }
                // $data[] = $row;
            }
            // var_dump($prod);exit;
            foreach($all as $ida => $a){
                $data['all'][] = $a;
                foreach($prod as $prd){
                    $qty = 0;
                    if(!isset($data[$prd])){
                        $data[$prd] = array();
                    }
                    if(isset($data_prod[$prd."#".$ida])){
                        $qty = $data_prod[$prd."#".$ida];
                    }
                    $data[$prd][] = $qty;
                }
            }
            // var_dump($data);exit;
            return $data;
        }
        return false;
    }
}
