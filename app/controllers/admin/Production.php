<?php

defined('BASEPATH') or exit('No direct script access allowed');

class Production extends MY_Controller
{
    public function __construct()
    {
        parent::__construct();
        if (!$this->loggedIn) {
            $this->session->set_userdata('requested_page', $this->uri->uri_string());
            $this->sma->md('login');
        }
        $this->lang->admin_load('products', $this->Settings->user_language);
        $this->load->library('form_validation');
        $this->load->admin_model('products_model');
        $this->digital_upload_path = 'files/';
        $this->upload_path         = 'assets/uploads/';
        $this->thumbs_path         = 'assets/uploads/thumbs/';
        $this->image_types         = 'gif|jpg|jpeg|png|tif';
        $this->digital_file_types  = 'zip|psd|ai|rar|pdf|doc|docx|xls|xlsx|ppt|pptx|gif|jpg|jpeg|png|tif|txt';
        $this->allowed_file_size   = '1024';
        $this->popup_attributes    = ['width' => '900', 'height' => '600', 'window_name' => 'sma_popup', 'menubar' => 'yes', 'scrollbars' => 'yes', 'status' => 'no', 'resizable' => 'yes', 'screenx' => '0', 'screeny' => '0'];
    }

    public function index(){
        $this->sma->checkPermissions();

        $this->data["title"] = "Produksi";
        $bc                 = [['link' => base_url(), 'page' => lang('home')], ['link' => '#', 'page' => $this->data['title']]];
        $meta               = ['page_title' => $this->data['title'], 'bc' => $bc];
        $this->page_construct('production/index', $meta, $this->data);
    }

    public function view_production($id = null){
        if($id == null){
            $this->session->set_flashdata('error', 'Gagal membuka produksi');
            admin_redirect('production');
            exit;
        }
        $param["id"] = $id;
        $this->data["header"] = $this->products_model->getProductionHeader($param);
        if(!$this->data["header"]){
            $this->session->set_flashdata('error', 'Dokumen produksi tidak ditemukan');
            admin_redirect('production');
            exit;
        }
        $wh = array();
        $warehouse = $this->site->getAllWarehouses();
        foreach ($warehouse as $warehouse) {
            $wh[$warehouse->id] = $warehouse->name;
        }
        $prm["reff_doc"] = $this->data["header"]->reff_doc;
        $this->data["detail"] = $this->products_model->getProductionDetail($prm);
        $this->data["warehouse"] = $wh;
        $this->data["title"] = "View Produksi";
        $bc                 = [['link' => base_url(), 'page' => lang('home')], 
                                ['link' => admin_url('production'), 'page' => "Produksi"],
                                ['link' => '#', 'page' => $this->data['title'],
                            ]];
        $meta               = ['page_title' => $this->data['title'], 'bc' => $bc];
        $this->page_construct('production/view_production', $meta, $this->data);
    }

    public function get_production(){
        $this->sma->checkPermissions("production");
        $this->load->library('datatables');

        $this->datatables
            ->select("reff_doc, status_doc, total_cost, created_by, created_date, note, id ")
            ->from('production');
        // $this->datatables->add_column('Actions', $action, 'id');
        $data = $this->datatables->generate();
        $decode = json_decode($data);
        // var_dump($decode);exit;
        $finish = array();
        foreach($decode->aaData as $dt){
            $usr = $this->products_model->getUser(["id" => $dt[3]]);
            if($usr != false){
                $dt[3] = $usr->first_name . " " . $usr->last_name;
            }
            $action = '<div class="text-center"><div class="btn-group text-left">'
            . '<button type="button" class="btn btn-default btn-xs btn-primary dropdown-toggle" data-toggle="dropdown">'
            . lang('actions') . ' <span class="caret"></span></button>
            <ul class="dropdown-menu pull-right" role="menu">';

            $link_view = anchor('admin/production/view_production/'.$dt[6], '<i class="fa fa-file"></i> ' . 'View Produksi');
            $action .= "<li>" . $link_view . "</li>";

            if($dt[1] == "On Production"){
                $link_finish = anchor('admin/production/finish_production/'.$dt[6], '<i class="fa fa-check"></i> ' . 'Finish Produksi');
                $action .= "<li>" . $link_finish . "</li>";

                $link_batal = anchor('admin/production/reject_production/'.$dt[6], '<i class="fa fa-trash"></i> ' . 'Reject Produksi');
                $action .= "<li>" . $link_batal . "</li>";
            }

            $action .= '</ul>
            </div></div>';
            $dt[6] = $action;
            $finish[] = $dt;
        }
        $decode->aaData = $finish;
        
        echo json_encode($decode);
    }

