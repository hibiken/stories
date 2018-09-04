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

export default class NewEditor extends React.Component {


  saveMethod = (context, editorContent)=>{

  $('[data-behavior="editor-message"]').text('Saving...');
   $.ajax({
      url: '/api' + $('.editor-form').attr('action'),
      dataType: "script",
      method: $('input[name="_method"]').val() || "POST",
      data: {
        post: {
          title: $('#post_title').val(),
          body: JSON.stringify(editorContent),
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

  widgetsConfig = ()=>{
    return [ ImageBlockConfig(), 
             EmbedBlockConfig(),
             VideoBlockConfig(),
             PlaceholderBlockConfig()
           ]
  }


  componentDidMount(){
    // preload tags if its edit.
    var tag_string = $('[data-behavior="tags"]').data("tags");
    var tags = tag_string.length > 0 ? tag_string.split(', ') : ['Story', 'Music'];

    var my_taggle = new Taggle('js-taggle', {
      duplicateTagClass: 'bounce',
      tags: tags,
      preserveCase: true
    });

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

    $('.publish-dropdown').on('click', function(e) {
      e.stopPropagation();
    });

  }

  render(){


    return <Dante data_storage= {
                    {
                      url: $('.editor-form').attr('action'),
                      save_handler: this.saveMethod
                    }

                  }
                  tooltips={this.tooltipsConfig()}
                  widgets={this.widgetsConfig()}
            />
  }
}