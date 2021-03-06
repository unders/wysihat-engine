class WysihatGenerator < Rails::Generator::Base
  def manifest
    record do |m|
      
      m.file 'javascripts/wysihat.js',        'public/javascripts/wysihat.js'
      m.file 'javascripts/facebox.js',        'public/javascripts/facebox.js'
      
      m.file 'stylesheets/wysihat.css',       'public/stylesheets/wysihat.css'
      m.file 'stylesheets/facebox.css',       'public/stylesheets/facebox.css'
      
      m.file 'images/arrow_redo.png',         'public/images/arrow_redo.png'      
      m.file 'images/arrow_undo.png',         'public/images/arrow_undo.png'      
      m.file 'images/b.png',                  'public/images/b.png'      
      m.file 'images/bl.png',                 'public/images/bl.png'      
      m.file 'images/br.png',                 'public/images/br.png'      
      m.file 'images/closelabel.gif',         'public/images/closelabel.gif'      
      m.file 'images/exclamation.png',        'public/images/exclamation.png'      
      m.file 'images/film.png',               'public/images/film.png'      
      m.file 'images/image.png',              'public/images/image.png'      
      m.file 'images/link.png',               'public/images/link.png'      
      m.file 'images/loading.gif',            'public/images/loading.gif'      
      m.file 'images/page_code.png',          'public/images/page_code.png'      
      m.file 'images/page_white_flash.png',   'public/images/page_white_flash.png'      
      m.file 'images/paste_plain.png',        'public/images/paste_plain.png'      
      m.file 'images/text_align_center.png',  'public/images/text_align_center.png'      
      m.file 'images/text_align_left.png',    'public/images/text_align_left.png'      
      m.file 'images/text_align_right.png',   'public/images/text_align_right.png'      
      m.file 'images/text_bold.png',          'public/images/text_bold.png'      
      m.file 'images/text_heading_1.png',     'public/images/text_heading_1.png'      
      m.file 'images/text_heading_2.png',     'public/images/text_heading_2.png'      
      m.file 'images/text_heading_3.png',     'public/images/text_heading_3.png'      
      m.file 'images/text_italic.png',        'public/images/text_italic.png'      
      m.file 'images/text_list_bullets.png',  'public/images/text_list_bullets.png'      
      m.file 'images/text_list_numbers.png',  'public/images/text_list_numbers.png'      
      m.file 'images/text_strikethrough.png', 'public/images/text_strikethrough.png'      
      m.file 'images/text_underline.png',     'public/images/text_underline.png'      
      m.file 'images/tl.png',                 'public/images/tl.png'      
      m.file 'images/tr.png',                 'public/images/tr.png'        
      
      m.migration_template                    'migrations/create_wysihat_files.rb',
                                              'db/migrate',
                                              :migration_file_name => 'create_wysihat_files'
      
      m.route_resources :wysihat_files
      
      m.system 'script/plugin install git://github.com/markcatley/responds_to_parent.git'
      
    end
  end
end
