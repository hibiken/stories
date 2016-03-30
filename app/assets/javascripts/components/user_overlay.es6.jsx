class UserOverlay extends React.Component {
  constructor(props) {
    super(props);

    this.state = {
      isOpen: false,
      users: [],
      currentPage: null,
      nextPage: null,
      endpoint: '',
      overlayHeading: ''
    };

    this.handleCloseClick = this.handleCloseClick.bind(this);
    this.handlePrevClick = this.handlePrevClick.bind(this);
    this.handleNextClick = this.handleNextClick.bind(this);
  }

  componentWillMount() {
    this.token = PubSub.subscribe('OverlayTriggerButton:onClick', (msg, data) => {
      const { endpoint, overlayHeading } = data;
      this.fetchUsers(endpoint, overlayHeading);
    })
  }

  componentWillUnmount() {
    PubSub.unsubscribe('OverlayTriggerButton:onClick');
  }

  fetchUsers(endpoint, overlayHeading) {
   $.ajax({
      url: endpoint,
      method: 'GET',
      dataType: 'json',
      success: (data) => {
        if (data.length) {
          this.setState({
            isOpen: true,
            users: data,
            currentPage: data[0].currentPage,
            nextPage: data[0].nextPage,
            endpoint: endpoint,
            overlayHeading: overlayHeading,
          });
        }
      }
    });
  }

  render () {
    return (
      <div className={`overlay overlay-hugeinc ${this.state.isOpen ? 'open' : ''}`}>
        <button className="overlay-close" onClick={this.handleCloseClick}>
          <span className="glyphicon glyphicon-remove"></span>
        </button>
        <nav className="users-overlay">
          <h2 className="grayed-heading center">{this.state.overlayHeading}</h2>
          <ul>
            {this.renderUsers()}
            <li className="pagination-button-group">
              {this.renderPrevButton()}
              {this.renderNextButton()}
            </li>
          </ul>
        </nav>
      </div>
    );
  }

  renderUsers() {
    return this.state.users.map((user) => {
      return (
        <li key={user.id}>
          <div dangerouslySetInnerHTML={this.renderAvatarImage(user)} />
          <a href={user.urlPath} className="overlay-user-info">
            <strong>{user.username}</strong>
            <p>{user.description}</p>
          </a>
          {this.renderUserFollowButton(user)}
        </li>
      );
    });
  }

  renderAvatarImage(user) {
    return {__html: user.avatar_image_tag};
  }

  renderUserFollowButton(user) {
    if (user.isSelf || !window.userSignedIn) { return; }
    return <UserFollowButton following={user.following} followed_id={user.id} />
  }

  renderPrevButton() {
    if (this.state.currentPage > 1) {
      return (
        <a className="button" onClick={this.handlePrevClick}>Prev</a>
      );
    }
  }

  renderNextButton() {
    if (this.state.nextPage !== null) {
      return (
        <a className="button" onClick={this.handleNextClick}>Next</a>
      );
    }
  }

  handleCloseClick(event) {
    this.setState({
      isOpen: false,
      users: [],
      currentPage: null,
      nextPage: null,
      endpoint: '',
      overlayHeading: ''
    });
  }

  handlePrevClick() {
    $.ajax({
      url: `${this.state.endpoint}&page=${this.state.currentPage - 1}`,
      method: 'GET',
      dataType: 'json',
      success: (data) => {
        this.setState({
          users: data,
          currentPage: data[0].currentPage,
          nextPage: data[0].nextPage
        });
      }
    });
  }

  handleNextClick() {
    $.ajax({
      url: `${this.state.endpoint}&page=${this.state.nextPage}`,
      method: 'GET',
      dataType: 'json',
      success: (data) => {
        this.setState({
          users: data,
          currentPage: data[0].currentPage,
          nextPage: data[0].nextPage
        });
      }
    });
  }

}

