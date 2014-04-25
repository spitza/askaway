OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter, 'Kp6nwP7uYB6n87RbYsAKiHIbI', 'oHicY35eOGuRA99RFWn8vz82TrBFUb9oBLEboRPKSUmhUeQASx'
end