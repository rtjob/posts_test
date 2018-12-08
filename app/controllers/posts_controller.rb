class PostsController < ApplicationController
  # before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user
    before_action :authenticate_user, only: [:edit, :update, :destroy]
  # GET /posts
  # GET /posts.json
  def index

    @posts = Post.order(_id: :desc)
    logger.debug("@posts=" + @posts.inspect)
    # @likes_count = Like.where(post_id: @posts).count
    # logger.debug("@likes_count=" + @likes_count.inspect)
    # logger.debug("@posts=" + @posts.inspect)
    #date値取得
    # @date = lambda{
    #   if unless @post.blank?

    #   else

    #   end

    # }
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
    @posts = Post.order(_id: :desc)
    logger.debug("@posts=" + @posts.inspect)
    @likes_count = Like.where(post_id: @posts).count
    logger.debug("@likes_count=" + @likes_count.inspect)
    render("/posts/index")
  end

  # GET /posts/new
  def new
    @post = Post.new
  end

  # POST /posts
  # POST /posts.json
  def create
    # フォームから送信されたデータを受け取り、保存する
    @post = Post.new(subject: params[:createSubject],
       contents: params[:createContents],
       user_id: @current_user.id)
    #rootページにredirect
    if @post.save
      flash[:notice] = "更新しました"
      redirect_to("/posts/index")
    else
      @errorMessage = "更新に失敗"
      render("/posts/index")    
    end

    # @post = Post.new(post_params)

    # respond_to do |format|
    #   if @post.save
    #     format.html { redirect_to @post, notice: 'Post was successfully created.' }
    #     format.json { render :show, status: :created, location: @post }
    #   else
    #     format.html { render :new }
    #     format.json { render json: @post.errors, status: :unprocessable_entity }
    #   end
    # end
  end

  # GET /posts/1/edit
  def edit
    #url値取得
    @id = params[:id]
    logger.debug("@id =" + @id)
    @post = Post.find_by(id: params[:id])
  end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update
    @post = Post.find_by(id: params[:id])
    @post.subject = params[:createSubject]
    @post.contents = params[:createContents]
    if @post.save
      flash[:notice] = "更新しました"
      redirect_to("/posts/index")           
    else
      render("/posts/edit")         
    end
    # respond_to do |format|
    #   if @post.update(post_params)
    #     format.html { redirect_to @post, notice: 'Post was successfully updated.' }
    #     format.html { render :index }
    #     format.json { render :index, status: :ok, location: @post }
    #   else
    #     format.html { render :edit }
    #     format.json { render json: @post.errors, status: :unprocessable_entity }
    #   end
    # end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post = Post.find_by(id: params[:id])
    @post.destroy
    flash[:notice] = "削除しました"
    redirect_to("/posts/index")    
  end

  def ensure_correct_user
    @posts = Post.find_by(id: params[:id])
    if @posts.user_id != @current_user.id
      flash[:notice] = "権限がありません"
      redirect_to("/posts/index")
    end

  end
  # private
    # Use callbacks to share common setup or constraints between actions.
    # def set_post
    #   @post = Post.find(params[:id])
    # end

    # Never trust parameters from the scary internet, only allow the white list through.
    # def post_params
    #  params.require(:post).permit(:contents)
    # end
    #def update_date
    #endｖ
  
end