# frozen_string_literal: true

class DailyReportsController < ApplicationController
  before_action :set_daily_report, only: %i[show edit update destroy]

  def index
    @daily_reports = DailyReport.order(:id).page(params[:page])
  end

  def show; end

  def new
    @daily_report = DailyReport.new
  end

  def edit; end

  def create
    @daily_report = DailyReport.new(daily_report_params)

    respond_to do |format|
      if @daily_report.save
        format.html { redirect_to @daily_report, notice: t('controllers.common.notice_create', name: DailyReport.model_name.human) }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @daily_report.update(daily_report_params)
        format.html { redirect_to @daily_report, notice: t('controllers.common.notice_update', name: DailyReport.model_name.human) }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @daily_report.destroy!

    respond_to do |format|
      format.html { redirect_to daily_reports_path, status: :see_other, notice: t('controllers.common.notice_destroy', name: DailyReport.model_name.human) }
    end
  end

  private

  def set_daily_report
    @daily_report = DailyReport.find(params.expect(:id))
  end

  def daily_report_params
    params.expect(daily_report: %i[title body])
  end
end
