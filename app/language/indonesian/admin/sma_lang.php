<?php

defined('BASEPATH') or exit('No direct script access allowed');

/*
 * Package:
 * Stock Manage Advance v3.0
 * Language: Indonesia
 * Module: General Language File for common lang keys
 *
 * Last edited:
 * 8th November 2018
 *
 * Package:
 * Stock Manage Advance v3.0
 *
 * Translated by:
 * Bram Andrian (barulaku) bram.andrian@gmail.com
 *
 * You can translate this file to your language.
 * For instruction on new language setup, please visit the documentations.
 * You also can share your language files by emailing to saleem@tecdiary.com
 * Thank you
 */

/* --------------------- CUSTOM FIELDS ------------------------ */
/*
* Below are custome field labels
* Please only change the part after = and make sure you change the the words in between "";
* $lang['bcf1']                         = "Biller Custom Field 1";
* Don't change this                     = "You can change this part";
* For support email contact@tecdiary.com Thank you!
*/

$lang['bcf1'] = 'Biller Custom Field 1';
$lang['bcf2'] = 'Biller Custom Field 2';
$lang['bcf3'] = 'Biller Custom Field 3';
$lang['bcf4'] = 'Biller Custom Field 4';
$lang['bcf5'] = 'Biller Custom Field 5';
$lang['bcf6'] = 'Biller Custom Field 6';
$lang['pcf1'] = 'Produk Custom Field 1';
$lang['pcf2'] = 'Produk Custom Field 2';
$lang['pcf3'] = 'Produk Custom Field 3';
$lang['pcf4'] = 'Produk Custom Field 4';
$lang['pcf5'] = 'Produk Custom Field 5';
$lang['pcf6'] = 'Produk Custom Field 6';
$lang['ccf1'] = 'Konsumen Custom Field 1';
$lang['ccf2'] = 'Konsumen Custom Field 2';
$lang['ccf3'] = 'Konsumen Custom Field 3';
$lang['ccf4'] = 'Konsumen Custom Field 4';
$lang['ccf5'] = 'Konsumen Custom Field 5';
$lang['ccf6'] = 'Konsumen Custom Field 6';
$lang['scf1'] = 'Pemasok Custom Field 1';
$lang['scf2'] = 'Pemasok Custom Field 2';
$lang['scf3'] = 'Pemasok Custom Field 3';
$lang['scf4'] = 'Pemasok Custom Field 4';
$lang['scf5'] = 'Pemasok Custom Field 5';
$lang['scf6'] = 'Pemasok Custom Field 6';

/* ----------------- DATATABLES LANGUAGE ---------------------- */
/*
* Below are datatables language entries
* Please only change the part after = and make sure you change the the words in between "";
* 'sEmptyTable'                     => "No data available in table",
* Don't change this                 => "You can change this part but not the word between and ending with _ like _START_;
* For support email support@tecdiary.com Thank you!
*/

$lang['datatables_lang'] = [
    'sEmptyTable'     => 'Tidak ada data tersedia di tabel',
    'sInfo'           => 'Menampilkan _START_ ke _END_ dari _TOTAL_ data',
    'sInfoEmpty'      => 'Menampilkan 0 ke 0 dari 0 data',
    'sInfoFiltered'   => '(dipilah dari _MAX_ total data)',
    'sInfoPostFix'    => '',
    'sInfoThousands'  => ',',
    'sLengthMenu'     => 'Menampilkan _MENU_ ',
    'sLoadingRecords' => 'Memuat...',
    'sProcessing'     => 'Proses...',
    'sSearch'         => 'Cari',
    'sZeroRecords'    => 'Tidak ada catatan yang cocok ditemukan',
    'oAria'           => [
        'sSortAscending'  => ': aktifkan untuk mengurutkan kolom naik',
        'sSortDescending' => ': aktifkan untuk mengurutkan kolom turun',
    ],
    'oPaginate' => [
        'sFirst'    => '<< Awal',
        'sLast'     => 'Terakhir >>',
        'sNext'     => 'Berikutnya >',
        'sPrevious' => '< Sebelumnya',
    ],
];

/* ----------------- Select2 LANGUAGE ---------------------- */
/*
* Below are select2 lib language entries
* Please only change the part after = and make sure you change the the words in between "";
* 's2_errorLoading'                 => "The results could not be loaded",
* Don't change this                 => "You can change this part but not the word between {} like {t};
* For support email support@tecdiary.com Thank you!
*/

