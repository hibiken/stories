class UserFollowContainer extends React.Component {
  constructor(props) {
    super(props);

    this.state = { followerCount: this.props.followerCount };
  }

  render () {
    return (
      <div className={this.props.className}>
        <div className="following-metadata">
          <span className="following-count">
            <b>{this.props.followingCount}</b> Following</span>
          <span className="follower-count">
            <OverlayTriggerButton 
              text={`<b>${this.state.followerCount}</b> ${this.pluralizeFollower()}`} 
              apiEndpoint={`/api/followers?user_id=${this.props.followed_id}`} 
              overlayHeading={`${this.props.username} is Followed by`} />
          </span>
        </div>
        {this.renderFollowButton()}
      </div>
    );
  }

  renderFollowButton() {
    if (this.props.hideButton) { return; }

    if (this.props.isSignedIn === false) { return (
      <UserFollowButton isSignedIn={false} />
    ); }

    return (
      <UserFollowButton 
        following={this.props.following}
        followed_id={this.props.followed_id}
        onFollowerCountChange={this.handleFollowerCountChange.bind(this)} />
    );
  }

  handleFollowerCountChange(newCount) {
    this.setState({
      followerCount: newCount
    });
  }

  pluralizeFollower() {
    return (this.state.followerCount > 1 || this.state.followerCount === 0) ? 'Followers' : 'Follower';
  }
}


UserFollowContainer.propTypes = {
  following: React.PropTypes.bool,
  hideButton: React.PropTypes.bool,
  followed_id: React.PropTypes.number,
  followerCount: React.PropTypes.number,
  followingCount: React.PropTypes.number,
  username: React.PropTypes.string
};
