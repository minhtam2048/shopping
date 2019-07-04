module UrStoresHelper

    def current_user?
        self == current_user 
    end

    def verify_store?
        current_user.ur_store != nil    
    end
end
