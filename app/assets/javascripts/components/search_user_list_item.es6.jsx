class SearchUserListItem extends React.Component {
  render() {
    return (
      <li>
        <a href={this.props.user.url}>
          <img width="35" className="avatar-image" src={this.props.user.avatar_url} />
          {this.props.user.username}
        </a> 
      </li>
    );
  }
}

