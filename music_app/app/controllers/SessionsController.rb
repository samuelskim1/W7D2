class SessionsController < ApplicationController
    def new
        render :new
    end

     #if we want to create a session, we must log in
     #reminder that we're trying to log in by the information that we inputed into our form from the new views
     #we find a user with the email and password that we passed in
        #argument params[:user][:emails] comes from the way that we nested it in our user_params method 
        #if we find an appropriate user, we login and redirect to that user's page
        #else we render another form for someone to log in
    def create
        @user = User.find_by_credentials(params[:user][:email], params[:user][:password])

        if @user
            login(@user)
            redirect_to user_url(@user.id) #could've also just done @user bc of Rails magic
        else
            puts @user.errors.full_messages
            render :new
        end
    end
    #if we destroy a session, that means that we are gonna log out
        #call logout method and then redirect to the new action which will give us the log in form
    def destroy
        logout!
        redirect_to new_session_url
    end

    
end