$lang['select2_lang'] = [
    'formatMatches_s'         => 'Satu hasil tersedia, tekan enter untuk memilihnya.',
    'formatMatches_p'         => 'hasil tersedia, gunakan tombol panah atas dan bawah untuk menavigasi.',
    'formatNoMatches'         => 'Tidak ditemukan kecocokan',
    'formatInputTooShort'     => 'Silakan ketik {n} atau lebih banyak karakter',
    'formatInputTooLong_s'    => 'Silakan hapus {n} karakter',
    'formatInputTooLong_p'    => 'Silakan hapus {n} karakter',
    'formatSelectionTooBig_s' => 'Anda hanya dapat memilih {n} item',
    'formatSelectionTooBig_p' => 'Anda hanya dapat memilih {n} items',
    'formatLoadMore'          => 'Memuat lebih banyak hasil...',
    'formatAjaxError'         => 'Permintaan Ajax gagal',
    'formatSearching'         => 'Pencarian...',
];

/* ----------------- SMA GENERAL LANGUAGE KEYS -------------------- */

$lang['home']                             = 'Home';
$lang['dashboard']                        = 'Dashboard';
$lang['username']                         = 'Username / NIK';
$lang['password']                         = 'Password';
$lang['first_name']                       = 'Nama Depan';
$lang['last_name']                        = 'Nama Belakang';
$lang['confirm_password']                 = 'Konfirmasi Password';
$lang['email']                            = 'Email';
$lang['phone']                            = 'Phone / HP';
$lang['company']                          = 'Perusahaan';
$lang['ktp']                              = 'KTP';
$lang['department']                       = 'Department';
$lang['product_code']                     = 'Kode Produk';
$lang['product_name']                     = 'Nama Produk';
$lang['cname']                            = 'Nama Konsumen';
$lang['barcode_symbology']                = 'Barcode Symbology';
$lang['product_unit']                     = 'Produk Unit';
$lang['product_price']                    = 'Produk Harga';
$lang['contact_person']                   = 'Kontak Person';
$lang['email_address']                    = 'Alamat Email';
$lang['address']                          = 'Alamat';
$lang['city']                             = 'Kota';
$lang['today']                            = 'Hari ini';
$lang['welcome']                          = 'Selamat Datang';
$lang['profile']                          = 'Profile';
$lang['change_password']                  = 'Ubah Password';
$lang['logout']                           = 'Logout';
$lang['notifications']                    = 'Pemberitahuan';
$lang['calendar']                         = 'Kalendar';
$lang['messages']                         = 'Pesan';
$lang['styles']                           = 'Styles';
$lang['language']                         = 'Bahasa';
$lang['alerts']                           = 'Peringatan';
$lang['list_products']                    = 'Daftar Produk';
$lang['add_product']                      = 'Tambah Produk';
$lang['print_barcodes']                   = 'Print Barcodes';
$lang['print_labels']                     = 'Print Labels';
$lang['import_products']                  = 'Import Produk';
$lang['update_price']                     = 'Update Harga';
$lang['damage_products']                  = 'Damage Produk';
$lang['sales']                            = 'Penjualan';
$lang['list_sales']                       = 'Daftar Penjualan';
$lang['add_sale']                         = 'Tambah Penjualan';
$lang['deliveries']                       = 'Pengiriman';
$lang['gift_cards']                       = 'Gift Cards';
$lang['quotes']                           = 'Pesanan';
$lang['list_quotes']                      = 'Daftar Pesanan';
$lang['add_quote']                        = 'Tambah Pesanan';
$lang['purchases']                        = 'Pembelian';
$lang['list_purchases']                   = 'Daftar Pembelian';
$lang['add_purchase']                     = 'Tambah Pembelian';
$lang['add_purchase_by_csv']              = 'Tambah Pembelian via CSV';
$lang['transfers']                        = 'Transfer';
$lang['list_transfers']                   = 'Daftar Transfer';
$lang['add_transfer']                     = 'Tambah Transfer';
$lang['add_transfer_by_csv']              = 'Tambah Transfer via CSV';
$lang['people']                           = 'SDM';
$lang['list_users']                       = 'Daftar Karyawan';
$lang['new_user']                         = 'Tambah Karyawan';
$lang['list_billers']                     = 'Daftar Billers';
$lang['add_biller']                       = 'Tambah Billers';
$lang['list_customers']                   = 'Daftar Pelanggan';
$lang['add_customer']                     = 'Tambah Pelanggan';
$lang['list_suppliers']                   = 'Daftar Suppliers';
$lang['add_supplier']                     = 'Tambah Suppliers';
$lang['settings']                         = 'Setting';
$lang['system_settings']                  = 'Setting Sistem';
$lang['change_logo']                      = 'Ubah Logo';
$lang['currencies']                       = 'Mata Uang';
$lang['attributes']                       = 'Varian Produk';
$lang['customer_groups']                  = 'Groups Konsumen';
$lang['categories']                       = 'Kategori';
$lang['subcategories']                    = 'Sub Kategori';
$lang['tax_rates']                        = 'Rate Pajak';
$lang['warehouses']                       = 'Gudang';
$lang['email_templates']                  = 'Template Email';
$lang['group_permissions']                = 'Hak Akses Group';
$lang['backup_database']                  = 'Backup Database';
$lang['reports']                          = 'Laporan';
$lang['overview_chart']                   = 'Grafis Iktisar';
$lang['warehouse_stock']                  = 'Grafis Stok Gudang';
$lang['product_quantity_alerts']          = 'Peringatan Kuantitas Produk';
$lang['product_expiry_alerts']            = 'Peringatan Produk Kadaluarsa';
$lang['products_report']                  = 'Laporan Produk';
$lang['daily_sales']                      = 'Penjualan Harian';
$lang['monthly_sales']                    = 'Penjualan Bulanan';
$lang['sales_report']                     = 'Laporan Penjualan';
$lang['payments_report']                  = 'Laporan Pembayaran';
$lang['profit_and_loss']                  = 'Untung dan/atau Rugi';
$lang['purchases_report']                 = 'Laporan Pembelian';
$lang['customers_report']                 = 'Laporan Konsumen';
$lang['suppliers_report']                 = 'Pemasok Report';
$lang['staff_report']                     = 'Staff Report';
$lang['your_ip']                          = 'Your IP Address';
$lang['last_login_at']                    = 'Login terakhir pada';
$lang['notification_post_at']             = 'Notifikasi dikirim pada';
$lang['quick_links']                      = 'Jalur Cepat';
$lang['date']                             = 'Tanggal';
$lang['reference_no']                     = 'No Referensi';
$lang['products']                         = 'Produk';
$lang['customers']                        = 'Pelanggan';
$lang['suppliers']                        = 'Suppliers';
$lang['users']                            = 'Pengguna';
$lang['latest_five']                      = 'Lima Terakhir';
$lang['total']                            = 'Total';
$lang['payment_status']                   = 'Status Terbayar';
$lang['paid']                             = 'Terbayar';
$lang['customer']                         = 'Pelanggan';
$lang['status']                           = 'Status';
$lang['amount']                           = 'Jumlah';
$lang['supplier']                         = 'Pemasok';
$lang['from']                             = 'Dari';
$lang['to']                               = 'Ke';
$lang['name']                             = 'Nama';
$lang['create_user']                      = 'Tambah Pengguna';
$lang['gender']                           = 'Jenis Kelamin';
$lang['biller']                           = 'Bill To';
$lang['select']                           = 'Pilih';
$lang['warehouse']                        = 'Gudang';
$lang['active']                           = 'Aktif';
$lang['inactive']                         = 'Tidak Aktif';
$lang['all']                              = 'Semua';
$lang['list_results']                     = 'Silakan gunakan tabel di bawah ini untuk menavigasi atau menyaring hasil. Anda dapat mengunduh tabel sebagai excel dan pdf.';
$lang['actions']                          = 'Action';
$lang['pos']                              = 'POS';
$lang['access_denied']                    = 'Akses Ditolak! Anda tidak memiliki hak untuk mengakses halaman yang diminta. Jika Anda berpikir, itu karena kesalahan, silakan hubungi administrator.';
$lang['add']                              = 'Tambah';
$lang['edit']                             = 'Ubah';
$lang['delete']                           = 'Hapus';
$lang['view']                             = 'Lihat';
$lang['update']                           = 'Ubah';
$lang['save']                             = 'Simpan';
$lang['login']                            = 'Login';
$lang['submit']                           = 'Kirim';
$lang['no']                               = 'No';
$lang['yes']                              = 'Ya';
$lang['disable']                          = 'Disable';
$lang['enable']                           = 'Enable';
$lang['enter_info']                       = 'Silakan isi informasi di bawah ini. Label lapangan yang ditandai dengan * adalah kolom input yang diperlukan.';
$lang['update_info']                      = 'Silakan perbarui informasi di bawah ini. Label Kolom yang ditandai dengan * adalah kolom input yang diperlukan.';
$lang['no_suggestions']                   = 'Tidak dapat memperoleh data untuk saran, Silakan periksa masukan Anda';
$lang['i_m_sure']                         = 'Ya, saya yakin';
$lang['r_u_sure']                         = 'Anda yakin?';
$lang['export_to_excel']                  = 'Export ke file Excel';
$lang['export_to_pdf']                    = 'Export ke file PDF';
$lang['image']                            = 'Image';
$lang['sale']                             = 'Penjualan';
$lang['quote']                            = 'Pemesanan';
$lang['purchase']                         = 'Pembelian';
$lang['transfer']                         = 'Transfer';
$lang['payment']                          = 'Pembayaran';
$lang['payments']                         = 'Pembayaran';
$lang['orders']                           = 'Pesanan';
$lang['pdf']                              = 'PDF';
$lang['vat_no']                           = 'NPWP';
$lang['country']                          = 'Negara';
$lang['add_user']                         = 'Tambah Pengguna';
$lang['type']                             = 'Tipe';
$lang['person']                           = 'Person';
$lang['state']                            = 'Propinsi';
$lang['postal_code']                      = 'Kode Pos';
$lang['id']                               = 'ID';
$lang['close']                            = 'Tutup';
$lang['male']                             = 'Pria';
$lang['female']                           = 'Wanita';
$lang['notify_user']                      = 'Notify Pengguna';
$lang['notify_user_by_email']             = 'Beritahu Pengguna melalui Email';
$lang['billers']                          = 'Pemasok';
$lang['all_warehouses']                   = 'Semua Gudang';
$lang['category']                         = 'Kategori';
$lang['product_cost']                     = 'Biaya Produk';
$lang['quantity']                         = 'Kuantitas';
$lang['loading_data_from_server']         = 'Memuat data dari server';
$lang['excel']                            = 'Excel';
$lang['print']                            = 'Print';
$lang['ajax_error']                       = 'Terjadi kesalahan Ajax, Harap baki lagi.';
$lang['product_tax']                      = 'Produk Pajak';
$lang['order_tax']                        = 'Pesan Pajak';
$lang['upload_file']                      = 'Upload File';
$lang['download_sample_file']             = 'Unduh Contoh File';
$lang['csv1']                             = 'Baris pertama dalam file csv yang diunduh harus tetap seperti apa adanya. Tolong jangan mengubah urutan kolom.';
$lang['csv2']                             = 'Urutan kolom yang benar adalah';
$lang['csv3']                             = '&amp; Anda harus mengikuti ini. <br> Harap pastikan file csv telah dienkode UTF-8 dan tidak disimpan dengan byte order mark (BOM).';
$lang['import']                           = 'Import';
$lang['note']                             = 'Catatan';
$lang['grand_total']                      = 'Grand Total';
$lang['download_pdf']                     = 'Unduh sebagai PDF';
$lang['no_zero_required']                 = 'Kolom %s diperlukan';
$lang['no_product_found']                 = 'Tidak ada produk yang ditemukan';
$lang['pending']                          = 'Menunggu';
$lang['sent']                             = 'Terkirim';
$lang['completed']                        = 'Selesai';
$lang['shipping']                         = 'Pengiriman';
$lang['add_product_to_order']             = 'Silakan tambahkan produk ke daftar pesanan';
$lang['order_items']                      = 'Item Pesanan';
$lang['net_unit_cost']                    = 'Harga Unit Bersih';
$lang['net_unit_price']                   = 'Harga Satuan Bersih';
$lang['expiry_date']                      = 'Tanggal Kedaluwarsa';
$lang['subtotal']                         = 'Subtotal';
$lang['reset']                            = 'Reset';
$lang['items']                            = 'Items';
$lang['au_pr_name_tip']                   = 'Silakan mulai ketik kode / nama untuk saran atau scan barcode';
$lang['no_match_found']                   = 'Tidak ditemukan hasil yang cocok! Produk mungkin kehabisan stok di gudang yang dipilih.';
$lang['csv_file']                         = 'File CSV';
$lang['document']                         = 'Lampiran Dokumen';
$lang['product']                          = 'Produk';
$lang['user']                             = 'Pengguna';
$lang['created_by']                       = 'Dibuat oleh';
$lang['loading_data']                     = 'Memuat data tabel dari server';
$lang['tel']                              = 'Telpon';
$lang['ref']                              = 'Referensi';
$lang['description']                      = 'Deskripsi';
$lang['code']                             = 'Code';
$lang['tax']                              = 'Pajak';
$lang['unit_price']                       = 'Harga Satuan';
$lang['discount']                         = 'Diskon';
$lang['order_discount']                   = 'Order Diskon';
$lang['total_amount']                     = 'Jumlah Total';
$lang['download_excel']                   = 'Unguh sebagai Excel';
$lang['subject']                          = 'Subjek';
$lang['cc']                               = 'CC';
$lang['bcc']                              = 'BCC';
$lang['message']                          = 'Pesan';
$lang['show_bcc']                         = 'Tampilkan/Sembunyikan BCC';
$lang['price']                            = 'Harga';
$lang['add_product_manually']             = 'Tambah Produk Manual';
$lang['currency']                         = 'Currency';
$lang['product_discount']                 = 'Produk Diskon';
$lang['email_sent']                       = 'Email sukses terkirim';
$lang['add_event']                        = 'Tambah Kegiatan';
$lang['add_modify_event']                 = 'Tambah/Ubah Kegiatan';
$lang['adding']                           = 'Adding...';
$lang['delete']                           = 'Delete';
$lang['deleting']                         = 'Deleting...';
$lang['calendar_line']                    = 'Please click the date to add/modify the event.';
$lang['discount_label']                   = 'Diskon (5/5%)';
$lang['product_expiry']                   = 'product_expiry';
$lang['unit']                             = 'Unit';
$lang['cost']                             = 'Biaya';
$lang['tax_method']                       = 'Metode Pajak';
$lang['inclusive']                        = 'Inklusif';
$lang['exclusive']                        = 'Eksklusif';
$lang['expiry']                           = 'Kadaluarsa';
$lang['customer_group']                   = 'Group Konsumen';
$lang['is_required']                      = 'diperlukan';
$lang['form_action']                      = 'Form Action';
$lang['return_sales']                     = 'Retur Penjualan';
$lang['list_return_sales']                = 'Daftar Retur Penjualan';
$lang['no_data_available']                = 'Tidak ada data tersedia';
$lang['disabled_in_demo']                 = 'Maaf, fitur ini dinonaktifkan di demo.';
$lang['payment_reference_no']             = 'No Referensi Pembayaran';
$lang['gift_card_no']                     = 'Nomor Gift Card';
$lang['paying_by']                        = 'Metode Pembayaran';
$lang['cash']                             = 'Tunai';
$lang['gift_card']                        = 'Gift Card';
$lang['CC']                               = 'Kartu Kredit';
$lang['cheque']                           = 'Cek';
$lang['cc_no']                            = 'Credit Card No';
$lang['cc_holder']                        = 'Holder Name';
$lang['card_type']                        = 'Card Type';
$lang['Visa']                             = 'Visa';
$lang['MasterCard']                       = 'MasterCard';
$lang['Amex']                             = 'Amex';
$lang['Discover']                         = 'Discover';
$lang['month']                            = 'Bulan';
$lang['year']                             = 'Tahun';
$lang['cvv2']                             = 'CVV2';
$lang['cheque_no']                        = 'Nomor Cek';
$lang['Visa']                             = 'Visa';
$lang['MasterCard']                       = 'MasterCard';
$lang['Amex']                             = 'Amex';
$lang['Discover']                         = 'Ditemukan';
$lang['send_email']                       = 'Kirim Email';
$lang['order_by']                         = 'Dipesan oleh';
$lang['updated_by']                       = 'Diupdate oleh';
$lang['update_at']                        = 'Diupdate pada';
$lang['error_404']                        = '404 Halaman Tidak Ditemukan';
$lang['default_customer_group']           = 'Group Konsumen Default';
$lang['pos_settings']                     = 'Setting POS';
$lang['pos_sales']                        = 'Penjualan POS';
$lang['seller']                           = 'Pejual';
$lang['ip:']                              = 'IP:';
$lang['sp_tax']                           = 'Pajak Produk Terjual';
$lang['pp_tax']                           = 'Pajak Produk yang Dibeli';
$lang['overview_chart_heading']           = 'Bagan Ikhtisar Saham termasuk penjualan bulanan dengan pajak produk dan pajak pesanan (kolom), pembelian (garis) dan nilai saham saat ini berdasarkan biaya dan harga (pie). Anda dapat menyimpan grafik sebagai jpg, png dan pdf.';
$lang['stock_value']                      = 'Nilai Saham';
$lang['stock_value_by_price']             = 'Nilai Saham berdasarkan Harga';
$lang['stock_value_by_cost']              = 'Nilai Saham berdasarkan Biaya';
$lang['sold']                             = 'Dijual';
$lang['purchased']                        = 'Dibeli';
$lang['chart_lable_toggle']               = 'Anda dapat mengubah grafik dengan mengklik legenda grafik. Klik sembarang legenda di atas untuk ditampilkan / sembunyikan dalam bagan.';
$lang['register_report']                  = 'Daftar Laporan';
$lang['sEmptyTable']                      = 'Tidak ada data tersedia di tabel';
$lang['upcoming_events']                  = 'Acara Yang Datang';
$lang['clear_ls']                         = 'Hapus semua data yang disimpan secara lokal';
$lang['clear']                            = 'Clear';
$lang['edit_order_discount']              = 'Edit Diskon Pesanan';
$lang['product_variant']                  = 'Varian Produk';
$lang['product_variants']                 = 'Varian Produk';
$lang['prduct_not_found']                 = 'Produk tidak ditemukan';
$lang['list_open_registers']              = 'Daftar Register Terbuka';
$lang['delivery']                         = 'Pengiriman';
$lang['serial_no']                        = 'Serial Number';
$lang['logo']                             = 'Logo';
$lang['attachment']                       = 'Lampiran';
$lang['balance']                          = 'Balance';
$lang['nothing_found']                    = 'Tidak ditemukan record yang cocok';
$lang['db_restored']                      = 'Basis data berhasil dikembalikan.';
$lang['backups']                          = 'Backups';
$lang['chart']                            = 'Chart';
$lang['received']                         = 'Diterima';
$lang['returned']                         = 'Dikembalikan';
$lang['award_points']                     = 'Award Points';
$lang['expenses']                         = 'Pengeluaran';
$lang['add_expense']                      = 'Tambah Beban';
$lang['other']                            = 'Lainnya';
$lang['none']                             = 'None';
$lang['calculator']                       = 'Calculator';
$lang['updates']                          = 'Edit';
$lang['update_available']                 = 'Pembaruan baru tersedia, perbarui sekarang..';
$lang['please_select_customer_warehouse'] = 'ilakan pilih pelanggan/gudang';
$lang['variants']                         = 'Varian';
$lang['add_sale_by_csv']                  = 'Tambah Penjualan oleh CSV';
$lang['categories_report']                = 'Laporan Kategori';
$lang['adjust_quantity']                  = 'Sesuaikan Kuantitas';
$lang['quantity_adjustments']             = 'Penyesuaian Kuantitas';
$lang['partial']                          = 'Sebagian';
$lang['unexpected_value']                 = 'Nilai tak terduga disediakan!';
$lang['select_above']                     = 'Silakan pilih di atas terlebih dahulu';
$lang['no_user_selected']                 = 'Tidak ada pengguna yang dipilih, silakan pilih setidaknya satu pengguna';
$lang['sale_details']                     = 'Detail Penjualan';
$lang['due']                              = 'Jatuh Tempo';
$lang['ordered']                          = 'Dipesan';
$lang['profit']                           = 'Untung';
$lang['unit_and_net_tip']                 = 'Dihitung berdasarkan harga satuan untuk semua penjualan';
$lang['expiry_alerts']                    = 'Peringatan kedaluwarsa';
$lang['quantity_alerts']                  = 'Peringatan Kuantitas';
$lang['products_sale']                    = 'Pendapatan Produk';
$lang['products_cost']                    = 'Biaya Produk';
$lang['day_profit']                       = 'Untung dan/atau Rugi harian';
$lang['get_day_profit']                   = 'Anda dapat mengklik tanggal untuk mendapatkan laporan laba dan/atau rugi hari ini.';
$lang['combine_to_pdf']                   = 'Gabungkan ke pdf';
$lang['print_barcode_label']              = 'Print Barcode/Label';
$lang['list_gift_cards']                  = 'Daftar Gift Cards';
$lang['today_profit']                     = 'Keuntungan Hari Ini';
$lang['adjustments']                      = 'Penyesuaian';
$lang['download_xls']                     = 'Unduh sebagai XLS';
$lang['browse']                           = 'Browse...';
$lang['transferring']                     = 'Proses Transfer';
$lang['supplier_part_no']                 = 'Pemasok Part No';
$lang['deposit']                          = 'Deposit';
$lang['ppp']                              = 'Paypal Pro';
$lang['stripe']                           = 'Stripe';
$lang['amount_greater_than_deposit']      = 'Jumlah lebih besar dari simpanan pelanggan, silakan coba lagi dengan jumlah yang lebih rendah dari deposit pelanggan.';
$lang['stamp_sign']                       = 'Stamp &amp; Tanda Tangan';
$lang['product_option']                   = 'Varian Produk';
$lang['Cheque']                           = 'Cek';
$lang['sale_reference']                   = 'Referensi Penjualan';
$lang['surcharges']                       = 'Biaya tambahan';
$lang['please_wait']                      = 'Silakan tunggu...';
$lang['list_expenses']                    = 'Daftar Biaya';
$lang['deposit']                          = 'Deposit';
$lang['deposit_amount']                   = 'Jumlah Setoran';
$lang['return_purchases']                 = 'Pembelian Kembali';
$lang['list_return_purchases']            = 'Daftar Pembelian Kembali';
$lang['expense_categories']               = 'Kategori Pengeluaran';
$lang['authorize']                        = 'Authorize.net';
$lang['expenses_report']                  = 'Laporan Biaya';
$lang['expense_categories']               = 'Kategori Pengeluaran';
$lang['edit_event']                       = 'Ubah Acara';
$lang['title']                            = 'Judul';
$lang['event_error']                      = 'Judul & Mulai diperlukan';
$lang['start']                            = 'Mulai';
$lang['end']                              = 'Selesai';
$lang['event_added']                      = 'Acara berhasil ditambah';
$lang['event_updated']                    = 'Acara berhasil diubah';
$lang['event_deleted']                    = 'Acara berhasil dihapus';
$lang['event_color']                      = 'Warna Acara';
$lang['toggle_alignment']                 = 'Toggle Alignment';
$lang['images_location_tip']              = 'Gambar-gambar harus diunggah dalam folder <strong>assets/uploads/</strong> dan thumbnail dengan nama yang sama seperti csv ke <strong>assets/uploads/thumbs/</strong> ';
$lang['this_sale']                        = 'Penjualan Ini';
$lang['return_ref']                       = 'Referensi Kembali';
$lang['return_total']                     = 'Pengembalian Total';
$lang['daily_purchases']                  = 'Pembelian Harian';
$lang['monthly_purchases']                = 'Pembelian Bulanan';
$lang['reference']                        = 'Referensi';
$lang['no_subcategory']                   = 'Tidak ada subkategori';
$lang['returned_items']                   = 'Item yang Dikembalikan';
$lang['return_payments']                  = 'Pembayaran yang Dikembalikan';
$lang['units']                            = 'Unit';
$lang['price_group']                      = 'Grup Harga';
$lang['price_groups']                     = 'Grup Harga';
$lang['no_record_selected']               = 'Tidak ada catatan yang dipilih, silakan pilih setidaknya satu baris';
$lang['brand']                            = 'Merek';
$lang['brands']                           = 'Merek';
$lang['file_x_exist']                     = 'Sistem tidak dapat menemukan file, mungkin dihapus atau dipindahkan.';
$lang['status_updated']                   = 'Status telah berhasil diperbarui';
$lang['x_col_required']                   = 'Kolom %d pertama diperlukan dan semua lainnya opsional.';
$lang['brands_report']                    = 'Laporan Merek';
$lang['add_adjustment']                   = 'Tambah Penyesuaian';
$lang['best_sellers']                     = 'Penjual Terbaik';
$lang['adjustments_report']               = 'Laporan Penyesuaian';
$lang['stock_counts']                     = 'Hitungan Saham';
$lang['count_stock']                      = 'Hitung Stok';
$lang['download']                         = 'Unduh';
$lang['list_printers']                    = 'Daftar Printers';
$lang['add_printer']                      = 'Tambah Printer';
$lang['shop']                             = 'Toko';
$lang['cart']                             = 'Keranjang';
$lang['api_keys']                         = 'API Keys';
$lang['slug']                             = 'Slug';
$lang['symbol']                           = 'Simbol';
$lang['packaging']                        = 'Daftar Packing';
$lang['rack']                             = 'Rak';
$lang['staff_sales']                      = 'Penjualan Staf';
$lang['all_sales']                        = 'Semua Penjualan';
$lang['call_back_heading']                = 'Jika Anda ingin menggunakan auth sosial, url callback Anda harus seperti di bawah ini';
$lang['replace_xxxxxx_with_provider']     = 'Silakan ganti XXXXXX dengan penyedia layanan, Google, Facebook, Twitter, dll.';
$lang['documentation_at']                 = 'Info lebih lanjut di';
$lang['enable_config_file']               = 'Anda dapat mengaktifkan / menonaktifkan penyedia di file konfigurasi berikut';
$lang['sales_x_delivered']                = 'Penjualan tidak terkirim';
$lang['order_item']                       = 'Order Item';
$lang['update_status']                    = 'Update Status';
$lang['purchase_code']                    = 'Pembayaran Code';
$lang['envato_username']                  = 'Envato Username';
$lang['update_successful']                = 'Item berhasil diperbarui';
$lang['using_latest_update']              = 'Anda menggunakan versi terbaru';
$lang['version']                          = 'Versi';
$lang['install']                          = 'Instal';
$lang['changelog']                        = 'Ubah Log';
$lang['update_done']                      = 'Pembaruan telah berhasil diinstal';
$lang['update_heading']                   = 'Halaman ini akan membantu Anda memeriksa dan menginstal pembaruan dengan mudah dengan sekali klik. <strong> Jika ada lebih dari 1 pembaruan yang tersedia, harap perbarui satu per satu mulai dari atas (versi terendah) </ strong>.';

