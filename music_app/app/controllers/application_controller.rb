class ApplicationController < ActionController::Base
    skip_before_action :verify_authenticity_token
    helper_method :current_user, :logged_in?

    #we log in if the sessions[session token] is equivalent to a session token of a user in the db
        #here we set them equivalent to indicate that the user is logged in now
    def login!(user)
        session[:session_token] = user.reset_session_token!
    end


    #holds instance of our current user
    #if @current_user = nil, it reassigns current user to a user that has the same session_token as the session's session_token(cookies)
    def current_user
        @current_user ||= User.find_by(session_token: session[:session_token])
    end

    #this basically checks if the current user is logged in
    #does this by checking if there is a current user instance
    def logged_in?
        !!current_user
    end

    #the second our session[session token] is not equivalent to the current_user's session token, that means that the user is not logged in
    #we also set the session's session token to nil and the current_user to nil
    def logout!
        current_user.reset_session_token! if logged_in?
        session[:session_token] = nil
        @current_user = nil
    end
end
