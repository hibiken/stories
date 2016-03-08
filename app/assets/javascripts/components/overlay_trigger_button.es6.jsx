class OverlayTriggerButton extends React.Component {
  constructor(props) {
    super(props);

    this.state = { isOpen: false, users: [] };
  }

  render () {
    if (this.state.isOpen) {
      return (
        <div>
          <span>
            {this.props.text}
          </span>
          <div data-behavior="overlay" className="overlay overlay-hugeinc open">
            <button className="overlay-close" onClick={this.handleCloseClick.bind(this)}>
              <span className="glyphicon glyphicon-remove"></span>
            </button>
            <nav>
              <h2 className="grayed-heading center">People Liked This Story</h2>
              <ul className="">
                {this.renderLikers()}
              </ul>
            </nav>
          </div>
        </div>
      );
    } else {
      return (
        <div>
          <span onClick={this.handleOpenClick.bind(this)}>
            {this.props.text}
          </span>
          <div className="overlay overlay-hugeinc">
            <button className="overlay-close" onClick={this.handleCloseClick.bind(this)}>
              <span className="glyphicon glyphicon-remove"></span>
            </button>
            <nav>
              <h2 className="grayed-heading center">People Liked This Story</h2>
              <ul className="">
                <li className="">
                  <a href=''></a>
                </li>

                <li className="">
                  <a href=""></a>
                </li>

                <li className="">
                  <a href=''></a>
                </li>

              </ul>
            </nav>
          </div>
        </div>
      );
    }
  }

  renderLikers() {
    return this.state.users.map((user) => {
      return (
        <li key={user.id}>
          <a href={user.urlPath}>
            <div dangerouslySetInnerHTML={this.renderAvatarImage(user)} />
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
    if (user.isSelf) { return; }
    return <UserFollowButton following={user.following} followed_id={user.id} />
  }

  handleOpenClick(event) {
    $.ajax({
      url: `/api/likers/?post_id=${this.props.post_id}`,
      method: 'GET',
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

