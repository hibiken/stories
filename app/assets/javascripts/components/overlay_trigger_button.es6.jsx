class OverlayTriggerButton extends React.Component {
  constructor(props) {
    super(props);

    this.state = { isOpen: false, users: [] };
  }

  render () {
    if (this.state.isOpen) {
      return (
        <span>
          <span dangerouslySetInnerHTML={ {__html: this.props.text} }>
          </span>
          <div className="overlay overlay-hugeinc open">
            <button className="overlay-close" onClick={this.handleCloseClick.bind(this)}>
              <span className="glyphicon glyphicon-remove"></span>
            </button>
            <nav className="users-overlay">
              <h2 className="grayed-heading center">{this.props.overlayHeading}</h2>
              <ul>
                {this.renderUsers()}
              </ul>
            </nav>
          </div>
        </span>
      );
    } else {
      return (
        <span>
          <span dangerouslySetInnerHTML={ {__html: this.props.text} } onClick={this.handleOpenClick.bind(this)}>
          </span>
          <div className="overlay overlay-hugeinc">
            <button className="overlay-close" onClick={this.handleCloseClick.bind(this)}>
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
          <a href={user.urlPath}>
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

  handleOpenClick(event) {
    $.ajax({
      url: this.props.apiEndpoint,
      method: 'GET',
      dataType: 'json',
      success: (data) => {
        console.log(data);
        this.setState({ isOpen: true, users: data });
      }
    });
  }

  handleCloseClick(event) {
    this.setState({ isOpen: false });
  }

}


OverlayTriggerButton.propTypes = {
  text: React.PropTypes.string,
  overlayHeading: React.PropTypes.string,
  apiEndpoint: React.PropTypes.string.isRequired
};
