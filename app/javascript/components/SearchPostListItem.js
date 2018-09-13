import React from 'react';
import ReactDOM from "react-dom";

export default class SearchPostListItem extends React.Component {
  render() {
    return (
      <li>
        <a href={this.props.post.url}>
          <img width="35" heigth="35" className="avatar-image" src={this.props.post.avatar_url} />
          <span dangerouslySetInnerHTML={{ __html: this.props.post.title }} />
        </a>
      </li>
    );
  }
}

