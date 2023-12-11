<?php

defined('BASEPATH') or exit('No direct script access allowed');

class Storage extends MY_Controller
{
    public function __construct()
    {
        parent::__construct();

        if (!$this->loggedIn) {
            $this->session->set_userdata('requested_page', $this->uri->uri_string());
            $this->sma->md('login');
        }
        if ($this->Supplier) {
            $this->session->set_flashdata('warning', lang('access_denied'));
            redirect($_SERVER['HTTP_REFERER']);
        }
        $this->lang->admin_load('storage', $this->Settings->user_language);
        $this->load->library('form_validation');
        $this->load->admin_model('storage_model');
        $this->load->helper('reference_helper');
        $this->digital_upload_path = 'files/';
        $this->upload_path         = 'assets/uploads/';
        $this->thumbs_path         = 'assets/uploads/thumbs/';
        $this->image_types         = 'gif|jpg|jpeg|png|tif';
        $this->digital_file_types  = 'zip|psd|ai|rar|pdf|doc|docx|xls|xlsx|ppt|pptx|gif|jpg|jpeg|png|tif|txt';
        $this->allowed_file_size   = '1024';
        $this->data['logo']        = true;
    }

    public function index(){
        $this->sma->checkPermissions();

        $this->data['warehouses'] = $this->storage_model->getListWarehouses();
        $this->data['products'] = $this->storage_model->getListProducts();
        
        $bc                        = [['link' => base_url(), 'page' => lang('home')], ['link' => admin_url('storage'), 'page' => 'Gudang']];
        $meta                      = ['page_title' => lang('add_sale'), 'bc' => $bc];
        $this->page_construct('storage/index', $meta, $this->data);
    }

    public function view_stock(){
        $view_type = $this->input->get('view_type');

        $this->data['warehouses'] = $this->storage_model->getListWarehouses();
        $this->data['products'] = $this->storage_model->getListProducts();
        $this->data['units'] = $this->storage_model->getListUnits();
        $param['quantity >'] = "0";
        if($view_type == "warehouse"){
            $param['warehouse_id'] = $this->input->get('warehouse_id');
            $group = [
                "product_id"
            ];
            $this->data['header'] = $this->storage_model->getListWarehousesProductsGrouping($param, $group);
            $this->data['batch'] = $this->storage_model->getListWarehousesProducts($param);
            
            $bc                        = [['link' => base_url(), 'page' => lang('home')], ['link' => admin_url('storage'), 'page' => 'Gudang'], ['link' => "#", 'page' => 'Stock by Warehouse']];
            $meta                      = ['page_title' => 'Stock by Warehouse', 'bc' => $bc];
            $this->page_construct('storage/view_by_warehouse', $meta, $this->data);
        }
        else {
            $param['product_id'] = $this->input->get('product_id');
            $group = [
                "warehouse_id"
            ];
            $this->data['header'] = $this->storage_model->getListWarehousesProductsGrouping($param, $group);
            $this->data['batch'] = $this->storage_model->getListWarehousesProducts($param);
            
            $bc                        = [['link' => base_url(), 'page' => lang('home')], ['link' => admin_url('storage'), 'page' => 'Gudang'], ['link' => "#", 'page' => 'Stock by Product']];
            $meta                      = ['page_title' => 'Stock by Product', 'bc' => $bc];
            $this->page_construct('storage/view_by_product', $meta, $this->data);
        }
    }

    public function add_damage(){
        $this->sma->checkPermissions();

        $this->form_validation->set_rules('reason', "Reason", 'required');
        // $this->form_validation->set_rules('total_amount', lang('total_amount'), 'required');

        if($this->form_validation->run() == true) {
            // Generate Reference
            // Get No Urut
            $no_urut = $this->storage_model->getCountForReff(date("Y"));
            $no_urut = 10000 + $no_urut + 1;
            $no_urut = substr($no_urut, 1, 4);
            // Genarete reff with helper
            $reference = generate_ref($no_urut, 'DMG');

            $header = [
                'reference'         => $reference,
                'reason'            => $this->input->post('reason'),
                'created_by'        => $this->session->userdata('user_id'),
            ];

            $total_amount = 0;
            $detail = array();
            $cnt    = isset($_POST['product_code']) ? sizeof($_POST['product_code']) : 0;
            for($i = 0; $i < $cnt; $i++){
                $unit = explode(",", $_POST['unit'][$i]);
                $dtl = [
                    'product_id'    => $_POST['product_id'][$i],
                    'product_code'  => $_POST['product_code'][$i],
                    'product_desc'    => $_POST['product_desc'][$i],
                    'product_batch'    => $_POST['product_batch'][$i],
                    'qty'    => $_POST['qty'][$i],
                    'unit_id'    => $unit[0],
                    'unit_code'    => $unit[1],
                    'unit_amount'    => $_POST['unit_amount'][$i],
                    'total_amount'    => $_POST['unit_amount'][$i] * $_POST['qty'][$i],
                    'warehouse_id'    => $_POST['warehouse_id'][$i],
                    'note'    => $_POST['note'][$i],
                ];

                $total_amount += $dtl['total_amount'];
                $detail[] = $dtl;
            }
            $header['total_amount'] = $total_amount;

            if (empty($detail)) {
                $this->form_validation->set_rules('product', 'Mohon tambahkan produk', 'required');
            }
        }
        // var_dump($detail);exit;
        if ($this->form_validation->run() == true && $this->storage_model->addDamage($header, $detail)) {
            $this->session->set_userdata('remove_rels', 1);
            $this->session->set_flashdata('message', "Damage berhasil ditambahkan");
            admin_redirect('storage/add_damage');
        }
        else {
            $warehouse = $this->site->getAllWarehouses();
            foreach ($warehouse as $warehouse) {
                $wh[$warehouse->id] = $warehouse->name;
            }
            // var_dump($wh);exit;
            $this->data['warehouses'] = $wh;
            $this->data["title"] = "Tambah Damage";
            $bc = [['link' => base_url(), 'page' => lang('home')], 
                    ['link' => admin_url('storage'), 'page' => "Gudang"],
                    ['link' => '#', 'page' => $this->data['title'],
                ]];
            $meta = ['page_title' => $this->data['title'], 'bc' => $bc];
            $this->page_construct('storage/add_damage', $meta, $this->data);
        }
    }

    public function damage(){
        $this->sma->checkPermissions();

        $this->data["title"] = "Damage";
        $bc                 = [['link' => base_url(), 'page' => lang('home')], ['link' => admin_url('storage'), 'page' => 'Gudang'], ['link' => '#', 'page' => $this->data['title']]];
        $meta               = ['page_title' => $this->data['title'], 'bc' => $bc];
        $this->page_construct('storage/damage', $meta, $this->data);
    }
}

?>