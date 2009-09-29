module ActionView
  module Helpers
    class FormBuilder
      def wysihat_editor(method, options = {})
        InstanceTag.new(@object_name, method, self, options.delete(:object)).to_wysihat_editor_tag(options)
      end
    end
    
    class InstanceTag #:nodoc:
      def to_wysihat_editor_tag(options = {})
        options = DEFAULT_TEXT_AREA_OPTIONS.merge(options.stringify_keys)
        add_default_name_and_id(options)

        if size = options.delete("size")
          options["cols"], options["rows"] = size.split("x") if size.respond_to?(:split)
        end
        
        buttons, helpers = '', ''
                
        if options['buttons']
          options['buttons'].each do |b|
            
            case b.to_s.downcase
            when "image"
              buttons << "toolbar.addButton({label : \'Image\', handler: function(editor) { return editor.faceBoxFile(editor); } })\n"
            when "link"
              buttons << "toolbar.addButton({label : \'Link\', handler: function(editor) { return editor.promptLink(editor); } })\n"
            when "html"
              buttons << "toolbar.addButton({label : \'HTML\', handler: function(editor) { return editor.promptHTML(editor); } })\n"
            else
              buttons << "toolbar.addButton({label : \'#{b.to_s.split('_').map {|w| w.capitalize}.join}\'});\n"
            end
            
          end
        else
          ['Bold', 'Italic', 'Underline'].each do |b|
            buttons << "toolbar.addButton({label : \'#{b}\'});\n"
          end
        end
            
        content_tag(
          :script,
          "
          var WysihatHelper = {
            faceBoxFile: function()
            {
              facebox.loading();
              new Effect.Appear($('facebox'), {duration: .3});

              var fb  = facebox;
            	var url = '/wysihat_files/?editor=' + this.id

            	new Ajax.Request(url, {
            		method		: 'get',
            		onFailure	: function(transport){
            			fb.reveal(transport.responseText, null);
            		},
            		onSuccess	: function(transport){
            			fb.reveal(transport.responseText, null);
            		}
            	});
            },
            
            promptLink: function()
            {
              if (this.linkSelected()) {
                if (confirm('Remove link?'))
                  this.unlinkSelection();
              } else {
                var value = prompt('Enter a URL', 'http://www.google.com/');
                if (value)
                  this.linkSelection(value);
              }
            },
            
            promptHTML: function()
            {
              var value = prompt('Please enter some HTML', '');
              if(value)
                this.insertHTML(value);
            }
          }
          
          WysiHat.Editor.include(WysihatHelper);
          
          Event.observe(window, 'load', function() {
            var editor = WysiHat.Editor.attach('#{tag_id}');
            var toolbar = new WysiHat.Toolbar(editor);
            #{buttons}
          });
          ",
          :type => 'text/javascript') <<
        content_tag("textarea", html_escape(options.delete('value') || value_before_type_cast(object)), options.merge(:class => 'wysihat_editor'))
      end
    end
  end
end