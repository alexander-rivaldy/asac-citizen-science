module ApplicationHelper
    
    heroku_key = "c3d23a5a-d8e2-43ab-807d-4d27e53f9275"
    
    def full_title(title)
        base = "The Citizen Science Project"
        if title.empty?
            base
        else
            title + " | " + base
        end
    end
    
    def open_svg(path)
        File.open("app/assets/images/#{path}", "rb") do |file|
            raw file.read
        end
    end
    
end
