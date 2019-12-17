class Api::V1::ThingsController < ApplicationController
    def index
        render json: { :things => [
            {
                name: 'Heelo',
                id: 'FSF33434-43434'
            }
        ] }.to_json
    end
end
