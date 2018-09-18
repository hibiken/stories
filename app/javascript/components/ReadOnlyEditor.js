import React from 'react';
import ReactDOM from "react-dom";
import Dante from 'Dante2'

import {DanteAnchorPopoverConfig} from 'Dante2/package/es/components/popovers/link.js'
import {ImageBlockConfig} from 'Dante2/package/es/components/blocks/image.js'
import {EmbedBlockConfig} from 'Dante2/package/es/components/blocks/embed.js'
import {VideoBlockConfig} from 'Dante2/package/es/components/blocks/video.js'
import {VideoRecorderBlockConfig} from 'Dante2/package/es/components/blocks/videoRecorder'
import {CodeBlockConfig} from 'Dante2/package/es/components/blocks/code'
import {PrismDraftDecorator} from 'Dante2/package/es/components/decorators/prism'
import Prism from 'prismjs';

import Link from 'Dante2/package/es/components/decorators/link'
import findEntities from 'Dante2/package/es/utils/find_entities'

import { CompositeDecorator } from 'draft-js'
import MultiDecorator from 'draft-js-multidecorators'


export default class NewEditor extends React.Component {

  tooltipsConfig = ()=>{
    return [DanteAnchorPopoverConfig()]
  }

  widgetsConfig = ()=>{
    return [
              CodeBlockConfig(),
              ImageBlockConfig(),
              EmbedBlockConfig(),
              VideoBlockConfig(),
              VideoRecorderBlockConfig()
           ]
  }

  decorators = (context)=>{
    return (context)=> {
      return new MultiDecorator([
        PrismDraftDecorator({
          prism: Prism,
        }),
        new CompositeDecorator(
          [{
            strategy: findEntities.bind(null, 'LINK', context),
            component: Link
          } ]
        )
      ])
      }
  }

  render(){
    return <Dante tooltips={this.tooltipsConfig()}
                  widgets={this.widgetsConfig()}
                  read_only={true}
                  content={JSON.parse(this.props.content)}
                  decorators={ (context)=> {
                    return new MultiDecorator([
                      PrismDraftDecorator({prism: Prism }),
                      new CompositeDecorator(
                        [{
                          strategy: findEntities.bind(null, 'LINK', context),
                          component: Link
                        } ]
                      )
                    ])
                    }
                  }
            />
  }
}