class PopoverLink extends React.Component {
  constructor(props) {
    super(props);

    this.state = { showPopover: false, user: null };
  }

  render () {
    return (
      <span className="popover-link"
        onMouseEnter={this.handleMouseEnter.bind(this)} 
        onMouseLeave={this.handleMouseLeave.bind(this)}
      >
        <a href={this.props.url}>
          {this.props.text}
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
        />
      );
    } else {
      return;
    }
  }

  handleMouseEnter(event) {
    $.ajax({
      url: `/api/users/${this.props.user_id}`,
      method: 'GET',
      success: (data) => {
        console.log(data);
        this.setState({ user: data, showPopover: true });
      }
    });
  }

  handleMouseLeave(event) {
    setTimeout(() => { this.setState({ showPopover: false }); }, 400);
  }
}

