$ideaText = $('#idea-text');
$ideaSubmit = $('#idea-submit');
$ideaList = $('#ideas');

$ideaSubmit.on('click', function (e) {
  e.preventDefault();
  var idea =  { idea: $ideaText.val(), status: 'incomplete' };
  $.post('/idea.json', idea)
    .done(addIdea)
    .fail(function () {
      alert('Oh noes!');
    });
});

function addIdea(data) {
  data = JSON.parse(data);
  $ideaList.append('<li class="idea">' + data.idea + '</li>')
}