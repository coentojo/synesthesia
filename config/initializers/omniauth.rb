Production
Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, '333859243294743', 'e32e626336c6f9dff311d3ae89609b96'
end
#dev
# Rails.application.config.middleware.use OmniAuth::Builder do
#   provider :facebook, '302401596450772', '24d20ad30724e75a6695368171fa809f'
# end