Gem::Specification.new do |s|
  s.name         =  'xml_file_renamer'
  s.version      =  '0.0.3'
  s.add_runtime_dependency "nokogiri", ["= 1.6.1"]
  s.executables  << 'xml_file_renamer'
  s.date         =  '2014-04-18'
  s.summary      =  "Rename XML files."
  s.description  =  "A Ruby class for renaming xml files based on content inside the XML."
  s.authors      =  ["Mike Taylor"]
  s.email        =  'local.mat@gmail.com'
  s.files        =  Dir["bin/*", "{example_xml_files}/*.xml", "{lib}/**/*.rb",
                    "LICENSE", "README.md"]
  s.homepage     =  'https://github.com/sealocal/xml_file_renamer'
  s.license      =  'MIT'
end
