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
import {VideoRecorderBlockConfig} from 'Dante2/package/es/components/blocks/videoRecorder'
import {CodeBlockConfig} from 'Dante2/package/es/components/blocks/code'
import Prism from 'prismjs';
import {PrismDraftDecorator} from 'Dante2/package/es/components/decorators/prism'

import Link from 'Dante2/package/es/components/decorators/link'
import findEntities from 'Dante2/package/es/utils/find_entities'

import { CompositeDecorator } from 'draft-js'
import MultiDecorator from 'draft-js-multidecorators'



export default class NewEditor extends React.Component {


  saveMethod = (context, editorContent)=>{

    const text = context.getTextFromEditor(editorContent)    
    if(text === ""){
      return
    }

    $('[data-behavior="editor-message"]').text('Saving...');
     $.ajax({
        url: '/api' + $('.editor-form').attr('action'),
        dataType: "script",
        method: $('input[name="_method"]').val() || "POST",
        data: {
          post: {
            //title: $('#post_title').val(),
            body: JSON.stringify(editorContent),
            plain: context.getTextFromEditor(editorContent),
            all_tags: $('#post_all_tags').val()
          }
        },
        success: function() { 
          console.log('autosave successful'); 
        }
      });
  }

  tooltipsConfig = ()=>{
    return [ DanteImagePopoverConfig(),
             DanteAnchorPopoverConfig(),
             DanteInlineTooltipConfig(),
             DanteTooltipConfig()
            ]
  }

