import React from 'react';
import ReactDOM from "react-dom";
import Dante from 'Dante2'

import {DanteImagePopoverConfig} from 'Dante2/package/es/components/popovers/image.js'
import {DanteAnchorPopoverConfig} from 'Dante2/package/es/components/popovers/link.js'
import {DanteInlineTooltipConfig} from 'Dante2/package/es/components/popovers/addButton.js' //'Dante2/package/es/components/popovers/addButton.js'
import {DanteTooltipConfig} from 'Dante2/package/es/components/popovers/toolTip.js' //'Dante2/package/es/components/popovers/toolTip.js'
import {ImageBlockConfig} from 'Dante2/package/es/components/blocks/image.js'
import {EmbedBlockConfig} from 'Dante2/package/es/components/blocks/embed.js'
import {VideoBlockConfig} from 'Dante2/package/es/components/blocks/video.js'
import {PlaceholderBlockConfig} from 'Dante2/package/es/components/blocks/placeholder.js'

export default class InlineEditor extends React.Component {

  tooltipsConfig = ()=>{
    return [ DanteImagePopoverConfig(),
             DanteAnchorPopoverConfig(),
             DanteTooltipConfig()
           ]
  }

  widgetsConfig = ()=>{
    return [ ImageBlockConfig(), 
             EmbedBlockConfig(),
             VideoBlockConfig(),
             PlaceholderBlockConfig()
           ]
  }

  componentDidMount(){
    $('[data-behavior="editor-cancel"]').click(function(e) {
      e.preventDefault();
      $('#inline-editor').removeClass('active');
    });
  }

  handleClick = (e)=>{
    $('#inline-editor').addClass('active');
  }

  initialContent = ()=>{
    return this.props.content ? JSON.parse(this.props.content) : null
  }

  saveMethod = (context, editorContent)=>{
    $('#editor-body').val( JSON.stringify(editorContent))
    $('#editor-plain').val( context.getTextFromEditor(editorContent))       
  }

  render(){
    return <div className="medium-editable post-body" 
                onClick={this.handleClick}
                >
              <Dante content={this.initialContent()}
                  data_storage= {
                      {
                        url: "/dummy",
                        save_handler: this.saveMethod
                      }
                  }
                  tooltips={this.tooltipsConfig()}
                  widgets={this.widgetsConfig()}
            />
          </div>

  }
}