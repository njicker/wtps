<?php

defined('BASEPATH') or exit('No direct script access allowed');

class Accounting extends MY_Controller
{
    public function __construct()
    {
        parent::__construct();
        if (!$this->loggedIn) {
            $this->session->set_userdata('requested_page', $this->uri->uri_string());
            $this->sma->md('login');
        }
        $this->lang->admin_load('accounting', $this->Settings->user_language);
        $this->lang->admin_load('settings', $this->Settings->user_language);
        $this->load->library('form_validation');
        $this->load->admin_model('accounting_model');
        $this->load->admin_model('settings_model');
        $this->load->helper('reference_helper');
        $this->digital_upload_path = 'files/';
        $this->upload_path         = 'assets/uploads/';
        $this->thumbs_path         = 'assets/uploads/thumbs/';
        $this->image_types         = 'gif|jpg|jpeg|png|tif';
        $this->digital_file_types  = 'zip|psd|ai|rar|pdf|doc|docx|xls|xlsx|ppt|pptx|gif|jpg|jpeg|png|tif|txt';
        $this->allowed_file_size   = '1024';
        $this->popup_attributes    = ['width' => '900', 'height' => '600', 'window_name' => 'sma_popup', 'menubar' => 'yes', 'scrollbars' => 'yes', 'status' => 'no', 'resizable' => 'yes', 'screenx' => '0', 'screeny' => '0'];
    }

    public function index_journal($status = null)
    {
        $this->sma->checkPermissions();

        $this->data['error'] = (validation_errors()) ? validation_errors() : $this->session->flashdata('error');

        $this->data['status'] = $status;
        $bc   = [['link' => base_url(), 'page' => lang('home')], ['link' => '#', 'page' => lang('accounting')]];
        $meta = ['page_title' => lang('journal'), 'bc' => $bc];
        $this->page_construct('accounting/index_journal', $meta, $this->data);
    }

    public function getJournal($status = null)
    {
        $this->sma->checkPermissions('index');

        $detail_link      = anchor('admin/accounting/edit_journal/$1/view', '<i class="fa fa-file-text-o"></i> ' . lang('journal_details'));
        $edit_link        = anchor('admin/accounting/edit_journal/$1/edit', '<i class="fa fa-edit"></i> ' . lang('edit_journal'));
        $delete_link      = "<a href='#' class='po' title='<b>" . $this->lang->line('delete_journal') . "</b>' data-content=\"<p>"
        . lang('r_u_sure') . "</p><a class='btn btn-danger po-delete' href='" . admin_url('accounting/delete_journal/$1') . "'>"
        . lang('i_m_sure') . "</a> <button class='btn po-close'>" . lang('no') . "</button>\"  rel='popover'><i class=\"fa fa-trash-o\"></i> "
        . lang('delete_journal') . '</a>';
        $action = '<div class="text-center"><div class="btn-group text-left">'
            . '<button type="button" class="btn btn-default btn-xs btn-primary dropdown-toggle" data-toggle="dropdown">'
            . lang('actions') . ' <span class="caret"></span></button>
            <ul class="dropdown-menu pull-right" role="menu">
                <li>' . $detail_link . '</li>
                <li>' . $edit_link . '</li>
                <li>' . $delete_link . '</li>
            </ul>
        </div></div>';
        //$action = '<div class="text-center">' . $detail_link . ' ' . $edit_link . ' ' . $email_link . ' ' . $delete_link . '</div>';

        $this->load->library('datatables');
        if ($status) {
            $this->datatables
                ->select("doc_date, no_journal, type_reff, no_reff, division, total_debit, total_credit, doc_status, id")
                ->from('journal')
                ->where('doc_status', $doc_status);
        } else {
            $this->datatables
                ->select("doc_date, no_journal, type_reff, no_reff, division, total_debit, total_credit, doc_status, id")
                ->from('journal');
        }
        $this->datatables->edit_column('id', $action, 'id');
        echo $this->datatables->generate();
    }

    public function add_journal()
    {
        $this->form_validation->set_rules('division', lang('division'), 'required');
        $this->form_validation->set_rules('no_journal', lang('no_journal'), 'required');
        $this->form_validation->set_rules('doc_status', lang('doc_status'), 'required');

        if ($this->form_validation->run() == true) {
            // Generate Journal
            $type = 'RFP';
            $no_urut = $this->site->getCountForReff($type);
            $no_urut = 10000 + $no_urut + 1;
            $no_urut = substr($no_urut, 1, 4);
            // Genarete reff with helper
            $no_journal = generate_ref($no_urut, $type);

            $header = [
                'no_journal' => $no_journal,
                'doc_date' => $this->input->post('doc_date') ? date('Y-m-d', strtotime($this->input->post('doc_date'))) : date("Y-m-d"),
                'type_reff' => $type,
                'no_reff' => $no_journal,
                'division' => $this->input->post('division'),
                'doc_status' => $this->input->post('doc_status'),
                'total_debit' => $this->input->post('total_debit'),
                'total_credit' => $this->input->post('total_credit'),
                'total_offset' => $this->input->post('total_debit') - $this->input->post('total_credit'),
                'created_by' => $this->session->userdata('user_id'),
                'note' => $this->input->post('note'),
            ];

            $detail = array();
            $cnt_no_acc = count($_POST['no_account']);
            for($i = 0; $i < $cnt_no_acc; $i++){
                if($_POST['no_account'][$i] != ""){
                    $detail[] = [
                        'no_account' => $_POST['no_account'][$i],
                        'type_amount' => $_POST['type_amount'][$i],
                        'amount' => $_POST['amount'][$i],
                        'note' => $_POST['note_item'][$i],
                    ];
                }
            }

            if(count($detail) <= 0){
                $this->session->set_flashdata('message', 'Gagal membuat jurnal umum karena item kosong');
                admin_redirect('accounting/add_journal');
                exit;
            }
        }

        if ($this->form_validation->run() == true && $this->accounting_model->addJournal($header, $detail)) {
            $this->session->set_flashdata('message', 'Berhasil menambahkan Jurnal Umum');
            admin_redirect('accounting/index_journal');
        } else {
            $this->data['error']    = validation_errors() ? validation_errors() : $this->session->flashdata('error');
            $this->data['account_journal'] = $this->settings_model->getAllAccountJournalActive();
            $bc                 = [['link' => base_url(), 'page' => lang('home')], ['link' => admin_url('accounting'), 'page' => lang('accounting')], 
                                    ['link' => admin_url('accounting/index_journal'), 'page' => lang('journal')], 
                                    ['link' => '#', 'page' => lang('add_journal')]];
            $meta               = ['page_title' => lang('add_journal'), 'bc' => $bc];
            $this->page_construct('accounting/add_journal', $meta, $this->data);
        }
    }

