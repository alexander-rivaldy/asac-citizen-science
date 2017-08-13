module ApplicationHelper
    
    def full_title(title)
        base = "The Citizen Science Project"
        if title.empty?
            base
        else
            title + " | " + base
        end
    end
    
end
