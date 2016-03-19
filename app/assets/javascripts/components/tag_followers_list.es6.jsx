class TagFollowersList extends React.Component {
  constructor(props) {
    super(props);

    this.state = { followers: [] };
  }

  componentWillMount() {
    this.fetchFollowers();
  }

  componentWillUnmount() {

  }

  render () {
    return (
      <div>
        {this.renderFollowers()}
      </div>
    );
  }

  fetchFollowers() {
    $.ajax({
      url: `/api/tag_followers.json?tag_id=${this.props.tagId}`,
      method: 'GET',
      dataType: 'json',
      success: (data) => {
        this.setState({ followers: data });
      }
    });
  }

  renderFollowers() {
    return this.state.followers.map(follower => {
      return (
        <div key={follower.id} dangerouslySetInnerHTML={ { __html: follower.avatar_image_tag }} />
      );
    });
  }
}