    public function add_production(){
        $this->sma->checkPermissions("add_production");
        $this->load->helper('security');

        $this->form_validation->set_rules('reff_doc', lang('batch_production'), 'required');
        $this->form_validation->set_rules('status_doc', lang('status'), 'required');
        $this->form_validation->set_rules('doc_date', lang('date'), 'required');
        if ($this->form_validation->run() == true) {
            // $header['reff_doc'] = $this->input->post('reff_doc');
            $doc_date = $this->sma->fsd($this->input->post('doc_date'));
            $batch = date("Ymd", strtotime($doc_date));
            // var_dump($doc_date, $batch); exit;

            $no_urut = $this->products_model->getCountProduction($batch);
            $no_urut++;

            $header['reff_doc'] = $batch . "-" . $no_urut;
            $header['doc_date'] = $doc_date;
            $header['status_doc'] = $this->input->post('status_doc');
            $header['division'] = $this->input->post('division');
            $header['created_by'] = $this->session->userdata('user_id');

            $detail = array();
            for($i = 0; $i < count($_POST['product_id']); $i++){
                $unit = explode(",", $_POST['unit'][$i]);
                $tmp = [
                    'reff_doc' => $header['reff_doc'],
                    'product_id' => $_POST['product_id'][$i],
                    'product_code' => $_POST['product_code'][$i],
                    'qty' => $_POST['qty'][$i],
                    'unit_id' => $unit[0],
                    'unit_code' => $unit[1],
                    'type_item' => $_POST['type_item'][$i],
                    'warehouse_id' => $_POST['warehouse_id'][$i],
                    'product_batch' => $_POST['product_batch'][$i],
                    'purchase_id' => "",
                ];
                $detail[] = $tmp;
            }
            // var_dump($detail);exit;
            if (empty($detail)) {
                $this->form_validation->set_rules('product_id', 'Produk', 'required');
            }
        }

        if($this->form_validation->run() == true && $this->products_model->addProduction($header, $detail)) {
            $this->session->set_flashdata('message', 'Produksi berhasil ditambahkan');
            admin_redirect('production');
        }
        else {
            $this->data['error']      = (validation_errors() ? validation_errors() : $this->session->flashdata('error'));
            $this->data['warehouses'] = $this->site->getAllWarehouses();
            $this->data['title'] = 'Tambah Produksi';
            $bc                 = [['link' => base_url(), 'page' => lang('home')], ['link' => admin_url('production'), 'page' => "Produksi"], ['link' => '#', 'page' => $this->data['title']]];
            $meta               = ['page_title' => $this->data['title'], 'bc' => $bc];
            // $this->load->view($this->theme . 'products/add_production', $this->data);
            $this->page_construct('production/add_production', $meta, $this->data);
        }
    }

    public function finish_production($id = null){
        $this->sma->checkPermissions("finish_production");

        $this->form_validation->set_rules('reff_doc', lang('batch_production'), 'required');
        $this->form_validation->set_rules('status_doc', lang('status'), 'required');
        $this->form_validation->set_rules('doc_date', lang('date'), 'required');
        if ($this->form_validation->run() == true) {
            $header['id'] = $this->input->post('id');
            $header['reff_doc'] = $this->input->post('reff_doc');
            $header['status_doc'] = $this->input->post('status_doc');
            $header['division'] = $this->input->post('division');
            $header['doc_date'] = $this->input->post('doc_date');

            $detail = array();
            $detail_raw = array();
            for($i = 0; $i < count($_POST['product_id']); $i++){
                $unit = explode(",", $_POST['unit'][$i]);
                $tmp = [
                    'reff_doc' => $header['reff_doc'],
                    'product_id' => $_POST['product_id'][$i],
                    'product_code' => $_POST['product_code'][$i],
                    'qty' => $_POST['qty'][$i],
                    'unit_id' => $unit[0],
                    'unit_code' => $unit[1],
                    'type_item' => $_POST['type_item'][$i],
                    'warehouse_id' => $_POST['warehouse_id'][$i],
                    'purchase_id' => "",
                    'expired_date' => date("Y-m-d", strtotime("+1 year")),
                ];
                $detail[] = $tmp;
            }
            // var_dump($header);exit;
            if (empty($detail)) {
                $this->form_validation->set_rules('product_id', 'Produk', 'required');
            }

            // check raw
            for($i = 0; $i < count($_POST['raw_product_id']); $i++){
                if($_POST['raw_qty'][$i] == $_POST['raw_confirm_qty'][$i]){
                    continue;
                }
                $qty = $_POST['raw_confirm_qty'][$i] - $_POST['raw_qty'][$i];
                $tmp = [
                    'reff_doc' => $header['reff_doc'],
                    'product_id' => $_POST['raw_product_id'][$i],
                    'product_code' => $_POST['raw_product_code'][$i],
                    'product_batch' => $_POST['raw_product_batch'][$i],
                    'qty' => $qty,
                    'unit_id' => $_POST['raw_unit_id'][$i],
                    'unit_code' => $_POST['raw_unit_code'][$i],
                    'type_item' => $_POST['raw_type_item'][$i],
                    'warehouse_id' => $_POST['raw_warehouse_id'][$i],
                    'purchase_id' => $_POST['raw_purchase_id'][$i],
                ];
                $detail_raw[] = $tmp;
            }
        }
        // check produksi jika masih on production
        if($this->form_validation->run() == true && $this->products_model->finishProduction($header, $detail, $detail_raw)) {
            $this->session->set_flashdata('message', 'Produksi selesai, data berhasil diupdate');
            admin_redirect('production');
        }
        else {
            $url = 'production/finish_production';
            $this->data['title'] = 'Finishing Production';
            if($id == "" || $id == null){
                $id = "9999999999";
            }
            if(isset($_POST["id"])){
                $id = $_POST["id"];
            }
            $param['id'] = $id;
            $param['status_doc'] = 'On Production';
            $prod = $this->products_model->getProductionHeader($param);
            // var_dump($prod);exit;
            if($prod == null){
                $this->session->set_flashdata('error', 'Produksi tidak ditemukan atau sudah selesai produksi');            
                $url = 'production';
                admin_redirect($url);exit;
            }
            else {
                $paramDtl['reff_doc'] = $prod->reff_doc;
                $dtl = $this->products_model->getProductionDetail($paramDtl);
                if(!$dtl){
                    $this->session->set_flashdata('error', 'Item produksi tidak ditemukan');
                    $url = 'production';
                    admin_redirect($url);exit;
                }
                else {
                    $this->data['header'] = $prod;
                    $this->data['detail'] = $dtl;
                    $url .= "/" . $id;
                }
            }
            $wh = array();
            $warehouse = $this->site->getAllWarehouses();
            foreach ($warehouse as $warehouse) {
                $wh[$warehouse->id] = $warehouse->name;
            }

            $this->data["title"] = "Finish Produksi";
            $this->data['error']      = (validation_errors() ? validation_errors() : $this->session->flashdata('error'));
            $this->data['warehouse'] = $wh;
            $bc                 = [['link' => base_url(), 'page' => lang('home')], ['link' => admin_url('production'), 'page' => "Produksi"], ['link' => '#', 'page' => $this->data['title']]];
            $meta               = ['page_title' => $this->data['title'], 'bc' => $bc];
            $this->page_construct('production/finish_production', $meta, $this->data);
        }
    }

