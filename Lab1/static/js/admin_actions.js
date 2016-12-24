/**
 * Created by flystyle on 27.11.16.
 */

function makeWinner() {

    var arr = []

    $("table").find('.ride').each(function () {
        var $tbl = $(this).closest("tr")   // Finds the closest row <tr>
        $this = $(this);
        if ($this.parents('tr').find('#chance-one').hasClass('active')) {
            const $ride_id = $tbl.find('.ride').html()
            const raceToWinner = JSON.stringify({
                race_id : parseInt($ride_id),
                winner : 1
            });
           arr.push(raceToWinner);
        }
        else if ($this.parents('tr').find('#chance-two').hasClass('active')){
            const $ride_id = $tbl.find('.ride').html()
            const raceToWinner = JSON.stringify({
                race_id : parseInt($ride_id),
                winner : 2
            });
            arr.push(raceToWinner);
        }
    });

    const json = JSON.stringify({
            arr : arr,
        }
    );

    console.log(json);

    $.ajax({
            "type": "POST",
            "dataType": "json",
            "url": "/ru/polls/endrace",
            "data": json,
            "beforeSend" : function (xhr, settings) {
                location.reload(true);
            },
            "success": function(result) {
                console.log(result);
                //location.reload(true);
            },
    });

}

$('.chance').click(function () {
    $this = $(this);

    if ($this.hasClass('active')) {
        $this.removeClass('active');
    }

    else if ($this.parents('tr').find('.chance').hasClass('active')) {
        $this.parents('tr').find('.chance').removeClass('active');
        $this.addClass('active');
        var $neighbour = 0;
        $this.parents('tr').find('.chance').each(function () {
            if (!$(this).hasClass('active')) {
                $neighbour = $(this).html();
            }
        });
    }
    else {
        $this.addClass('active');
    }

});
