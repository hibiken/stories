class FollowSuggestionsContainer extends React.Component {
  constructor(props) {
    super(props);

    this.state = { 
      users: [],
      activeUsers: []
    };
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
        const newActives = data.slice(0, 3)
        this.setState({ 
          activeUsers: newActives,
          users: [ ...data.slice(3), ...newActives ]
        });
      }
    });
  }

  render () {
    return (
      <div className="follow-suggestions-container">
        <div className="suggestions-header">
          <h4 className="small-heading">People to follow</h4>
          <a className="refresh-link pull-right" onClick={this.refreshActiveUsers.bind(this)}>Refresh</a>
        </div>
        <div>
          {this.renderSuggestions()}
        </div>
      </div>
    );
  }

  renderSuggestions() {
    return this.state.activeUsers.map(user => {
      return <SuggestionItem key={user.id} {...user} />
    });
  }

  refreshActiveUsers() {
    const newActives = this.state.users.slice(0, 3);
    this.setState({
      activeUsers: newActives,
      users: [ ...this.state.users.slice(3), ...newActives ]
    });
  }

  // replaceUser(id) {
  //   const filteredActives = this.state.activeUsers.filter(user => {
  //     return user.id != id;
  //   });
  //   const filteredUsers = this.state.users.filter(user => {
  //     return user.id != id;
  //   });
  //   this.setState({
  //     users: [ ...filteredUsers.slice(1), filteredUsers[0] ],
  //     activeUsers: [ ...filteredActives, filteredUsers[0] ]
  //   });
  // }

}

