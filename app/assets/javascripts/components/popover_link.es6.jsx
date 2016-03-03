class PopoverLink extends React.Component {
  constructor(props) {
    super(props);

    this.state = { showPopover: false, user:  { username: 'ken', description: 'JavaScript developer', followingCount: 3, followerCount: 4 }
 };
  }

  render () {
    return (
      <span className="popover-link">
        <a href={this.props.url} 
          onMouseEnter={this.handleMouseEnter.bind(this)} 
          onMouseLeave={this.handleMouseLeave.bind(this)}>
          {this.props.text}
        </a>
        {this.renderPopover()}
      </span>
    );
  }

  renderPopover() {
    if (true) {
      return (
        <UserPopover 
          user={this.state.user}
        />
      );
    } else {
      return;
    }
  }

  handleMouseEnter(event) {
    this.setState({ 
      showPopover: true,
      user: { username: 'ken', description: 'JavaScript developer', followingCount: 3, followerCount: 4 }
    });
  }

  handleMouseLeave(event) {
    this.setState({ showPopover: false });
  }
}

