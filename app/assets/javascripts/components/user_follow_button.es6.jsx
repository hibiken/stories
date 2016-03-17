class UserFollowButton extends React.Component {
  constructor(props) {
    super(props)

    this.state = { following: this.props.following };
  }

  componentWillMount() {
    this.token = PubSub.subscribe('UserFollowButton:onClick', (msg, data) => {
      if (this.props.followed_id === data.followed_id) {
        this.setState({ following: data.following });
      }
    })
  }

  componentWillUnmount() {
    PubSub.unsubscribe(this.token);
  }

  render () {
    return (
      <div>
        {this.renderButton()}
      </div>
    );
  }

  renderButton() {

    if (window.userSignedIn === false) {
      return (
        <a href="" className="button green-border-button follow-button" onClick={this.openOverlay}>
          Follow
        </a>
      );
    }

    if (this.state.following) {
      return (
        <button 
          className="button green-inner-button unfollow-button" 
          onClick={this.handleUnfollowClick.bind(this)}
          rel="nofollow" 
          >
          <span className="top content">Following</span><br />
          <span className="bottom content">Unfollow</span>
        </button>
      );
    } else {
      return (
        <button
          onClick={this.handleFollowClick.bind(this)}
          className="button green-border-button follow-button" 
          rel="nofollow" 
        >
          Follow
        </button>
      );
    }
  }

  // FIXME: this is not really a React way. Maybe create an Overlay and
  // TriggerOverlayButton components?
  openOverlay(event) {
    event.preventDefault();
    $('[data-behavior="overlay"]').addClass('open');
  }

  handleFollowClick(event) {
    $.ajax({
      url: `/api/relationships?followed_id=${this.props.followed_id}`,
      method: 'POST',
      success: (data) => {
        this.setState({
          following: true
        });

        if (this.props.onFollowerCountChange) {
          this.props.onFollowerCountChange(data.followerCount);
        }
        PubSub.publish('UserFollowButton:onClick', {
          followed_id: this.props.followed_id,
          following: true
        });
      }
    });

  }

  handleUnfollowClick(event) {
    $.ajax({
      url: `/api/relationships?followed_id=${this.props.followed_id}`,
      method: 'DELETE',
      success: (data) => {
        this.setState({
          following: false
        });

        if (this.props.onFollowerCountChange) {
          this.props.onFollowerCountChange(data.followerCount);
        }
        PubSub.publish('UserFollowButton:onClick', {
          followed_id: this.props.followed_id,
          following: false
        });
      }
    });
  }

}

UserFollowButton.propTypes = {
  following: React.PropTypes.bool
};
