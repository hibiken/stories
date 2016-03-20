class OverlayTriggerButton extends React.Component {
  constructor(props) {
    super(props);

    this.state = { isOpen: false, users: [], currentPage: null, nextPage: null };

    this.handleCloseClick = this.handleCloseClick.bind(this);
    this.handleOpenClick = this.handleOpenClick.bind(this);
    this.handlePrevClick = this.handlePrevClick.bind(this);
    this.handleNextClick = this.handleNextClick.bind(this);
  }

  render () {
    if (this.state.isOpen) {
      return (
        <span>
          <span dangerouslySetInnerHTML={ {__html: this.props.text} }>
          </span>
          <div className="overlay overlay-hugeinc open">
            <button className="overlay-close" onClick={this.handleCloseClick}>
              <span className="glyphicon glyphicon-remove"></span>
            </button>
            <nav className="users-overlay">
              <h2 className="grayed-heading center">{this.props.overlayHeading}</h2>
              <ul>
                {this.renderUsers()}
                <li className="pagination-button-group">
                  {this.renderPrevButton()}
                  {this.renderNextButton()}
                </li>
              </ul>
            </nav>
          </div>
        </span>
      );
    } else {
      return (
        <span>
          <span dangerouslySetInnerHTML={ {__html: this.props.text} } onClick={this.handleOpenClick}>
          </span>
          <div className="overlay overlay-hugeinc">
            <button className="overlay-close" onClick={this.handleCloseClick}>
              <span className="glyphicon glyphicon-remove"></span>
            </button>
            <nav className="users-overlay">
              <h2 className="grayed-heading center">{this.props.overlayHeading}</h2>
              <ul>
              </ul>
            </nav>
          </div>
        </span>
      );
    }
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

  handleOpenClick(event) {
    $.ajax({
      url: this.props.apiEndpoint,
      method: 'GET',
      dataType: 'json',
      success: (data) => {
        if (data.length) {
          this.setState({
            isOpen: true,
            users: data,
            currentPage: data[0].currentPage,
            nextPage: data[0].nextPage
          });
        }
      }
    });
  }

  handleCloseClick(event) {
    this.setState({ isOpen: false });
  }

  handlePrevClick() {
    $.ajax({
      url: `${this.props.apiEndpoint}&page=${this.state.currentPage - 1}`,
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
      url: `${this.props.apiEndpoint}&page=${this.state.nextPage}`,
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


OverlayTriggerButton.propTypes = {
  text: React.PropTypes.oneOfType([React.PropTypes.string, React.PropTypes.number]).isRequired,
  overlayHeading: React.PropTypes.string,
  apiEndpoint: React.PropTypes.string.isRequired
};
