// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require_tree .


function toggleComment(target) {
	$('#debt'+target).toggle();
	if ($('#debt'+target).is(":visible"))
		$('#text'+target).text('Hide');
	else
		$('#text'+target).text('Contest');
}

function togglePaid() {
	$('#debtsPaid').toggle();
}

function setFocus(target) {
	$('#'+target).addClass('expense_cmt_box_hover');
}

function remFocus(target) {
	$('#'+target).removeClass('expense_cmt_box_hover');
}

    $(function() {
        $(".datepicker").datepicker({dateFormat: 'yy-mm-dd'});
    });


function updateUserDebtSlice() {
	var debtSlices = document.getElementsByClassName("debtSliceField");
	var userDebtSlice = 100;
	$.each( debtSlices, function() {
		userDebtSlice -= this.value;
	});
	userDebtSlice = Math.round(userDebtSlice*100)/100 //rounding
	document.getElementById("userDebt").innerHTML = userDebtSlice+"%";
}