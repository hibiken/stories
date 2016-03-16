class LikeCount extends React.Component {
  constructor(props) {
    super(props);

    this.state = { count: this.props.count };
  }

  componentWillMount() {
    
  }
  render () {
    return (
      <div>
        <div>Count: {this.props.count}</div>
      </div>
    );
  }
}

LikeCount.propTypes = {
  count: React.PropTypes.number
};
