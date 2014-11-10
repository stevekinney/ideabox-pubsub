$ideaText = $('#idea-text');
$ideaSubmit = $('#idea-submit');
$ideaList = $('#ideas');

var client = new Faye.Client('/faye');
var subscription = client.subscribe('/ideas', function(idea) {
  addIdea(idea);
});

$ideaSubmit.on('click', function (e) {
  e.preventDefault();
  var idea =  { idea: $ideaText.val(), status: 'incomplete' };
  $.post('/idea.json', idea)
    .done(function (data) {
      client.publish('/ideas', data);
    })
    .fail(function () {
      alert('Oh noes!');
    });
});

function addIdea(data) {
  if (typeof data === 'string') data = JSON.parse(data);
  $ideaList.append('<li class="idea">' + data.idea + '</li>')
}