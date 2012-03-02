namespace :fadeflash do

  desc "Show the all code snippets of Fadeout-Flash"
  task :view => :environment do
    puts "\n>>> Codes to be added as follows:\n"
    puts %q{
  ***** for ERB
  <div id="flash-banner">
    <% flash.each do |key, msg| %>
      <%= content_tag :div, msg, :class => "flash " + key.to_s, :id => key.to_s + "-message" %>
      <%= content_tag :script, :type => "text/javascript" do %>
        $('#<%= key.to_s + "-message" %>').css('display', 'none');
        $('#<%= key.to_s + "-message" %>').slideDown().delay(1000).slideUp();
      <% end %>
    <% end %>
  </div>

  ***** for HAML
  #flash-banner
    - flash.each do |key, msg|
      = content_tag :div, msg, :class => "flash " + key.to_s, :id => key.to_s + "-message"
      = content_tag :script, :type => "text/javascript" do
        $("##{key.to_s + '-message'}").css('display', 'none');
        $("##{key.to_s + '-message'}").fadeIn('slow').delay(2000).fadeOut('slow');

  ***** for Layout.css.scss
  #flash-banner {
    //#notice-message, #alert-message,
    .flash.notice, .flash.alert {
      z-index: 999;
      /*display:none;*/
      position:fixed;
      left:10px;
      top:10px;
      -moz-border-radius : 4px;
      border-radius : 4px;
      padding: 5px 8px;
      margin: 0 auto 10px;

      /* width: 492px; */
      text-align:center;
    }

    //#notice-message,
    .flash.notice {
      background-color: #CFC;
      border: solid 1px #6C6;
    }

    #alert-message,
    .flash.alert {
      background-color: #FCC;
      border: solid 1px #C66;
    }
  }
      }
  end

  desc "Add Flash snippet into Application template file"
  task :add => :environment do

    def replace(filepath, regexp, *args, &block)
      content = File.read(filepath).gsub(regexp, *args, &block)
      File.open(filepath, 'wb') { |file| file.write(content) }
    end

    if ENV.include?('f') and ENV['f'].eql?("haml")
      path = "app/views/layouts/application.html.haml"
      replace(path, /^%body/mi) { |match| "#{match}" +
        %q{
  #flash-banner
    - flash.each do |key, msg|
      = content_tag :div, msg, :class => "flash " + key.to_s, :id => key.to_s + "-message"
      = content_tag :script, :type => "text/javascript" do
        $("##{key.to_s + '-message'}").css('display', 'none');
        $("##{key.to_s + '-message'}").fadeIn('slow').delay(2000).fadeOut('slow');\n\1
        }}
    else
      path = "app/views/layouts/application.html.erb"
      replace(path, /^<body>/mi) { |match| "#{match}" +
        %q{
    <div id="flash-banner">
      <% flash.each do |key, msg| %>
        <%= content_tag :div, msg, :class => "flash " + key.to_s, :id => key.to_s + "-message" %>
        <%= content_tag :script, :type => "text/javascript" do %>
          $('#<%= key.to_s + "-message" %>').css('display', 'none');
          $('#<%= key.to_s + "-message" %>').slideDown().delay(1000).slideUp();
        <% end %>
      <% end %>
    </div>
        }}
    end

    puts "\n>>>Results added as follows:\n\n"

    counter = 1
    File.open(path, "r") do |infile|
        while (line = infile.gets)
            puts "#{counter}: #{line}"
            counter = counter + 1
        end
    end

    path = "app/assets/stylesheets/layout.css.scss"
    # a+ : Read and write mode. The file pointer is at the end of the file if the file exists. The file opens in the append mode. If the file does not exist, it creates a new file for reading and writing.
    open(path, 'a+') do |f|
      f << %q{

#flash-banner {
  //#notice-message, #alert-message,
  .flash.notice, .flash.alert {
    z-index: 999;
    /*display:none;*/
    position:fixed;
    left:10px;
    top:10px;
    -moz-border-radius : 4px;
    border-radius : 4px;
    padding: 5px 8px;
    margin: 0 auto 10px;

    /* width: 492px; */
    text-align:center;
  }

  //#notice-message,
  .flash.notice {
    background-color: #CFC;
    border: solid 1px #6C6;
  }


  #alert-message,
  .flash.alert {
    background-color: #FCC;
    border: solid 1px #C66;
  }
}
}
    end


    puts "\n>>>Stylesheet file modified as follows:\n\n"

    counter = 1
    File.open(path, "r") do |infile|
        while (line = infile.gets)
            puts "#{counter}: #{line}"
            counter = counter + 1
        end
    end
  end
end