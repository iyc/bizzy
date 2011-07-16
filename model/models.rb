
# ---------------------------------------
class Models < Object
  
  # ---------------------------------------
  def self.require_models

    physical_file_dir = Dir[File.dirname(__FILE__)+"/physical/*"]
    physical_file_dir.each { |file|
      if File.file?(file)
        require file
      end
    }

    logical_file_dir = Dir[File.dirname(__FILE__)+"/logical/*"]
    logical_file_dir.each { |file|
      if File.file?(file)
        require file
      end
    }
  end
end