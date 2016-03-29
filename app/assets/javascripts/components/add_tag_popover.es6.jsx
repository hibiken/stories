class AddTagPopover extends React.Component {
  constructor(props) {
    super(props);
    this.state = { tagName: '' };
  }

  render () {
    return (
      <div className="add-tag-popover popover top">
        <div className="arrow" />
        <h3 className="popover-title">
          Add your interest
        </h3>
        <div className="popover-content">
          <div className="input-group">
            <input
              type="text"
              value={this.state.tagName}
              onChange={this.handleInputChange.bind(this)}
              className="form-control"
            />
            <span
              onClick={this.handleAddClick.bind(this)}
              className="input-group-addon add-button"
            >
              Add
            </span>
          </div>
        </div>
      </div>
    );
  }

  handleInputChange(e) {
    this.setState({ tagName: e.target.value });
  }

  handleAddClick() {
    console.log('Add ', this.state.tagName);
    this.props.closePopover();
  }
}

