import React from 'react';
import ReactDOM from "react-dom";
import Dante from 'Dante2'

import {DanteAnchorPopoverConfig} from 'Dante2/package/es/components/popovers/link.js'
import {ImageBlockConfig} from 'Dante2/package/es/components/blocks/image.js'
import {EmbedBlockConfig} from 'Dante2/package/es/components/blocks/embed.js'
import {VideoBlockConfig} from 'Dante2/package/es/components/blocks/video.js'

export default class NewEditor extends React.Component {

  tooltipsConfig = ()=>{
    return [DanteAnchorPopoverConfig()]
  }

  widgetsConfig = ()=>{
    return [
              ImageBlockConfig(),
              EmbedBlockConfig(),
              VideoBlockConfig()
           ]
  }

  render(){
    return <Dante tooltips={this.tooltipsConfig()}
                  widgets={this.widgetsConfig()}
                  read_only={true}
                  content={JSON.parse(this.props.content)}
            />
  }
}