class UserFollowButton extends React.Component {
  constructor(props) {
    super(props)

    this.state = { following: this.props.following };
  }

  render () {
    return (
      <div>
        {this.renderButton()}
      </div>
    );
  }

  renderButton() {
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
      }
    });
  }

}

UserFollowButton.propTypes = {
  following: React.PropTypes.bool
};
