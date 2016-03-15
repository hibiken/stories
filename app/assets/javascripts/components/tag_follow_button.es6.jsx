class TagFollowButton extends React.Component {
  constructor(props) {
    super(props)

    this.state = { following: this.props.following }
  }

  render () {
    return (
      <div>
        {this.renderButton()}
      </div>
    );
  }

  renderButton() {
    if (this.state.following) {
      return (
        <button
          onClick={this.handleUnfollowClick.bind(this)}
          className="pull-right button green-inner-button unfollow-button" 
          rel="nofollow" 
        >
          <span className="top content">Following</span><br />
          <span className="bottom content">Unfollow</span>
        </button>
      );
    } else {
      return (
        <button 
          onClick={this.handleFollowClick.bind(this)}
          className="pull-right button green-border-button follow-button" 
          rel="nofollow" 
        >
          Follow
        </button>
      );
    }
  }

  handleFollowClick(event) {
    $.ajax({
      url: `/api/interests?tag_id=${this.props.tag_id}`,
      method: 'POST',
      success: () => {
        this.setState({
          following: true
        });
        PubSub.publish('TagFollowButton:onClick');
      }
    });
  }

  handleUnfollowClick(event) {
    $.ajax({
      url: `/api/interests?tag_id=${this.props.tag_id}`,
      method: 'DELETE',
      success: () => {
        this.setState({
          following: false
        });
        PubSub.publish('TagFollowButton:onClick');
      }
    });
  }
}

TagFollowButton.propTypes = {
  following: React.PropTypes.bool
};
