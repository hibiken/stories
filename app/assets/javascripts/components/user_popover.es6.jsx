class UserPopover extends React.Component {
  render () {
    return (
      <div className="user-popover popover bottom">
        <div className="arrow" />
        <div className="flex-container flex-space-btw up-main">
          <div>
          <h3 className="po-username">{this.props.user.username}</h3>
          <h4 className="po-description">{this.props.user.description}</h4>
          </div>
          <div dangerouslySetInnerHTML={this.renderAvatarImage()} />
        </div>
        <UserFollowContainer 
          following={this.props.user.isFollowing}
          followed_id={this.props.user.id}
          followerCount={this.props.user.followerCount}
          followingCount={this.props.user.followingCount}
          hideButton={this.props.user.hideButton}
          className="flex-container flex-space-btw user-follow-container"
        />
      </div>
    );
  }

  renderAvatarImage() {
    return {__html: this.props.user.avatar_image_tag};
  }
}

