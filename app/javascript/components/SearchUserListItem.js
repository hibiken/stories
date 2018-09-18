import React from 'react';
import ReactDOM from "react-dom";

export default class SearchUserListItem extends React.Component {
  render() {
    return (
      <li>
        <a href={this.props.user.url}>
          <img width="35" heigth="35" className="avatar-image" src={this.props.user.avatar_url} />
          <span dangerouslySetInnerHTML={{ __html: this.props.user.username }} />
        </a> 
      </li>
    );
  }
}

