class BooksController < ApplicationController
  before_action :authenticate_user!

  def index
    @book = Book.new
    @books = Book.all
    @user = current_user
  end

  def search
    @user_or_book = params[:option]
    @how_search = params[:choice]
      if @user_or_book == "1"
        @users = User.search(params[:search], @user_or_book, @how_search)
      else
        @books = Book.search(params[:search], @user_or_book, @how_search)
      end
  end

    def create
    @books = Book.all
    @user = current_user
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      flash[:notice] ="You have creatad book successfully."
      redirect_to book_path(@book)
    else
      render :index
    end
    end

  def show
    @book = Book.find(params[:id])
    @user = current_user
    @book_comment = BookComment.new
  end

  def edit
    @user = current_user
    @book = Book.find(params[:id])
    unless @book.user == current_user
       redirect_to books_path
    end
  end

  def update
    @user = current_user
    @book = Book.find(params[:id])
    if @book.update(book_params)
      flash[:notice] ="You have updated book successfully."
      redirect_to book_path(@book.id)
    else
      render :edit
    end
  end



  def destroy
    book = Book.find(params[:id])
    book.destroy
    redirect_to books_path
  end



  private
    def book_params
      params.require(:book).permit(:title, :body)
    end
end