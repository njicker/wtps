<?php

defined('BASEPATH') or exit('No direct script access allowed');

class Accounting_model extends CI_Model
{
    public function __construct()
    {
        parent::__construct();
    }

    public function addJournal($header, $detail){
        $this->db->trans_start();
        $type = 'RFP';
        if($this->db->insert('journal', $header)){
            $id = $this->db->insert_id();
            // var_dump($id);exit;
            $dataAcc = array();
            foreach($detail as $d){
                $d['journal_id'] = $id;
                $this->db->insert('journal_items', $d);
                $dtl_id = $this->db->insert_id();

                $no_account = $d['no_account'];
                $type_amount = $d['type_amount'];
                $amount = $d['amount'];
                $acc = [
                    'no_source' => $header['no_journal'],
                    'doc_date' => date("Y-m-d", strtotime($header['doc_date'])),
                    'type_source' => $type,
                    'loc_source' => 'detail',
                    'id_source' => $dtl_id,
                    'division' => $header['division'],
                    'no_account' => $no_account,
                    'type_amount' => $type_amount,
                    'amount' => $amount,
                    'note' => $d['note'],
                    'note_query' => 'field=amount',
                    "created_by" => $this->session->userdata('user_id'),
                ];
                $dataAcc[] = $acc;
            }
            $this->site->postAccounting($dataAcc, false);
            
            $this->site->updateReff($type, $header['doc_date']);
            $this->db->trans_complete();
            if ($this->db->trans_status() === false) {
                log_message('error', 'An errors has been occurred while edit the journal (Add:Accounting_model.php)');
            } else {
                return true;
            }
        }
        return false;
    }

    public function editJournal($id, $header, $detail){
        $this->db->trans_start();
        $type = 'RFP';
        if($this->db->update('journal', $header, ['id' => $id])){
            if($this->db->delete('journal_items', ['journal_id' => $id]))
            {
                $dataAcc = array();
                foreach($detail as $d){
                    $d['journal_id'] = $id;
                    $this->db->insert('journal_items', $d);
                    $dtl_id = $this->db->insert_id();

                    $no_account = $d['no_account'];
                    $type_amount = $d['type_amount'];
                    $amount = $d['amount'];
                    $acc = [
                        'no_source' => $header['no_journal'],
                        'doc_date' => date("Y-m-d", strtotime($header['doc_date'])),
                        'type_source' => $type,
                        'loc_source' => 'detail',
                        'id_source' => $dtl_id,
                        'division' => $header['division'],
                        'no_account' => $no_account,
                        'type_amount' => $type_amount,
                        'amount' => $amount,
                        'note' => $d['note'],
                        'note_query' => 'field=amount',
                        "created_by" => $this->session->userdata('user_id'),
                    ];
                    $dataAcc[] = $acc;
                }
                $edit['no_source'] = $header['no_journal'];
                $this->site->postAccounting($dataAcc, $edit);

                $this->db->trans_complete();
                if ($this->db->trans_status() === false) {
                    log_message('error', 'An errors has been occurred while edit the journal (Edit:Accounting_model.php)');
                } else {
                    return true;
                }
            }
        }
        return false;
    }

    public function deleteJournal($id){
        $this->db->trans_start();

        $jou = $this->getJournal($id);
        $this->site->log('Accounting', ['model' => $jou]);

        if($this->db->delete('journal', ['id' => $id])){
            if($this->db->delete('journal_items', ['journal_id' => $id]))
            {
                $dataAcc = array();
                $edit['no_source'] = $jou->no_journal;
                $this->site->postAccounting($dataAcc, $edit);

                $this->db->trans_complete();
                if ($this->db->trans_status() === false) {
                    log_message('error', 'An errors has been occurred while edit the journal (Edit:Accounting_model.php)');
                } else {
                    return true;
                }
            }
        }
        return false;
    }

    public function getJournal($id)
    {
        $q = $this->db->get_where('journal', ['id' => $id], 1);
        if ($q->num_rows() > 0) {
            return $q->row();
        }
        return false;
    }

    public function getJournalItems($journal_id)
    {
        $this->db->where('journal_id', $journal_id);
        $q = $this->db->get('journal_items');
        if ($q->num_rows() > 0) {
            foreach (($q->result()) as $row) {
                $data[] = $row;
            }
            return $data;
        }
        return false;
    }
}
?>