class SessionController < ApplicationController
  def login

  end

  def register
    @usuario=Usuario.new
  end
end
