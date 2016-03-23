class NotificationsContainer extends React.Component {
  constructor(props) {
    super(props);

    this.state = {
      newNotificationCount: 0,
      notifications: [],
      nextPage: null
    };
  }

  componentWillMount() {
    this.fetchNotifications();
    // TODO: set timer to poll
  }

  render () {
    return (
      <div className="notification-container">
        <a className={`dropdown-toggle ${this.state.newNotificationCount > 0 ? 'active' : ''}`}
          onClick={() => this.handleMarkAsTouched()}
          data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">
          {this.renderNotificationIcon()}
        </a>
        <div
          className="dropdown-menu"
          ref={(ref) => {this.dropdownRef = ref}}
        >
          <span className="dropdown-arrow-top"></span>
          <span className="dropdown-arrow-bottom"></span>
          <div className="notification-header">
            <span>Notifications</span>
            <a className="pull-right mark-all-as-read"
              onClick={(e) => this.handleMarkAllAsRead(e)}>
              Mark All as Read
            </a>
          </div>
          <ul
            onScroll={() => this.handleScroll()}
            ref={(ref) => {this.notificationsListRef = ref}}
            className="notifications-list">
            {this.renderNotificationItems()}
            {this.loadMoreButton()}
          </ul>
        </div>
      </div>
    );
  }

  fetchNotifications() {
    $.ajax({
      url: "/api/notifications.json",
      dataType: "JSON",
      method: "GET",
      success: (data) => {
        this.setState({
          newNotificationCount: data.new_notification_count,
          nextPage: data.next_page,
          notifications: data.notifications
        });
      }
    });
  }

  renderNotificationIcon() {
    if (this.state.newNotificationCount > 0) {
      return (
        <span id="new-notifications-count">
          {this.state.newNotificationCount}
        </span>
      );
    } else {
      return (
        <span className="icon-bell-o notification-bell" id="bell"></span>
      );
    }
  }





  renderNotificationItems() {
    if (!this.state.notifications.length) {
      return (
      <div className="no-notifications">
        No notifications yet

        <div className="ringer">
        <svg className="bell-no" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 119.4 128.6">
          <path className="bell-jar" d="M119.4 101.1c0 2.5-.9 4.6-2.7 6.5-1.8 1.8-4 2.7-6.5 2.7H78.1c0 5.1-1.8 9.4-5.4 13-3.6 3.6-7.9 5.4-13 5.4s-9.4-1.8-13-5.4c-3.6-3.6-5.4-7.9-5.4-13H9.2c-2.5 0-4.6-.9-6.5-2.7-1.8-1.8-2.7-4-2.7-6.5 2.4-2 4.6-4.1 6.5-6.3 2-2.2 4-5.1 6.1-8.6s3.9-7.3 5.3-11.4c1.5-4.1 2.7-9 3.6-14.8.9-5.8 1.4-12 1.4-18.7 0-7.3 2.8-14 8.4-20.3 5.6-6.2 12.9-10 22-11.4-.4-.9-.6-1.8-.6-2.8 0-1.9.7-3.5 2-4.9s3-2 4.9-2 3.5.7 4.9 2c1.3 1.3 2 3 2 4.9 0 1-.2 1.9-.6 2.8 9.1 1.3 16.4 5.1 22 11.4 5.6 6.2 8.4 13 8.4 20.3 0 6.7.5 12.9 1.4 18.7.9 5.8 2.1 10.7 3.6 14.8 1.5 4.1 3.2 7.9 5.3 11.4 2.1 3.5 4.1 6.4 6.1 8.6 2.2 2.1 4.3 4.2 6.7 6.3z"/>
          <circle className="eye blink" cx="39.7" cy="75.2" r="5"/>
          <circle className="eye blink" cx="79.7" cy="75.2" r="5"/>
          <path className="mouth smile" d="M41.3 88.4c5.2 4.6 11.6 7.2 18.4 7.2s13.2-2.7 18.4-7.2H41.3z"/>
        </svg>
        </div>

      </div>);
    }

    return this.state.notifications.map(notification => {
      return (<NotificationItem key={notification.id} {...notification} />);
    });
  }

  // Keep this as a fallack fro handleScroll
  loadMoreButton() {
    if (this.state.nextPage === null) {
      return;
    }
    return (
      <li>
        <a onMouseOver={() => this.handleLoadMore()}>
          See More
        </a>
      </li>
    );
  }

  handleMarkAsTouched() {
    if (this.state.newNotificationCount === 0 ) { return; }
    $.ajax({
      url: '/api/notifications/mark_as_touched',
      method: 'POST',
      dataType: 'JSON',
      success: () => {
        this.setState({
          newNotificationCount: 0
        });
      }
    });
  }

  handleScroll() {
    let scrollHeight = $(this.notificationsListRef)[0].scrollHeight;
    const OFFSET = 50;
    let scrollTop = $(this.notificationsListRef).scrollTop();
    if (scrollHeight - (scrollTop + OFFSET) < $(this.notificationsListRef).innerHeight()) {
      this.handleLoadMore();
    }
  }

  handleMarkAllAsRead() {
    $(this.dropdownRef).parent().addClass('open'); // workaround jquery dropdown
    $.ajax({
      url: '/api/notifications/mark_all_as_read',
      method: 'POST',
      dataType: 'json',
      success: () => {
        this.setState({
          notifications: this.state.notifications.map(notification => {
            return { ...notification, unread: false };
          })
        });
      }
    });
  }

  handleLoadMore() {
    if (this.fetching || !this.state.nextPage) { return; }
    this.fetching = true;
    $.ajax({
      url: `/api/notifications.json/?page=${this.state.nextPage}`,
      method: 'GET',
      dataType: 'json',
      success: (data) => {
        this.fetching = false;
        this.setState({
          newNotificationCount: data.new_notification_count,
          nextPage: data.next_page,
          notifications: [ ...this.state.notifications, ...data.notifications ]
        });
      }
    });
  }

}
