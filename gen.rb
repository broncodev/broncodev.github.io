require 'erb'
require 'tilt'
require 'tilt/erb'

files = [
  "index",
  "privacy-policy",
  "rules",
  "pinko",
]

# Define a method to render the page content with a layout
def render_with_layout(page_template, layout_template)
  # Render the page content first within a block
  content = Tilt::ERBTemplate.new(page_template).render(binding, page: page_template)

  # Render the layout, passing the content as a block to the 'yield'
  Tilt::ERBTemplate.new(layout_template).render(binding, page: page_template) do
    content
  end
end

directory_name = "docs"

unless File.exist?(directory_name)
  Dir.mkdir(directory_name)
  puts "Directory '#{directory_name}' created."
end

for file in files[0..-1]
  output_html = render_with_layout("#{file}.erb", 'header.erb')
  File.open("docs/#{file}.html", "w") do |f|
    f.write(output_html)
  end
end