def obtain_class
  class_name = ENV['CLASS'] || ENV['class']
  raise "Must specify CLASS" unless class_name
  @klass = Object.const_get(class_name)
end

def obtain_attachments
  name = ENV['ATTACHMENT'] || ENV['attachment']
  raise "Class #{@klass.name} has no attachments specified" unless @klass.respond_to?(:attachment_definitions)
  if !name.blank? && @klass.attachment_definitions.keys.include?(name)
    [ name ]
  else
    @klass.attachment_definitions.keys
  end
end

namespace :paperclip do
  desc "Regenerates thumbnails for a given CLASS (and optional ATTACHMENT)"
  task :refresh do
    
    # this loads all plugins required in your init file so don't add them here again, Merb will do it for you
    Merb.start_environment(:rake => true, :adapter => 'runner', :environment => ENV['MERB_ENV'] || 'development')
    
    klass     = obtain_class
    names     = obtain_attachments
    instances = klass.all

    puts "Regenerating thumbnails for #{instances.length} instances of #{klass.name}:"
    instances.each do |instance|
      names.each do |name|
        result = if instance.send("#{ name }?")
          instance.send(name).reprocess!
          instance.send(name).save
        else
          true
        end
        print result ? "." : "x"; $stdout.flush
      end
    end
    puts " Done."
  end
end
