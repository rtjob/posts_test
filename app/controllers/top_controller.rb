class TopController < ApplicationController
    before_action :forbit_loginUser,{only:[:indexTop]}
    def indexTop

    end
end
