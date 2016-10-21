$(document).on('turbolinks:load', function(event) {
  $('.comment-form').hide();
  $('.reply').click(function() {
    var commentForm = $(this).parentsUntil('article.media').find('.comment-form');
    commentForm.toggle();
    commentForm.find('input[type=text]').focus();
  });
});