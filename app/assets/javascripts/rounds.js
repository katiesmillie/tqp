


$(document).ready(function() {

$('.month-item').on('hidden', function () {
	var header=$(this).siblings("h4").find("i");
	header.addClass("icon-plus").removeClass("icon-minus");
});

$('.month-item').on('show', function () {
	var header=$(this).siblings("h4").find("i");
	header.addClass("icon-minus").removeClass("icon-show");  
});

// $(".month-item .index-well").on('click', function() {
// 	$(this).css("border-color", "red");
// });

});