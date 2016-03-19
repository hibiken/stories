class TagFollowersList extends React.Component {
  constructor(props) {
    super(props);

    this.state = { followers: [] };
  }

  componentWillMount() {
    this.fetchFollowers();
    this.token = PubSub.subscribe('TagFollowButton:onClick', () => {
      this.fetchFollowers();
    })
  }

  componentWillUnmount() {
    PubSub.unsubscribe(this.token);
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
        <PopoverLink key={follower.id} user_id={follower.id} url={follower.urlPath}>
          <div dangerouslySetInnerHTML={ { __html: follower.avatar_image_tag }} />
        </PopoverLink>
      );
    });
  }
}

