$(document).on('turbolinks:load', function(event) {
  $('.tabs ul li').click(function() { 
    var tab_id = $(this).attr('data-tab');
    $('.tabs ul li').removeClass('is-active');
    $('.tab-content').removeClass('current');
    $(this).addClass('is-active');
    $("#"+tab_id).addClass('current');
  });
});