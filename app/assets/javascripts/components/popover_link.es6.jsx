class PopoverLink extends React.Component {
  constructor(props) {
    super(props);

    this.state = { showPopover: false, user: null, position: null };
  }

  render () {
    return (
      <span className="popover-link"
        onMouseEnter={this.handleMouseEnter.bind(this)} 
        onMouseLeave={this.handleMouseLeave.bind(this)}
      >
        <a href={this.props.url}>
          {this.props.children}
        </a>
        {this.renderPopover()}
      </span>
    );
  }

  renderPopover() {
    if (this.state.showPopover) {
      return (
        <UserPopover 
          user={this.state.user}
          position={this.state.position}
        />
      );
    } else {
      return;
    }
  }

  handleMouseEnter(event) {
    let position;
    const POPOVER_HEIGHT = 200;
    if ( POPOVER_HEIGHT + 30 > event.clientY) {
      this.position = "bottom";
    } else {
      this.position = "top";
    }
    this.timeoutID = setTimeout(() => {
      $.ajax({
        url: `/api/users/${this.props.user_id}`,
        method: 'GET',
        success: (data) => {
          this.setState({ user: data, showPopover: true, position: this.position });
        }
      });
    }, 450);
  }

  handleMouseLeave(event) {
    if (this.timeoutID) {
      clearTimeout(this.timeoutID);
      this.timeoutID = null;
    }
    setTimeout(() => { this.setState({ showPopover: false, position: null }); }, 180);
  }
}

