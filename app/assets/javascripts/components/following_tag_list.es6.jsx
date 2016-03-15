class FollowingTagList extends React.Component {
  constructor(props) {
    super(props);

    this.state = { followingTags: this.props.followingTags };
  }

  render () {
    return (
      <div className="tags-wrapper following-tag-list">
        {this.renderFollowingTags()}
      </div>
    );
  }

  renderFollowingTag() {
    this.state.followingTags.map(tag => {
      return (
        <a href={`/tags/${tag.id}`}>
          {tag.name}
        </a>
      );
    })
  }
}

