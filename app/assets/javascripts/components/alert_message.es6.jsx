class AlertMessage extends React.Component {
  constructor(props) {
    super(props);

    this.state = { slideUp: false };
  }
  componentWillMount() {
    setTimeout(() => {
      this.setState({ slideUp: true });
    }, 3500);
  }

  render () {
    if (this.state.slideUp) {
      return (
        <div className={`alert alert-message slideup alert-${this.props.type}`}>
          {this.props.message}
        </div>
      );
    } else {
      return (
        <div className={`alert alert-message alert-${this.props.type}`}>
          {this.props.message}
        </div>
      );
    }
  }

}

AlertMessage.propTypes = {
  message: React.PropTypes.string.isRequired,
  type: React.PropTypes.string
};
