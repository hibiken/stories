class SearchTagListItem extends React.Component {
  render () {
    return (
      <li>
        <a href={this.props.tag.url}>
          <span className="icon-tag"></span> {this.props.tag.name}
        </a>
      </li>
    );
  }
}

