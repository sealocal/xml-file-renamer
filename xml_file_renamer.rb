require 'nokogiri'
require 'open-uri'
require 'fileutils'

class XMLFileRenamer
  attr_reader :source_xml_file, :css_selector, :xml_document,
      :origin_directory, :export_directory, :new_file_name

  def initialize(source_xml_file, css_selector)
    @source_xml_file = source_xml_file
    @css_selector = css_selector
  end

  def set_origin_directory
    @origin_directory = Dir.pwd
  end

  def print_origin_directory
    puts '**** Origin Directory: ' + @origin_directory
  end

  def print_css_selector
    puts '**** CSS selector: ' + @css_selector
  end

  def set_export_directory
    # Specify export directory:
    @export_directory = @origin_directory + '/export_folder'
  end

  def print_export_directory
    puts '**** Export Directory: ' + @export_directory
  end

  def open_xml_file
    # Read in the file and get new file name:
    puts '**** Source File: ' + @source_xml_file
    @xml_document = Nokogiri::XML(open(@source_xml_file))
  end

  def query_xml_file
    xml_query_by_css = @xml_document.css(@css_selector)

    @new_file_name = xml_query_by_css.text.strip
    puts '**** New File Name: ' + @new_file_name
  end

  #This method should be split into making a directory and exporting a file
  def export_xml_file
    destination_file = @export_directory + '/' + @new_file_name.to_s + '.xml'

    FileUtils.mkdir_p @export_directory
    FileUtils.copy_file(source_xml_file, destination_file)
  end
end

source_data = ARGV[0]
css_selector = ARGV[1]


# Example call from console:
# $ ruby rename_xml_files_by_content.rb example_building_589989.xml 'building Contact alt_building_name'
if (!File.directory? source_data) && (File.exist? source_data)
  file_renamer = XMLFileRenamer.new(source_data, css_selector)
  file_renamer.set_origin_directory
  file_renamer.print_origin_directory
  file_renamer.print_css_selector
  file_renamer.set_export_directory
  file_renamer.print_export_directory
  file_renamer.open_xml_file
  file_renamer.query_xml_file
  file_renamer.export_xml_file
end

if File.directory? source_data
  Dir.chdir(source_data) do
    puts '**** Orgin Directory: ' + source_data
    puts '**** Export Directory: ' + source_data + '/export_folder'
    all_regular_files_in_directory = Dir.glob('*.*')
    all_regular_files_in_directory.each do |file_name|
      file_renamer = XMLFileRenamer.new(file_name, css_selector)
      file_renamer.set_origin_directory
      file_renamer.set_export_directory
      file_renamer.open_xml_file
      file_renamer.query_xml_file
      file_renamer.export_xml_file
    end
  end
end


# Checkout the public repo at:
# https://github.com/sealocal/rename-xml-files-by-content