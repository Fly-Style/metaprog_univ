/**
 * Created by flystyle on 14.12.16.
 */

var currentValue = 1, summ = 0;


var betClientValidation = function (value) {
    const currentBalance = parseInt($("#balance-bar").html().replace( /^\D+/g, ''));
    return currentBalance > value;
};

var makeBet = function() {

    var arr = [];

    $("table").find('.clearable').each(function () {
        if($(this).val() > 0) {
            $this = $(this);
            summ += parseInt($this.val());
        }
    });

    $("table").find('.ride').each(function () {
        $this = $(this);
        if ($this.parents('tr').find('#chance-one').hasClass('active')) {
            var json = JSON.stringify({
                ride_id : parseInt($this[0].innerText),
                bet_winner : 1
            });
            arr.push(json);
        }
        else if ($this.parents('tr').find('#chance-two').hasClass('active')){
            var json = JSON.stringify({
                ride_id : parseInt($this[0].innerText),
                bet_winner : 2
            });
            arr.push(json);
        }
    });


    if (betClientValidation(summ) != true) {
        $('.user-fail').show();
        $("table").find('.clearable').each(function () {
        $(this).val('');
    });
        return
    }
    else $(".user-fail").hide();

    summ = betClientValidation(summ) ? summ : 0;
    const betValue = summ * currentValue;
    var username = $('#usr-name').html();
    username = username.split(", ")[1];

    console.log(arr);

    var json = JSON.stringify({
            expressValue: summ,
            potentialWin : betValue,
            ridesIdArray : arr,
            user_name : username
        }
    );

    $.ajax({
            "type": "POST",
            "dataType": "json",
            "url": "/sessions/makebet",
            "data": json,
            "beforeSend" : function (xhr, settings) {
                location.reload(true);
            },
            "success": function(result) {
                console.log(result);
                //location.reload(true);
            },
    });

    summ = 0;
    currentValue = 1;

};

$('.chance').click(function () {
    $this = $(this);
    console.log("here")
    if ($this.hasClass('active')) {
        console.log("here-1")
        $this.removeClass('active');
        var _str = $this.html().replace(",", ".");
        console.log(_str)
        currentValue /= parseFloat(_str);
    }

    else if ($this.parents('tr').find('.chance').hasClass('active')) {
        console.log("here-2")
        $this.parents('tr').find('.chance').removeClass('active');
        $this.addClass('active');
        var $neighbour = 0;
        $this.parents('tr').find('.chance').each(function () {
            if (!$(this).hasClass('active')) {
                var str = $neighbour.replace(",", ".");
                $neighbour = parseFloat(str);
            }
        });
        currentValue /= $neighbour;
        currentValue *= parseFloat($this.html().replace(',', '.'));
    }
    else {
        console.log("here-3")
        $this.addClass('active');
        var str_ = $this.html().replace(",", ".");
        console.log(str_);
        currentValue *= parseFloat(str_);
        console.log(currentValue);
    }

});
