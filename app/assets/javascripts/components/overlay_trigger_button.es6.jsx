class OverlayTriggerButton extends React.Component {
  constructor(props) {
    super(props);

    this.handleOpenClick = this.handleOpenClick.bind(this);
  }

  render () {
    return (
      <span>
        <span dangerouslySetInnerHTML={ {__html: this.props.text} } onClick={this.handleOpenClick}>
        </span>
      </span>
    );
  }

  handleOpenClick(event) {
    /** Notify UserOverlay component **/
    PubSub.publish('OverlayTriggerButton:onClick', {
      endpoint: this.props.apiEndpoint,
      overlayHeading: this.props.overlayHeading
    });
  }

}


OverlayTriggerButton.propTypes = {
  text: React.PropTypes.oneOfType([React.PropTypes.string, React.PropTypes.number]).isRequired,
  overlayHeading: React.PropTypes.string,
  apiEndpoint: React.PropTypes.string.isRequired
};
