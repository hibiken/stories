class NotificationItem extends React.Component {
  constructor(props) {
    super(props);

    this.state = { unread: this.props.unread };
  }

  componentWillReceiveProps(nextProps) {
    this.setState({
      unread: nextProps.unread
    });
  }

  render () {
    return (
      <li
        className={this.state.unread ? 'unread-notification' : ''}
        onClick={() => this.handleMarkAsRead()}>
        <a href={this.props.url}>
          <span dangerouslySetInnerHTML={{ __html: this.props.actor_avatar_img_tag }} />
          <div className="notification-metadata">
            {this.notificationContent()}
            <br/>
            <small>{this.notificationIcon()} {this.props.time_ago}</small>
          </div>
        </a>
      </li>
    );
  }

  notificationContent() {
    const { actor, action, type } = this.props;
    switch (type) {
      case 'post':
        return `${actor} ${action} ${type}`;
      case 'user':
        return `${actor} ${action}`;
      case 'response':
        return `${actor} ${action} ${type}`;
    }
  }

  // FIXME: this is tightly coupled to action.
  notificationIcon() {
    switch(this.props.action) {
      case 'liked your':
        return <i className="fa fa-heart-o"></i>;
      case 'started following you':
        return <i className="fa fa-user"></i>;
      case 'responded to your':
      case 'also commented on a':
        return <i className="fa fa-commenting-o"></i>;
    }
  }

  handleMarkAsRead(id) {
    $.ajax({
      url: `/api/notifications/${this.props.id}/mark_as_read`,
      method: 'POST',
      dataType: 'json',
      success: () => {
        this.setState({
          unread: false
        });
      }
    });
  }
}

