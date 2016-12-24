
/**
 * Created by flystyle on 23.11.16.
 */

$(".bet-btn").click(function() {
    var $tbl = $(this).closest("tr")   // Finds the closest row <tr>
    const $item = $tbl.find('#usr-f').val()
    const $item2 = $tbl.find('#usr-s').val()
    const $ride_id = $tbl.find('.ride').html()

    var json = JSON.stringify({
        first : $item,
        second : $item2,
        ride_id : $ride_id
    });


    $.ajax({
        "type": "POST",
        "dataType": "json",
        "url": "/ru/polls/prediction",
        "data": json,
        "beforeSend" : function (xhr) {
            console.log("Before Send");
            console.log(xhr);
            location.reload(true);
        },
        "success": function(result) {
            location.reload(true);
        },
    });
});