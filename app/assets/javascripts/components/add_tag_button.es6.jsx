class AddTagButton extends React.Component {
  constructor(props) {
    super(props);
    this.state = { showPopover: false };

    this.closePopover = this.closePopover.bind(this);
  }

  render () {
    if (!this.state.showPopover) {
      return (
        <div className="add-tag-button">
          <button onClick={this.handleButtonClick.bind(this)}>
            +
          </button>
        </div>
      );
    } else {
      return (
        <div className="add-tag-button">
          <button className="active" onClick={this.closePopover}>
            +
          </button>
          <AddTagPopover closePopover={this.closePopover}/>
        </div>
      );
    }
  }

  handleButtonClick() {
    this.setState({ showPopover: true });
  }

  closePopover() {
    this.setState({ showPopover: false });
  }
}

