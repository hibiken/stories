class UserPopover extends React.Component {
  render () {
    return (
      <div className={`user-popover popover ${this.props.position}`} style={this.cssStyles()}>
        <div className="po-buffer-top" />
        <div className="po-buffer-bottom" />
        <div className="arrow" />
        <div className="flex-container flex-space-btw up-main">
          <div className="up-metadata">
            <h3 className="po-username">
              <a href={this.props.user.urlPath}>
                {this.props.user.username}
              </a>
            </h3>
            <h4 className="po-description">{this.props.user.description}</h4>
            {this.renderLocation()}
          </div>
          <div dangerouslySetInnerHTML={this.renderAvatarImage()} />
        </div>
        <UserFollowContainer 
          following={this.props.user.isFollowing}
          followed_id={this.props.user.id}
          followerCount={this.props.user.followerCount}
          followingCount={this.props.user.followingCount}
          hideButton={this.props.user.hideButton}
          isSignedIn={this.props.user.isSignedIn}
          className="flex-container flex-space-btw user-follow-container"
        />
      </div>
    );
  }

  renderAvatarImage() {
    return {__html: this.props.user.avatar_image_tag};
  }

  renderLocation() {
    if (this.props.user.location) {
      return (
        <div className="po-location">
          <i className="fa fa-map-marker"></i>{this.props.user.location}
        </div>
      );
    }
  }

  cssStyles() {
    if (this.props.position === "bottom") {
      return { transform: 'translate(-50%, 14px)' };
    } else {
      return { transform: 'translate(-50%, -100%)' };
    }
  }
}

