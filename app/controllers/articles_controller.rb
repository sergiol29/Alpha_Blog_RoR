class ArticlesController < ApplicationController

  # required logged all method for look views 
  before_action :required_user

  # required logged and only permit edit, update, destroy a articles created four you
  before_action :require_same_user, only: [:edit, :update, :destroy]

  # GET /articles
  def index
    @article = Article.paginate(page: params[:page], per_page: 5)
  end

  # GET /articles/1
  def show
    @article = Article.find(params[:id])
  end

  # GET /articles/new
  def new
    @article = Article.new
  end

  # GET /articles/1/edit
  def edit
    @article = Article.find(params[:id])
  end

  # POST /articles
  def create
    #render plain: params(:user].inspec[:id])
    @article = Article.new(article_params)
    
    # Get User a create article
    @article.user = current_user

    if @article.save
      flash[:success] = "Article was successfully created"
      redirect_to article_path(@article)
    else
      render 'new'
    end
  end

  # PATCH/PUT /articles/1
  def update
    #render plain: params(:user].inspec[:id])
    @article = Article.find(params[:id])
    if @article.update(article_params)
        flash[:success] = "Article was successfully update"
        redirect_to article_path(@article)
    else
        render 'edit'
    end
  end

  # DELETE /articles/1
  def destroy
    @article = Article.find(params[:id])
    @article.destroy
    flash[:danger] = "Article was successfully delete"
    redirect_to articles_path
  end

  def require_same_user
    @article = Article.find(params[:id])
    
    if current_user != @article.user
      flash[:danger] = "You can only edit or delete your own articles "
      redirect_to articles_path
    end
  end

  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def article_params
      params.require(:article).permit(:title, :description)
    end
end
