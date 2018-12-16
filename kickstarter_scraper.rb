require "nokogiri"
require "pry"

#projects: kickstarter.css("li.project.grid_4")
#title: project.css(h2.bbcard_name strong a").text 
#image link: project.css("div.project-thumbnail a img").attribute("src").value 
# description: project.css("p.bbcard_blurb").text
# location: project.css("ul.project-meta span.location-name").text
#funded: project.css("ul.project-stats li.first.funded strong").text.gsub("%", "").to_i

# in Pry using project = _ or variable name = _ will assign the variable name to the return value of whatever was executed above

def create_project_hash
  html = File.read("fixtures/kickstarter.html")
  kickstarter = Nokogiri::HTML(html)
    
  projects = {}
  
  # iterating through projects 
  
  kickstarter.css("li.project.grid_4").each do |project|
    title = project.css("h2.bbcard_name strong a").text 
    projects[title.to_sym] = {
    # symbols make better hashes than strings 
    
    :image_link => project.css("div.project-thumbnail a img").attribute("src").value,
    :description => project.css("p.bbcard_blurb").text,
    :location => project.css("ul.project-meta span.location-name").text,
    :percent_funded => project.css("ul.project-stats li.first.funded strong").text.gsub("%","").to_i
    }
  end 
  projects 
end 

