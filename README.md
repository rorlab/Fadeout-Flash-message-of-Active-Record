# Fadeout Flash Message of ActiveRecord, in Rails

이 rake(or thor) 파일은 ActiveRecord의 flash message를 fadeout할 수 있도록 application템플릿과 layout.css.scss 파일에 코드를 추가해 주는 task파일입니다. 

It's up to your preference with which one (rake or thor) you will perform a task 

### Installation

    # Application view template file should exist.
      (app/views/layouts/application.html.erb or app/views/layouts/application.html.haml)
      
    # if layout.css.scss file doesn't exist, it will be created in the app/assets/stylesheets/ directory.
    
    # move to the "lib/" directory
    $[proj] cd lib
    
    # if there is no files in "lib/tasks/" directory, 
      $[proj/lib] rm -rf tasks
      $[proj/lib] git clone git://github.com/rorlab/Fadeout-Flash-message-of-Active-Record.git tasks
    # else
      $[proj/lib] git clone git://github.com/rorlab/Fadeout-Flash-message-of-Active-Record.git
      $[proj/lib] mv Fadeout-Flash-message-of-Active-Record/* tasks/
      $[proj/lib] rm -rf Fadeout-Flash-message-of-Active-Record
    # end
    
    # And then, move to the root directory of project
    $[proj/lib] cd ..
    
    
### Usage for Rake

    # First of all, you should place this rake file(fadeFlash.rake) in proj/lib/tasks/ directory.
    
    # Add FadeoutFlash Message Snippet to your application view file and layout.css.scss file.
    $ rake -T
    $ rake fadeflash:view  # Note: no "_" character
    $ rake fadeflash:add [f=haml]   # Note: no"_" character

### Usage for Thor

    # First of all, you should place this thor file(fadeFlash.thor) and thor/*.* in proj/lib/tasks/ directory.
    
    # Add FadeoutFlash Message Snippet to your application view file and layout.css.scss file.
    $ thor list
    $ thor fade_flash:help
    $ thor fade_flash:install [--format=haml]

### Confirm Results

    * app/views/layouts/application.html.erb or app/views/layouts/application.html.haml
    * app/assets/stylesheets/layout.css.scss