    public function reject_production($id = null){
        $this->sma->checkPermissions();

        $this->form_validation->set_rules('reff_doc', lang('batch_production'), 'required');
        $this->form_validation->set_rules('status_doc', lang('status'), 'required');
        $this->form_validation->set_rules('note', 'Note', 'required');
        if ($this->form_validation->run() == true) {
            $header['id'] = $this->input->post('id');
            $header['reff_doc'] = $this->input->post('reff_doc');
            $header['status_doc'] = $this->input->post('status_doc');
            $header['note'] = $this->input->post('note');

            $prm["reff_doc"] = $header['reff_doc'];
            $detail = $this->products_model->getProductionDetail($prm);
            // var_dump($header);exit;
        }
        // check produksi jika masih on production
        if($this->form_validation->run() == true && $this->products_model->rejectProduction($header, $detail)) {
            $this->session->set_flashdata('message', 'Produksi berhasil direject');
            admin_redirect('production');
        }
        else {
            $url = 'production/reject_production';
            $this->data['title'] = 'Finishing Production';
            if($id == "" || $id == null){
                $id = "9999999999";
            }
            $param['id'] = $id;
            $param['status_doc'] = 'On Production';
            $prod = $this->products_model->getProductionHeader($param);
            // var_dump($prod);exit;
            if($prod == null){
                $this->session->set_flashdata('error', 'Produksi tidak ditemukan atau sudah selesai produksi');            
                $url = 'production';
                admin_redirect($url);exit;
            }
            else {
                $paramDtl['reff_doc'] = $prod->reff_doc;
                $dtl = $this->products_model->getProductionDetail($paramDtl);
                if(!$dtl){
                    $this->session->set_flashdata('error', 'Item produksi tidak ditemukan');
                    $url = 'production';
                    admin_redirect($url);exit;
                }
                else {
                    $this->data['header'] = $prod;
                    $this->data['detail'] = $dtl;
                    $url .= "/" . $id;
                }
            }
            $wh = array();
            $warehouse = $this->site->getAllWarehouses();
            foreach ($warehouse as $warehouse) {
                $wh[$warehouse->id] = $warehouse->name;
            }

            $this->data["title"] = "Reject Produksi";
            $this->data['error']      = (validation_errors() ? validation_errors() : $this->session->flashdata('error'));
            $this->data['warehouse'] = $wh;
            $bc                 = [['link' => base_url(), 'page' => lang('home')], ['link' => admin_url('production'), 'page' => "Produksi"], ['link' => '#', 'page' => $this->data['title']]];
            $meta               = ['page_title' => $this->data['title'], 'bc' => $bc];
            $this->page_construct('production/reject_production', $meta, $this->data);
        }
    }
}
?>