$lang['please_select_these_before_adding_product'] = 'Silakan pilih ini sebelum menambahkan produk apa pun';

$lang['tax_summary']      = 'Resume Pajak';
$lang['qty']              = 'Qty/Weight';
$lang['tax_excl']         = 'Pajak Excl Amt';
$lang['tax_amt']          = 'Pajak Amt';
$lang['total_tax_amount'] = 'Total Jumlah Pajak';
$lang['gst']              = 'GST';
$lang['hsn_code']         = 'Kode HSN';
$lang['cgst']             = 'CGST';
$lang['sgst']             = 'SGST';
$lang['igst']             = 'IGST';
$lang['returns']          = 'Retur';
$lang['list_returns']     = 'Daftar Retur';
$lang['add_return']       = 'Tambah Return';
$lang['tax_report']       = 'Laporan Pajak';
$lang['gst_no']           = 'GST Number';
$lang['no.']              = 'No.';

/* ---------------------- Front End Settings ---------------------- */
$lang['shop']                       = 'Toko';
$lang['shop_sales']                 = 'Penjualan Toko';
$lang['front_end']                  = 'Tatap Muka';
$lang['site_offline']               = 'Site sedang Offline';
$lang['visit_us_later']             = 'Silakan kunjungi kami lagi dalam beberapa hari.';
$lang['shop_settings']              = 'Toko Settings';
$lang['slider_settings']            = 'Setting Slider';
$lang['silder_updated']             = 'Setting Slider diubah';
$lang['list_pages']                 = 'Daftar Halaman';
$lang['add_page']                   = 'Tambah Halaman';
$lang['payment_added']              = 'Pembayaran telah berhasil ditambahkan.';
$lang['payment_failed']             = 'Pembayaran telah gagal, silakan coba lagi nanti atau hubungi administrator.';
$lang['payment_processing']         = 'Pembayaran sedang diproses, setelah selesai, pembayaran akan dicerminkan pada pesanan Anda.';
$lang['theme_color']                = 'Warna Tema';
$lang['thank_you']                  = 'Terima kasih!';
$lang['info']                       = 'INFO!';
$lang['error']                      = 'ERROR!';
$lang['csrf_error']                 = 'CSRF ERROR!';
$lang['csrf_error_msg']             = 'Sesi telah kadaluwarsa dan tindakan yang Anda minta diblokir. Silakan coba lagi!';
$lang['error_404_message']          = '<h4>404 Tidak Ditemukan!</h4><p> Halaman yang Anda cari tidak dapat ditemukan.</p>';
$lang['auto_slugify']               = 'Otomatis Hasilkan dan Perbarui Produk Slugs';
$lang['slugs_updated']              = 'Slug telah diperbarui untuk semua produk';
$lang['settings_updated']           = 'Pengaturan berhasil diperbarui';
$lang['manual_payments']            = 'Pembayaran Manual';
$lang['sitemap']                    = 'Sitemap';
$lang['visit']                      = 'Kunjungi';
$lang['bank_details']               = 'Bank Detail';
$lang['bank_details_tip']           = '(jika Anda ingin menerima pembayaran bank-in / transfer langsung)';
$lang['sms_settings']               = 'SMS Settings';
$lang['sms_log']                    = 'SMS Log';
$lang['send_sms']                   = 'Send SMS';
$lang['search_phone_by_customer']   = 'Cari telepon oleh pelanggan';
$lang['sms_request_sent']           = 'Permintaan SMS telah dikirim ke gateway SMS untuk diproses.';
$lang['sms_request_failed']         = 'Permintaan SMS telah gagal, silakan periksa log sms.';
$lang['sms_log_heading']            = 'Silakan tinjau log SMS di bawah ini, Anda dapat memilih tanggal untuk menampilkan log hari itu.';
$lang['send_sms_heading']           = 'Silakan tambahkan nomor ponsel dengan memilih pelanggan.';
$lang['log_x_exists']               = 'Tidak ada log yang tersedia untuk tanggal yang dipilih.';
$lang['auto_send']                  = 'Kirim SMS Secara Otomatis';
$lang['gateway']                    = 'Gateway';
$lang['api_id']                     = 'API ID';
$lang['mobile']                     = 'Mobile';
$lang['url']                        = 'URL';
$lang['send_to_name']               = 'Nama Dikirim ke';
$lang['msg_name']                   = 'Nama Message';
$lang['param1']                     = 'Param 1';
$lang['param2']                     = 'Param 2';
$lang['param3']                     = 'Param 3';
$lang['param4']                     = 'Param 4';
$lang['param5']                     = 'Param 5';
$lang['eapi_url']                   = 'EAPI_URL';
$lang['sender_id']                  = 'SENDER ID';
$lang['account_sid']                = 'Account SID';
$lang['auth_token']                 = 'Auth Token';
$lang['access_token']               = 'Access Token';
$lang['api_key']                    = 'API KEY';
$lang['api_secret']                 = 'API Secret';
$lang['sid']                        = 'SID';
$lang['gwid']                       = 'GWID';
$lang['domain']                     = 'Domain';
$lang['uid']                        = 'UID';
$lang['pin']                        = 'PIN';
$lang['userid']                     = 'Pengguna ID';
$lang['api_code']                   = 'API Code';
$lang['hide0']                      = 'Sembunyikan Merek/Kategori dengan 0 produk';
$lang['products_description']       = 'Deskripsi halaman produk';
$lang['private_shop']               = 'Toko pribadi (khusus untuk anggota)';
$lang['hide_price']                 = 'Nonaktifkan keranjang & harga';
$lang['login_to_your_account']      = 'Silakan login ke akun Anda.';
$lang['forgot_password_successful'] = 'Email telah dikirim dengan instruksi kata sandi reset';
$lang['accounting']                        = 'Accounting';
$lang['journal']                        = 'Jurnal Umum';
$lang['accounting_report']                        = 'Laporan Accounting';
$lang['chart_hpp_report']                        = 'Grafik Harga Pokok Produksi';
$lang['invoices_report']                        = 'Laporan Tagihan';
$lang['group_account']                        = 'Grup Akun';
$lang['production']                        = 'Produksi';
$lang['invoices']                        = 'Daftar Tagihan';
$lang['hpp']                        = 'Harga Pokok Produksi';