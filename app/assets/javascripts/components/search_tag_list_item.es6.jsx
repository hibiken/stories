class SearchTagListItem extends React.Component {
  render () {
    return (
      <li className="search-tag-list-item">
        <a href={this.props.tag.url}>
          <span className="icon-tag"></span>
          <span dangerouslySetInnerHTML={{ __html: this.props.tag.name }} />
        </a>
      </li>
    );
  }
}

