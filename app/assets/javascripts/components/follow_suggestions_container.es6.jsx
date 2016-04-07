class FollowSuggestionsContainer extends React.Component {
  constructor(props) {
    super(props);

    this.state = { users: [] };
  }

  componentWillMount() {
    this.fetchUsers();
  }

  fetchUsers() {
    $.ajax({
      url: '/api/follow_suggestions.json',
      method: 'GET', 
      dataType: 'json',
      success: (data) => {
        console.log(data);
        this.setState({ users: data });
      }
    });
  }

  render () {
    return (
      <div className="follow-suggestions-container">
        {this.renderSuggestions()}
      </div>
    );
  }

  renderSuggestions() {
    return this.state.users.slice(0, 3).map(user => {
      return <SuggestionItem key={user.id} {...user} />
    });
  }
}

