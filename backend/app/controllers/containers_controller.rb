class ContainersController < ApplicationController
  before_action :set_container, only: %i[ show ]

  # GET /containers/1
  def show
    render json: @container
  end

  # POST /containers
  def create
    @container = Container.new(container_params)

    container = Docker::Container.create("Image" => "shmeee/gjallarhorn:latest", "HostConfig" => { "PortBindings" => { "3000/tcp" => [{"HostPort" => "1234" }]}}, "name" => "gjallahorn", "Env" => ["GJALLARHORN_CM_REFRESH_KEY=#{container_params[:api_key]}"])
    container.start

    @container.container_id = container.id

    if @container.save
      render json: @container, status: :created, location: @container
    else
      render json: @container.errors, status: :unprocessable_entity
    end
  end
  
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_container
      @container = Container.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def container_params
      params.expect(container: [ :name, :api_key ])
    end
end
