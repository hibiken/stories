var ResponseEditor = {
  init: function() {
    if (!$('[data-behavior="response-editor"]').length > 0) {
      return;
    }

    var editor = new MediumEditor('.medium-editable', {
      placeholder: {
        text: "Write a response"
      }
    });

    editor.subscribe('focus', function() {
      $('[data-behavior="response-editor"]').addClass('active');
    });

    $('[data-behavior="editor-cancel"]').click(function(e) {
      e.preventDefault();
      $('[data-behavior="response-editor"]').removeClass('active');
      ResponseEditor.clearEditor(editor);
    });
  },

  clearEditor: function(editor) {
    editor.destroy();
    $('#editor-body').val('');
    editor.setup();
    editor.subscribe('focus', function() {
      $('[data-behavior="response-editor"]').addClass('active');
    });
  }
};

$(document).ready( ResponseEditor.init );
$(document).on( 'page:load', ResponseEditor.init );
