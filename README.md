# Fadeout Flash Message of ActiveRecord, in Rails

이 rake 파일은 ActiveRecord의 flash message를 fadeout할 수 있도록 application템플릿과 layout.css.scss 파일에 코드를 추가해 주는 task파일입니다. 

### Installation

    # Application view template file should exist.
      (app/views/layouts/application.html.erb or app/views/layouts/application.html.haml)
      
    # if layout.css.scss file doesn't exist, it will be created in the app/assets/stylesheets/ directory.

### Usage

    # First of all, you should place this rake file(fadeFlash.rake) in proj/lib/tasks/ directory.
    
    # Add FadeoutFlash Message Snippet to your application view file and layout.css.scss file.
    $ rake -T
    $ rake fadeFlash:view
    $ rake fadeFlash:add [f=haml]
