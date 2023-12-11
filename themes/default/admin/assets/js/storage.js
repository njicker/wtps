function add_item(item) {
    let list_wh = $("#list_warehouse").clone();
    let wh = $(list_wh[0].outerHTML).css("display", "block").prop("id", "");
    let tr = "<tr>";
        tr += "<td>";
            tr += item.row.code + " - " + item.row.name;
            tr += "<input type='hidden' name='product_id[]' value='" + item.row.id + "'>";
            tr += "<input type='hidden' name='product_code[]' value='" + item.row.code + "'>";
            tr += "<input type='hidden' name='product_desc[]' value='" + item.row.name + "'>";
        tr += "</td>";
        tr += "<td>";
            tr += "<input type='text' name='product_batch[]' class='form-control' required='required'>";
            tr += "<input type='hidden' name='unit_amount[]' value='" + item.row.real_unit_cost + "'>";
        tr += "</td>";
        tr += "<td>";
            tr += "<input type='number' name='qty[]' class='form-control' required='required'>";
        tr += "</td>";
        tr += "<td>";
            tr += "<select class='form-control' name='unit[]' required='required'>";
                tr += "<option value='" + item.units.id + "," + item.units.code + "'>" + item.units.code + "</option>";
                if(item.units.base_unit != null){
                    tr += "<option value='" + item.units.base_unit + "," + item.units.base_unit_code + "'>" + item.units.base_unit_code + "</option>";
                }
            tr += "</select>";
        tr += "</td>";
        tr += "<td>";
            tr += wh[0].outerHTML;
        tr += "</td>";
        tr += "<td>";
            tr += "<textarea name='note[]' class='form-control'></textarea>";
        tr += "</td>";
        tr += "<td>";
            tr += "<span class='fa fa-trash' style='cursor:pointer;' onclick='removeRow(this)'></span>";
        tr += "</td>";
        tr += "</tr>";
    $("#poTable tbody").append(tr);

    return true;
}

function removeRow(elm){
    $(elm).closest("tr").remove();
}