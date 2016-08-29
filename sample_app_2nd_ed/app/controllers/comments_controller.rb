class CommentsController < ApplicationController
	before_filter :signed_in_user
	before_filter :correct_user, only: :destroy

	def create
		@micropost_id = params[:micropost_id]
		@micropost = Micropost.find(@micropost_id)
		@comment = @micropost.comments.build(params[:comment])
		if @comment.save
			flash[:success] = "Comment created"
			redirect_to :action => "show", :id => @micropost_id, :controller => "microposts"
		else
			@comments = []
			render template: 'microposts/show', :locals => {:id => @micropost_id}
		end
	end

	def destroy
		@comment.destroy
		redirect_to :action => "show", :id => @comment.micropost_id, :controller => "microposts"
	end

	def edit
		@comment = Comment.find(params[:id])
	end

	def update
		@comment = Comment.find(params[:id])
	    if @comment.update_attributes(params[:comment])
	      redirect_to :action => "show", :id => @comment.micropost_id, :controller => "microposts"
	    else
	      @title = "Edit comment"
	      render 'edit'
	    end
  	end

	private
		def correct_user
			@micropost_id = params[:micropost_id]
			micropost = Micropost.find_by_id(@micropost_id)
			@comment = micropost.comments.find_by_id(params[:id])
			redirect_to root_url if @comment.nil?
		end
end
