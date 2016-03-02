class SearchContainer extends React.Component {
  constructor(props) {
    super(props)

    this.state = { term: '', posts: [], users: [] }
  }

  search(term) {
    this.setState({ term });

    $.ajax({
      url: `/api/autocomplete.json/?term=${term}`,
      method: 'GET',
      success: (data) => { this.setState({
        posts: data.posts,
        users: data.users
      });}
    });
  }

  render () {
    return (
      <div>
        <SearchBar 
          term={this.state.term} 
          onSearchTermChange={(term) => {this.search(term)}}
        />
        {this.renderSearchResults()}
      </div>
    );
  }

  renderSearchResults() {
    if(this.state.posts.length === 0 && this.state.users.length === 0) {
      return;
    }

    return (
      <SearchResultsList 
        term={this.state.term} 
        posts={this.state.posts}
        users={this.state.users}
      />
    );
  }
}

