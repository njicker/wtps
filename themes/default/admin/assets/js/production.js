function add_production_item(item) {
    let list_wh = $("#list_warehouse").clone();
    let wh = $(list_wh[0].outerHTML).css("display", "block").prop("id", "");
    let tr = "<tr>";
        tr += "<td>";
            tr += item.row.code + " - " + item.row.name;
            tr += "<input type='hidden' name='product_id[]' value='" + item.row.id + "'>";
            tr += "<input type='hidden' name='product_code[]' value='" + item.row.code + "'>";
            tr += "<input type='hidden' name='type_item[]' value='raw'>";
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
            tr += "<span class='fa fa-trash' style='cursor:pointer;' onclick='removeRowProduction(this)'></span>";
        tr += "</td>";
        tr += "</tr>";
    $("#poTable tbody").append(tr);

    return true;
}

function add_finish_item(item) {
    let list_wh = $("#list_warehouse").clone();
    let wh = $(list_wh[0].outerHTML).css("display", "block").prop("id", "");
    let tr = "<tr>";
        tr += "<td>";
            tr += item.row.code + " - " + item.row.name;
            tr += "<input type='hidden' name='product_id[]' value='" + item.row.id + "'>";
            tr += "<input type='hidden' name='product_code[]' value='" + item.row.code + "'>";
            tr += "<input type='hidden' name='type_item[]' value='goods'>";
        tr += "</td>";
        tr += "<td>";
            tr += "<input type='number' name='qty[]' class='form-control' required='required'>";
        tr += "</td>";
        tr += "<td>";
            tr += "<select class='form-control' name='unit[]' required='required'>";
                tr += "<option value='" + item.units.id + "," + item.units.code + "'>" + item.units.code + "</option>";
                // if(item.units.base_unit != null){
                //     tr += "<option value='" + item.units.base_unit + "," + item.units.base_unit_code + "'>" + item.units.base_unit_code + "</option>";
                // }
            tr += "</select>";
        tr += "</td>";
        tr += "<td>";
            tr += wh[0].outerHTML;
        tr += "</td>";
        tr += "<td>";
            tr += "<span class='fa fa-trash' style='cursor:pointer;' onclick='removeRowProduction(this)'></span>";
        tr += "</td>";
        tr += "</tr>";
    $("#poTable tbody").append(tr);

    return true;
}

function removeRowProduction(elm){
    $(elm).closest("tr").remove();
}