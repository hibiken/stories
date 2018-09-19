import React from 'react';
import ReactDOM from "react-dom";

export default class AddTagPopover extends React.Component {
  constructor(props) {
    super(props);
    this.state = { tagName: '' };
  }

  render () {
    return (
      <div className="add-tag-popover popover bs-popover-top" x-placement="bottom">
        <div className="arrow" />
        <h3 className="popover-header">
          Add your interest
        </h3>
        <div className="popover-body">
          <form onSubmit={this.handleAddTag.bind(this)}>
            <div className="input-group">
              <input
                type="text"
                value={this.state.tagName}
                onChange={this.handleInputChange.bind(this)}
                className="form-control"
              />

              <div className="input-group-append">
                <button 
                  className="btn btn-outline-secondary" 
                  type="button"
                  onClick={this.handleAddTag.bind(this)}>
                  Add
                </button>
              </div>

              
            </div>
          </form>
        </div>
      </div>
    );
  }

  handleInputChange(e) {
    this.setState({ tagName: e.target.value });
  }

  handleAddTag(e) {
    e.preventDefault();
    if (this.state.tagName.length) {
      $.ajax({
        url: `/api/tags?tag_name=${this.state.tagName}`,
        method: 'POST',
        dataType: 'json',
        success: (data) => {
          PubSub.publish('TagFollowButton:onClick');
        }
      });
      this.props.closePopover();
    }
  }
}

