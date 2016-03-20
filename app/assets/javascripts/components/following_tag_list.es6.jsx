class FollowingTagList extends React.Component {
  constructor(props) {
    super(props);

    this.state = { followingTags: this.props.followingTags  };
  }

  componentWillMount() {
    this.token = PubSub.subscribe('TagFollowButton:onClick', () => {
      this.fetchTags();
    })
  }

  componentWillUnmount() {
    PubSub.unsubscribe(this.token);
  }

  render () {
    return (
      <div className="tags-wrapper following-tag-list">
        {this.renderFollowingTags()}
      </div>
    );
  }

  renderFollowingTags() {
    return this.state.followingTags.map(tag => {
      return (
        <a
          key={tag.id}
          className="tag"
          href={`/tags/${tag.id}`}>
          {tag.name}
        </a>
      );
    })
  }

  fetchTags() {
    $.ajax({
      url: '/api/following_tags.json',
      method: 'GET',
      success: (data) => {
        this.setState({ followingTags: data });
      }
    });
  }
}

FollowingTagList.propTypes = {
  followingTags: React.PropTypes.array.isRequired
};
