class SearchBar extends React.Component {
  constructor(props) {
    super(props)
  }

  render () {
    return (
      <form action="/search" acceptCharset="UTF-8" method="get">
        <input name="utf8" type="hidden" value="√" />
        <button name="button" type="submit">
          <span className="glyphicon glyphicon-search"></span>
        </button>
        <input
          value={this.props.term}
          onChange={(event) => {this.handleInputChange(event.target.value)}}
          placeholder="Search Stories" 
          autoComplete="off" 
          type="search" 
          name="search[q]" 
          id="search_q" />
      </form>
    );
  }

  handleInputChange(term) {
    this.props.onSearchTermChange(term);
  }
}

