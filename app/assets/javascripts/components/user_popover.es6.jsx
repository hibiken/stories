class UserPopover extends React.Component {
  render () {
    return (
      <div className="user-popover">
        <h3 className="po-username">{this.props.user.username}</h3>
        <h4 className="po-description">{this.props.user.description}</h4>
        <UserFollowContainer 
          following={true}
          followed_id={1}
          followerCount={3}
          followingCount={4}
          className="flex-container flex-space-btw user-follow-container"
        />
      </div>
    );
  }
}

