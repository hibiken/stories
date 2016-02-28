class SearchResultsList extends React.Component {

  render() {
    return (
      <ul className="dropdown-menu" id="autocomplete-items">
        <li>
          <a href={`/search?q=${this.props.term}`}>
            <span className="glyphicon glyphicon-search"></span> Search for <strong>{this.props.term}</strong>
          </a>
        </li>
        {this.renderPostHeading()}
        {this.renderPosts()}
        {this.renderUserHeading()}
        {this.renderUsers()}
      </ul>
    );
  }

  renderPosts() {
   return this.props.posts.slice(0, 3).map((post) => {
      return <SearchPostListItem key={post.id} post={post} />
    });
  }

  renderUsers() {
    return this.props.users.slice(0, 3).map((user) => {
      return <SearchUserListItem key={user.id} user={user} />
    });
  }

  renderPostHeading() {
    if (this.props.posts.length === 0) { return; }

    return <li><h4 className="autocomplete-heading">Posts</h4></li>
  }

  renderUserHeading() {
    if (this.props.users.length === 0) { return; }

    return <li><h4 className="autocomplete-heading">People</h4></li>
  }
}

