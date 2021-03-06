module ObsFactory
  class StagingProjectsController < ApplicationController
    respond_to :json, :html

    def index
      @distribution = Distribution.find(params[:project])
      respond_to do |format|
        format.html do
          @staging_projects = StagingProjectPresenter.sort(@distribution.staging_projects)
          @backlog_requests = Request.with_open_reviews_for(by_group: 'factory-staging')
          @backlog_requests.sort! { |x,y| x.package <=> y.package }
          # For the breadcrumbs
          @project = @distribution.project
        end
        format.json { render json: @distribution.staging_projects }
      end
    end

    def show
      @distribution = Distribution.find(params[:project])
      staging_project = @distribution.staging_project(params[:id].upcase)
      respond_to do |format|
        format.html do
          @staging_project = StagingProjectPresenter.new(staging_project)
          # For the breadcrumbs
          @project = @distribution.project
        end
        format.json { render json: staging_project }
      end
    end
  end
end
