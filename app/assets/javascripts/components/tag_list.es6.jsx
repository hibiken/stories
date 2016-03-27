class TagList extends React.Component {
  render () {
    return (
      <div className={`tags-wrapper ${this.props.className}`} >
        {this.renderTags()}
      </div>
    );
  }

  renderTags() {
    return this.props.tags.map(tag => {
      return (
        <a
          key={tag.id}
          className="tag"
          href={`/tags/${tag.slug}`}>
          {tag.name}
        </a>
      );
    });
  }
}

TagList.propTypes = {
  tags: React.PropTypes.array.isRequired,
  className: React.PropTypes.string
};

