// Twitter Typeahead
$(document).ready(function() {
  var substringMatcher = function(strs) {
    return function findMatches(q, cb) {
      var matches, substringRegex;
      matches = [];
      substrRegex = new RegExp(q, 'i');
      $.each(strs, function(i, str) {
        if (substrRegex.test(str)) {
          matches.push({ value: str });
        }
      });
      cb(matches);
    };
  };
  var logos = gon.logos;
  var teams = gon.teams;
  $('.typeahead').typeahead({
    hint: true,
    highlight: true,
    minLength: 1,
  },

  {
    name: 'teams',
    displayKey: 'value',
    source: substringMatcher(teams),
    templates: {
      empty: [
        '<div class="empty-message">',
        'No team matches found.',
        '</div>'
      ].join('\n'),
      suggestion: function(team){
        return  '<div id="user-selection">' +
                '<img src="' + logos[teams.indexOf(team.value)] + '"/>' +
                '<p><strong>' + team.value + '</strong></p>' +
                '</div>' ;
      }
    }
  });
});