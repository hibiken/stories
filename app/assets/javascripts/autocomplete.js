$autocompleteItems = $('<div id="autocomplete-items"></div>');
$postItemWrapper = $('<ul class="post-items"><li id="autocomplete-posts"><h4>Posts</h4></li></ul>');

var Autocomplete = {
  setup: function() {
    // $("#search_q").autocomplete({
    //   source: '/autocomplete',
    //   minLength: 2
    // });
    
    $("#search_q").keydown(function() {
      Autocomplete.getData($("#search_q").val());
    });
  },

  getData: function(term) {
    $.ajax({
      url: '/autocomplete.json?term=' + term,
      dataType: "JSON",
      method: "GET",
      success: Autocomplete.render
    });
  },

  render: function(data) {
    console.log(data);
    var posts = data['posts'];
    var users = data['users'];
    console.log(posts);
    console.log(users);
    var imageTag;
    var items = $.map(posts, function(post) {
      imageTag = '<img width="35" class="avatar-image" src="' + post.avatar_url + '"/>';
      return '<li><a href="' + post.url + '">' + imageTag + post.title + '</a></li>';
    });
    var userItems = $.map(users, function(user) {
      avatarTag = '<img width="35" class="avatar-image" src="' + user.avatar_url + '"/>';
      return '<li><a href="#">' + user.username + '</a></li>';
    });

    if (items.length > 0) {
      $autocompleteItems.html(items.join(' '));
      $('#main-searchbar').after($autocompleteItems);
      $autocompleteItems.show();
    } else {
      $('#autocomplete-items').html('');
      $autocompleteItems.hide();
    }
  }
};

$(document).ready(Autocomplete.setup);
$(document).on('page:load', Autocomplete.setup);

