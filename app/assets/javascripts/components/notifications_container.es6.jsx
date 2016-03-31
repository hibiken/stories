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
        <i className="fa fa-bell-o notification-bell" id="bell"></i>
      );
    }
  }





  renderNotificationItems() {
    if (!this.state.notifications.length) {
      return (
      <div className="no-notifications">
        <div className="speech-bubble">Nothing to see here...</div>
        <span className="speech-arrow-top"></span>
        <span className="speech-arrow-bottom"></span>

        <div className="ringer">
        <svg id="Layer_1" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 119.4 128.6">
        	<circle className="eye blink" cx="41.8" cy="72.2" r="4.5"/>
        	<circle className="eye blink" cx="78.2" cy="72.2" r="4.5"/>
        	<path className="mouth smile" d="M43.3 84.2c4.8 4.2 10.5 6.6 16.8 6.6s12-2.4 16.8-6.6H43.3z"/>
        	<g><path className="bell-jar" d="M118.7 100.3c0 2.4-.9 4.6-2.7 6.3-1.8 1.8-3.9 2.7-6.3 2.7H78.1c0 5-1.8 9.2-5.3 12.8-3.5 3.5-7.8 5.3-12.8 5.3-5 0-9.2-1.8-12.8-5.3s-5.3-7.8-5.3-12.8H10.4c-2.4 0-4.6-.9-6.3-2.7-1.8-1.8-2.7-3.9-2.7-6.3 2.4-2 4.5-4 6.4-6.2 1.9-2.2 3.9-5 6-8.4 2.1-3.5 3.8-7.2 5.3-11.2 1.4-4 2.6-8.8 3.5-14.5.9-5.7 1.4-11.8 1.4-18.3 0-7.1 2.8-13.8 8.3-19.9C37.8 15.7 45 11.9 54 10.6c-.4-.9-.6-1.8-.6-2.8 0-1.9.7-3.5 2-4.8 1.3-1.3 2.9-2 4.8-2s3.5.7 4.8 2c1.3 1.3 2 2.9 2 4.8 0 .9-.2 1.9-.6 2.8 8.9 1.3 16.2 5 21.7 11.2 5.5 6.1 8.3 12.8 8.3 19.9 0 6.5.5 12.6 1.4 18.3.9 5.7 2.1 10.5 3.5 14.5s3.2 7.7 5.3 11.2c2.1 3.5 4.1 6.3 6 8.4 1.6 2.2 3.7 4.2 6.1 6.2zm-104.5 0h91.7C93.4 86.2 87.1 66.6 87.1 41.6c0-2.4-.6-4.9-1.7-7.4s-2.8-5-4.9-7.3c-2.1-2.3-5-4.2-8.6-5.7-3.6-1.5-7.6-2.2-12-2.2s-8.4.7-12 2.2-6.5 3.4-8.6 5.7c-2.1 2.3-3.7 4.7-4.9 7.3s-1.7 5-1.7 7.4c.2 25-6 44.6-18.5 58.7zm46.9 20.3c0-.8-.4-1.1-1.1-1.1-2.8 0-5.2-1-7.2-3s-3-4.4-3-7.2c0-.8-.4-1.1-1.1-1.1-.8 0-1.1.4-1.1 1.1 0 3.4 1.2 6.4 3.6 8.8 2.4 2.4 5.3 3.6 8.8 3.6.8 0 1.1-.3 1.1-1.1z"/></g>
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
      <li className="load-more">
        <a onMouseOver={() => this.handleLoadMore()}>
          <i className="fa fa-spinner fa-pulse"></i>
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