  decorators = (context)=>{
    return (context)=> {
      return new MultiDecorator([
        PrismDraftDecorator({
          prism: Prism,
          defaultSyntax: 'javascript'
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

  widgetsConfig = ()=>{
    return [ CodeBlockConfig(),
            ImageBlockConfig({
                options: {
                  upload_url: $('.editor-form').attr('action') + '/uploads',
                  image_caption_placeholder: "type a caption (optional)"
                }
            }), 
             EmbedBlockConfig({ options: {
                                      placeholder: "put an external link",
                                      endpoint: "/oembed?url="
                                    } 
                              }),
             VideoBlockConfig({ breakOnContinuous: true,
                                options: {
                                    placeholder: "put an external video link",
                                    endpoint: "/oembed?url=",
                                    caption: 'optional caption'
                                  } 
                                }),
             PlaceholderBlockConfig(),
             VideoRecorderBlockConfig({
                options: {
                  seconds_to_record: 20000,
                  upload_url: $('.editor-form').attr('action') + '/uploads',
                }
             })
           ]
  }

  // use this in case you want to convert
  /*
  save_handler = (context, content, cb)=>{
  
    const exportedStyles = context.editor.styleExporter(context.editor.getEditorState())

    let convertOptions = {

      styleToHTML: (style) => {
        if (style === 'BOLD') {
          return <b/>;
        }
        if (style === 'ITALIC') {
          return <i/>;
        }
        if (style.includes("CUSTOM")){
          const s = exportedStyles[style].style
          return <span style={s} />
        }
      },
      blockToHTML: (block, oo) => {
       
        if (block.type === "unstyled"){
          return <p class="graf graf--p"/>
        }
        if (block.type === "header-one"){
          return <h1 class="graf graf--h2"/>
        }
        if (block.type === "header-two"){
          return <h2 class="graf graf--h3"/>
        }
        if (block.type === "header-three"){
          return <h3 class="graf graf--h4"/>
        }
        if (block.type === "blockquote"){
          return <blockquote class="graf graf--blockquote"/>
        }
        if (block.type === "button" || block.type === "unsubscribe_button"){
          const {href, buttonStyle, containerStyle, label} = block.data
          return {start: `<div style="width: 100%; margin: 18px 0px 47px 0px">
                          <div 
                            style="${styleString(containerStyle)}">
                            <a href="${href}"
                              className="btn"
                              ref="btn"
                              style="${styleString(buttonStyle)}">`,
                  end: `</a>
                    </div>
                  </div>`}
        }
        if (block.type === "card"){
          return {
            start: `<div class="graf graf--figure">
                    <div style="width: 100%; height: 100px; margin: 18px 0px 47px">
                      <div class="signature">
                        <div>
                          <a href="#" contenteditable="false">
                            <img src="${block.data.image}">
                            <div></div>
                          </a>
                        </div>
                        <div class="text" 
                          style="color: rgb(153, 153, 153);
                                font-size: 12px; 
                                font-weight: bold">`,
                  end: `</div>
                      </div>
                    <div class="dante-clearfix"/>
                  </div>
                </div>`
          }
        }
        if (block.type === "jumbo"){
          return {
            start: `<div class="graf graf--jumbo">
                    <div class="jumbotron">
                      <h1>` ,
            end: `</h1>
                    </div>
                  </div>`
          }
        }
        if (block.type === "image"){
          const {width, height, ratio} = block.data.aspect_ratio
          const {url } = block.data
          return {
            start: `<figure class="graf graf--figure">
                    <div>
                      <div class="aspectRatioPlaceholder is-locked" style="max-width: 1000px; max-height: 723.558px;">
                        <div class="aspect-ratio-fill" 
                            style="padding-bottom: ${ratio}%;">
                        </div>

                        <img src="${url}" 
                          height=${height} 
                          width=${width} 
                          class="graf-image" 
                          contenteditable="false"
                        >
                      <div>
                    </div>

                    </div>
                    <figcaption class="imageCaption">
                      <span>
                        <span data-text="true">`,
            end: `</span>
                      </span>
                    </figcaption>
                    </div>
                  </figure>`
          }
        }
        if (block.type === "column"){
          return <div class={`graf graf--column ${block.data.className}`}/>
        }
        if (block.type === "footer"){
          
          return {
                  start:`<div class="graf graf--figure"><div ><hr/><p>`,
                  end: `</p></div></div>`
                }
        }

        if(block.type === "embed"){
          if(!block.data.embed_data)
            return

          let data = null

          // due to a bug in empbed component
          if(typeof(block.data.embed_data.toJS) === "function"){
            data = block.data.embed_data.toJS()  
          } else {
            data = block.data.embed_data
          }
          
          if( data ){
            return <div class="graf graf--mixtapeEmbed">
                    <span>
                      <a target="_blank" class="js-mixtapeImage mixtapeImage" 
                        href={block.data.provisory_text} 
                        style={{backgroundImage: `url(${data.images[0].url})` }}>
                      </a>
                      <a class="markup--anchor markup--mixtapeEmbed-anchor" 
                        target="_blank" 
                        href={block.data.provisory_text}>
                        <strong class="markup--strong markup--mixtapeEmbed-strong">
                          {data.title}
                        </strong>
                        <em class="markup--em markup--mixtapeEmbed-em">
                          {data.description}
                        </em>
                      </a>
                      {data.provider_url}
                    </span>
                  </div>
          } else{
            <p/>
          }
        }
        if ("atomic"){
          return <p/>
        }

        if (block.type === 'PARAGRAPH') {
          return <p />;
        }
      },
      entityToHTML: (entity, originalText) => {
        if (entity.type === 'LINK') {
          return <a href={entity.data.url}>{originalText}</a>;
        }
        return originalText;
      }
    }

    let html3 = convertToHTML(convertOptions)(context.editorState().getCurrentContent())
   
    const serialized = JSON.stringify(content)
    const plain = context.getTextFromEditor(content)

    console.log(html3)
    if(cb)
      cb(html3, plain, serialized)
  }*/


  componentDidMount(){
    // preload tags if its edit.
    var tag_string = $('[data-behavior="tags"]').data("tags");
    
    //if(tag_string){
      var tags = tag_string.length > 0 ? tag_string.split(', ') : ['Story', 'Music'];

      var my_taggle = new Taggle('js-taggle', {
        duplicateTagClass: 'bounce',
        tags: tags,
        preserveCase: true
      });      
    //}


    // FIXME: is there a better way to do this?
    $('[data-behavior="publish-button"').hover(function() {
      $('#post_all_tags').val(my_taggle.getTagValues());
    });

    $("#post_picture").change(function(){
      const readURL = function(input) {
        if (input.files && input.files[0]) {
          var reader = new FileReader();
          reader.onload = function (e) {
            $('#image_preview').attr('src', e.target.result);
          }
          reader.readAsDataURL(input.files[0]);
        }
      }

      readURL(this);

      $('#existing-img-previewer').addClass('hidden');
      $('.picture_upload').addClass('active');
      $('.file-upload-previewer').removeClass('hidden');
    });

    /*** Form submit ***/
    $('[data-behavior="publish-button"]').on('click', function() {
      $('.editor-form').submit();
    });

    $('.inlineTooltip-button').on('click', (e)=>{
      e.preventDefault()
    })

    $('.publish-dropdown').on('click', function(e) {
      e.stopPropagation();
    });

  }

  initialContent = ()=>{
    return this.props.content ? JSON.parse(this.props.content) : null
  }

  render(){

    return <Dante data_storage= {
                    {
                      url: $('.editor-form').attr('action'),
                      save_handler: this.saveMethod
                    }

                  }
                  content={this.initialContent()}
                  tooltips={this.tooltipsConfig()}
                  widgets={this.widgetsConfig()}
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