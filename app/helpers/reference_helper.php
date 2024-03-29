<?php

defined('BASEPATH') or exit('No direct script access allowed');

if (!function_exists('generate_ref')) {
    function generate_ref($no, $prefix, $date = null)
    {
        $mo_romawi = ['','I','II','III','IV','V','VI','VII','VIII','IX','X','XI','XII'];
        if(!isset($date)){
            $date = date("Y-m-d");
        }
        $mo = date("n", strtotime($date));
        $year = date("Y", strtotime($date));
        $ref_arr = [$no, $prefix, 'WTPS', $mo_romawi[$mo], $year];

        $ref = implode("/", $ref_arr);
        return $ref;
    }
}

?>