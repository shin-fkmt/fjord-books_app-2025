# frozen_string_literal: true

class CommentsController < ApplicationController
  before_action :set_comment, only: %i[edit update destroy]
  before_action :redirect_uneditable_comment, only: %i[edit update destroy]

  def edit; end

  def create
    @comment = current_user.comments.build(comment_params)

    respond_to do |format|
      if @comment.save
        format.html { redirect_to @comment.commentable, notice: t('controllers.common.notice_create', name: Comment.model_name.human) }
      else
        case @comment.commentable_type
        when 'Book'
          @book = @comment.commentable
          @path = 'books/show'
        when 'Report'
          @report = @comment.commentable
          @path = 'reports/show'
        end

        format.html { render @path, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @comment.update(comment_params)
        format.html { redirect_to @comment.commentable, notice: t('controllers.common.notice_update', name: Comment.model_name.human) }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @comment.destroy!

    respond_to do |format|
      format.html { redirect_to @comment.commentable, status: :see_other, notice: t('controllers.common.notice_destroy', name: Comment.model_name.human) }
    end
  end

  private

  def set_comment
    @comment = Comment.find(params.expect(:id))
  end

  def comment_params
    params.expect(comment: %i[comment commentable_id commentable_type])
  end

  def redirect_uneditable_comment
    redirect_to root_url, status: :see_other unless current_user == @comment.user
  end
end
