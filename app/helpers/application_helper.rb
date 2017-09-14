module ApplicationHelper
    
    $token = ""
    $refresh_token = ""
    
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
