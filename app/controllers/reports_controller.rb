# frozen_string_literal: true

class ReportsController < ApplicationController
  before_action :set_report, only: %i[edit update destroy]

  EXTRACT_ID_FROM_URL_PATTERN = %r{http://localhost:3000/reports/(\d+)}

  def index
    @reports = Report.includes(:user).order(id: :desc).page(params[:page])
  end

  def show
    @report = Report.find(params[:id])
  end

  def new
    @report = Report.new
  end

  def edit; end

  def create
    @report = current_user.reports.new(report_params)
    @report.mentioning_report_ids = mentioning_report_ids

    if @report.save
      redirect_to @report, notice: t('controllers.common.notice_create', name: Report.model_name.human)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    @report.mentioning_report_ids = mentioning_report_ids

    if @report.update(report_params)
      redirect_to @report, notice: t('controllers.common.notice_update', name: Report.model_name.human)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @report.destroy!

    redirect_to reports_path, status: :see_other, notice: t('controllers.common.notice_destroy', name: Report.model_name.human)
  end

  private

  def set_report
    @report = current_user.reports.find(params[:id])
  end

  def mentioning_report_ids
    report_params['content'].scan(EXTRACT_ID_FROM_URL_PATTERN).flatten.uniq
  end

  def report_params
    params.expect(report: %i[user_id title content])
  end
end
