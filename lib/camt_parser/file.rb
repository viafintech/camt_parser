module CamtParser
  class File
    def self.parse(path)
      data = ::File.read(path)
      CamtParser::String.parse(data)
    end
  end
end