    public function edit_journal($id = null, $mode = null)
    {
        $this->form_validation->set_rules('division', lang('division'), 'required');
        $this->form_validation->set_rules('no_journal', lang('no_journal'), 'required');
        $this->form_validation->set_rules('doc_status', lang('doc_status'), 'required');

        if ($this->form_validation->run() == true) {
            $header = [
                'no_journal' => $this->input->post('no_journal'),
                'doc_date' => $this->input->post('doc_date') ? date('Y-m-d', strtotime($this->input->post('doc_date'))) : date("Y-m-d"),
                'type_reff' => $this->input->post('type_reff'),
                'no_reff' => $this->input->post('no_journal'),
                'division' => $this->input->post('division'),
                'doc_status' => $this->input->post('doc_status'),
                'total_debit' => $this->input->post('total_debit'),
                'total_credit' => $this->input->post('total_credit'),
                'total_offset' => $this->input->post('total_debit') - $this->input->post('total_credit'),
                'created_by' => $this->session->userdata('user_id'),
                'note' => $this->input->post('note'),
            ];

            $detail = array();
            $cnt_no_acc = count($_POST['no_account']);
            for($i = 0; $i < $cnt_no_acc; $i++){
                if($_POST['no_account'][$i] != ""){
                    $detail[] = [
                        'no_account' => $_POST['no_account'][$i],
                        'type_amount' => $_POST['type_amount'][$i],
                        'amount' => $_POST['amount'][$i],
                        'note' => $_POST['note_item'][$i],
                    ];
                }
            }

            if(count($detail) <= 0){
                $this->session->set_flashdata('message', 'Gagal ubah jurnal umum karena item kosong');
                admin_redirect('accounting/edit_journal');
                exit;
            }
        }

        if ($this->form_validation->run() == true && $this->accounting_model->editJournal($id, $header, $detail)) {
            $this->session->set_flashdata('message', 'Berhasil ubah Jurnal Umum');
            admin_redirect('accounting/index_journal');
        } else {
            $this->data['error']    = validation_errors() ? validation_errors() : $this->session->flashdata('error');
            $this->data['account_journal'] = $this->settings_model->getAllAccountJournalActive();
            $this->data['header'] = $this->accounting_model->getJournal($id);
            if(!$this->data['header']){
                $this->session->set_flashdata('error', 'Jurnal Umum tidak ditemukan');
                admin_redirect('accounting/index_journal');
                exit;
            }
            $this->data['detail'] = $this->accounting_model->getJournalItems($id);
            $this->data['mode'] = $mode;
            $this->data['id'] = $id;
            $bc                 = [['link' => base_url(), 'page' => lang('home')], 
                                    ['link' => admin_url('accounting'), 'page' => lang('accounting')],
                                    ['link' => admin_url('accounting/index_journal'), 'page' => lang('journal')],
                                    ['link' => '#', 'page' => lang($mode.'_journal')]];
            $meta               = ['page_title' => lang($mode.'_journal'), 'bc' => $bc];
            $this->page_construct('accounting/edit_journal', $meta, $this->data);
        }
    }

    public function delete_journal($id = null)
    {
        $this->sma->checkPermissions(null, true);

        if ($this->input->get('id')) {
            $id = $this->input->get('id');
        }

        $isErr = false;
        $msg = "";
        $data = $this->accounting_model->getJournal($id);
        if(!$data){
            $msg = 'Data Jurnal umum tidak ditemukan';
            $isErr = true;
        }
        if($isErr){
            $this->sma->send_json(['error' => 1, 'msg' => $msg]);
            admin_redirect('accounting/index_journal');
            exit;
        }
        if ($this->accounting_model->deleteJournal($id)) {
            if ($this->input->is_ajax_request()) {
                $this->sma->send_json(['error' => 0, 'msg' => 'Berhasil hapus Jurnal Umum']);
            }
            $this->session->set_flashdata('message', 'Berhasil hapus Jurnal Umum');
            admin_redirect('accounting/index_journal');
        }
        else {
            if ($this->input->is_ajax_request()) {
                $this->sma->send_json(['error' => 1, 'msg' => 'Gagal hapus Jurnal Umum']);
            }
            $this->session->set_flashdata('message', 'Gagal hapus Jurnal Umum');
            admin_redirect('accounting/index_journal');
        }
    }
}

?>