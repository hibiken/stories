class FollowingTagList extends React.Component {
  constructor(props) {
    super(props);

    this.state = { followingTags: this.props.followingTags  };
  }

  componentWillMount() {
    PubSub.subscribe('TagFollowButton:onClick', () => {
      this.fetchTags();
    })
  }

  render () {
    return (
      <div className="tags-wrapper following-tag-list">
        {this.renderFollowingTags()}
      </div>
    );
  }

  renderFollowingTags() {
    console.log(this.state.followingTags);
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
        console.log(data);
        this.setState({ followingTags: data });
      }
    });
  }
}

