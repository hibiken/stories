class BookmarkButton extends React.Component {
  constructor(props) {
    super(props);

    this.state = { bookmarked: this.props.bookmarked };

    this.onUnbookmarkClick = this.onUnbookmarkClick.bind(this);
    this.onBookmarkClick = this.onBookmarkClick.bind(this);
  }

  componentWillMount() {
    const { bookmarkableType, bookmarkableId } = this.props;
    this.token = PubSub.subscribe('BookmarkButton:onClick', (msg, data) => {
      if (bookmarkableType === data.type && bookmarkableId === data.id) {
        this.setState({ bookmarked: data.bookmarked });
      }
    });
  }

  render () {
    return (
      <div className="bookmark-button-wrapper">
        {this.renderBookmarkButton()}
      </div>
    );
  }

  renderBookmarkButton() {
    if (this.state.bookmarked) {
      return (
        <button className="unbookmark-button" onClick={this.onUnbookmarkClick}>
          <i className="fa fa-bookmark" />
          <span className="hide-text">Unbookmark</span>
        </button>
      );
    } else {
      return (
        <button className="bookmark-button" onClick={this.onBookmarkClick}>
          <i className="fa fa-bookmark-o" />
          <span className="hide-text">Bookmark</span>
        </button>
      );
    }
  }

  onUnbookmarkClick(e) {
    $.ajax({
      url: this.props.unbookmarkEndpoint,
      method: 'DELETE',
      dataType: 'json',
      success: (data) => {
        this.setState({ bookmarked: data.bookmarked });
        PubSub.publish('BookmarkButton:onClick', data);
      }
    });
  }

  onBookmarkClick(e) {
    $.ajax({
      url: this.props.bookmarkEndpoint,
      method: 'POST',
      dataType: 'json',
      success: (data) => {
        this.setState({ bookmarked: data.bookmarked });
        PubSub.publish('BookmarkButton:onClick', data);
      }
    });
  }
}

BookmarkButton.propTypes = {
  bookmarked: React.PropTypes.bool.isRequired,
  unbookmarkEndpoint: React.PropTypes.string.isRequired,
  bookmarkEndpoint: React.PropTypes.string.isRequired,
  bookmarkableType: React.PropTypes.string.isRequired,
  bookmarkableId: React.PropTypes.number.isRequired
};
