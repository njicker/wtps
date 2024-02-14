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
        if($this->db->insert('journal', $header)){
            $id = $this->db->insert_id();
            // var_dump($id);exit;
            foreach($detail as $d){
                $d['journal_id'] = $id;
                $this->db->insert('journal_items', $d);
            }
            $type = 'RFP';
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
        if($this->db->update('journal', $header, ['id', $id])){
            if($this->db->delete('journal_items', ['journal_id' => $id]))
            {
                foreach($detail as $d){
                    $d['journal_id'] = $id;
                    $this->db->insert('journal_items', $d);
                }
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
        if($this->db->delete('journal', ['id', $id])){
            if($this->db->delete('journal_items', ['journal_id' => $id]))
            {
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