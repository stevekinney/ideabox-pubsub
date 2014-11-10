$ideaText = $('#idea-text');
$ideaSubmit = $('#idea-submit');

$ideaSubmit.on('click', function () {
  alert($ideaText.val());
});