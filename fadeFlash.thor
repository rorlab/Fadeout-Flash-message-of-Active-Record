class FadeFlash < Thor

	desc "help", "preview the code snippets"
	def help    
  	puts "\n>>> Codes to be added as follows:\n"      
  	puts "\n***** for ERB :\n\n"
    File.open("lib/tasks/thor/fadeFlash.html.erb", "r") do |infile|
      while (line = infile.gets)
        puts line
      end
    end      
  	puts "\n***** for HAML :\n\n"
    File.open("lib/tasks/thor/fadeFlash.html.haml", "r") do |infile|
      while (line = infile.gets)
        puts line
      end
    end      
  	puts "\n***** for Layout.css.scss :\n\n"
    File.open("lib/tasks/thor/fadeFlash.css.scss", "r") do |infile|
      while (line = infile.gets)
        puts line
      end
    end
	end 
	
	desc "install", "add code snippets for fading out flash message"
	method_options :format => "erb"
	def	install
    if options[:format] and options[:format].eql?("haml")
      path = "app/views/layouts/application.html.haml"
      replace(path, /^%body/mi) { |match| "#{match}\n" +
        IO.read("lib/tasks/thor/fadeFlash.html.haml")
	    }
    else
      path = "app/views/layouts/application.html.erb"
	    content = File.read(path).gsub(/^<body>/mi) { |match| "#{match}\n" +
        IO.read("lib/tasks/thor/fadeFlash.html.erb")
	    }
      File.open(path, 'wb') { |file| file.write(content) }
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
      f << "\n\n" + IO.read("lib/tasks/thor/fadeFlash.css.scss")
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